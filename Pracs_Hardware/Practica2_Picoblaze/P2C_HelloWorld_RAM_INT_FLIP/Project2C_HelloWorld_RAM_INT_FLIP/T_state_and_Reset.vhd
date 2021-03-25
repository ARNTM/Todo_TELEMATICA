--
-- Definition of basic time T-state and clean reset
--
-- This function forms the basic 2 cycle T-state control used by the processor.
-- It also forms a clean synchronous reset pulse that is long enough to ensure
-- correct operation at start up and following a reset input.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity T_state_and_Reset is
    Port (    reset_input : in std_logic;
           internal_reset : out std_logic;
                  T_state : out std_logic;
                      clk : in std_logic);
    end T_state_and_Reset;
--
architecture low_level_definition of T_state_and_Reset is
--
-- Internal signals
--
signal reset_delay1     : std_logic;
signal reset_delay2     : std_logic;
signal not_T_state      : std_logic;
signal internal_T_state : std_logic;
--
begin
  --
  delay_flop1:
  process (clk)
  begin
        if clk'event and clk = '1' then
            reset_delay1 <= reset_input;
        end if;
  end process delay_flop1;

  delay_flop2:
  process (clk)
  begin
        if clk'event and clk = '1' then
            reset_delay2 <= reset_delay1 or reset_input;
        end if;
  end process delay_flop2;

  not_T_state <= not internal_T_state;

  toggle_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if (reset_delay2 = '1') then
			internal_T_state <= '0';
		else internal_T_state <= not_T_state;
		end if;
	end if;
  end process toggle_flop;

  T_state <= internal_T_state;
  internal_reset <= reset_delay2;
--
end low_level_definition;
--
