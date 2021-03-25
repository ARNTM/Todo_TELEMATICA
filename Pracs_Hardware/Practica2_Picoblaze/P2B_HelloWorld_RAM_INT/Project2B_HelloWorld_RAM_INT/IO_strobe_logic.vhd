--
-- Definition of the Input and Output Strobes
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library unisim;
use unisim.vcomponents.all;
--
entity IO_strobe_logic is
    Port (i_input : in std_logic;
          i_output : in std_logic;
          active_interrupt : in std_logic;
          T_state : in std_logic;
          reset : in std_logic;
          write_strobe : out std_logic;
          read_strobe : out std_logic;
          clk : in std_logic);
    end IO_strobe_logic;
--
architecture low_level_definition of IO_strobe_logic is
--
-- Internal signals
--
signal write_event : std_logic;
signal read_event  : std_logic;
--
begin
  --
  write_event <= i_output and (not T_state) and (not active_interrupt);

  write_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			write_strobe <= '0';
		else write_strobe <= write_event;
		end if;
	end if;
  end process write_flop;

  read_event <= i_input and (not T_state) and (not active_interrupt);

  read_flop:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		if reset = '1' then
			read_strobe <= '0';
		else read_strobe <= read_event;
		end if;
	end if;
  end process read_flop;
--
end low_level_definition;
--
