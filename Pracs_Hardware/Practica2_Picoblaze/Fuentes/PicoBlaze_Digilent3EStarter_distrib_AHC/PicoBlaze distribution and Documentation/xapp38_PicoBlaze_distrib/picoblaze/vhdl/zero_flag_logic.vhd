--
-- Definition of the Zero Flag
--
-- The ZERO value is detected and stored in an FDRE.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity zero_flag_logic is
    Port (data : in std_logic_vector(7 downto 0);
          returni : in std_logic;
          shadow_zero : in std_logic;
          reset : in std_logic;
          flag_enable : in std_logic;
          zero_flag : out std_logic;
          clk : in std_logic);
    end zero_flag_logic;
--
architecture low_level_definition of zero_flag_logic is
--
-- Internal signals
--
signal lower_zero       : std_logic;
signal upper_zero       : std_logic;
signal lower_zero_carry : std_logic;
signal data_zero        : std_logic;
signal next_zero_flag   : std_logic;
--
begin
  --
  -- Detect all bits in data are zero using wired NOR gate

  lower_zero <= (not data(3)) and (not data(2)) and (not data(1)) and (not data(0));
  upper_zero <= (not data(7)) and (not data(6)) and (not data(5)) and (not data(4));

        lower_zero_carry <= lower_zero;
        data_zero <= (upper_zero) and lower_zero_carry;

 -- Select new zero status or the shaddow flag for a RETURNI
  --
  next_zero_flag <= (data_zero and (not returni)) or
                    (shadow_zero and returni);

  zero_flag_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if ( reset = '1' ) then
			zero_flag <= '0';
		else if (flag_enable = '1') then
			zero_flag <= next_zero_flag;
		end if;
		end if;
	end if;
  end process zero_flag_flop;
--
end low_level_definition;
--
