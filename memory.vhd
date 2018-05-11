library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
generic(K : integer:=8; -- the depth of the memory
	n : integer:=16); -- n bits for quantification 
port( e,clk: in std_logic;
      d: in std_logic_vector(32*n-1 downto 0);
      adress: in std_logic_vector(K-1 downto 0);
      out_compteur_memory: out std_logic_vector(K-1 downto 0);
      q: out std_logic_vector(32*n-1 downto 0));
end entity;

architecture behav of memory is
type matrix_t is array(0 to 200) of std_logic_vector(32*n-1 downto 0);
signal matrix : matrix_t; --the memory

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(e='0') then 
				matrix(to_integer(unsigned(adress)))<=d;
			elsif(e='1') then
				q<=matrix(to_integer(unsigned(adress)))(32*n-1 downto 0);
				out_compteur_memory<=adress;
			end if;
		end if;
	end process;
end behav;

