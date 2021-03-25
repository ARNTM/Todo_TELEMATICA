------------------------------------------------------------------------------------
--
-- Definition of an 8-bit shift/rotate process
-- Operation
--
-- The input operand is shifted by one bit left or right.
-- The bit which falls out of the end is passed to the carry_out.
-- The bit shifted in is determined by the select bits
--
--     code1    code0         Bit injected
--
--       0        0          carry_in
--       0        1          msb of input_operand
--       1        0          lsb of operand
--       1        1          inject_bit
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shift_rotate is
    Port (operand : in std_logic_vector(7 downto 0);
          carry_in : in std_logic;
          inject_bit : in std_logic;
          shift_right : in std_logic;
          code1 : in std_logic;
          code0 : in std_logic;
          Y : out std_logic_vector(7 downto 0);
          carry_out : out std_logic;
          clk : in std_logic);
    end shift_rotate;
--
architecture low_level_definition of shift_rotate is
--
-- Internal signals
--
signal mux_output   : std_logic_vector(7 downto 0);
signal shift_in_bit : std_logic;
signal carry_bit    : std_logic;
--
begin
  --
  -- Selection of the bit to be shifted in
  --
	shift_in_bit <= (inject_bit and code1 and code0)
					 or (operand(0) and code1 and (not code0) and shift_right)
					 or (operand(7) and (not code1) and code0 and shift_right)
					 or (operand(7) and code1 and (not code0) and (not shift_right))
					 or (operand(0) and (not code1) and code0 and (not shift_right))
					 or (carry_in   and (not code1) and (not code0));
  --
  -- shift left or right of operand
  --
  mux_output <= (shift_in_bit & operand(7 downto 1)) when shift_right = '1'
  				else (operand(6 downto 0) & shift_in_bit);

  bus_width_loop: for i in 0 to 7 generate
  begin

               pipeline:
               process (clk)
               begin
  		if (clk'event and clk = '1') then
                        Y(i) <= mux_output(i);
		end if;
               end
               process pipeline;

  end generate bus_width_loop;
  --
  -- Selection of carry output
  --

  	carry_bit <= (shift_right and operand(0))
				or ((not shift_right) and operand(7));

  	fd:
  	process (clk)
	begin
   	if (clk'event and clk = '1') then
                        carry_out <= carry_bit;
		end if;
	end
	process fd;
--
end low_level_definition;
