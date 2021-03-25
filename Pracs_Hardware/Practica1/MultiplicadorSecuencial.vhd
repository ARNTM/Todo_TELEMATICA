----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Diego Ismael Antolinos García && Andrés Ruz Nieto
-- 
-- Create Date:    19:53:22 10/03/2020 
-- Design Name: 
-- Module Name:    MultiplicadorSecuencial - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiplicadorSecuencial is
    Port ( inbus : in  STD_LOGIC_VECTOR (7 downto 0);
           outbus : out  STD_LOGIC (15 downto 0);
           I : in  STD_LOGIC;
           weQ : in  STD_LOGIC;
           weM : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC);
end MultiplicadorSecuencial;

architecture Behavioral of MultiplicadorSecuencial is

	type type_state is (INICIO, SUMACU, DESDESC);
	signal current_state, next_state: type_state;
	
	signal CA, pp: std_logic_vector (8 downto 0); --CA (producto parcial)
	signal Q, M: std_logic_vector (7 downto 0); --Q (Multiplicador), M(Multiplicando)
	signal init, ldA, sh: std_logic;
	signal cnt: unsigned (2 downto 0); --CONTADOR
	signal Z: std_logic;
	signal q0: std_logic;
begin
--FMS-----------------------------------
STATE_PROC:PROCESS(clk,reset)
        BEGIN
            IF(reset = '1') THEN
                current_state <= START;
            ELSIF (clk'event and clk = '1') THEN
                current_state <= next_state;
            END IF;
    END PROCESS;
	 
 OUTPUT_PROC:process(current_state)
				begin
					case(current_state) is
						WHEN INICIO =>
							init<='1';
							ldA<='0';
							sh<='0';
						WHEN SUMACU=>
							init<='0';
							if(q0='1')then
								ldA<='1';
							else
								ldA<='0';
							end if;
							sh<='0';
						WHEN DESDESC=>
							init<='0';
							ldA<='0';
							sh<='1';
					end case;
	end process;
	
NEXT_STATE_PROC:process(next_state)
			begin	
				case(current_state) is
					WHEN INICIO =>
						if(I='1' )then
							next_state<=SUMACU;
						else
							next_state<=INICIO;
						end if;
					WHEN SUMACU=>
						next_state<=DESDESC;
					WHEN DESDESC=>
						if(Z='0')then
							next_state<=SUMACU;
						else
							next_state<=INICIO;
						end if;
				end case;
			end process;
--Registro C y A -> Es un único registro
	process(reset,clk)
	begin
		if(reset='1') then
			CA <= (others=>'0');
		elsif rising_edge(clk) then
			if(init='1')then
				CA<=(others=>'0');
			elsif(ldA='1')then
				CA<=pp;
			elsif(sh='1')then
				CA<='0' & CA(3 downto 1);
			end if;
		end if;				
	end process;
	
-- Sumador
pp <= std_logic_vector(unsigned('0' & CA(7 downto 0)) + unsigned('0' & M));

--Salida
outbus<=CA(7 downto 0) & Q;

--Detector de cero
	process(cnt)
	begin
		if(cnt="000")then
			Z<='1';
		else
			Z<='0';
		end if;
	end process;
	
-- Registros Q, M, Contador, UC
-- RegistroM
	process(reset, weM)
	begin
		if(reset='1')then
			M<=(others=>'0');
		elsif rising_edge(weM)then
				M<=inbus;
		else
			M<=(others=>'0');
		end if;
	end process;
	
--RegistroQ
	process(reset,clk)
	begin
		if(reset='1')then
			Q<=(others=>'0');
		elsif rising_edge(clk) then
			if(weQ='1')then
				Q<=inbus;
			elsif(sh='1')then
				q0<=Q(0);
				Q<=CA(0) & Q(7 downto 1);
			end if;
		end if;
	end process;

--CONTADOR
	process(reset,clk)
	begin
		if(reset ='1')then
			cnt<=(others=>'0');
		elsif rising_edge(clk)then
			if(init='1')then
				cnt<= M.Length;
			elsif(sh='1')then
				cnt<=cnt-1;
			end if;
		end if;
	end process;
	
end Behavioral;
