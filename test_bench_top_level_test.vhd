library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_bench_top_level_test is
generic(n: integer :=16);
port(input_test: in std_logic_vector(2048*n-1 downto 0);
     new_data: in std_logic);
end entity;

architecture test_bench of test_bench_top_level_test is

component top_level_test is
generic(n: integer:=16);
port(reset,clk,l_p,new_data: in std_logic;
      input_test : in std_logic_vector(2048*n-1 downto 0));
end component;

signal reset_s,l_p_s: std_logic;
signal clk_s: std_logic :='0';
begin
u0: top_level_test port map(reset_s,clk_s,l_p_s,new_data,input_test);

 
 process
 begin
    l_p_s<='0';
    reset_s<='1';
     wait for 5 ns;
     reset_s<='0';
     wait for 5 ns;
    for i in 0 to 199 loop
    clk_s<='0';
    wait for 5 ns;
    clk_s<='1';
    wait for 5 ns;
end loop;
l_p_s<='1';
wait for 10 ns;
for i in 0 to 60000 loop
    clk_s<='0';
    wait for 5 ns;
    clk_s<='1';
    wait for 5 ns;
end loop;

end process;
 end test_bench;
