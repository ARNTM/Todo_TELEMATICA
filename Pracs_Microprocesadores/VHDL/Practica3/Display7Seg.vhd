----------------------------------------------------------------------------------
-- Company: 	UPCT - SDBM
-- Engineer:	Andres Ruz Nieto y Diego Ismael Antolinos Garcia
-- 
-- Create Date:    09:33:42 05/31/2019 
-- Design Name: 
-- Module Name:    Display7Seg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- DepENDencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration IF using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration IF instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Display7Seg is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           dato : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
			  AN_display7seg: out STD_LOGIC_VECTOR(3 downto 0);
           display7seg : out  STD_LOGIC_VECTOR(7 downto 0));
END Display7Seg;

architecture Behavioral of Display7Seg is
	type state_type is (START, PASO1, PASO2, FIN);
	signal current_state, next_state: state_type;
	
	signal actualiza_display : std_logic;
	signal count : unsigned (14 DOWNTO 0);
	signal reg : std_logic_vector (3 DOWNTO 0);
	signal datoBCD : unsigned (3 DOWNTO 0);
	signal iteracion: unsigned (3 DOWNTO 0);
	signal BINARIO : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal DIGITO1 : unsigned (3 DOWNTO 0);
	signal DIGITO2 : unsigned (3 DOWNTO 0);
	signal DIGITO3 : unsigned (3 DOWNTO 0);
	signal UNIDADES : unsigned (3 DOWNTO 0);
	signal DECENAS : unsigned (3 DOWNTO 0);
	signal CENTENAS : unsigned (3 DOWNTO 0);
	signal reinicia : std_logic;
	signal enable_carga_paso1 : std_logic;
	signal enable_desplaza_paso2 : std_logic;
	signal enable_contador_iteraciones : std_logic;
	signal enable_actualiza_salida : STD_LOGIC;
	
	BEGIN
-- FMS

-- #############################################
	STATE_PROC:PROCESS(clk,reset)
		BEGIN
			IF(reset = '1') THEN
				current_state <= START;
			ELSIF (clk'event and clk = '1') THEN
				current_state <= next_state;
			END IF;
	END PROCESS;
	
	OUTPUT_PROC:PROCESS(current_state)
		BEGIN
			CASE (current_state) is
			WHEN START =>
				reinicia <= '1';
				enable_carga_paso1 <='0';
				enable_desplaza_paso2 <= '0';
				enable_contador_iteraciones <= '0';
				enable_actualiza_salida <= '0';
				
			WHEN PASO1 =>
				enable_carga_paso1 <='1';
				reinicia <= '0';
				enable_desplaza_paso2 <= '0';
				enable_contador_iteraciones <='0';
				enable_actualiza_salida <= '0';
				
			WHEN PASO2 =>
				enable_desplaza_paso2 <= '1';
				reinicia <= '0';
				enable_carga_paso1 <='0';
				enable_contador_iteraciones <= '1'; 
				enable_actualiza_salida <= '0';
				
			WHEN FIN =>
				enable_desplaza_paso2 <= '0';
				reinicia <= '0';
				enable_carga_paso1 <='0';
				enable_contador_iteraciones <= '0'; 
				enable_actualiza_salida <= '1';
			END CASE;
	END PROCESS;
	
	NEXT_STATE_PROC:PROCESS(current_state,dato,iteracion)
		BEGIN
			CASE (current_state) is
				WHEN START =>
					next_state <= PASO1;
				WHEN PASO1 =>
					next_state <= PASO2;
				WHEN PASO2 =>
					IF(iteracion = 7) THEN
						next_state <= FIN;
					ELSE 
						next_state <= PASO1;
					END IF;
				WHEN FIN =>
					next_state <= START;	
		END CASE;
	END PROCESS;
-- #############################################				
				
	-- RegDesp_BINARIO
	PROCESS(clk) 
		BEGIN
			IF (clk ='1' and clk'event) THEN
				IF (reinicia ='1') THEN
					BINARIO <= dato;
				ELSIF(enable_desplaza_paso2 = '1') THEN
						BINARIO <= BINARIO(6 DOWNTO 0) & '0';
				END IF;
			END IF;	
	END PROCESS;
		
	-- RegDesp_DIG1	
	PROCESS(clk) 
		BEGIN
			IF(clk='1' and clk'event) THEN
				IF(reinicia ='1') THEN
					DIGITO1 <= "0000";
				ELSIF(enable_carga_paso1 = '1') THEN
					IF (DIGITO1 >= 5) THEN
						DIGITO1 <= DIGITO1 +3;
					END IF;
				ELSIF(enable_desplaza_paso2 = '1') THEN
						DIGITO1 <= DIGITO1(2 DOWNTO 0) & BINARIO(7);
				END IF;
			END IF;
	END PROCESS;
		
	-- RegDesp_DIG2	
	PROCESS(clk) 
		BEGIN
			IF(clk='1' and clk'event) THEN
				IF(reinicia ='1') THEN
					DIGITO2 <= "0000";
				ELSIF(enable_carga_paso1 = '1') THEN
					IF (DIGITO2 >= 5) THEN
							DIGITO2 <= DIGITO2 +3;
					END IF;
				ELSIF (enable_desplaza_paso2 = '1') THEN
						DIGITO2 <= DIGITO2(2 DOWNTO 0) & DIGITO1(3);
				END IF;
			END IF;
	END PROCESS;

	-- RegDesp_DIG3
	PROCESS(clk) 
		BEGIN
			IF(clk='1' and clk'event) THEN
				IF(reinicia ='1') THEN
					DIGITO3 <= "0000";
				ELSIF(enable_carga_paso1 = '1') THEN
					IF (DIGITO3 >= 5) THEN
						DIGITO3 <= DIGITO3 +3;
					END IF;
				ELSIF(enable_desplaza_paso2 ='1') THEN
					DIGITO3 <= DIGITO3(2 DOWNTO 0) & DIGITO2(3);		
				END IF;
			END IF;
	END PROCESS;
		
	-- Contador de ITERACIONES
	PROCESS(clk) 
		BEGIN
		IF(clk ='1' and clk'EVENT) THEN
			IF (reinicia = '1') THEN
				iteracion <= "0000";
			ELSIF(enable_contador_iteraciones = '1') THEN
				IF (iteracion = 7) THEN
					iteracion <= (OTHERS => '0');
				ELSE
					iteracion <= iteracion+1;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	-- RegUNI
	PROCESS(clk,reset) 
		BEGIN
		IF( reset = '1')THEN
			UNIDADES <= (OTHERS => '0');
		ELSIF(clk ='1' and clk'EVENT) THEN
			IF (enable_actualiza_salida = '1') THEN
				UNIDADES <= DIGITO1;
			END IF;
		END IF;
	END PROCESS;
	
	-- RegDEC
	PROCESS(clk,reset) 
		BEGIN
		IF( reset = '1')THEN
			DECENAS <= (OTHERS => '0');
		ELSIF(clk ='1' and clk'EVENT) THEN
			IF (enable_actualiza_salida = '1') THEN
				DECENAS <= DIGITO2;
			END IF;
		END IF;
	END PROCESS;
	
	-- RegCEN
	PROCESS(clk,reset) 
		BEGIN
			IF( reset = '1')THEN
				CENTENAS <= (OTHERS => '0');
			ELSIF(clk ='1' and clk'EVENT) THEN
				IF (enable_actualiza_salida = '1') THEN
					CENTENAS <= DIGITO3;
				END IF;
			END IF;
	END PROCESS;
	
	-- Contador 400us
	PROCESS(clk,reset) 
		BEGIN
			IF (reset = '1') THEN
				count <= (OTHERS => '0');
			ELSIF (clk='1' and clk'EVENT) THEN
				IF(count = 19999) THEN -- Contamos 20000 ciclos de reloj = 400us y reiniciamos la cuenta
					count <= (OTHERS => '0');	
				ELSE
					count <= count + 1;	
				END IF;
			END IF;
	END PROCESS;
	
	 --Tiempo de refresco o delay
	PROCESS(count)
		BEGIN
			IF (count = 19999) THEN -- cada 400 us ponemos actualiza_dispaly a 1
				actualiza_display <='1';
			ELSE
				actualiza_display <= '0';
			END IF;
	END PROCESS;
	
	-- REG an_display		
	PROCESS(clk,reset) 
		BEGIN
			IF (reset = '1') THEN
				reg <= "1110";
			ELSIF (clk = '1' and clk'event) THEN
				IF (actualiza_display = '1') THEN -- cada 400us, actualiza display deberá ser 1 y se desplazará a la izq para pasar al siguiente estado
					reg <= reg(2 DOWNTO 0) & reg(3);
				END IF;
			END IF;
	END PROCESS;
	
	AN_display7seg <= reg;

	-- Valor en display
	PROCESS (UNIDADES,DECENAS,CENTENAS,reg)
		BEGIN
			IF (reg = "1110") THEN -- 1110 == Unidades
				datoBCD <= UNIDADES;
			ELSIF (reg = "1101") THEN -- 1101 == Decenas
				datoBCD <= DECENAS;
			ELSIF (reg = "1011") THEN -- 1011 == Centenas
				datoBCD <= CENTENAS;
			ELSE								-- Cualquier otro caso
				datoBCD <= "1111";
			END IF;
	END PROCESS;
	
	-- BCD a 7 segmentos
	PROCESS (datoBCD) 
		BEGIN
			CASE datoBCD is
				WHEN "0000" => display7seg <= "00000011"; --  0 <= los segmentos a,b,c,d,e y f se enciENDen
				WHEN "0001" => display7seg <= "10011111"; --  1 <= los segmentos b y c se enciENDen
				WHEN "0010" => display7seg <= "00100101"; --  2 <= los segmentos a,b,d,e y g se enciENDen
				WHEN "0011" => display7seg <= "00001101"; --  3 <= los segmentos a,b,c,d y g se enciENDen
				WHEN "0100" => display7seg <= "10011001"; --  4 <= los segmentos b,c,f y g se enciENDen
				WHEN "0101" => display7seg <= "01001001"; --  5 <= los segmentos a,c,d,f y g se enciENDen
				WHEN "0110" => display7seg <= "01000001"; --  6 <= los segmentos a,c,d,e,f y g se enciENDen
				WHEN "0111" => display7seg <= "00011111"; --  7 <= los segmentos a,b,c se enciENDen
				WHEN "1000" => display7seg <= "00000001"; --  8 <= los segmentos a,b,c,e,f y g se enciENDen
				WHEN "1001" => display7seg <= "00011001"; --  9 <= los segmentos a,b,c,f,g se enciENDen
				WHEN OTHERS => display7seg <= "11111111"; -- otro caso todo apagado
			END CASE;
	END PROCESS;
	
END Behavioral;

