--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:50:46 07/06/2019
-- Design Name:   
-- Module Name:   D:/GIT/Pracs_Microprocesadores/VHDL/UART/tb_uart_rx.vhd
-- Project Name:  UART
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UART_RX
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
 
ENTITY tb_uart_rx IS
END tb_uart_rx;
 
ARCHITECTURE behavior OF tb_uart_rx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_RX
    PORT(
         RX_IN : IN  std_logic;
         clk : IN  std_logic;
         RESET : IN  std_logic;
         RX_DATA : OUT  std_logic_vector(7 downto 0);
         RX_NEWDATA : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RX_IN : std_logic := '0';
   signal clk : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal RX_DATA : std_logic_vector(7 downto 0);
   signal RX_NEWDATA : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_RX PORT MAP (
          RX_IN => RX_IN,
          clk => clk,
          RESET => RESET,
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

      -- insert stimulus here 
		RX_IN <= '1';
		RESET <= '1';
		wait for 100 ns;	
			RESET <= '0';
		wait for 1 ms;
		
		RX_IN <= '0';
		wait for 104 us;
		
		RX_IN <= '0';
		wait for 104 us;
		
		RX_IN <= '0';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 104 us;
		
		RX_IN <= '0';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 104 us;
		
		RX_IN <= '1';
		wait for 50 ms;
		
		
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
