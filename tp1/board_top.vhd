--  Universidad de Buenos Aires - Facultad de Ingenieria
--  66.17 - Sistemas Digitales
--  Pagina web de la materia: http://cactus.fi.uba.ar/6617/
--  Tema: Ejemplo de un posible "top-level" para el trabajo practico N°1
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Board_Top is
   port(
      -------------------------------------------
      -- Xilinx/Digilent SPARTAN-3 Starter Kit --
      -------------------------------------------
      -- Board Leds / 7-segment displays:
      s3s_anodes_o     : out std_logic_vector(3 downto 0);
      s3s_segment_a_o  : out std_logic;
      s3s_segment_b_o  : out std_logic;
      s3s_segment_c_o  : out std_logic;
      s3s_segment_d_o  : out std_logic;
      s3s_segment_e_o  : out std_logic;
      s3s_segment_f_o  : out std_logic;
      s3s_segment_g_o  : out std_logic;
      s3s_segment_dp_o : out std_logic;

--      switches_i       : in  std_logic_vector(7 downto 0);  -- hay 8 "slide switches" en la placa.
      buttons_i        : in  std_logic_vector(3 downto 0);    -- hay 4 botones en la placa.
--      leds_o           : out std_logic_vector(7 downto 0);  -- hay 7 leds en la placa.
      xtal_i           : in  std_logic);                      -- cristal, por default es de 50MHz

      attribute LOC  : string;

        -------------------------------------------
        -- Xilinx/Digilent SPARTAN-3 Starter Kit --
        -------------------------------------------
      attribute LOC of xtal_i        : signal is "B8"; -- fijate que con los atributos se asignan los pines de la FPGA a las entradas/salidas de la entidad.
--      attribute LOC of leds_o        : signal is "P11 P12 N12 P13 N14 L12 P14 K12";
      attribute LOC of buttons_i     : signal is "B18 D18 E18 H13";   
--      attribute LOC of switches_i    : signal is "K13 K14 J13 J14 H13 H14 G12 F12";
      attribute LOC of s3s_anodes_o     : signal is "F15 C18 H17 F17";
      attribute LOC of s3s_segment_a_o  : signal is "L18";
      attribute LOC of s3s_segment_b_o  : signal is "F18";
      attribute LOC of s3s_segment_c_o  : signal is "D17";
      attribute LOC of s3s_segment_d_o  : signal is "D16";
      attribute LOC of s3s_segment_e_o  : signal is "G14";
      attribute LOC of s3s_segment_f_o  : signal is "J17";
      attribute LOC of s3s_segment_g_o  : signal is "H14";
      attribute LOC of s3s_segment_dp_o : signal is "C17";
end entity Board_Top;


architecture RTL of Board_Top is
component FPGA is
  generic(nanosecs, cant: integer);
  port(
	clk 	: 	in std_logic;
	rst		: 	in std_logic;
	
	selector			:	out std_logic_vector(3 downto 0);
	a,b,c,d,e,f,g,dp	: 	out std_logic
  );
end component FPGA;
-- SENIALES UTILIZADAS:
signal clk_i : std_logic:='0';                     -- reloj del sistema
begin

-- Ejemplo de asignacion de la entrada del cristal a una senial que defini como "clk_i".
	clk_i <= xtal_i;     
	-- 50000000 para que cuente segundos y 50000 para que la frecuencia de cambio de digito el display sea 1khz
	instFPGA: FPGA generic map(50000000,50000) port map(clk_i,buttons_i(0),s3s_anodes_o,s3s_segment_a_o,s3s_segment_b_o,s3s_segment_c_o,s3s_segment_d_o,s3s_segment_e_o,s3s_segment_f_o,s3s_segment_g_o,s3s_segment_dp_o);
end architecture RTL; -- Entity: Board_Top

