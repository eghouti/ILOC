library ieee;
use ieee.std_logic_1164.all;

entity registre_entrer is
generic(n : integer :=16); 
port(clk: in std_logic;
     d: in std_logic_vector(2048*n-1 downto 0);
     q: out std_logic_vector(2048*n-1 downto 0));
end entity;

architecture behav of registre_entrer is

begin
	process(clk)
	begin
		if(rising_edge(clk))then
		q<=d;
		end if;
	end process;
end behav;
