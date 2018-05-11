library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity soustracteur is
generic(n : integer :=16);
port(a,b: in std_logic_vector(n-1 downto 0);
     c: out std_logic_vector(n-1 downto 0));
end entity;

architecture behav of soustracteur is
begin
c<=std_logic_vector(to_signed(to_integer(signed(a)) - to_integer(signed(b)),n));
end behav;
