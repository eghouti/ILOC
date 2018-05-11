library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur_processing is
generic(K: integer:=8);
port(e,clk,reset: in std_logic; --e='1'=> processing
     d: in std_logic_vector(K-1 downto 0);
     f: out std_logic;--f='1'=> the loop is over
     --new_data: in std_logic;--new_data='1'=> new processing data
     q: out std_logic_vector(k-1 downto 0));
     
end entity;

architecture behav of compteur_processing is
signal qs : std_logic_vector(K-1 downto 0);
begin
	process(reset,clk)
	begin
		if(reset='1') then
			qs<=(others=>'0');
			f<='0';
		elsif(rising_edge(clk)) then
			if(e='1')then
				if(qs=d)then
					f<='1';
					qs<=(others=>'0');
				else
					f<='0';
					qs<=std_logic_vector(to_unsigned(to_integer(unsigned(qs))+1,K));
				end if;
			end if;
		end if;
	end process;
q<=qs;
end behav;
