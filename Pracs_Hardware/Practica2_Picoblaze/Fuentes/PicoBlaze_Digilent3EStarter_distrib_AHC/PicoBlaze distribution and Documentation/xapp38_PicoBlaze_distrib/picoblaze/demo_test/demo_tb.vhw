-- C:\WORK\APP\COOLCORE_NEW\COOLBLAZE_SOURCE\PICOBLAZE\DEMO_TEST
-- VHDL Test Bench created by
-- HDL Bencher 5.1i
-- Mon Dec 16 14:18:21 2002
-- 
-- Notes:
-- 1) This testbench has been automatically generated from
--   your Test Bench Waveform
-- 2) To use this as a user modifiable testbench do the following:
--   - Save it as a file with a .vhd extension (i.e. File->Save As...)
--   - Add it to your project as a testbench source (i.e. Project->Add Source...)
-- 

LIBRARY  IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ieee;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE testbench_arch OF testbench IS
-- If you get a compiler error on the following line,
-- from the menu do Options->Configuration select VHDL 87
FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";
	COMPONENT demo
		PORT (
			output : out  std_logic_vector (7 DOWNTO 0);
			reset : in  std_logic;
			clk : in  std_logic
		);
	END COMPONENT;

	SIGNAL output : std_logic_vector (7 DOWNTO 0);
	SIGNAL reset : std_logic;
	SIGNAL clk : std_logic;

BEGIN
	UUT : demo
	PORT MAP (
		output => output,
		reset => reset,
		clk => clk
	);

	PROCESS -- clock process for clk,
	BEGIN
		CLOCK_LOOP : LOOP
		clk <= transport '1';
		WAIT FOR 1 ns;
		clk <= transport '0';
		WAIT FOR 6 ns;
		clk <= transport '1';
		WAIT FOR 4 ns;
		WAIT FOR 1 ns;
		END LOOP CLOCK_LOOP;
	END PROCESS;

	PROCESS   -- Process for clk
		VARIABLE TX_OUT : LINE;
		VARIABLE TX_ERROR : INTEGER := 0;

		PROCEDURE CHECK_output(
			next_output : std_logic_vector (7 DOWNTO 0);
			TX_TIME : INTEGER
		) IS
			VARIABLE TX_STR : String(1 to 4096);
			VARIABLE TX_LOC : LINE;
		BEGIN
			-- If compiler error ("/=" is ambiguous) occurs in the next line of code
			-- change compiler settings to use explicit declarations only
			IF (output /= next_output) THEN 
				write(TX_LOC,string'("Error at time="));
				write(TX_LOC, TX_TIME);
				write(TX_LOC,string'("ns output="));
				write(TX_LOC, output);
				write(TX_LOC, string'(", Expected = "));
				write(TX_LOC, next_output);
				write(TX_LOC, string'(" "));
				TX_STR(TX_LOC.all'range) := TX_LOC.all;
				writeline(results, TX_LOC);
				Deallocate(TX_LOC);
				ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
				TX_ERROR := TX_ERROR + 1;
			END IF;
		END;

		BEGIN
		-- --------------------
		reset <= transport '1';
		-- --------------------
		WAIT FOR 12 ns; -- Time=12 ns
		reset <= transport '1';
		-- --------------------
		WAIT FOR 96 ns; -- Time=108 ns
		reset <= transport '0';
		-- --------------------
		WAIT FOR 973 ns; -- Time=1081 ns
		-- --------------------

		IF (TX_ERROR = 0) THEN 
			write(TX_OUT,string'("No errors or warnings"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Simulation successful (not a failure).  No problems detected. "
				SEVERITY FAILURE;
		ELSE
			write(TX_OUT, TX_ERROR);
			write(TX_OUT, string'(
				" errors found in simulation"));
			writeline(results, TX_OUT);
			ASSERT (FALSE) REPORT
				"Errors found during simulation"
				SEVERITY FAILURE;
		END IF;
	END PROCESS;
END testbench_arch;

CONFIGURATION demo_cfg OF testbench IS
	FOR testbench_arch
	END FOR;
END demo_cfg;
