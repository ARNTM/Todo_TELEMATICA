--
------------------------------------------------------------------------------------
--
-- Definition of write enable for register bank and flags
--
-- This function decodes all instructions which result in a value being stored
-- in the data registers and those cases in which the flags must be enabled.
--
-- The generation of a register enable pulse is prevented by an active interrupt condition.
-- The single cycle pulse timing of each enable is determined by the T-state.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity register_and_flag_enable is
    Port (i_logical: in std_logic;
	 		 i_arithmetic: in std_logic;
			 i_shift_rotate: in std_logic;
--			 i_flip: in std_logic;				 -- added new instruction
			 i_returni: in std_logic;
			 i_input: in std_logic;
          active_interrupt : in std_logic;
          T_state : in std_logic;
          register_enable : out std_logic;
          flag_enable : out std_logic;
          clk : in std_logic);
    end register_and_flag_enable;
--
architecture low_level_definition of register_and_flag_enable is
--
-- Internal signals
--
signal reg_instruction_decode  : std_logic;
signal register_write_valid    : std_logic;
signal returni_or_shift_decode : std_logic;
signal returni_or_shift_valid  : std_logic;
signal arith_or_logical_decode : std_logic;
signal arith_or_logical_valid  : std_logic;
--
begin
  --
  -- Register enable
  --
  -- added new instruction, uncomment this instruction and comment next instruction
  -- to enable the new instruction
  -- reg_instruction_decode <= (i_logical or i_arithmetic or i_shift_rotate or i_input or i_flip) 
  --								and (not active_interrupt);

  reg_instruction_decode <= (i_logical or i_arithmetic or i_shift_rotate or i_input) 
  								and (not active_interrupt);

  reg_pipeline_bit:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		register_write_valid <= reg_instruction_decode;
	end if;
  end process reg_pipeline_bit;

  register_enable <= register_write_valid and T_state;
  --
  -- Flag enable
  --
	 arith_or_logical_decode <= i_logical or i_arithmetic;

  flag_pipeline1_bit:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		arith_or_logical_valid <= arith_or_logical_decode;
	end if;
  end process flag_pipeline1_bit;

  returni_or_shift_decode <= i_shift_rotate or i_returni;

  flag_pipeline2_bit:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		returni_or_shift_valid <= returni_or_shift_decode;
	end if;
  end process flag_pipeline2_bit;

  flag_enable <= (returni_or_shift_valid and arith_or_logical_valid and T_state) or
              (returni_or_shift_valid and (not arith_or_logical_valid) and T_state) or
              ((not returni_or_shift_valid) and arith_or_logical_valid and T_state);
--
end low_level_definition;
--
