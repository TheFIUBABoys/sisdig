library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux is
  port(
    e0	:   in std_logic_vector(3 downto 0);
    e1	:   in std_logic_vector(3 downto 0);
    e2	:   in std_logic_vector(3 downto 0);
	e3	:   in std_logic_vector(3 downto 0);

    sel     :   in std_logic_vector(1 downto 0);
	
	q  :   out std_logic_vector(3 downto 0)
  );
end entity Mux;
  
architecture arq_Mux of Mux is
signal q_tmp : std_logic_vector(3 downto 0);
begin
	mux_proc: process(sel)
    begin
        if (unsigned(sel) = 0) then q_tmp <= e0;
        elsif (unsigned(sel) = 1) then q_tmp <= e1;
		elsif (unsigned(sel) = 2) then q_tmp <= e2;
		elsif (unsigned(sel) = 3) then q_tmp <= e3;
		end if;
    end process mux_proc;
	q <= q_tmp;
end architecture arq_Mux;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testMux is
end;

architecture test_Mux of testMux is
component Mux is
	port (
    e0	:   in std_logic_vector(3 downto 0);
    e1	:   in std_logic_vector(3 downto 0);
    e2	:   in std_logic_vector(3 downto 0);
	e3	:   in std_logic_vector(3 downto 0);

    sel     :   in std_logic_vector(1 downto 0);
	
	q  :   out std_logic_vector(3 downto 0)
	); 
end component;
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
  signal e0, e1, e2, e3, q1 : std_logic_vector(3 downto 0);
  signal r_t,ck_t,e_t: std_logic := '1';
  signal sel_t: std_logic_vector(1 downto 0);
  
begin
  ck_t <= not ck_t after 10 ns;
  r_t <= '0' after 1 ps;
  e_t <= not e_t after 20 ns;
  
  e0(3) <= '0';e0(2) <= '0';e0(1) <= '0';e0(0) <= '1';
  e1(3) <= '0';e1(2) <= '0';e1(1) <= '1';e1(0) <= '0';
  e2(3) <= '0';e2(2) <= '1';e2(1) <= '0';e2(0) <= '0';
  e3(3) <= '1';e3(2) <= '0';e3(1) <= '0';e3(0) <= '0';
  
  inst_cont: Cont2b port map(ck_t,r_t,e_t,sel_t);
  
  inst_Mux: Mux port map(e0,e1,e2,e3, sel_t ,q1);
end; 