----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:32 11/12/2020 
-- Design Name: 
-- Module Name:    our_component - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity our_component is
    Port ( entrada : in  STD_LOGIC_VECTOR(7 downto 0);
           salida : out  STD_LOGIC_VECTOR(7 downto 0);
           addr : in  STD_LOGIC_VECTOR(7 downto 0);
           ws : in  STD_LOGIC);
end our_component;

architecture low_level_definition of our_component is



begin


end Behavioral;

