--
------------------------------------------------------------------------------------
--
-- Definition of an 8-bit dual port RAM with 2 ** M locations (M-bit address)
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_bank is
	 generic(M: natural);
    Port ( we 		: in std_logic;
           d_bus	: in std_logic_vector(7 downto 0);
           wclk 	: in std_logic;
           a      : in std_logic_vector(M-1 downto 0);
           dpra   : in std_logic_vector(M-1 downto 0);
           spo_bus : out std_logic_vector(7 downto 0);
           dpo_bus : out std_logic_vector(7 downto 0));
end register_bank;

architecture Behavioral of register_bank is

component ram_Nx1
	generic(M: natural);
   Port ( we : in std_logic;
          d : in std_logic;
          wclk : in std_logic;
          a : in std_logic_vector(M-1 downto 0);
          dpra  : in std_logic_vector(M-1 downto 0);
          spo : out std_logic;
          dpo : out std_logic);
	end component;

begin

  bus_width_loop: for i in 0 to 7 generate

  begin

     data_register_bit: ram_Nx1
	  generic map (M)
     port map (d => d_bus(i),
               we => we,
               wclk => wclk,
               a => a,
               dpra => dpra,
               spo => spo_bus(i),
               dpo => dpo_bus(i));

  end generate bus_width_loop;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_Nx1 is
	 generic(M: natural);
    Port ( we : in std_logic;
           d : in std_logic;
           wclk : in std_logic;
           a : in std_logic_vector(M-1 downto 0);
           dpra : in std_logic_vector(M-1 downto 0);
           spo : out std_logic;
           dpo : out std_logic);
end ram_Nx1;

architecture Behavioral of ram_Nx1 is

signal rambit: std_logic_vector((2 ** M) - 1 downto 0);

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

	dpo <= rambit(conv_integer(dpra));
	spo <= rambit(conv_integer(a));

end Behavioral;
