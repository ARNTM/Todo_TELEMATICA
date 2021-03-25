--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:26:53 06/13/2019
-- Design Name:   
-- Module Name:   D:/GIT/Pracs_Microprocesadores/VHDL/Practica3/tb_Display7Seg.vhd
-- Project Name:  Practica3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Display7Seg
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
USE ieee.numeric_std.ALL;
 
ENTITY tb_Display7Seg IS
END tb_Display7Seg;
 
ARCHITECTURE behavior OF tb_Display7Seg IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Display7Seg
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         dato : IN  std_logic_vector(7 downto 0);
         AN_display7seg : OUT  std_logic_vector(3 downto 0);
         display7seg : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal dato : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal AN_display7segm : std_logic_vector(3 downto 0);
   signal display7segm : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Display7Seg PORT MAP (
          clk => clk,
          reset => reset,
          dato => dato,
          AN_display7seg => AN_display7segm,
          display7seg => display7segm
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
		reset <= '1';
		
		wait for 100 ns;
		reset <= '0';
		
      wait for 100 ns;	
      dato <= "10000011";
		
		wait for 1600 us;		
		dato <= "01001100";
		
		wait for 1600 us;		
		dato <= "00000000";	
		
		wait for 1600 us;		
		dato <= "00000000";
				
		wait for 1600 us;		
		dato <= "00001111";
				
		wait for 1600 us;		
		dato <= "11111111";
				
		wait for 1600 us;		
		dato <= "00000001";
				
		wait for 1600 us;		
		dato <= "10010100";


      -- insert stimulus here 

      wait;
   end process;

END;
