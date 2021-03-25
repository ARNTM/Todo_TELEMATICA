library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity swap is
    Port (operand : in std_logic_vector(15 downto 0);
          Y : out std_logic_vector(15 downto 0);
          clk : in std_logic);
end swap;
--
architecture low_level_definition of swap is

signal aux : std_logic_vector(15 downto 0);

begin
	
  aux <= operand(7 downto 0) & operand(15 downto 8);
  
  bus_width_loop: for i in 0 to 15 generate -- 15
  begin
     FF:
     process (clk)
      begin
  		if (clk'event and clk = '1') then
         Y(i) <= aux(i);
		end if;
     end process FF;
  end generate bus_width_loop;
--
end low_level_definition;
