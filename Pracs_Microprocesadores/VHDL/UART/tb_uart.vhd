--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:29:49 07/08/2019
-- Design Name:   
-- Module Name:   D:/GIT/Pracs_Microprocesadores/VHDL/UART/tb_uart.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_uart IS
END tb_uart;
 
ARCHITECTURE behavior OF tb_uart IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         TX_DATA : IN  std_logic_vector(7 downto 0);
         BTN_IN : IN  std_logic;
         TX_READY : OUT  std_logic;
         TSR : OUT  std_logic_vector(9 downto 0);
         TX_OUT : OUT  std_logic;
         RX_IN : IN  std_logic;
         RX_DATA : OUT  std_logic_vector(7 downto 0);
         RX_NEWDATA : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal TX_DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal BTN_IN : std_logic := '0';
   signal RX_IN : std_logic := '0';

 	--Outputs
   signal TX_READY : std_logic;
   signal TSR : std_logic_vector(9 downto 0);
   signal TX_OUT : std_logic;
   signal RX_DATA : std_logic_vector(7 downto 0);
   signal RX_NEWDATA : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART PORT MAP (
          clk => clk,
          reset => reset,
          TX_DATA => TX_DATA,
          BTN_IN => BTN_IN,
          TX_READY => TX_READY,
          TSR => TSR,
          TX_OUT => TX_OUT,
          RX_IN => RX_IN,
          RX_DATA => RX_DATA,
          RX_NEWDATA => RX_NEWDATA
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		RESET <= '0';
		BTN_IN <= '0';
		TX_DATA <= "10010010";
			
      wait for 100 ns;	
			RESET <= '1';
		wait for 100 ns;	
			RESET <= '0';
		
		wait for 1000 ns;
			BTN_IN <= '1';
		
		wait for 100 ns;
			BTN_IN <= '0';
		
		wait for 10 ms;			
		TX_DATA <= "01001110";
			
      wait for 100 ns;	
			RESET <= '1';
		wait for 100 ns;	
			RESET <= '0';
		
		wait for 1000 ns;
			BTN_IN <= '1';
		
		wait for 100 ns;
			BTN_IN <= '0';
			
					RX_IN <= '1';
		RESET <= '1';
		wait for 100 ns;	
			RESET <= '1';
		wait for 100 ns;	
			RESET <= '0';
		wait for 100 ns;
		
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '1';
		
		wait for 1 ms;
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '0';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '1';
		wait for 100 us;
		RX_IN <= '1';

      wait;
   end process;

END;
