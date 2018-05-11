library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_1164.all;

entity registre_soustraction is
generic(n: integer :=16);
port(clk,f: in std_logic;
     d: in std_logic_vector(n-1 downto 0);
     f_out: out std_logic;
     q: out std_logic_vector(n-1 downto 0));
end entity;

architecture behav of registre_soustraction is

begin
	process(clk)
	begin
		if(rising_edge(clk))then
			q<=d;
			f_out<=f;
		end if;
	end process;
end behav;
