library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity mult_sec is
    Port ( inbus  : in std_logic_vector(7 downto 0);
           outbus : out std_logic_vector(15 downto 0);
           I      : in std_logic;
	        weQ	   : in std_logic;
	        weM	   : in std_logic;
           rst    : in std_logic;
           clk    : in std_logic);
end mult_sec;

architecture Behavioral of mult_sec is
	
	type type_state is (INICIO, SUMACU, DESDEC);
	signal state, nextstate: type_state;
	
	signal CA, pp: std_logic_vector(8 downto 0);
	signal Q, M: std_logic_vector(7 downto 0);
	signal init, ld, sh: std_logic;
	signal cnt: unsigned (2 downto 0);
	signal Z: std_logic;

begin

	--Registro C y A:
	process(rst, clk)
	begin
		if (rst='1') then
			CA <= (others=>'0');
		elsif rising_edge(clk) then
			if (init='1') then
				CA <= (others=>'0');
			elsif	(ld='1') then
				CA <= pp;
			elsif (sh='1') then
				CA <= '0' & CA(8 downto 1);
			end if;
		end if;
	end process;
	
	--Registro Q:
	process(rst, clk)
	begin
		if (rst='1') then
			Q <= (others=>'0');
		elsif rising_edge(clk) then
			if	(weQ='1') then
				Q <= inbus(7 downto 0);
			elsif (sh='1') then
				Q <= CA(0) & Q(7 downto 1);
			end if;
		end if;
	end process;

	--Registro M:
	process(rst, clk)
	begin
		if (rst='1') then
			M <= (others=>'0');
		elsif rising_edge(clk) then
			if	(weM='1') then
				M <= inbus(7 downto 0);
			end if;
		end if;
	end process;

	--Sumador:
	pp <= std_logic_vector(unsigned('0' & CA(7 downto 0)) + unsigned('0' & M));
	
	--Salida:
	outbus <= CA(7 downto 0) & Q;
	
	--Contador:
	process(rst, clk)
	begin
		if (rst='1') then
			cnt <= (others=>'0');
		elsif rising_edge(clk) then
			if	(init='1') then
				cnt <= "111";
			elsif (sh='1') then
				cnt <= cnt - 1;
			end if;
		end if;
	end process;
	
	--Detector de cero:
	process(cnt)
	begin
		if (cnt="000") then
			Z <= '1';
		else 
			Z <= '0';	
			end if;
	end process;
	
	--Unidad de control: 
	process(rst, clk)
	begin
		if (rst='1') then
			state <= INICIO;
		elsif rising_edge(clk) then
			state <= nextstate;
		end if;
	end process;

	process(state, I, Q(0), Z)
	begin
		init <= '0'; ld <= '0'; sh <= '0';
		nextstate <= state;
		case state is
			when INICIO =>
				if (I='1') then
					init <= '1';
					nextstate <= SUMACU;
				else
					init <= '0';
					nextstate <= INICIO;
				end if;
			when SUMACU =>
				if (Q(0)='1') then
					ld <= '1';
				else
					ld <= '0';
				end if;	
				nextstate <= DESDEC;
			when DESDEC =>
				if (Z='1') then
					nextstate <= INICIO;
				else
					nextstate <= SUMACU; 
				end if;
				sh <= '1';
			when others =>
            nextstate <= INICIO;
		end case;
	end process;

end Behavioral;
