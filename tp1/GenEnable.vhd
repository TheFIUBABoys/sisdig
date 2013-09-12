library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GenEnable is
  port(
---   Entradad del clock
    clk     :   in std_logic;
    reset   :   in std_logic;
    enable  :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q     :   out std_logic
  );
end entity GenEnable;
  
architecture arq_GenEnable of GenEnable is
signal counter: integer;
begin
	count_proc: process(clk, reset)
    begin
        if (reset='1') then
            counter <= 0;
			Q <= '0';
        elsif (rising_edge(clk)) then
            if (enable = '1') then
                counter <= counter + 1;
				Q <= '0';
                if (counter = 499) then
					counter <= 0;
					Q <= '1';
				end if;
            end if;
        end if;
    end process count_proc;
end architecture arq_GenEnable;

--Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;

entity testGenEnable is
end;

architecture test_GenEnable of testGenEnable is
component GenEnable is
	port (
---   Entradad del clock
    clk   :   in std_logic;
    reset   :   in std_logic;
    enable   :   in std_logic;
---   Salida del contador. Cuenta en binario
    Q     :   out std_logic
	); 
end component;
  signal r_t,ck_t,e_t: std_logic := '1';
  signal q_t: std_logic;
begin
  ck_t <= not ck_t after 10 ns;
  r_t <= '0' after 1 ns;
  
  inst_GenEnable: GenEnable port map(ck_t,r_t,e_t,q_t);
end; 
