--
-- Definition of a N-bit special counter for stack pointer
--
-- The counter is able to increment and decrement.
-- It can also hold current value during an active interrupt
-- and decrement by two during a RETURN or RETURNI.
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--
entity stack_counter is
	 generic (N: natural);
    Port (i_call : in std_logic;
          i_return : in std_logic;
          i_returni : in std_logic;
			 -- i_interrupt : in std_logic;
          conditional : in std_logic;
          T_state : in std_logic;
          flag_condition_met : in std_logic;
          active_interrupt : in std_logic;
          reset : in std_logic;
          stack_count : out std_logic_vector(N-1 downto 0);
          clk : in std_logic);
    end stack_counter;
--
architecture low_level_definition of stack_counter is
--
-- Internal signals
--
signal not_interrupt    : std_logic;
signal count_value      : std_logic_vector(N-1 downto 0);
signal next_count       : std_logic_vector(N-1 downto 0);
signal count_carry      : std_logic_vector(N-2 downto 0);
signal half_count       : std_logic_vector(N-1 downto 0);
signal valid_to_move    : std_logic;
signal push_or_pop_type : std_logic;
--
begin

  -- Inverter should be implemented in the CE to flip flops
  not_interrupt <= not active_interrupt;

  -- Control logic decoding
  valid_to_move <= flag_condition_met or (not conditional);
  push_or_pop_type <= i_call or i_return or i_returni;-- or i_interrupt;

  count_width_loop: for i in 0 to N-1 generate
  --
  -- The counter
  --
  begin

     register_bit:
          process (clk, reset)
          begin
                if reset = '1' then
                        count_value(i) <= '0';
                else if clk'event and clk = '1' then
					 	if not_interrupt = '1' then
                     count_value(i) <= next_count(i);
							end if;
                  end if;
                end if;
          end
          process register_bit;

          lsb_count: if i=0 generate
          begin
                 
            half_count(i) <= (push_or_pop_type and valid_to_move and (not T_state) and count_value(i))
                          or (push_or_pop_type and (not valid_to_move) and (not T_state) and (not count_value(i)))
                          or ((not push_or_pop_type) and (not T_state) and (not count_value(i)))
                          or (T_state and (not count_value(i)));

                 count_carry(i) <= (not half_count(i)) and count_value(i);
                 next_count(i) <= half_count(i);

          end generate lsb_count;

     mid_count: if i>0 and i<N-1 generate
          begin

                 half_count(i) <= (i_call and valid_to_move and (not T_state) and count_value(i))
                               or (i_call and (not valid_to_move) and (not T_state) and (not count_value(i)))
                               or ((not i_call) and (not T_state) and (not count_value(i)))
                               or (T_state and count_value(i));

                 count_carry(i) <= ((not half_count(i)) and count_value(i)) or (half_count(i) and count_carry(i-1));
                 next_count(i) <= half_count(i) xor count_carry(i-1);

          end generate mid_count;

     msb_count: if i=N-1 generate
          begin

                 half_count(i) <= (i_call and valid_to_move and (not T_state) and count_value(i))
                               or (i_call and (not valid_to_move) and (not T_state) and (not count_value(i)))
                               or ((not i_call) and (not T_state) and (not count_value(i)))
                               or (T_state and count_value(i));
                 next_count(i) <= half_count(i) xor count_carry(i-1);

          end generate msb_count;

  end generate count_width_loop;

  stack_count <= count_value;
--
end low_level_definition;
--

