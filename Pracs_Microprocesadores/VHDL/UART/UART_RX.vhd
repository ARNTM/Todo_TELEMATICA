----------------------------------------------------------------------------------
-- Company: 	UPCT - SDBM
-- Engineer:	Andres Ruz Nieto y Diego Ismael Antolinos Garcia
-- 
-- Create Date:    15:39:23 07/03/2019 
-- Design Name: 
-- Module Name:    UART_RX - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_RX is
    Port ( RX_IN : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           RX_DATA : out  STD_LOGIC_VECTOR(7 downto 0);
           RX_NEWDATA : out  STD_LOGIC);
end UART_RX;

architecture Behavioral of UART_RX is
	signal registro : STD_LOGIC_VECTOR(8 downto 0);
	signal ACTUALIZACION_RX : STD_LOGIC;
	signal RX_NBIT : unsigned(3 downto 0);
	signal reinicia : STD_LOGIC;
	signal enable_RX : STD_LOGIC;
	signal enable_rxnewdata : STD_LOGIC;
	signal RSR : STD_LOGIC_VECTOR(7 downto 0);
	signal contador_baudios : unsigned(15 downto 0);

	-- ESTADOS DE LAS FMS
-- ############################################
	type estados_rx is (idle,RX_inicio,RX_datos,RX_fin);
	signal actual_rx, siguiente_rx : estados_rx;

BEGIN

	-- FMS RX
-- ############################################
	PROCESS(reset,clk)
		BEGIN
			IF(reset='1') THEN
				actual_rx <= idle;
			ELSIF(clk'event and clk='1') THEN
				actual_rx <= siguiente_rx;
			END IF;
	END PROCESS;
		
	proceso_salida_rx:PROCESS(actual_rx)
		BEGIN
			CASE actual_rx is
				WHEN idle => 
					reinicia <= '1';
					enable_RX <= '0';
					enable_rxnewdata <= '0';
				WHEN RX_inicio => 
					reinicia <= '0';
					enable_RX <= '1';
					enable_rxnewdata <= '0';
				WHEN RX_datos =>
					reinicia <= '0';
					enable_RX <= '1';
					enable_rxnewdata <= '0';
				WHEN RX_fin => 
					reinicia <= '0';
					enable_RX <= '0';
					enable_rxnewdata <= '1';
			END CASE;
	END PROCESS;
	
	proceso_siguiente_estado_rx:PROCESS(actual_rx,RX_IN,RX_NBIT)
		BEGIN
			CASE actual_rx is
				WHEN idle => 
					IF(RX_IN = '0') THEN
						siguiente_rx <= RX_inicio;
					ELSE
						siguiente_rx <= idle;
					END IF;
					
				WHEN RX_inicio =>
						siguiente_rx <= RX_datos;
					
				WHEN RX_datos =>
					IF(RX_NBIT = 9) THEN
						siguiente_rx <= RX_fin;
					ELSE
						siguiente_rx <= RX_datos;
					END IF;
					
				WHEN RX_fin =>
					siguiente_rx <= idle;
					
			END CASE;
	END PROCESS;
-- ############################################

	-- Contador de recepción
-- ############################################
	PROCESS(clk,RESET)
		BEGIN
			IF(RESET = '1') THEN
				RX_NBIT <= (OTHERS => '0');
			ELSIF(clk'event and clk = '1') THEN
				IF (reinicia = '1') THEN
				RX_NBIT <= (OTHERS => '0');
				ELSIF (enable_RX = '1') THEN
					IF (RX_NBIT = 9) THEN
						RX_NBIT <= (OTHERS => '0');
					ELSIF(ACTUALIZACION_RX = '1') THEN
						RX_NBIT <= RX_NBIT + 1;
					END IF;
				END IF;
			END IF;
	END PROCESS;
-- ############################################

	-- Desplazamiento
-- ############################################
	PROCESS(clk,RESET)
		BEGIN
			IF (RESET = '1') THEN
				registro <= (OTHERS => '1');
			ELSIF (clk'event and clk = '1') THEN
				IF (reinicia = '1') THEN
					registro <= (OTHERS => '1');
				ELSIF (enable_RX = '1') THEN
					IF (ACTUALIZACION_RX = '1') THEN
						registro <= RX_IN & registro(8 downto 1);
					END IF;
				END IF;
			END IF;
	END PROCESS;
	
	RSR <= registro(7 downto 0);
-- ############################################

	-- regRX (RSR to RX_DATA)
-- ############################################
	PROCESS(clk)
		BEGIN
			IF(clk'event and clk = '1') THEN
				IF(enable_rxnewdata = '1') THEN
					RX_DATA <= RSR;
				END IF;
			END IF;
		END PROCESS;	
-- ############################################

	-- regRX_newdata
-- ############################################
	PROCESS(clk,RESET)
		BEGIN
			IF (RESET='1') THEN
				RX_NEWDATA <= '0';
			ELSIF(clk'event and clk = '1') THEN
				IF(enable_rxnewdata = '1') THEN
					RX_NEWDATA <= '1';
				ELSE 
					RX_NEWDATA <= '0';
				END IF;
			END IF;
	END PROCESS;
-- ############################################

	-- Baud rate generator
-- ############################################
	PROCESS(clk,RESET)
		BEGIN
			IF (RESET = '1') THEN
				contador_baudios <= (OTHERS => '0'); -- 1/BAUDIOS y RESULTADO ENTRE 20ns (50MHz)
			ELSIF (clk'event and clk = '1') THEN
				IF (reinicia = '1') THEN
					contador_baudios <= (OTHERS => '0');
				ELSIF (enable_RX = '1') THEN
					IF (contador_baudios = 5208) THEN
						contador_baudios <= (OTHERS => '0');
					ELSE
						contador_baudios <= contador_baudios + 1;
					END IF;
				END IF;
			END IF;	
	END PROCESS;
-- ############################################

	-- ACTUALIZACION_RX
-- ############################################
	PROCESS(contador_baudios)
		BEGIN
			IF (contador_baudios = 5208) THEN
				ACTUALIZACION_RX <= '1';
			ELSE
				ACTUALIZACION_RX <= '0';
			END IF;
	END PROCESS;
-- ############################################

end Behavioral;

