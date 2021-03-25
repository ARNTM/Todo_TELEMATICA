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
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           A_in : in  STD_LOGIC_VECTOR (7 DOWNTO 0);
           B_in : in  STD_LOGIC_VECTOR (7 DOWNTO 0);
           OP_in : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           A_out : out  STD_LOGIC_VECTOR (7 DOWNTO 0);
           B_out : out  STD_LOGIC_VECTOR (7 DOWNTO 0);
           LEDs : out  STD_LOGIC_VECTOR (7 DOWNTO 0);
           TipoOP_out : out  STD_LOGIC_VECTOR (1 DOWNTO 0));

end ALU;

architecture Behavioral of ALU is
			signal OP : STD_LOGIC_VECTOR (4 DOWNTO 0);
			signal DatoA : STD_LOGIC_VECTOR (7 DOWNTO 0);
			signal DatoB : STD_LOGIC_VECTOR (7 DOWNTO 0);
			signal TipoOP : STD_LOGIC_VECTOR (1 DOWNTO 0);
			signal SALIDA_ALU : STD_LOGIC_VECTOR (7 DOWNTO 0);

begin
-- REGISTRO OP_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN
				OP <= "00000";
			ELSIF(clk'EVENT AND clk='1') THEN 
				OP <= OP_in;
			END IF;
	END PROCESS;
	
-- REGISTRO A_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN
				DatoA <= "00000000";
			ELSIF(clk'EVENT AND clk='1') THEN 
				DatoA <= A_in;
			END IF;
	END PROCESS;
	
-- REGISTRO B_IN
	PROCESS(clk,reset)
		BEGIN
			IF (reset='1') THEN
				DatoB <= "00000000";
			ELSIF(clk'EVENT AND clk='1') THEN 
				DatoB <= B_in;
			END IF;
	END PROCESS;
	
-- REGISTRO TIPO OP
	PROCESS(clk,reset)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN 
				TipoOP_out <= TipoOP;
			END IF;
	END PROCESS;
	
-- REGISTRO LEDS
	PROCESS(clk,reset)
		BEGIN
			IF(clk'EVENT AND clk='1') THEN 
				IF(TipoOP="10") THEN
					LEDs <= SALIDA_ALU;
				END IF;
			END IF;
	END PROCESS;


			A_out <= DatoA;
			B_out <= DatoB;

-- ALU (MULTIPLEXOR)
	PROCESS(OP,DatoA,DatoB)
		BEGIN
			CASE OP IS
				WHEN "00001" => SALIDA_ALU <= DatoA OR DatoB;
				WHEN "00010" => SALIDA_ALU <= DatoA AND DatoB;
				WHEN "00011" => SALIDA_ALU <= DatoA XOR DatoB;
				WHEN "00100" => SALIDA_ALU <= DatoA NAND DatoB;
				WHEN "00101" => SALIDA_ALU <= NOT DatoA;
				WHEN "00110" =>
					SALIDA_ALU(6)  <= DatoA(7);
					SALIDA_ALU(5)  <= DatoA(6);
					SALIDA_ALU(4)  <= DatoA(5);
					SALIDA_ALU(3)  <= DatoA(4);
					SALIDA_ALU(2)  <= DatoA(3);
					SALIDA_ALU(1)  <= DatoA(2);
					SALIDA_ALU(0)  <= DatoA(1);
					SALIDA_ALU(7)  <= DatoA(0);
				WHEN "00111" =>
					SALIDA_ALU(7)  <= DatoA(6);
					SALIDA_ALU(6)  <= DatoA(5);
					SALIDA_ALU(5)  <= DatoA(4);
					SALIDA_ALU(4)  <= DatoA(3);
					SALIDA_ALU(3)  <= DatoA(2);
					SALIDA_ALU(2)  <= DatoA(1);
					SALIDA_ALU(1)  <= DatoA(0);
					SALIDA_ALU(0)  <= DatoA(7);
				WHEN others => SALIDA_ALU <= "00000000";
			END CASE;
	END PROCESS;

-- TipoOP
	PROCESS(OP)
		BEGIN
			IF(OP="00001" or OP="00010" or OP="00011" or OP="00100" or OP="00101" or OP="00110" or OP="00111") THEN
				TipoOP <= "10";
			ELSE
				TipoOP <= "00";
			END IF;
	END PROCESS;
		
end Behavioral;

-- Codigos de operaciones lógicas que puede realizar la ALU

-- OR = 00001
-- AND = 00010
-- XOR = 00011
-- NAND = 00100
-- NOT A = 00101
-- RR A = 00110
-- RL A = 00111
