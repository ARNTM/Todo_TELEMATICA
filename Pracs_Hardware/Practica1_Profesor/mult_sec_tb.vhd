LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY testbench_mult_sec IS
END testbench_mult_sec;

ARCHITECTURE behavior OF testbench_mult_sec IS 

	COMPONENT mult_sec
	PORT(inbus  : IN std_logic_vector(7 downto 0);
		   i      : IN std_logic;
		   weq    : IN std_logic;
		   wem    : IN std_logic;
		   rst    : IN std_logic;
		   clk    : IN std_logic;          
		   outbus : OUT std_logic_vector(15 downto 0)  	);
	END COMPONENT;

	SIGNAL inbus :  std_logic_vector(7 downto 0):="00000000";
	SIGNAL outbus :  std_logic_vector(15 downto 0);
	SIGNAL i :  std_logic:='0';
	SIGNAL weqm :  std_logic:='0';
	SIGNAL wemm :  std_logic:='0';
	SIGNAL rst :  std_logic:='1';
	SIGNAL clk :  std_logic:='0';

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
	   inbus <= "00001011"; -- operando M= 11 
		wemm <= '1';
		wait for 1*periodo;
		wemm <= '0';
		wait for 1*periodo;
		inbus <= "00001101"; -- operando Q= 13 
		weqm <= '1';
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