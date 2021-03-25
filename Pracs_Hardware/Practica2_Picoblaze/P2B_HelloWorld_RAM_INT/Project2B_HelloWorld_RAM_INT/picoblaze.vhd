-- Constant (K) Coded Programmable State Machine for CoolRunner-II Devices
--
-- Version : 1.00
-- Version Date : 15th August 2002
--
-- Start of design entry : 12th July 2002
--
------------------------------------------------------------------------------------
--
-- NOTICE:
--
-- Copyright Xilinx, Inc. 2001.   This code may be contain portions patented by other
-- third parites.  By providing this core as one possible implementation of a standard,
-- Xilinx is making no representation that the provided implementation of this standard
-- is free from any claims of infringement by any third party.  Xilinx expressly
-- disclaims any warranty with respect to the adequacy of the implementation, including
-- but not limited to any warranty or representation that the implementation is free
-- from claims of any third party.  Futhermore, Xilinx is providing this core as a
-- courtesy to you and suggests that you contact all third parties to obtain the
-- necessary rights to use this implementation.
--
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
--
-- Main Entity for picoblaze
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity picoblaze is
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
end picoblaze;

architecture Behavioral of picoblaze is
--
-- Size of register bank, stack counter can be changed here
--
constant register_bank_address : natural := 3; -- 8 registers
constant stack_counter_address : natural := 2; -- 4 program stack address
--
-- size of program counter should not be changed
--
constant program_counter_address : natural := 8; -- 256 program word

--
-- Decalare instruction set decoding
--
-- program control group
constant jump_id : std_logic_vector(4 downto 0) := "11010";
constant call_id : std_logic_vector(4 downto 0) := "11011";
constant return_id : std_logic_vector(4 downto 0) := "10010";
--
-- logical group
constant load_k_to_x_id : std_logic_vector(4 downto 0) := "00000";
constant load_y_to_x_id : std_logic_vector(4 downto 0) := "01000";
constant and_k_to_x_id : std_logic_vector(4 downto 0) := "00001";
constant and_y_to_x_id : std_logic_vector(4 downto 0) := "01001";
constant or_k_to_x_id : std_logic_vector(4 downto 0) := "00010";
constant or_y_to_x_id : std_logic_vector(4 downto 0) := "01010";
constant xor_k_to_x_id : std_logic_vector(4 downto 0) := "00011";
constant xor_y_to_x_id : std_logic_vector(4 downto 0) := "01011";
--
-- arithmetic group
constant add_k_to_x_id : std_logic_vector(4 downto 0) := "00100";
constant add_y_to_x_id : std_logic_vector(4 downto 0) := "01100";
constant addcy_k_to_x_id : std_logic_vector(4 downto 0) := "00101";
constant addcy_y_to_x_id : std_logic_vector(4 downto 0) := "01101";
constant sub_k_to_x_id : std_logic_vector(4 downto 0) := "00110";
constant sub_y_to_x_id : std_logic_vector(4 downto 0) := "01110";
constant subcy_k_to_x_id : std_logic_vector(4 downto 0) := "00111";
constant subcy_y_to_x_id : std_logic_vector(4 downto 0) := "01111";

--
-- shift and rotate
constant shift_rotate_id : std_logic_vector(4 downto 0) := "10100";
--
-- added new instruction
-- flip
-- constant flip_id : std_logic_vector(4 downto 0) := "11111";
--
-- input/output group
constant input_p_to_x_id : std_logic_vector(4 downto 0) := "10000";
constant input_y_to_x_id : std_logic_vector(4 downto 0) := "11000";
constant output_p_to_x_id : std_logic_vector(4 downto 0) := "10001";
constant output_y_to_x_id : std_logic_vector(4 downto 0) := "11001";
--
-- interrupt group
--
constant interrupt_id : std_logic_vector(4 downto 0) := "11110";
constant returni_id : std_logic_vector(4 downto 0) := "10110";
--
-- flag
constant zero_id : std_logic_vector(1 downto 0) := "00";
constant not_zero_id : std_logic_vector(1 downto 0) := "01";
constant carry_id : std_logic_vector(1 downto 0) := "10";
constant not_carry_id : std_logic_vector(1 downto 0) := "11";
-- instruction(14) : 0 - constant for 2nd operand, 1 - content of sYY register.
--
------------------------------------------------------------------------------------
--
-- Components used in picoblaze and defined in subsequent entities.
--
------------------------------------------------------------------------------------
--
-- Input and Output Strobes
--
component IO_strobe_logic
    Port (i_input : in std_logic;
          i_output : in std_logic;
          active_interrupt : in std_logic;
          T_state : in std_logic;
          reset : in std_logic;
          write_strobe : out std_logic;
          read_strobe : out std_logic;
          clk : in std_logic);
  end component;
--
-- An 8-bit arithmetic process
--
component arithmetic_process
    Port (first_operand : in std_logic_vector(7 downto 0);
       	 second_operand : in std_logic_vector(7 downto 0);
	       carry_in : in std_logic;
          code1 : in std_logic;
			 code0 : in std_logic;
			 Y : out std_logic_vector(7 downto 0);
			 carry_out : out std_logic;
			 clk : in std_logic);
    end component;

--
-- Definition of an 8-bit shift/rotate process
--
component shift_rotate
    Port (operand : in std_logic_vector(7 downto 0);
          carry_in : in std_logic;
          inject_bit : in std_logic;
          shift_right : in std_logic;
          code1 : in std_logic;
          code0 : in std_logic;
          Y : out std_logic_vector(7 downto 0);
          carry_out : out std_logic;
          clk : in std_logic);
    end component;

-- added new instruction
--
-- Definition of flip process
--
--component flip
--    Port (operand : in std_logic_vector(7 downto 0);
--          Y : out std_logic_vector(7 downto 0);
--          clk : in std_logic);
--    end component;
--
-- Definition of an 8-bit logical processing unit
--
component logical_bus_processing
    Port (first_operand : in std_logic_vector(7 downto 0);
          second_operand : in std_logic_vector(7 downto 0);
          code1 : in std_logic;
          code0 : in std_logic;
          Y : out std_logic_vector(7 downto 0);
          clk : in std_logic);
    end component;
--
-- Reset conditioning and T-state generation
--
component T_state_and_Reset
    Port (    reset_input : in std_logic;
           internal_reset : out std_logic;
                  T_state : out std_logic;
                      clk : in std_logic);
    end component;
--
--
-- Decoding and timing of write enable for register bank and clock enable for flags
--
component register_and_flag_enable
    Port (i_logical: in std_logic;
	 		 i_arithmetic: in std_logic;
			 i_shift_rotate: in std_logic;
--			 i_flip: in std_logic;					-- added new instruction
			 i_returni: in std_logic;
			 i_input: in std_logic;
          active_interrupt : in std_logic;
          T_state : in std_logic;
          register_enable : out std_logic;
          flag_enable : out std_logic;
          clk : in std_logic);
    end component;
--
-- Carry Flag logic
--
component carry_flag_logic
    Port (add_sub : in std_logic;
          shift : in std_logic;
          returni : in std_logic;
          shift_carry : in std_logic;
          add_sub_carry : in std_logic;
          shadow_carry : in std_logic;
          reset : in std_logic;
          flag_enable : in std_logic;
          carry_flag : out std_logic;
          clk : in std_logic);
    end component;
--
-- Zero Flag logic
--
component zero_flag_logic
    Port (data : in std_logic_vector(7 downto 0);
          returni : in std_logic;
          shadow_zero : in std_logic;
          reset : in std_logic;
          flag_enable : in std_logic;
          zero_flag : out std_logic;
          clk : in std_logic);
    end component;
--
-- Definition of a Program Counter
--
component program_counter
    Port (i_jump             : in std_logic;
	 		 i_call             : in std_logic;
	 		 i_return           : in std_logic;
			 i_returni          : in std_logic;
          conditional        : in std_logic;
          low_instruction    : in std_logic_vector(7 downto 0);
          stack_value        : in std_logic_vector(7 downto 0);
          flag_condition_met : in std_logic;
          T_state            : in std_logic;
          reset              : in std_logic;
          interrupt          : in std_logic;
          program_count      : out std_logic_vector(7 downto 0);
          clk                : in std_logic);
     end component;
--
-- An 8-bit dual port RAM
--
component register_bank
	 generic(M: natural);
    Port ( we 		: in std_logic;
           d_bus	: in std_logic_vector(7 downto 0);
           wclk 	: in std_logic;
           a      : in std_logic_vector(M-1 downto 0);
           dpra   : in std_logic_vector(M-1 downto 0);
           spo_bus : out std_logic_vector(7 downto 0);
           dpo_bus : out std_logic_vector(7 downto 0));
    end component;
--
-- State_ram
--
component stack_ram
	generic(M: natural; N: natural);
   Port (Din : in std_logic_vector(N-1 downto 0);
         Dout : out std_logic_vector(N-1 downto 0);
         addr : in std_logic_vector(M-1 downto 0);
         write_bar : in std_logic;
         clk : in std_logic);
	end component;
--
-- Address pointer for program stack
--
component stack_counter
	 generic (N: natural);
    Port (i_call : in std_logic;
          i_return : in std_logic;
          i_returni : in std_logic;
          conditional : in std_logic;
          T_state : in std_logic;
          flag_condition_met : in std_logic;
          active_interrupt : in std_logic;
          reset : in std_logic;
          stack_count : out std_logic_vector(N-1 downto 0);
          clk : in std_logic);
	end component;
--
-- Capture of interrupt signal
--
 component interrupt_capture is
    Port (interrupt : in std_logic;
          T_state : in std_logic;
          reset : in std_logic;
          interrupt_enable : in std_logic;
          active_interrupt : out std_logic;
          clk : in std_logic);
  end component;
--
-- Interrupt Enable and shaddow flags
--
 component interrupt_logic is
    Port (i_interrupt : in std_logic;
	 		 i_returni : in std_logic;
          instruction0 : in std_logic;
          active_interrupt : in std_logic;
          carry_flag : in std_logic;
          zero_flag : in std_logic;
          reset : in std_logic;
          interrupt_enable : out std_logic;
          shaddow_carry : out std_logic;
          shaddow_zero : out std_logic;
          clk : in std_logic);
  end component;


-- internal signals
--
-- instruction decoding signals
--
signal i_jump : std_logic;
signal i_call : std_logic;
signal i_return : std_logic;
signal i_returni : std_logic;
--
signal i_load_k_to_x : std_logic;
signal i_load_y_to_x : std_logic;
signal i_and_k_to_x : std_logic;
signal i_and_y_to_x : std_logic;
signal i_or_k_to_x : std_logic;
signal i_or_y_to_x : std_logic;
signal i_xor_k_to_x : std_logic;
signal i_xor_y_to_x : std_logic;
--
signal i_add_k_to_x : std_logic;
signal i_add_y_to_x : std_logic;
signal i_addcy_k_to_x : std_logic;
signal i_addcy_y_to_x : std_logic;
signal i_sub_k_to_x : std_logic;
signal i_sub_y_to_x : std_logic;
signal i_subcy_k_to_x : std_logic;
signal i_subcy_y_to_x : std_logic;
signal i_add_sub : std_logic;
signal i_carry_nocarry : std_logic;
--
signal i_input_p_to_x : std_logic;
signal i_input_y_to_x : std_logic;
signal i_output_p_to_x : std_logic;
signal i_output_y_to_x : std_logic;
--
signal i_interrupt : std_logic;
--
signal i_arithmetic : std_logic;
signal i_logical : std_logic;
signal i_shift_rotate : std_logic;
signal i_input : std_logic;
signal i_output : std_logic;

-- added new instruction
-- signal i_flip : std_logic;


signal conditional : std_logic;
signal zero : std_logic;
signal not_zero : std_logic;
signal carry : std_logic;
signal not_carry : std_logic;
signal shift_right : std_logic;
signal shift_in_bit : std_logic;
signal shift_code1 : std_logic;
signal shift_code0 : std_logic;
signal logical_code1 : std_logic;
signal logical_code0 : std_logic;
--
-- Fundamental control signals
--
signal internal_reset : std_logic;
signal T_state : std_logic;
--
-- Register bank signals
--
signal sX_register           : std_logic_vector(7 downto 0);
signal sY_register           : std_logic_vector(7 downto 0);
signal register_write_enable : std_logic;
--
-- ALU signals
--
signal second_operand          : std_logic_vector(7 downto 0);
signal logical_result          : std_logic_vector(7 downto 0);
signal shift_and_rotate_result : std_logic_vector(7 downto 0);
signal shift_and_rotate_carry  : std_logic;
signal arithmetic_result       : std_logic_vector(7 downto 0);
signal arithmetic_carry        : std_logic;
signal ALU_result              : std_logic_vector(7 downto 0);
signal flip_result : std_logic_vector(7 downto 0);
--
-- Flag signals
--
signal carry_flag         : std_logic;
signal zero_flag          : std_logic;
signal flag_clock_enable  : std_logic;
signal flag_condition_met : std_logic;
--
-- Interrupt signals
--
signal shaddow_carry_flag : std_logic;
signal shaddow_zero_flag  : std_logic;
signal interrupt_enable   : std_logic;
signal active_interrupt   : std_logic;
--
-- Program Counter and Stack signals
--
signal program_count  : std_logic_vector(7 downto 0);
signal stack_pop_data : std_logic_vector(7 downto 0);
signal stack_pointer  : std_logic_vector(stack_counter_address-1 downto 0);
--
------------------------------------------------------------------------------------
--
-- Start of picoblaze circuit description
--
------------------------------------------------------------------------------------
begin
 	--
   -- Connections to output port and port address
   --
   out_port <= sX_register;
   port_id <= second_operand;
   --
   --
   -- Input and Output Strobes
   --
   IO_strobes: IO_strobe_logic
   port map (i_input => i_input,
             i_output => i_output,
             active_interrupt => active_interrupt,
             T_state  => T_state,
             reset => internal_reset,
             write_strobe => write_strobe,
             read_strobe => read_strobe,
             clk => clk );

	--
   -- The ALU structure
   --
   arithmetic_group: arithmetic_process
   port map (first_operand => sX_register,
             second_operand => second_operand,
             carry_in => carry_flag,
             code1 => i_add_sub,
             code0 => i_carry_nocarry,
             Y => arithmetic_result,
             carry_out => arithmetic_carry,
             clk => clk);

  shift_group: shift_rotate
  port map (operand => sX_register,
            carry_in => carry_flag,
            inject_bit => shift_in_bit,
            shift_right => shift_right,
            code1 => shift_code1,
            code0 => shift_code0,
            Y => shift_and_rotate_result,
            carry_out => shift_and_rotate_carry,
            clk => clk);

-- added new instruction
--  flip_group: flip
--  port map (operand => sX_register,
--            Y => flip_result,
--            clk => clk);

   logical_group: logical_bus_processing
   port map (first_operand => sX_register,
             second_operand => second_operand,
             code1 => logical_code1,
             code0 => logical_code0,
             Y => logical_result,
             clk => clk);

	--
   -- Reset conditioning and T-state generation
   --
   basic_control: T_state_and_Reset
   port map (reset_input => reset,
             internal_reset => internal_reset,
             T_state => T_state,
             clk => clk);
	--
   reg_and_flag_enables: register_and_flag_enable
   Port map (i_logical => i_logical,
	 		    i_arithmetic => i_arithmetic,
			 	 i_shift_rotate => i_shift_rotate,
--				 i_flip => i_flip,		  -- added new instruction
			 	 i_returni => i_returni,
				 i_input => i_input,
          	 active_interrupt => active_interrupt,
          	 T_state => T_state,
          	 register_enable => register_write_enable,
          	 flag_enable => flag_clock_enable,
          	 clk => clk);

   carry_logic: carry_flag_logic
   Port map (add_sub => i_arithmetic,
          	  shift => i_shift_rotate,
          	  returni => i_returni,
          	  shift_carry => shift_and_rotate_carry,
				  add_sub_carry => arithmetic_carry,
          	  shadow_carry => shaddow_carry_flag,
          	  reset => internal_reset,
          	  flag_enable => flag_clock_enable,
          	  carry_flag => carry_flag,
          	  clk => clk);

	zero_logic: zero_flag_logic
  	port map (data => ALU_result,
             returni => i_returni,
             shadow_zero => shaddow_zero_flag,
             reset => internal_reset,
             flag_enable => flag_clock_enable,
             zero_flag => zero_flag,
             clk => clk);

   --
   --
   -- Program Counter
   --
   prog_count: program_counter
   port map (i_jump => i_jump,
				 i_call => i_call,
				 i_return => i_return,
				 i_returni => i_returni,
				 conditional => conditional,
				 low_instruction => instruction(7 downto 0),
             stack_value => stack_pop_data,
             flag_condition_met => flag_condition_met,
             T_state => T_state,
             reset => internal_reset,
             interrupt => active_interrupt,
             program_count => program_count,
             clk => clk );

   address <= program_count;
   --
   -- Register bank
   --
   data_registers: register_bank
	generic map (register_bank_address)
   port map (we => register_write_enable,
				 d_bus => ALU_result,
				 wclk => clk,
				 a => instruction(10 downto 8),
				 dpra => instruction(7 downto 5),
				 spo_bus => sX_register,
				 dpo_bus => sY_register );
	--
   -- Stack RAM
   --
	stack_memory: stack_ram
	generic map (stack_counter_address, program_counter_address)
	port map (Din  => program_count,
         	 Dout  => stack_pop_data,
         	 addr => stack_pointer,
         	 write_bar => T_state,
         	 clk => clk);
	--
   -- Stack Counter
   --
	stack_control: stack_counter
	generic map (stack_counter_address)
   Port map (i_call => i_call,
             i_return => i_return,
          	 i_returni => i_returni,
          	 conditional => conditional,
          	 T_state => T_state,
          	 flag_condition_met => flag_condition_met,
          	 active_interrupt => active_interrupt,
          	 reset => internal_reset,
          	 stack_count => stack_pointer,
          	 clk => clk);
	--
   -- Capture of interrupt signal
   --
   get_interrupt: interrupt_capture
   port map (interrupt => interrupt,
             T_state => T_state,
             reset => internal_reset,
             interrupt_enable => interrupt_enable,
             active_interrupt => active_interrupt,
             clk => clk );
	--
	-- Interrupt Enable and shaddow flags
	--
   interrupt_control: interrupt_logic
   port map (i_interrupt => i_interrupt,
				 i_returni => i_returni,
             instruction0 => instruction(0),
             active_interrupt => active_interrupt,
             carry_flag => carry_flag,
             zero_flag => zero_flag,
             reset => internal_reset,
             interrupt_enable => interrupt_enable,
             shaddow_carry => shaddow_carry_flag,
             shaddow_zero => shaddow_zero_flag,
             clk => clk );

	--
	-- ********************************************************************
	-- set condition and flag signals
	--
	conditional <= instruction(10);
	zero <= '1' when instruction(9 downto 8) = zero_id else '0';
	not_zero <= '1' when instruction(9 downto 8) = not_zero_id else '0';
	carry <= '1' when instruction(9 downto 8) = carry_id else '0';
	not_carry <= '1' when instruction(9 downto 8) = not_carry_id else '0';
	flag_condition_met <= (zero and zero_flag) or (not_zero and (not zero_flag))
							or (carry and carry_flag) or (not_carry and (not carry_flag));

	-- set shift decoding bits
	shift_right <= instruction(3);
	shift_in_bit <= instruction(0);
	shift_code1 <= instruction(2);
	shift_code0 <= instruction(1);
	logical_code1 <= instruction(12);
	logical_code0 <= instruction(11);

	-- set instruction decoding signals
	i_jump <= '1' when instruction(15 downto 11) = jump_id else '0';
	i_call <= '1' when instruction(15 downto 11) = call_id else '0';
	i_return <= '1' when instruction(15 downto 11) = return_id else '0';
	i_returni <= '1' when instruction(15 downto 11) = returni_id else '0';
        i_load_k_to_x <= '1' when instruction(15 downto 11) = load_k_to_x_id else '0';
        i_load_y_to_x <= '1' when instruction(15 downto 11) = load_y_to_x_id else '0';
        i_and_k_to_x <= '1' when instruction(15 downto 11) = and_k_to_x_id else '0';
        i_and_y_to_x <= '1' when instruction(15 downto 11) = and_y_to_x_id else '0';
        i_or_k_to_x <= '1' when instruction(15 downto 11) = or_k_to_x_id else '0';
        i_or_y_to_x <= '1' when instruction(15 downto 11) = or_y_to_x_id else '0';
        i_xor_k_to_x <= '1' when instruction(15 downto 11) = xor_k_to_x_id else '0';
        i_xor_y_to_x <= '1' when instruction(15 downto 11) = xor_y_to_x_id else '0';
        i_add_k_to_x <= '1' when instruction(15 downto 11) = add_k_to_x_id else '0';
        i_add_y_to_x <= '1' when instruction(15 downto 11) = add_y_to_x_id else '0';
        i_addcy_k_to_x <= '1' when instruction(15 downto 11) = addcy_k_to_x_id else '0';
        i_addcy_y_to_x <= '1' when instruction(15 downto 11) = addcy_y_to_x_id else '0';
        i_sub_k_to_x <= '1' when instruction(15 downto 11) = sub_k_to_x_id else '0';
        i_sub_y_to_x <= '1' when instruction(15 downto 11) = sub_y_to_x_id else '0';
        i_subcy_k_to_x <= '1' when instruction(15 downto 11) = subcy_k_to_x_id else '0';
        i_subcy_y_to_x <= '1' when instruction(15 downto 11) = subcy_y_to_x_id else '0';
        i_input_p_to_x <= '1' when instruction(15 downto 11) = input_p_to_x_id else '0';
        i_input_y_to_x <= '1' when instruction(15 downto 11) = input_y_to_x_id else '0';
        i_output_p_to_x <= '1' when instruction(15 downto 11) = output_p_to_x_id else '0';
        i_output_y_to_x <= '1' when instruction(15 downto 11) = output_y_to_x_id else '0';
        i_interrupt <= '1' when instruction(15 downto 11) = interrupt_id else '0';
	i_shift_rotate <= '1' when instruction(15 downto 11) = shift_rotate_id else '0';

-- added new instruction
--	i_flip <= '1' when instruction(15 downto 11) = flip_id else '0';

	i_add_sub <= instruction(12);
	i_carry_nocarry <= instruction(11);

 	i_arithmetic <= i_add_k_to_x or i_add_y_to_x or i_addcy_k_to_x or i_addcy_y_to_x
					 or i_sub_k_to_x or i_sub_y_to_x or i_subcy_k_to_x or i_subcy_y_to_x;

	i_logical <= i_load_k_to_x or i_load_y_to_x or i_and_k_to_x or i_and_y_to_x
				 or i_or_k_to_x or i_or_y_to_x or i_xor_k_to_x or i_xor_y_to_x;

	i_input <= i_input_p_to_x or i_input_y_to_x;
	i_output <= i_output_p_to_x or i_output_y_to_x;

	--
	-- get ALU result
	--
	ALU_loop: for i in 0 to 7 generate
	begin
		ALU_result(i) <= (shift_and_rotate_result(i) and i_shift_rotate)
							or (in_port(i) and i_input)
							or (arithmetic_result(i) and i_arithmetic)
--							or (flip_result(i) and i_flip)		-- added new instruction
							or (logical_result(i) and i_logical);
	end generate ALU_loop;

	-- decode second operand
	second_operand <= sY_register when instruction(14) = '1' else instruction(7 downto 0);

end Behavioral;
