library ieee;
use ieee.std_logic_1164.all;

entity comparaison is
generic(k : integer:=8;
        n: integer:=16);
port(c: in std_logic_vector(2*n+4 downto 0);
     itter: in std_logic_vector(k-1 downto 0);
     e,clk,f: in std_logic;
     f_out : out std_logic;
     itter_best: out std_logic_vector(k-1 downto 0));
end entity;

architecture behav of comparaison is
signal distance_register : std_logic_vector(2*n+4 downto 0):=(others=>'1');
signal itter_best_s: std_logic_vector(k-1 downto 0);
begin
process(clk)
begin
    if(rising_edge(clk))then
        if(e='1')then
            if(f='1')then
            
             distance_register<=c;
             itter_best_s<=itter;
             itter_best<=itter_best_s;
            elsif(distance_register>c)then
                distance_register<=c;
                itter_best_s<=itter;
		        
             end if;
             f_out<=f;
             --if(f='1')then
             --if(itter=X"00")then
             --distance_register<=(others=>'1');
             --end if;
         elsif(e='0')then
            distance_register<=(others=>'1');
         end if;
     end if;
end process;

end behav;
