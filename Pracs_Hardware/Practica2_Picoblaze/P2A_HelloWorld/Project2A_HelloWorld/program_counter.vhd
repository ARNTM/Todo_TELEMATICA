--
-- Definition of an 8-bit program counter
--
-- This function provides the control to the dual loadable counter
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity program_counter is
    Port (i_jump             : in std_logic;
	 		 i_call             : in std_logic;
	 		 i_return           : in std_logic;
			 i_returni          : in std_logic;
          conditional        : in std_logic;
          low_instruction    : in std_logic_vector(7 downto 0);
          stack_value        : in std_logic_vector(7 downto 0);
          flag_condition_met : in std_logic;
          T_state            : in std_logic;
          reset              : in std_logic;
          interrupt          : in std_logic;
          program_count      : out std_logic_vector(7 downto 0);
          clk                : in std_logic);
    end program_counter;
--
architecture low_level_definition of program_counter is
--
-- Internal signals
--
signal move_group       : std_logic;
signal normal_count     : std_logic;
signal select_load_value : std_logic;
signal selected_load_value   : std_logic_vector(7 downto 0);
signal count_value           : std_logic_vector(7 downto 0);
--
begin

  move_group <= i_jump or i_call or i_return or i_returni;

  normal_count <= (not move_group) or
  					   (move_group and (not flag_condition_met) and conditional);

  select_load_value <= i_jump or i_call;

  selected_load_value <= low_instruction when select_load_value = '1' else stack_value;

   dual_loadable_counter:
	process (clk)
	begin
		if clk'event and clk = '1' then
			if interrupt = '1' then
				count_value <= "11111111";
			else if reset = '1' then
				count_value <= "00000000";
			else if T_state = '0' then
				if normal_count = '1' then
					count_value <= count_value + 1;
				else if i_return = '1' then
					count_value <= selected_load_value + 1;
				else count_value <= selected_load_value;
				end if; -- increment_load_value
				end if; -- normal_count
			end if; -- enable_bar
			end if; -- reset
			end if; -- ce_3FF
		end if; -- clk
	end process dual_loadable_counter;
	program_count <= count_value;
--
--
end low_level_definition;

