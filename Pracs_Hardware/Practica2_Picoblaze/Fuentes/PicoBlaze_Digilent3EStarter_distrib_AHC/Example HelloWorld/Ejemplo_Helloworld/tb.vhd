LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS
END tb;

ARCHITECTURE behavior OF tb IS 

	COMPONENT toplevel
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		interrupt : IN std_logic;
		rx : IN std_logic;          
		port_id : OUT std_logic_vector(7 downto 0);
		write_strobe : OUT std_logic;
		read_strobe : OUT std_logic;
		out_port : OUT std_logic_vector(7 downto 0);
		in_port : OUT std_logic_vector(7 downto 0);
		tx : OUT std_logic;
		LED : OUT std_logic
		);
	END COMPONENT;

	SIGNAL port_id :  std_logic_vector(7 downto 0);
	SIGNAL write_strobe :  std_logic;
	SIGNAL read_strobe :  std_logic;
	SIGNAL out_port :  std_logic_vector(7 downto 0);
	SIGNAL in_port :  std_logic_vector(7 downto 0);
	SIGNAL reset :  std_logic;
	SIGNAL clk :  std_logic:='0';
	SIGNAL interrupt :  std_logic;
	SIGNAL rx :  std_logic;
	SIGNAL tx :  std_logic;
	SIGNAL LED :  std_logic;

BEGIN

	uut: toplevel PORT MAP(
		port_id => port_id,
		write_strobe => write_strobe,
		read_strobe => read_strobe,
		out_port => out_port,
		in_port => in_port,
		reset => reset,
		clk => clk,
		interrupt => interrupt,
		rx => rx,
		tx => tx,
		LED => LED
	);

	 clk <= not clk after 10 ns;
	 reset <= '1', '0' after 200 ns;
	 interrupt <= '0';
	 
-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
			rx <= '1'; --linea de recepcion inactiva
			wait for 20 us;
	 		rx <= '0';	--bit de inicio
			wait for 8.68 us; --OJO: para transmitir a 9600 bps poner 104.16 us
									  --     para transmitir a 115200 bps poner 8.68 us
	 		rx <= '1';	--enviamos una A (=0100.0001)
			wait for 8.68 us;
			rx <= '0';
			wait for 8.68 us;
	 		rx <= '0';
			wait for 8.68 us;
	 		rx <= '0';
			wait for 8.68 us;
	 		rx <= '0';
			wait for 8.68 us;
	 		rx <= '0';
			wait for 8.68 us;
	 		rx <= '1';
			wait for 8.68 us;
	 		rx <= '0';
			wait for 8.68 us;
	 		rx <= '1'; --bit de parada
			wait for 8.68 us;

      wait; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
