----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:16 10/09/2020 
-- Design Name: 
-- Module Name:    mult_sec_mod_tb - Behavioral 
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench_mult_sec_mod IS
END testbench_mult_sec_mod;

ARCHITECTURE behavior OF testbench_mult_sec_mod IS 

	COMPONENT mult_sec
	PORT(inbus_Q  : IN std_logic_vector(31 downto 0);
		  inbus_M  : IN std_logic_vector(31 downto 0);
		   i      : IN std_logic;
		   rst    : IN std_logic;
		   clk    : IN std_logic;          
		   outbus : OUT std_logic_vector(63 downto 0)  	);
	END COMPONENT;

	SIGNAL inbus_Q :  std_logic_vector(31 downto 0):="00000000";
	SIGNAL inbus_M :  std_logic_vector(31 downto 0):="00000000";
	SIGNAL outbus :  std_logic_vector(63 downto 0);
	SIGNAL i :  std_logic:='0';
	SIGNAL weqm :  std_logic:='1';
	SIGNAL wemm :  std_logic:='1';
	SIGNAL rst :  std_logic:='1';
	SIGNAL clk :  std_logic:='0';
	SIGNAL weq : std_logic;
	SIGNAL wem : std_logic;

	constant periodo: time := 100 ns;

BEGIN

	uut: mult_sec PORT MAP(
		inbus => inbus,
		outbus => outbus,
		i => i,
		weq => weqm,
		wem => wemm,
		rst => rst,
		clk => clk 	);

	clk <= not clk after periodo/2;

-- Asignacion secuencial de estimulos
   tb : PROCESS
   BEGIN
	   rst <= '1';					--reset inicial
	   wait for 2*periodo;
	   rst <= '0';					--desactivamos el reset
	   wait for 2*periodo;
	   inbus_Q <= "00000000000000000010001111000000"; -- operando M= 9152 
		inbus_M <= "00000000000000000000000000000101"; -- operando M= 5

		wait for 1*periodo;
		weqm <= '0';
		wait for 1*periodo;
		inbus <= x"00";	        -- Inbus = 0
	   I <= '1';					  --inicio de la multiplicacion
	   wait for periodo;
	   I <= '0';
	   wait for 16*periodo; -- resultado aparece tras 16 ciclos
     
		 wait;             --esperamos indefinidamente
   END PROCESS;

END;