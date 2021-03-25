--
-- Definition of an 8-bit arithmetic process
--
-- Operation
--
-- Two input operands are added or subtracted.
-- An input carry bit can be included in the calculation.
-- An output carry is always generated.
-- Carry signals work in the positive sense at all times.
--
--     code1     code0         Bit injected
--
--       0        0            ADD
--       0        1            ADD with carry
--       1        0            SUB
--       1        1            SUB with carry
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity arithmetic_process is
    Port (  first_operand : in std_logic_vector(7 downto 0);
       	  second_operand : in std_logic_vector(7 downto 0);
	              carry_in : in std_logic;
                    code1 : in std_logic;
			           code0 : in std_logic;
			               Y : out std_logic_vector(7 downto 0);
			       carry_out : out std_logic;
			             clk : in std_logic);
    end arithmetic_process;
--
architecture low_level_definition of arithmetic_process is
--
-- An 8-bit adder/subtractor
--
component addsub8
    Port (  first_operand : in std_logic_vector(7 downto 0);
           second_operand : in std_logic_vector(7 downto 0);
                 carry_in : in std_logic;
                 subtract : in std_logic;
                        Y : out std_logic_vector(7 downto 0);
                carry_out : out std_logic;
                      clk : in std_logic);
    end component;
--
-- Internal signals
--
signal carry_in_bit       : std_logic;
signal carry_out_bit      : std_logic;
signal modified_carry_out : std_logic;
--
begin
  --
  -- Selection of the carry input to add/sub
  --
  carry_in_bit <= (code1 and (not code0) and (not carry_in))
             or (code1 and code0 and (not carry_in))
             or (code1 and (not code0) and carry_in)
             or ((not code1) and code0 and carry_in);

  --
  -- Main add/sub
  --
  add_sub_module: addsub8
  port map (  first_operand => first_operand,
             second_operand => second_operand,
                   carry_in => carry_in_bit,
                   subtract => code1,
                          Y => Y,
                  carry_out => carry_out_bit,
                        clk => clk);
  --
  -- Modification to carry output and pipeline
  --
  modified_carry_out <= code1 xor carry_out_bit;

  pipeline_bit:
  process (clk)
  begin
  	if clk'event and clk = '1' then
		carry_out <= modified_carry_out;
	end if;
  end
  process pipeline_bit;
--
end low_level_definition;
------------------------------------------------------------------------------------
--
-- Definition of an 8-bit adder/subtractor
--
--     subtract    Operation
--
--         0          ADD          Y <= first_operand + second_operand
--         1          SUB          Y <= first_operand - second_operand
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity addsub8 is
    Port (  first_operand : in std_logic_vector(7 downto 0);
           second_operand : in std_logic_vector(7 downto 0);
                 carry_in : in std_logic;
                 subtract : in std_logic;
                        Y : out std_logic_vector(7 downto 0);
                carry_out : out std_logic;
                      clk : in std_logic);
    end addsub8;
--
architecture low_level_definition of addsub8 is
--
-- Internal signals
--
signal half_addsub : std_logic_vector(7 downto 0);
signal full_addsub : std_logic_vector(7 downto 0);
signal carry_chain : std_logic_vector(6 downto 0);
--
begin

  bus_width_loop: for i in 0 to 7 generate
  begin

     lsb_carry: if i=0 generate
	  begin

		carry_chain(i) <= carry_in when half_addsub(i)= '1' else first_operand(i);
		full_addsub(i) <= half_addsub(i) xor carry_in;

	  end generate lsb_carry;

     mid_carry: if i>0 and i<7 generate
	  begin

 		carry_chain(i) <= carry_chain(i-1) when half_addsub(i)= '1' else first_operand(i);
		full_addsub(i) <= half_addsub(i) xor carry_chain(i-1);

	  end generate mid_carry;

     msb_carry: if i=7 generate
	  begin

 		carry_out <= carry_chain(i-1) when half_addsub(i)= '1' else first_operand(i);
		full_addsub(i) <= half_addsub(i) xor carry_chain(i-1);

  	  end generate msb_carry;

		half_addsub(i) <= (subtract and second_operand(i) and first_operand(i))
                              or (subtract and (not second_operand(i)) and (not first_operand(i)))
                              or ((not subtract) and (not second_operand(i)) and first_operand(i))
                              or ((not subtract)  and second_operand(i) and (not first_operand(i)));

     pipeline_bit:
	  process (clk)
	  begin
	  	if clk'event and clk = '1' then
			 Y(i) <= full_addsub(i);
		end if;
	  end
	  process pipeline_bit;

  end generate bus_width_loop;
--
end low_level_definition;

