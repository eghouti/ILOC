library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity multiplier is
generic(n: integer :=16);
port(a,b: in std_logic_vector(n-1 downto 0);
     c: out std_logic_vector(2*n-1 downto 0));
end entity;

architecture behav of multiplier is
begin
c<=std_logic_vector(to_unsigned(to_integer(signed(a))*to_integer(signed(b)),2*n));
end behav;
