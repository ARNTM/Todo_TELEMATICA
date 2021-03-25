--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: toplevel_synthesis.vhd
-- /___/   /\     Timestamp: Sat Dec 19 08:32:28 2020
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm toplevel -w -dir netgen/synthesis -ofmt vhdl -sim toplevel.ngc toplevel_synthesis.vhd 
-- Device	: xc3s500e-4-fg320
-- Input file	: toplevel.ngc
-- Output file	: D:\GIT\Universidad\Pracs_Hardware\Practica2_Picoblaze\P2D_16BITS\Project2D_16BITS\netgen\synthesis\toplevel_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: toplevel
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity toplevel is
  port (
    clk : in STD_LOGIC := 'X'; 
    reset : in STD_LOGIC := 'X'; 
    rx : in STD_LOGIC := 'X'; 
    tx : out STD_LOGIC; 
    LED : out STD_LOGIC 
  );
end toplevel;

architecture Structure of toplevel is
  signal LED_OBUF_1 : STD_LOGIC; 
  signal tx_OBUF_4 : STD_LOGIC; 
begin
  XST_VCC : VCC
    port map (
      P => tx_OBUF_4
    );
  reset_IBUF : IBUF
    port map (
      I => reset,
      O => LED_OBUF_1
    );
  tx_OBUF : OBUF
    port map (
      I => tx_OBUF_4,
      O => tx
    );
  LED_OBUF : OBUF
    port map (
      I => LED_OBUF_1,
      O => LED
    );

end Structure;

