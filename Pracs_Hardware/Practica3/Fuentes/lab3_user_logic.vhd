  lcd_PROC : process(Bus2IP_Clk) is
  begin
    if Bus2IP_Clk'event and Bus2IP_Clk='1' then
      if Bus2IP_Reset='1' then
	lcd_i<=(others=>'0');
      else
        if Bus2IP_WrCE(0)='1' then
	  lcd_i<=Bus2IP_Data(25 to 31);
        end if;
      end if;
    end if;
  end process lcd_PROC;
  lcd<=lcd_i;

