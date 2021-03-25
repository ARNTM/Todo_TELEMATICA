--
-- Definition of an 8-bit logical processing unit
--	
-- This function provide the logical bit operations.
-- The function contains an output pipeline register using 8 FDs.
--
--     Code1    Code0       Bit Operation
--
--       0        0            LOAD      Y <= second_operand 
--       0        1            AND       Y <= first_operand and second_operand
--       1        0            OR        Y <= first_operand or second_operand 
--       1        1            XOR       Y <= first_operand xor second_operand
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--library unisim;
--use unisim.vcomponents.all;
--
entity logical_bus_processing is
    Port (first_operand : in std_logic_vector(7 downto 0);
          second_operand : in std_logic_vector(7 downto 0);
          code1 : in std_logic;
          code0 : in std_logic;
          Y : out std_logic_vector(7 downto 0);
          clk : in std_logic);
    end logical_bus_processing;
--
architecture low_level_definition of logical_bus_processing is
--
-- Internal signals
--
signal combinatorial_logical_processing : std_logic_vector(7 downto 0);
signal sel: std_logic_vector(1 downto 0);
--
begin
 
  sel <= code1 & code0;
  bus_width_loop: for i in 0 to 7 generate
  --
  begin

 	  combinatorial_logical_processing(i) <= (first_operand(i) xor second_operand(i)) 
	  		when (code1 = '1' and code0 = '1') else
	  (first_operand(i) or second_operand(i))
	  		when (code1 = '1' and code0 = '0') else
	  (first_operand(i) and second_operand(i))
	  		when (code1 = '0' and code0 = '1') else
	  second_operand(i);

     pipeline_bit:
	  process (clk)
	  begin
	  	if clk'event and clk = '1' then
			Y(i) <= combinatorial_logical_processing(i);
		end if;
	  end
	  process pipeline_bit;

  end generate bus_width_loop;
--
end low_level_definition;
--
