--
-- Definition of interrupt enable and shaddow flags
--	
-- This function decodes the ENABLE and DSIABLE INTERRUPT instructions as well as
-- the RETURNI ENABLE and RETURNI DISABLE instructions to determine if future interrupts
-- will be enabled.
--
-- It also provideds the shaddow flags which store the flag status at time of an 
-- interrupt.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity interrupt_logic is
    Port (i_interrupt : in std_logic;
	 		 i_returni : in std_logic;
          instruction0 : in std_logic;
          active_interrupt : in std_logic;
          carry_flag : in std_logic;
          zero_flag : in std_logic;
          reset : in std_logic;
          interrupt_enable : out std_logic;
          shaddow_carry : out std_logic;
          shaddow_zero : out std_logic;
          clk : in std_logic);
    end interrupt_logic;
--
architecture low_level_definition of interrupt_logic is
--
-- Internal signals
--
signal update_enable    : std_logic;
signal new_enable_value : std_logic;
--
begin

  update_enable <= (i_interrupt and (not active_interrupt))
  					or active_interrupt or i_returni;

  new_enable_value <= instruction0 and (not active_interrupt);

  int_enable_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			interrupt_enable <= '0';
		else if update_enable = '1' then
			interrupt_enable <= new_enable_value;
		end if;
		end if;
	end if;
  end process int_enable_flop;

  preserve_carry_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if active_interrupt = '1' then
			shaddow_carry <= carry_flag;
		end if;
	end if;
  end process preserve_carry_flop;

  preserve_zero_flop: 
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if active_interrupt = '1' then
			shaddow_zero <= zero_flag;
		end if;
	end if;
  end process preserve_zero_flop;
--
end low_level_definition;
--
