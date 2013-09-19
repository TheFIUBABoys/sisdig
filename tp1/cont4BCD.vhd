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
    BCD0       :   out std_logic_vector(3 downto 0);
	BCD1       :   out std_logic_vector(3 downto 0);
	BCD2       :   out std_logic_vector(3 downto 0);
	BCD3       :   out std_logic_vector(3 downto 0)
  );
end entity Cont4BCD;
  
architecture arq_Cont4BCD of Cont4BCD is
signal c0,c1,c2,c3: integer;
begin
	count_proc: process(clk, reset)
    begin
        if (reset='1') then
            c0 <= 0;c1 <= 0;c2 <= 0;c3 <= 0;
        elsif (rising_edge(clk)) then
            if (enable = '1') then
                c0 <= c0 + 1;
				if (c0 = 9) then
					c0 <= 0;
					c1 <= c1+1;
				end if;
				if (c1 = 9 and c0 = 9) then
					c1 <= 0;c0 <= 0;
					c2 <= c2+1;
				end if;
				if (c2 = 9 and c1 = 9 and c0 = 9) then
					c2 <= 0;c1 <= 0;c0 <= 0;
					c3 <= c3+1;
				end if;
				if (c3 = 9 and c2 = 9 and c1 = 9 and c0 = 9 ) then
					c3 <= 0;c2 <= 0;c1 <= 0;c0 <= 0;
				end if;
            end if;
        end if;
    end process count_proc;
	BCD0 <= std_logic_vector(to_unsigned(c0,4));
	BCD1 <= std_logic_vector(to_unsigned(c1,4));
	BCD2 <= std_logic_vector(to_unsigned(c2,4));
	BCD3 <= std_logic_vector(to_unsigned(c3,4));
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
    BCD0       :   out std_logic_vector(3 downto 0);
	BCD1       :   out std_logic_vector(3 downto 0);
	BCD2       :   out std_logic_vector(3 downto 0);
	BCD3       :   out std_logic_vector(3 downto 0)
	); 
end component;
  signal r_t,ck_t,e_t: std_logic := '1';
  signal BCD0_t,BCD1_t,BCD2_t,BCD3_t: std_logic_vector(3 downto 0);
begin
  ck_t <= not ck_t after 10 ns;
  r_t <= '0';--- after 1 ps;
  e_t <= not e_t after 20 ns;
  
  inst_Cont4BCD: Cont4BCD port map(ck_t,r_t,e_t,BCD0_t,BCD1_t,BCD2_t,BCD3_t);
end; 
