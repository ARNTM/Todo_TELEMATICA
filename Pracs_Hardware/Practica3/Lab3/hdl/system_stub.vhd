-------------------------------------------------------------------------------
-- system_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity system_stub is
  port (
    fpga_0_RS232_DCE_RX_pin : in std_logic;
    fpga_0_RS232_DCE_TX_pin : out std_logic;
    fpga_0_LEDs_8Bit_GPIO_IO_O_pin : out std_logic_vector(0 to 7);
    fpga_0_DDR_SDRAM_DDR_Clk_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_Clk_n_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_CE_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_CS_n_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_RAS_n_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_CAS_n_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_WE_n_pin : out std_logic;
    fpga_0_DDR_SDRAM_DDR_BankAddr_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR_SDRAM_DDR_Addr_pin : out std_logic_vector(12 downto 0);
    fpga_0_DDR_SDRAM_DDR_DQ_pin : inout std_logic_vector(15 downto 0);
    fpga_0_DDR_SDRAM_DDR_DM_pin : out std_logic_vector(1 downto 0);
    fpga_0_DDR_SDRAM_DDR_DQS_pin : inout std_logic_vector(1 downto 0);
    fpga_0_DDR_SDRAM_ddr_dqs_div_io_pin : inout std_logic;
    fpga_0_clk_1_sys_clk_pin : in std_logic;
    fpga_0_rst_1_sys_rst_pin : in std_logic;
    dip_GPIO_IO_I_pin : in std_logic_vector(0 to 3);
    push_GPIO_IO_I_pin : in std_logic_vector(0 to 3);
    lcd_ip_J09_lcd_pin : out std_logic_vector(0 to 6)
  );
end system_stub;

architecture STRUCTURE of system_stub is

  component system is
    port (
      fpga_0_RS232_DCE_RX_pin : in std_logic;
      fpga_0_RS232_DCE_TX_pin : out std_logic;
      fpga_0_LEDs_8Bit_GPIO_IO_O_pin : out std_logic_vector(0 to 7);
      fpga_0_DDR_SDRAM_DDR_Clk_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_Clk_n_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_CE_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_CS_n_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_RAS_n_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_CAS_n_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_WE_n_pin : out std_logic;
      fpga_0_DDR_SDRAM_DDR_BankAddr_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR_SDRAM_DDR_Addr_pin : out std_logic_vector(12 downto 0);
      fpga_0_DDR_SDRAM_DDR_DQ_pin : inout std_logic_vector(15 downto 0);
      fpga_0_DDR_SDRAM_DDR_DM_pin : out std_logic_vector(1 downto 0);
      fpga_0_DDR_SDRAM_DDR_DQS_pin : inout std_logic_vector(1 downto 0);
      fpga_0_DDR_SDRAM_ddr_dqs_div_io_pin : inout std_logic;
      fpga_0_clk_1_sys_clk_pin : in std_logic;
      fpga_0_rst_1_sys_rst_pin : in std_logic;
      dip_GPIO_IO_I_pin : in std_logic_vector(0 to 3);
      push_GPIO_IO_I_pin : in std_logic_vector(0 to 3);
      lcd_ip_J09_lcd_pin : out std_logic_vector(0 to 6)
    );
  end component;

  attribute BOX_TYPE : STRING;
  attribute BOX_TYPE of system : component is "user_black_box";

begin

  system_i : system
    port map (
      fpga_0_RS232_DCE_RX_pin => fpga_0_RS232_DCE_RX_pin,
      fpga_0_RS232_DCE_TX_pin => fpga_0_RS232_DCE_TX_pin,
      fpga_0_LEDs_8Bit_GPIO_IO_O_pin => fpga_0_LEDs_8Bit_GPIO_IO_O_pin,
      fpga_0_DDR_SDRAM_DDR_Clk_pin => fpga_0_DDR_SDRAM_DDR_Clk_pin,
      fpga_0_DDR_SDRAM_DDR_Clk_n_pin => fpga_0_DDR_SDRAM_DDR_Clk_n_pin,
      fpga_0_DDR_SDRAM_DDR_CE_pin => fpga_0_DDR_SDRAM_DDR_CE_pin,
      fpga_0_DDR_SDRAM_DDR_CS_n_pin => fpga_0_DDR_SDRAM_DDR_CS_n_pin,
      fpga_0_DDR_SDRAM_DDR_RAS_n_pin => fpga_0_DDR_SDRAM_DDR_RAS_n_pin,
      fpga_0_DDR_SDRAM_DDR_CAS_n_pin => fpga_0_DDR_SDRAM_DDR_CAS_n_pin,
      fpga_0_DDR_SDRAM_DDR_WE_n_pin => fpga_0_DDR_SDRAM_DDR_WE_n_pin,
      fpga_0_DDR_SDRAM_DDR_BankAddr_pin => fpga_0_DDR_SDRAM_DDR_BankAddr_pin,
      fpga_0_DDR_SDRAM_DDR_Addr_pin => fpga_0_DDR_SDRAM_DDR_Addr_pin,
      fpga_0_DDR_SDRAM_DDR_DQ_pin => fpga_0_DDR_SDRAM_DDR_DQ_pin,
      fpga_0_DDR_SDRAM_DDR_DM_pin => fpga_0_DDR_SDRAM_DDR_DM_pin,
      fpga_0_DDR_SDRAM_DDR_DQS_pin => fpga_0_DDR_SDRAM_DDR_DQS_pin,
      fpga_0_DDR_SDRAM_ddr_dqs_div_io_pin => fpga_0_DDR_SDRAM_ddr_dqs_div_io_pin,
      fpga_0_clk_1_sys_clk_pin => fpga_0_clk_1_sys_clk_pin,
      fpga_0_rst_1_sys_rst_pin => fpga_0_rst_1_sys_rst_pin,
      dip_GPIO_IO_I_pin => dip_GPIO_IO_I_pin,
      push_GPIO_IO_I_pin => push_GPIO_IO_I_pin,
      lcd_ip_J09_lcd_pin => lcd_ip_J09_lcd_pin
    );

end architecture STRUCTURE;

