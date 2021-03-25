--
-- Definition of the Carry Flag
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity carry_flag_logic is
    Port (add_sub : in std_logic;
          shift : in std_logic;
          returni : in std_logic;
          shift_carry : in std_logic;
          add_sub_carry : in std_logic;
          shadow_carry : in std_logic;
          reset : in std_logic;
          flag_enable : in std_logic;
          carry_flag : out std_logic;
          clk : in std_logic);
    end carry_flag_logic;
--
architecture low_level_definition of carry_flag_logic is
--
-- Internal signals
--
signal carry_status    : std_logic;
signal next_carry_flag : std_logic;
--
begin
  --
  carry_status <= (shift_carry and shift) or (add_sub_carry and add_sub);
  --
  -- Select new carry status or the shaddow flag for a RETURNI
  --
  next_carry_flag  <= (shadow_carry and returni) or (shadow_carry and carry_status) or
                 (carry_status and (shift or add_sub));

  carry_flag_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			carry_flag <= '0';
		else if flag_enable = '1' then
			carry_flag <= next_carry_flag;
		end if;
		end if;
	end if;
  end process carry_flag_flop;
--
end low_level_definition;
--
