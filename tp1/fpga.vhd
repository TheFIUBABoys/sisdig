library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FPGA is
  generic(nanosecs, cant: integer);
  port(
	clk 	: 	in std_logic;
	rst		: 	in std_logic;
	
	selector			:	out std_logic_vector(3 downto 0);
	a,b,c,d,e,f,g,dp	: 	out std_logic
  );
end entity FPGA;

architecture arq_FPGA of FPGA is
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
component Cont4BCD is
	port (
---   Entradad del clock
    clk   :   in std_logic;
    reset   :   in std_logic;
    enable   :   in std_logic;
---   Salida del contador. Cuenta en binario
    BCD0       :   out std_logic_vector(3 downto 0);
	BCD1       :   out std_logic_vector(3 downto 0);
	BCD2       :   out std_logic_vector(3 downto 0);
	BCD3       :   out std_logic_vector(3 downto 0)
	); 
end component;
signal bcd0, bcd1,bcd2,bcd3: std_logic_vector(3 downto 0);
signal gen_en: std_logic;
signal q_t : std_logic_vector(15 downto 0);
begin
	instGenEnable: 	GenEnable generic map(nanosecs) port map(clk,rst,'1',gen_en); 
	inst_Cont4BCD: Cont4BCD port map(clk,rst,gen_en,bcd0,bcd1,bcd2,bcd3);
	instDC: DisplayController generic map(cant) port map(clk,'1',bcd0,bcd1,bcd2,bcd3,selector,a,b,c,d,e,f,g,dp);
end architecture arq_FPGA;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testFPGA is
end;

architecture test_FPGA of testFPGA is
component FPGA is
  generic(nanosecs, cant: integer);
  port(
	clk 	: 	in std_logic;
	rst		: 	in std_logic;
	
	selector			:	out std_logic_vector(3 downto 0);
	a,b,c,d,e,f,g,dp	: 	out std_logic
  );
end component FPGA;
 signal ck_t, rst: std_logic := '1';
 signal selected_dsp : std_logic_vector(3 downto 0) := "0000";
 signal seg	: 	std_logic_vector(7 downto 0):= "00000000";
begin
	rst <= '0' after 10 ns;
	ck_t <= not ck_t after 10 ns;
	instFPGA: FPGA generic map(16,1) port map(ck_t,rst,selected_dsp,seg(0),seg(1),seg(2),seg(3),seg(4),seg(5),seg(6),seg(7));
end; 
