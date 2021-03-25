--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:45:25 05/17/2019
-- Design Name:   
-- Module Name:   D:/GIT/Pracs_Microprocesadores/VHDL/Practica2/tb_ALU.vhd
-- Project Name:  Practica2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY tb_ALU IS
END tb_ALU;
 
ARCHITECTURE behavior OF tb_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         A_in : IN  std_logic_vector(7 downto 0);
         B_in : IN  std_logic_vector(7 downto 0);
         OP_in : IN  std_logic_vector(4 downto 0);
         A_out : OUT  std_logic_vector(8 downto 0);
         B_out : OUT  std_logic_vector(8 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0);
         RESULTADO : OUT  std_logic_vector(8 downto 0);
         CERO : OUT  std_logic;
         SIGNO : OUT  std_logic;
         TipoOP_out : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal A_in : std_logic_vector(7 downto 0) := (others => '0');
   signal B_in : std_logic_vector(7 downto 0) := (others => '0');
   signal OP_in : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal A_out : std_logic_vector(8 downto 0);
   signal B_out : std_logic_vector(8 downto 0);
   signal LEDs : std_logic_vector(7 downto 0);
   signal RESULTADO : std_logic_vector(8 downto 0);
   signal CERO : std_logic;
   signal SIGNO : std_logic;
   signal TipoOP_out : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          clk => clk,
          reset => reset,
          A_in => A_in,
          B_in => B_in,
          OP_in => OP_in,
          A_out => A_out,
          B_out => B_out,
          LEDs => LEDs,
          RESULTADO => RESULTADO,
          CERO => CERO,
          SIGNO => SIGNO,
          TipoOP_out => TipoOP_out
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
		wait for 85 ns;	
			reset <= '0';

		wait for 100 ns; 
		
      -- insert stimulus here 
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00010";
		wait for 200 ns;		
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00001";
		wait for 200 ns;		
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00011";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00100";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00101";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00110";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "11010100";
		OP_in <= "00111";
		wait for 200 ns;		
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01000";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01001";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01010";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01111";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01100";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01101";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10001";
		wait for 200 ns;		
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10010";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01110";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "01011";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10000";
		wait for 200 ns;
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10011";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10100";
		wait for 200 ns;	
		
		A_in <= "01110001";
		B_in <= "00110111";
		OP_in <= "10101";
		wait for 200 ns;
		
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "01000";
		wait for 200 ns;
				
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "01010";
		wait for 200 ns;
						
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "01111";
		wait for 200 ns;
								
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "01100";
		wait for 200 ns;
										
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "01101";
		wait for 200 ns;
						
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "10001";
		wait for 200 ns;
												
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "10010";
		wait for 200 ns;
														
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "10011";
		wait for 200 ns;
																
		A_in <= "11110001";
		B_in <= "00110111";
		OP_in <= "10100";
		wait for 200 ns;
																		
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "10101";
		wait for 200 ns;
																				
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "01110";
		wait for 200 ns;
																						
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "01011";
		wait for 200 ns;
																								
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "10000";
		wait for 200 ns;
																										
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "01111";
		wait for 200 ns;
																												
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "01010";
		wait for 200 ns;
																														
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "00110";
		wait for 200 ns;
		
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "00111";
		wait for 200 ns;
				
		A_in <= "11110001";
		B_in <= "11110001";
		OP_in <= "00011";
		wait for 200 ns;
		
		
      wait;
   end process;

END;
