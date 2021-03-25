-------------------------------------------------------------------------------
-- lmb_bram_elaborate.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity lmb_bram_elaborate is
  generic (
    C_MEMSIZE : integer;
    C_PORT_DWIDTH : integer;
    C_PORT_AWIDTH : integer;
    C_NUM_WE : integer;
    C_FAMILY : string
    );
  port (
    BRAM_Rst_A : in std_logic;
    BRAM_Clk_A : in std_logic;
    BRAM_EN_A : in std_logic;
    BRAM_WEN_A : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_A : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_A : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_A : in std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Rst_B : in std_logic;
    BRAM_Clk_B : in std_logic;
    BRAM_EN_B : in std_logic;
    BRAM_WEN_B : in std_logic_vector(0 to C_NUM_WE-1);
    BRAM_Addr_B : in std_logic_vector(0 to C_PORT_AWIDTH-1);
    BRAM_Din_B : out std_logic_vector(0 to C_PORT_DWIDTH-1);
    BRAM_Dout_B : in std_logic_vector(0 to C_PORT_DWIDTH-1)
  );

  attribute keep_hierarchy : STRING;
  attribute keep_hierarchy of lmb_bram_elaborate : entity is "yes";

end lmb_bram_elaborate;

architecture STRUCTURE of lmb_bram_elaborate is

  component RAMB16_S9_S9 is
    generic (
      WRITE_MODE_A : string;
      WRITE_MODE_B : string
    );
    port (
      ADDRA : in std_logic_vector(10 downto 0);
      CLKA : in std_logic;
      DIA : in std_logic_vector(7 downto 0);
      DIPA : in std_logic_vector(0 downto 0);
      DOA : out std_logic_vector(7 downto 0);
      DOPA : out std_logic_vector(0 downto 0);
      ENA : in std_logic;
      SSRA : in std_logic;
      WEA : in std_logic;
      ADDRB : in std_logic_vector(10 downto 0);
      CLKB : in std_logic;
      DIB : in std_logic_vector(7 downto 0);
      DIPB : in std_logic_vector(0 downto 0);
      DOB : out std_logic_vector(7 downto 0);
      DOPB : out std_logic_vector(0 downto 0);
      ENB : in std_logic;
      SSRB : in std_logic;
      WEB : in std_logic
    );
  end component;

  -- Internal signals

  signal dina : std_logic_vector(31 downto 0);
  signal dinb : std_logic_vector(31 downto 0);
  signal douta : std_logic_vector(31 downto 0);
  signal doutb : std_logic_vector(31 downto 0);
  signal net_gnd1 : std_logic_vector(0 downto 0);

begin

  -- Internal assignments

  dina(31 downto 0) <= BRAM_Dout_A(0 to 31);
  BRAM_Din_A(0 to 31) <= douta(31 downto 0);
  dinb(31 downto 0) <= BRAM_Dout_B(0 to 31);
  BRAM_Din_B(0 to 31) <= doutb(31 downto 0);
  net_gnd1(0 downto 0) <= B"0";

  ramb16_s9_s9_0 : RAMB16_S9_S9
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(19 to 29),
      CLKA => BRAM_Clk_A,
      DIA => dina(31 downto 24),
      DIPA => net_gnd1(0 downto 0),
      DOA => douta(31 downto 24),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(0),
      ADDRB => BRAM_Addr_B(19 to 29),
      CLKB => BRAM_Clk_B,
      DIB => dinb(31 downto 24),
      DIPB => net_gnd1(0 downto 0),
      DOB => doutb(31 downto 24),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(0)
    );

  ramb16_s9_s9_1 : RAMB16_S9_S9
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(19 to 29),
      CLKA => BRAM_Clk_A,
      DIA => dina(23 downto 16),
      DIPA => net_gnd1(0 downto 0),
      DOA => douta(23 downto 16),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(1),
      ADDRB => BRAM_Addr_B(19 to 29),
      CLKB => BRAM_Clk_B,
      DIB => dinb(23 downto 16),
      DIPB => net_gnd1(0 downto 0),
      DOB => doutb(23 downto 16),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(1)
    );

  ramb16_s9_s9_2 : RAMB16_S9_S9
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(19 to 29),
      CLKA => BRAM_Clk_A,
      DIA => dina(15 downto 8),
      DIPA => net_gnd1(0 downto 0),
      DOA => douta(15 downto 8),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(2),
      ADDRB => BRAM_Addr_B(19 to 29),
      CLKB => BRAM_Clk_B,
      DIB => dinb(15 downto 8),
      DIPB => net_gnd1(0 downto 0),
      DOB => doutb(15 downto 8),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(2)
    );

  ramb16_s9_s9_3 : RAMB16_S9_S9
    generic map (
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST"
    )
    port map (
      ADDRA => BRAM_Addr_A(19 to 29),
      CLKA => BRAM_Clk_A,
      DIA => dina(7 downto 0),
      DIPA => net_gnd1(0 downto 0),
      DOA => douta(7 downto 0),
      DOPA => open,
      ENA => BRAM_EN_A,
      SSRA => BRAM_Rst_A,
      WEA => BRAM_WEN_A(3),
      ADDRB => BRAM_Addr_B(19 to 29),
      CLKB => BRAM_Clk_B,
      DIB => dinb(7 downto 0),
      DIPB => net_gnd1(0 downto 0),
      DOB => doutb(7 downto 0),
      DOPB => open,
      ENB => BRAM_EN_B,
      SSRB => BRAM_Rst_B,
      WEB => BRAM_WEN_B(3)
    );

end architecture STRUCTURE;

