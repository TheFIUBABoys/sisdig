library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DispSelect is
	port(
		sel     :   in std_logic_vector(1 downto 0);
	
		q  :   out std_logic_vector(3 downto 0)
	);
end entity;

architecture arq_DispSelect of DispSelect is
  signal e0, e1, e2, e3  : std_logic_vector(3 downto 0);
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
begin

  
  e0(3) <= '1';e0(2) <= '1';e0(1) <= '1';e0(0) <= '0';
  e1(3) <= '1';e1(2) <= '1';e1(1) <= '0';e1(0) <= '1';
  e2(3) <= '1';e2(2) <= '0';e2(1) <= '1';e2(0) <= '1';
  e3(3) <= '0';e3(2) <= '1';e3(1) <= '1';e3(0) <= '1';

  inst_Mux: Mux port map(e0,e1,e2,e3, sel ,q);
end; 