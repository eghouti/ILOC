library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_cls is
generic(K : integer:=8; -- the depth of the memory
	n : integer:=16); -- n bits for quantification 
port( e,clk: in std_logic;
      d_cls: in std_logic_vector(9 downto 0);
      adress: in std_logic_vector(K-1 downto 0);
      q_cls: out std_logic_vector(9 downto 0));
end entity;

architecture behav of memory_cls is
type matrix_t_cls is array(0 to 200) of std_logic_vector(9 downto 0);
signal matrix_cls: matrix_t_cls;

begin

	process(clk)
	begin
		if(rising_edge(clk)) then
			if(e='0') then 
				matrix_cls(to_integer(unsigned(adress)))<=d_cls;
			elsif(e='1') then
				q_cls<=matrix_cls(to_integer(unsigned(adress)));
			end if;
		end if;
	end process;
end behav;

