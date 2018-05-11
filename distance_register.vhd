library ieee;
use ieee.std_logic_1164.all;

entity distance_register is
generic(n:integer :=16);--quantification
port(clk: in std_logic;
     d:in std_logic_vector(32*2*n+4 downto 0);
     q: out std_logic_vector(32*2*n+4 downto 0));
end entity;

architecture behav of distance_register is

begin
	process(clk)
	begin
		if(rising_edge(clk))then
			q<=d;
			
		end if;
	end process;
end behav;
