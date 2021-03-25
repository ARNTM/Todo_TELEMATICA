----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:50 01/02/2021 
-- Design Name: 
-- Module Name:    crc8 - Behavioral 
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

entity crc8 is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           crc : out  STD_LOGIC_VECTOR (7 downto 0);
           clk : in  STD_LOGIC);
end crc8;

architecture Behavioral of crc8 is
begin
     process (clk)
      begin
  		if (clk'event and clk = '1') then
			crc(0) <= d(6) xor d(4) xor d(3) xor d(0) xor c(0) xor c(3) xor c(4) xor c(6);
			crc(1) <= d(7) xor d(5) xor d(4) xor d(1) xor c(1) xor c(4) xor c(5) xor c(7);
			crc(2) <= d(6) xor d(5) xor d(2) xor c(2) xor c(5) xor c(6);
			crc(3) <= d(7) xor d(6) xor d(3) xor c(3) xor c(6) xor c(7);
			crc(4) <= d(7) xor d(6) xor d(3) xor d(0) xor c(0) xor c(3) xor c(6) xor c(7);
			crc(5) <= d(7) xor d(6) xor d(3) xor d(1) xor d(0) xor c(0) xor c(1) xor c(3) xor c(6) xor c(7);
			crc(6) <= d(7) xor d(4) xor d(2) xor d(1) xor c(1) xor c(2) xor c(4) xor c(7);
			crc(7) <= d(5) xor d(3) xor d(2) xor c(2) xor c(3) xor c(5);
		end if;
begin


end Behavioral;

