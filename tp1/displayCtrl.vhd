library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DispCtrl is
  port(
---   Entradad del contador
    num     :   in std_logic_vector(3 downto 0);
---   Salida del controlador
    segments     :   out std_logic_vector(7 downto 0)
  );
end entity DispCtrl;
  
architecture arq_DispCtrl of DispCtrl is
signal aux_seg 	 :   std_logic_vector(7 downto 0);
begin
	selector: process(num)
    begin
		if (unsigned(num) = 0) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='0';aux_seg(2)<='0';aux_seg(1)<='1';aux_seg(0)<='1';
		elsif (unsigned(num) = 1) then aux_seg(7)<='1';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='1';aux_seg(3)<='1';aux_seg(2)<='1';aux_seg(1)<='1';aux_seg(0)<='1';
		elsif (unsigned(num) = 2) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='1';aux_seg(4)<='0';aux_seg(3)<='0';aux_seg(2)<='1';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 3) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='1';aux_seg(2)<='1';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 4) then aux_seg(7)<='1';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='1';aux_seg(3)<='1';aux_seg(2)<='0';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 5) then aux_seg(7)<='0';aux_seg(6)<='1';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='1';aux_seg(2)<='0';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 6) then aux_seg(7)<='0';aux_seg(6)<='1';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='0';aux_seg(2)<='0';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 7) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='1';aux_seg(3)<='1';aux_seg(2)<='1';aux_seg(1)<='1';aux_seg(0)<='1';
		elsif (unsigned(num) = 8) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='0';aux_seg(2)<='0';aux_seg(1)<='0';aux_seg(0)<='1';
		elsif (unsigned(num) = 9) then aux_seg(7)<='0';aux_seg(6)<='0';aux_seg(5)<='0';aux_seg(4)<='0';aux_seg(3)<='1';aux_seg(2)<='0';aux_seg(1)<='0';aux_seg(0)<='1';  
        end if;
    end process selector;
	segments <= aux_seg;
end architecture arq_DispCtrl;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testDispCtrl is
end;

architecture test_DispCtrl of testDispCtrl is
component DispCtrl is
	port (
---   Entradad del contador
    num     :   in std_logic_vector(3 downto 0);
---   Salida del controlador
    segments     :   out std_logic_vector(7 downto 0)
	); 
end component;
component ContBCD is
  port(
---   Entradad del clock
    clk     :   in std_logic;
    reset   :   in std_logic;
    enable  :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q       :   out std_logic_vector(3 downto 0)
  );
end component;
 signal r_t,ck_t,e_t: std_logic := '1';
 signal q_t: std_logic_vector(3 downto 0);
 signal seg_t: std_logic_vector(7 downto 0);
begin
  ck_t <= not ck_t after 10 ns;
  r_t <= '0' after 1 ns;
  inst_ContBCD: ContBCD port map(ck_t,r_t,e_t,q_t);
  inst_DispCtrl: DispCtrl port map(q_t,seg_t);
end; 
