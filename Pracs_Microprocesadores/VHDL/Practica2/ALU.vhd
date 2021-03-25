----------------------------------------------------------------------------------
-- Company: 	UPCT - SDBM
-- Engineer:	Andres Ruz Nieto y Diego Ismael Antolinos Garcia
-- 
-- Create Date:    18:30:11 05/12/2019 
-- Design Name: 	 
-- Module Name:    ALU - Behavioral 
-- Project Name:   ALU Design
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
-- Aquí se ponen solo las entradas y las salidas de la "caja"
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           A_in : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           B_in : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
           OP_in : in  STD_LOGIC_VECTOR(4 DOWNTO 0);
           A_out : out  STD_LOGIC_VECTOR(8 DOWNTO 0);
           B_out : out  STD_LOGIC_VECTOR(8 DOWNTO 0);
           LEDs : out  STD_LOGIC_VECTOR(7 DOWNTO 0);
           RESULTADO : out  STD_LOGIC_VECTOR(8 DOWNTO 0);
           CERO : out  STD_LOGIC;
           SIGNO : out  STD_LOGIC;
           TipoOP_out : out  STD_LOGIC_VECTOR(1 DOWNTO 0));

end ALU;

architecture Behavioral of ALU is
-- Declaramos las señales internas
			signal OP : STD_LOGIC_VECTOR (4 DOWNTO 0);
			signal DatoA : signed(8 DOWNTO 0);
			signal DatoB : signed(8 DOWNTO 0);
			signal TipoOP : STD_LOGIC_VECTOR (1 DOWNTO 0);
			signal SALIDA_ALU : signed(8 DOWNTO 0);

begin
-- REGISTRO OP_IN, creamos el registro destinado a guardar OP_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN -- Si reset está activado pon OP a 0
				OP <= "00000";
			ELSIF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza OP
				OP <= OP_in;
			END IF;
	END PROCESS;
	
-- REGISTRO A_IN, creamos el registro destinado a guardar A_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN -- Si reset esta activado pon DatoA a 0
				DatoA <= "000000000";
			ELSIF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza DatoA
				IF(A_in(7)='0') THEN DatoA <= '0' & signed(A_in);
				ELSE DatoA <= '1' & signed(A_in);
				END IF;
			END IF;
	END PROCESS;
	
-- REGISTRO B_IN, creamos el registro destinado a guardar B_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN -- Si reset esta activado pon DatoB a 0
				DatoB <= "000000000";
			ELSIF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza DatoB
				DatoB <= B_in(7) & signed(B_in); -- Copiamos el bit más significativo para mantener el signo
			END IF;
	END PROCESS;
	
-- REGISTRO TIPO OP, creamos el registro destinado a guardar TIPO OP
	PROCESS(clk)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza TipoOP_out
				TipoOP_out <= TipoOP;
			END IF;
	END PROCESS;
	
-- REGISTRO LEDS
	PROCESS(clk)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza LEDS
				IF(TipoOP="10" or TipoOP="11") THEN -- Comprobamos el tipo de operación que realizamos
					LEDs <= STD_LOGIC_VECTOR(SALIDA_ALU(7 downto 0));
				ELSE LEDs <= "00000000";
				END IF;
			END IF;
	END PROCESS;
	
-- REGISTRO CERO
	PROCESS(clk)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza CERO
				IF(SALIDA_ALU="000000000") THEN -- Si la SALIDA_ALU es 0 ponemos CERO a 1, si no, CERO es 0
					CERO <= '1';
				ELSE
					CERO <= '0';
				END IF;
			END IF;
	END PROCESS;

-- REGISTRO SIGNO
	PROCESS(clk)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza SIGNO
				IF(SALIDA_ALU(8)='1' and TipoOP="01") THEN -- Si realizamos una operacion aritmetica y el signo es -, ponemos SIGNO a 1, si no, SIGNO es 0
					SIGNO <= '1';
				ELSE
					SIGNO <= '0';
				END IF;
			END IF;
	END PROCESS;
	
	-- REGISTRO RESULTADO
	PROCESS(clk)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN -- Si llega un ciclo de reloj actualiza RESULTADO
				IF(TipoOP="01") THEN -- Si la operación es aritmética metemos su valor en RESULTADO
					RESULTADO <= STD_LOGIC_VECTOR(SALIDA_ALU);
				ELSE
					RESULTADO <= "000000000";
				END IF;
			END IF;
	END PROCESS;

			A_out <= STD_LOGIC_VECTOR(DatoA);  -- Damos valor a A_out
			B_out <= STD_LOGIC_VECTOR(DatoB);  -- Damos valor a B_out

-- ALU (MULTIPLEXOR)
	PROCESS(OP,DatoA,DatoB)
		BEGIN
			CASE OP IS -- Creamos un SWITCH de Java, para cada caso de OP, los codigos de 
						  -- las distintas operaciones se pueden ver a continuacion
						  
				-- ###### LOGICAS	
				WHEN "00001" => SALIDA_ALU <= DatoA OR DatoB; -- OR = 00001
				WHEN "00010" => SALIDA_ALU <= DatoA AND DatoB; -- AND = 00010
				WHEN "00011" => SALIDA_ALU <= DatoA XOR DatoB; -- XOR = 00011
				WHEN "00100" => SALIDA_ALU <= DatoA NAND DatoB; -- NAND = 00100
				WHEN "00101" => SALIDA_ALU <= NOT DatoA; -- NOT A = 00101
				WHEN "00110" =>
					SALIDA_ALU	<= DatoA(8) & DatoA(0) & DatoA(7 downto 1); -- RR A = 00110
				WHEN "00111" =>
					SALIDA_ALU	<= DatoA(8) & DatoA(6 downto 0) & DatoA(7); -- RL A = 00111
					
				-- ###### ARITMETICAS
				WHEN "01000" => SALIDA_ALU <= DatoA; -- A+0 = 01000
				WHEN "01001" => SALIDA_ALU <= DatoB; -- B+0 = 01001
				WHEN "01010" => SALIDA_ALU <= DatoA+DatoB; -- A+B = 01010
				WHEN "01111" => SALIDA_ALU <= DatoA-DatoB; -- A-B = 01111
				WHEN "01100" => SALIDA_ALU <= DatoA+1; -- A+1 = 01100
				WHEN "01101" => SALIDA_ALU <= DatoA-1; -- A-1 = 01101
				WHEN "01110" => SALIDA_ALU <= DatoA(7 downto 0) & '0'; -- 2*A = 01110
				WHEN "01011" => SALIDA_ALU <= DatoA(8) & DatoA(8 downto 1); -- A/2 = 01011
				WHEN "10000" => 
					IF(DatoA(8)='1') THEN
						SALIDA_ALU <= NOT DatoA + 1; -- |A| = 10000, para numeros negativos
					ELSE
						SALIDA_ALU <= DatoA; -- |A| = 10000, para numeros positivos
					END IF;
				WHEN "10001" =>  -- MAX(A,B) = 10001
					IF (DatoA < DatoB) THEN -- Si A es menor que B, SALIDA_ALU es DatoB
						SALIDA_ALU <= DatoB;
					ELSE	 -- Si no, SALIDA_ALU es DatoA
						SALIDA_ALU <= DatoA;
					END IF;	
				WHEN "10010" =>  -- MIN(A,B) = 10010
					IF (DatoA > DatoB) THEN  -- Si A es mayor que B, SALIDA_ALU es DatoB
						SALIDA_ALU <= DatoB;
					ELSE	 -- Si no, SALIDA_ALU es DatoA
						SALIDA_ALU <= DatoA; 
					END IF;
					
				
				-- ###### COMPARACION
				WHEN "10011" => -- A<B = 10011
					IF (DatoA < DatoB) THEN -- Si A es menor que B, SALIDA_ALU es 1, si no, es 0
						SALIDA_ALU <= "000000001";
					ELSE
						SALIDA_ALU <= "000000000";
					END IF;
				WHEN "10100" => -- A>B = 10100					
					IF (DatoA > DatoB) THEN -- Si A es mayor que B, SALIDA_ALU es 1, si no, es 0
						SALIDA_ALU <= "000000001";
					ELSE
						SALIDA_ALU <= "000000000";
					END IF;
				WHEN "10101" => -- A=B = 10101
					IF(DatoA = DatoB) THEN -- Si A es igual que B, SALIDA_ALU es 1, si no, es 0
						SALIDA_ALU <= "000000001";
					ELSE
						SALIDA_ALU <= "000000000";
					END IF;
				WHEN others => SALIDA_ALU <= "000000000";
			END CASE;
	END PROCESS;

-- TipoOP
	PROCESS(OP)
		BEGIN
			IF(OP="00001" or OP="00010" or OP="00011" or OP="00100" or OP="00101" or OP="00110" or OP="00111") THEN
				TipoOP <= "10"; -- Operación LÓGICA
			ELSIF(OP="10011" or OP="10100" or OP="10101") THEN
				TipoOP <= "11"; -- Operación de COMPARACIÓN
			ELSIF(OP="01000" or OP="01001" or OP="01010" or OP="01111" or OP="01100" or OP="01101" or OP="01110" or OP="01011" or OP="10000" or OP="10001" or OP="10010") THEN
				TipoOP <= "01"; -- Operación ARITMÉTICA
			ELSE
				TipoOP <= "00";
			END IF;
	END PROCESS;
		
end Behavioral;