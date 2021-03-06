library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DisplayController is
  generic(cant: integer);
  port(
	clk 	: 	in std_logic;
	enable	: 	in std_logic;
	bcd0 	:	in std_logic_vector(3 downto 0);
	bcd1 	:	in std_logic_vector(3 downto 0);
	bcd2 	:	in std_logic_vector(3 downto 0);
	bcd3 	:	in std_logic_vector(3 downto 0);
	
	selector			:	out std_logic_vector(3 downto 0);
	a,b,c,d,e,f,g,dp	: 	out std_logic
  );
end entity DisplayController;
  
architecture arq_DisplayController of DisplayController is
component GenEnable is
  generic(max: integer);
  port(
---   Entradad del clock
    clk     :   in std_logic;
    reset   :   in std_logic;
    enable  :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q     :   out std_logic
  );
end component GenEnable;
component Mux is
  port(
    e0	:   in std_logic_vector(3 downto 0);
    e1	:   in std_logic_vector(3 downto 0);
    e2	:   in std_logic_vector(3 downto 0);
	e3	:   in std_logic_vector(3 downto 0);

    sel     :   in std_logic_vector(1 downto 0);
	
	q  :   out std_logic_vector(3 downto 0)
  );
end component Mux;
component DispCtrl is
  port(
---   Entradad del contador
    num     :   in std_logic_vector(3 downto 0);
---   Salida del controlador
    segments     :   out std_logic_vector(7 downto 0)
  );
end component DispCtrl;
component Cont2b is
  port(
---   Entradad del clock
    clk     :   in std_logic;
    reset   :   in std_logic;
    enable  :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q       :   out std_logic_vector(1 downto 0)
  );
end component Cont2b;
component DispSelect is
	port(
		sel     :   in std_logic_vector(1 downto 0);
	
		q  :   out std_logic_vector(3 downto 0)
	);
end component;
signal gen_en:  std_logic := '0';
signal rst : std_logic := '1';
signal count: std_logic_vector(1 downto 0) := "00";
signal selected_in, selected_dsp: std_logic_vector(3 downto 0) := "0000";
signal segm_t : std_logic_vector(7 downto 0) := "00000000";
begin
	rst <= '0' after 1 ns;
	instGenEnable: 	GenEnable generic map(cant) port map(clk,rst,enable,gen_en);
	instCont2b: 	Cont2b port map(clk,rst,gen_en,count);
	instMux:		Mux port map(bcd0,bcd1,bcd2,bcd3, count , selected_in);
	instDispSelect: DispSelect port map(count, selected_dsp);
	instDispCtrl:  	DispCtrl port map (selected_in,segm_t);
	
	selector <= selected_dsp;
	a <= segm_t(7);b <= segm_t(6);c <= segm_t(5);d <= segm_t(4);
	e <= segm_t(3);f <= segm_t(2);g <= segm_t(1);dp <= segm_t(0);
	
end architecture arq_DisplayController;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testDisplayController is
end;

architecture test_DisplayController of testDisplayController is
component DisplayController is
  generic(cant: integer);
  port(
	clk 	: 	in std_logic;
	enable	: 	in std_logic;
	bcd0 	:	in std_logic_vector(3 downto 0);
	bcd1 	:	in std_logic_vector(3 downto 0);
	bcd2 	:	in std_logic_vector(3 downto 0);
	bcd3 	:	in std_logic_vector(3 downto 0);
	
	selector			:	out std_logic_vector(3 downto 0);
	a,b,c,d,e,f,g,dp	: 	out std_logic
  );
end component DisplayController;
 signal ck_t, en: std_logic := '1';
 signal bcd0, bcd1, bcd2, bcd3 : std_logic_vector(3 downto 0);
 signal selected_dsp : std_logic_vector(3 downto 0) := "0000";
 signal seg	: 	std_logic_vector(7 downto 0):= "00000000";
begin
	ck_t <= not ck_t after 10 ns;
	
	bcd0(3) <= '0';bcd0(2) <= '0';bcd0(1) <= '0';bcd0(0) <= '1';
	bcd1(3) <= '0';bcd1(2) <= '0';bcd1(1) <= '1';bcd1(0) <= '0';
	bcd2(3) <= '0';bcd2(2) <= '0';bcd2(1) <= '1';bcd2(0) <= '1';
	bcd3(3) <= '0';bcd3(2) <= '1';bcd3(1) <= '0';bcd3(0) <= '0';
	
	instDC: DisplayController generic map(5) port map(ck_t,en,bcd0,bcd1,bcd2,bcd3,selected_dsp,seg(7),seg(6),seg(5),seg(4),seg(3),seg(2),seg(1),seg(0));
end; 

