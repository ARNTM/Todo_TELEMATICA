------------------------------------------------------------------------------------
-- Standard IEEE libraries
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
------------------------------------------------------------------------------------
--
--
entity demo is
    Port (output : out std_logic_vector(7 downto 0);
          reset : in std_logic;
          clk : in std_logic);
    end demo;
--
------------------------------------------------------------------------------------
--
-- Start of test achitecture
--
architecture Behavioral of demo is
--
------------------------------------------------------------------------------------
--
--
  component picoblaze
    Port (      address : out std_logic_vector(7 downto 0);
            instruction : in std_logic_vector(15 downto 0);
                port_id : out std_logic_vector(7 downto 0);
           write_strobe : out std_logic;
               out_port : out std_logic_vector(7 downto 0);
            read_strobe : out std_logic;
                in_port : in std_logic_vector(7 downto 0);
              interrupt : in std_logic;
                  reset : in std_logic;
                    clk : in std_logic);
    end component;
--
-- declaration of program ROM
--
  component demo_test
    Port (address : in std_logic_vector(7 downto 0);
          dout : out std_logic_vector(15 downto 0);
          clk : in std_logic);
    end component;
--
------------------------------------------------------------------------------------
--
-- Signals used to connect picoblaze to program ROM and I/O logic
--
signal address : std_logic_vector(7 downto 0);
signal instruction : std_logic_vector(15 downto 0);
signal port_id : std_logic_vector(7 downto 0);
signal out_port : std_logic_vector(7 downto 0);
signal in_port : std_logic_vector(7 downto 0);
signal write_strobe : std_logic;
signal read_strobe : std_logic;
signal interrupt_event : std_logic;
-- signal reset : std_logic;
--
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Start of circuit description
--
begin
  -- Inserting picoblaze and the program memory

  processor: picoblaze
    port map(      address => address,
               instruction => instruction,
                   port_id => port_id,
              write_strobe => write_strobe,
                  out_port => out_port,
               read_strobe => read_strobe,
                   in_port => in_port,
                 interrupt => interrupt_event,
                     reset => reset,
                       clk => clk);

  program: demo_test
    port map(address => address,
             dout => instruction,
             clk => clk);

  -- Unused inputs on processor

  in_port <= "00000000";
  interrupt_event <= '0';
  -- reset <= '0';

  -- adding the output registers to the processor

  IO_registers: process(clk)
  begin

    -- waveform register at address 01

    if clk'event and clk='1' then
      if port_id(0)='1' and write_strobe='1' then
        output <= out_port;
      end if;
   end if;

  end process IO_registers;

end Behavioral;

------------------------------------------------------------------------------------
--
-- END OF FILE demo.VHD
--
------------------------------------------------------------------------------------

