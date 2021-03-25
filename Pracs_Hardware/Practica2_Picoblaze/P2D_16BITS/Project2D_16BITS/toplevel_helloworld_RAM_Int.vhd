library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity toplevel is
    Port (      
	-- COMENTAMOS YA QUE NUESTRO PROCESADOR ES DE 16 BITS Y ESTAS SEÑALES DE DEBUG OCUPAN MUCHOS PINES
	--port_id : out std_logic_vector(15 downto 0);	--solo para depurar
	--write_strobe : out std_logic;	 						--solo para depurar
	--read_strobe : out std_logic;							--solo para depurar
   --out_port : out std_logic_vector(15 downto 0);	--solo para depurar
   --in_port : out std_logic_vector(15 downto 0);	--solo para depurar
						reset : in std_logic;
						  clk : in std_logic;
						   rx : in std_logic;
				         tx : out std_logic;
		     		     LED : out std_logic);	 --led de comprobacion y reset
end toplevel ;

architecture behavioral of toplevel is
----------------------------------------------------------------
-- declaracion del picoblaze
----------------------------------------------------------------
  component picoblaze
    Port (      address : out std_logic_vector(15 downto 0);
            instruction : in std_logic_vector(25 downto 0);
                port_id : out std_logic_vector(15 downto 0);
           write_strobe : out std_logic;
               out_port : out std_logic_vector(15 downto 0);
            read_strobe : out std_logic;
                in_port : in std_logic_vector(15 downto 0);
              interrupt : in std_logic;
                  reset : in std_logic; 
						  clk : in std_logic);
    end component;

-----------------------------------------------------------------
-- declaración de la ROM de programa
-----------------------------------------------------------------
  component programa_helloworld_int_FLIP 
    Port (      address : in std_logic_vector(15 downto 0);
            		   dout : out std_logic_vector(25 downto 0); -- ??
                    clk : in std_logic);
    end component;

-----------------------------------------------------------------
-- Signals usadas para conectar el picoblaze y la ROM de programa
-----------------------------------------------------------------
signal     address : std_logic_vector(15 downto 0);
signal instruction : std_logic_vector(25 downto 0);
		
-----------------------------------------------------------------
-- Signals para debugging 
-----------------------------------------------------------------
signal readstrobe: std_logic;
signal writestrobe: std_logic;
signal portid: std_logic_vector(15 downto 0);
signal inport: std_logic_vector(15 downto 0);
signal outport: std_logic_vector(15 downto 0);
signal picoint: std_logic;

type ram_type is array (0 to 63) of std_logic_vector (15 downto 0);
signal RAM : ram_type := (
x"000A", x"000D", x"002A", x"0020", x"0044", x"0049", x"0045", x"0047",
x"004F", x"0020", x"0059", x"0020", x"0041", x"004E", x"0044", x"0052",
x"0045", x"0053", x"0020", x"002A", x"000A", x"000D", x"002A", x"0020", 
x"0031", x"0036", x"0020", x"0042", x"0049", x"0054", x"0053", x"0020", 
x"002A", x"000A", x"000D", x"002A", x"0020", x"0032", x"0030", x"0032", 
x"0030", x"002F", x"0032", x"0030", x"0032", x"0031", x"0020", x"002A", 
x"000A", x"000D", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", 
x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000", x"0000");

signal rxbuff_out,RAM_out: std_logic_vector(15 downto 0);

begin

	LED <= reset; 	-- para comprobar la programacion encendemos
						--	un led cada vez que reseteamos
						
	-- COMENTAMOS YA QUE NUESTRO PROCESADOR ES DE 16 BITS Y ESTAS SEÑALES DE DEBUG OCUPAN MUCHOS PINES
	-- read_strobe <= readstrobe;
	-- write_strobe <= writestrobe;
	-- port_id <= portid;
	-- in_port <= inport;
	-- out_port <= outport;
	
	picoint <= NOT rx;
 	
  processor: picoblaze
    port map(      address => address,
               instruction => instruction,
                   port_id => portid,
              write_strobe => writestrobe,
                  out_port => outport,
               read_strobe => readstrobe,
                   in_port => inport,
                 interrupt => picoint,
                     reset => reset,
                       clk => clk);

  program: programa_helloworld_int_FLIP 
    port map(     address => address,
               	     dout => instruction,
                      clk => clk);

	--registra el bit tx del puerto de salida, por si éste cambia
	txbuff:process(reset, clk)
	begin
		if (reset='1') then
			tx <= '1';
		elsif rising_edge(clk) then
			if (writestrobe = '1' and portid=x"00FF") then
				tx <= outport(0);	
			end if;
		end if;
	end process;
	
	--añade 7ceros a rx para meterlos al puerto de entrada cuando se lea
	rxbuff:process(reset, clk)
	begin
		if (reset='1') then
			rxbuff_out <= (others=>'1');
		elsif rising_edge(clk) then
			if (readstrobe = '1' and portid =x"00FF") then
				rxbuff_out <= rx & "000000000000000";	
			end if;		 
		end if;
	end process;
	
	-- Memoria RAM (escritura sincrona / lectura asincrona)
	process (clk)
	begin
		if (clk'event and clk = '1') then
			if (writestrobe = '1' and portid<x"0040") then
				RAM(to_integer(unsigned(portid))) <= outport;
			end if;
		end if;
	end process;
	RAM_out <= RAM(to_integer(unsigned(portid)));
	
-- Multiplexor inport
inport <= RAM_out when (readstrobe = '1' and portid<x"0040") else
			 rxbuff_out when (readstrobe = '1' and portid=x"00FF") else
			 x"0000";

end behavioral;