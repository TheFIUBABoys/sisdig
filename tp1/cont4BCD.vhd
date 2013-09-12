library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Cont4BCD is
  port(
---   Entradad del clock
    clk     :   in std_logic;
    reset   :   in std_logic;
    enable  :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q       :   out std_logic_vector(15 downto 0)
  );
end entity Cont4BCD;
  
architecture arq_Cont4BCD of Cont4BCD is
signal counter: integer;
begin
	count_proc: process(clk, reset)
    begin
        if (reset='1') then
            counter <= 0;
        elsif (rising_edge(clk)) then
            if (enable = '1') then
                counter <= counter + 1;
                if (counter = 9999) then
					counter <= 0;
				end if;
            end if;
        end if;
    end process count_proc;
	Q <= std_logic_vector(to_unsigned(counter,16));
end architecture arq_Cont4BCD;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testCont4BCD is
end;

architecture test_Cont4BCD of testCont4BCD is
component Cont4BCD is
	port (
---   Entradad del clock
    clk   :   in std_logic;
    reset   :   in std_logic;
    enable   :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q     :   out std_logic_vector(15 downto 0)
	); 
end component;
  signal r_t,ck_t,e_t: std_logic := '1';
  signal q_t: std_logic_vector(15 downto 0);
begin
  ck_t <= not ck_t after 10 ns;
  r_t <= '0';--- after 1 ps;
  e_t <= not e_t after 20 ns;
  
  inst_Cont4BCD: Cont4BCD port map(ck_t,r_t,e_t,q_t);
end; 
