--
-- Definition of interrupt signal capture
--	
-- This function accepts the external interrupt signal and synchronises it to the 
-- processor logic. It then forms a single cycle pulse provided that interrupts 
-- are currently enabled.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity interrupt_capture is
    Port (interrupt : in std_logic;
          T_state : in std_logic;
          reset : in std_logic;
          interrupt_enable : in std_logic;
          active_interrupt : out std_logic;
          clk : in std_logic);
    end interrupt_capture;
--
architecture low_level_definition of interrupt_capture is
--
-- Internal signals
--
signal clean_interrupt        : std_logic;
signal interrupt_pulse        : std_logic;
signal active_interrupt_pulse : std_logic;
--
begin

  input_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			clean_interrupt <= '0';
		else clean_interrupt <= interrupt;
		end if;
	end if;
  end process input_flop;

  interrupt_pulse <= (not active_interrupt_pulse) and interrupt_enable and clean_interrupt and T_state;

  toggle_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			active_interrupt_pulse <= '0';
		else active_interrupt_pulse <= interrupt_pulse;
		end if;
	end if;
  end process toggle_flop;

  active_interrupt <= active_interrupt_pulse;

--
end low_level_definition;
--
