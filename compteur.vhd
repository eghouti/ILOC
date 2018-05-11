library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur is
generic(K: integer:=8);
port(e,clk,reset: in std_logic;
     q: out std_logic_vector(k-1 downto 0));
     
end entity;

architecture behav of compteur is
signal qs : std_logic_vector(k-1 downto 0):=(others=>'0');
begin
    process(reset,clk)
    begin
        if(reset='1')then
            qs<=(others=>'0');
        elsif(rising_edge(clk))then
            if(e='0')then
                qs<=std_logic_vector(to_unsigned(to_integer(unsigned(qs))+1,k));
            end if;
        end if;
     end process;
q<=qs;
end behav;
