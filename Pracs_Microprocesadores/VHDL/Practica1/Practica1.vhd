--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:26:46 05/13/2019
-- Design Name:   
-- Module Name:   D:/GIT/Pracs_Microprocesadores/VHDL/Practica1/Practica1.vhd
-- Project Name:  Practica1
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
 
ENTITY Practica1 IS
END Practica1;
 
ARCHITECTURE behavior OF Practica1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         A_in : IN  std_logic_vector(7 downto 0);
         DatoA : INOUT  std_logic_vector(7 downto 0);
         B_in : IN  std_logic_vector(7 downto 0);
         DatoB : INOUT  std_logic_vector(7 downto 0);
         OP_in : IN  std_logic_vector(4 downto 0);
         OP : INOUT  std_logic_vector(4 downto 0);
         A_out : OUT  std_logic_vector(7 downto 0);
         B_out : OUT  std_logic_vector(7 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0);
         TipoOP_out : INOUT  std_logic_vector(1 downto 0);
         TipoOP : IN  std_logic_vector(1 downto 0);
         SALIDA_ALU : INOUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal A_in : std_logic_vector(7 downto 0) := (others => '0');
   signal B_in : std_logic_vector(7 downto 0) := (others => '0');
   signal OP_in : std_logic_vector(4 downto 0) := (others => '0');
   signal TipoOP : std_logic_vector(1 downto 0) := (others => '0');

	--BiDirs
   signal DatoA : std_logic_vector(7 downto 0);
   signal DatoB : std_logic_vector(7 downto 0);
   signal OP : std_logic_vector(4 downto 0);
   signal TipoOP_out : std_logic_vector(1 downto 0);
   signal SALIDA_ALU : std_logic_vector(7 downto 0);

 	--Outputs
   signal A_out : std_logic_vector(7 downto 0);
   signal B_out : std_logic_vector(7 downto 0);
   signal LEDs : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          clk => clk,
          reset => reset,
          A_in => A_in,
          DatoA => DatoA,
          B_in => B_in,
          DatoB => DatoB,
          OP_in => OP_in,
          OP => OP,
          A_out => A_out,
          B_out => B_out,
          LEDs => LEDs,
          TipoOP_out => TipoOP_out,
          TipoOP => TipoOP,
          SALIDA_ALU => SALIDA_ALU
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

      wait;
   end process;

END;
