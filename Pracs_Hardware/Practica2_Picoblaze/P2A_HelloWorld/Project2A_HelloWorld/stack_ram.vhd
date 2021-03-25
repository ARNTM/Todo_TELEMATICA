--
-- Definition of RAM for stack
--	 
-- This is a 2**M location single port RAM of N-bits to support the address range
-- of the program counter. The ouput is registered and the write enable is active low.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity stack_ram is
	 generic(M: natural; N: natural);
    Port (        Din : in std_logic_vector(N-1 downto 0);
                 Dout : out std_logic_vector(N-1 downto 0);
                 addr : in std_logic_vector(M-1 downto 0);
            write_bar : in std_logic;
                  clk : in std_logic);
    end stack_ram;
--
architecture low_level_definition of stack_ram is

component ram_x1s
	generic(M: natural);
	Port (  d 		: in std_logic;
          we 		: in std_logic;
        wclk 	   : in std_logic;
           a      : in std_logic_vector(M-1 downto 0);
           o   	: out std_logic);
end component; 

--
-- Internal signals
--
signal ram_out      : std_logic_vector(N-1 downto 0);
signal write_enable : std_logic;
--
begin

  -- Inverter should be implemented in the WE to RAM
  write_enable <= not write_bar;

  bus_width_loop: for i in 0 to N-1 generate
  --
  -- Attribute to define RAM contents during implementation 
  -- The information is repeated in the generic map for functional simulation
  --
  begin

     stack_ram_bit: ram_x1s
	  generic map (M)
     port map (    d => Din(i),
                  we => write_enable,
                wclk => clk,
                   a => addr,
                   o => ram_out(i));

     stack_ram_flop:
	  process (clk)
	  begin
	  	if clk'event and clk = '1' then
			Dout(i) <= ram_out(i);
		end if;
	  end
	  process stack_ram_flop;

  end generate bus_width_loop;
--
end low_level_definition;
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_x1s is
	 generic ( M: natural);
    Port (  d 		: in std_logic;
           we		: in std_logic;
           wclk 	: in std_logic;
           a      : in std_logic_vector(M-1 downto 0);
           o		: out std_logic);
end ram_x1s;

architecture Behavioral of ram_x1s is

signal rambit: std_logic_vector((2**M)-1 downto 0);

begin

	fd:
	process (wclk)
	begin
		if (wclk'event and wclk = '1') then
			if we = '1' then
				rambit(conv_integer(a)) <= d;
			end if;
		end if;
	end
	process fd;

	o <= rambit(conv_integer(a));

end Behavioral;
