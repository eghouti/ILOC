library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sommateur is
generic(k: integer:=8;
        n: integer:=16);
port(e,clk,f: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     a : in std_logic_vector(32*2*n-1 downto 0);
     b : out std_logic_vector(2*n+4 downto 0);
     e_out,f_out: out std_logic;
     itter_out: out std_logic_vector(k-1 downto 0));
end entity;

architecture behav of sommateur is
signal e_out_s: std_logic:='0';
signal f_signal1,f_signal2,f_signal3: std_logic;
signal b1,b2,b3,b4: std_logic_vector(2*n+2 downto 0);
signal b5,b6: std_logic_vector(2*n+3 downto 0);
signal e_signal1,e_signal2,e_signal3: std_logic;
signal itter_out1,itter_out2,itter_out3: std_logic_vector(k-1 downto 0);
signal b10,b11,b12,b13,b14,b15,b16,b17: std_logic_vector(2*n+1 downto 0);
--signal itter_register: std_logic_vector(k-1 downto 0):=(others=>'0');
begin

process(clk)
begin
if(rising_edge(clk))then
    if(e='1')then
    b10<=std_logic_vector(to_unsigned(to_integer(unsigned(a(2*n-1 downto 0)))+to_integer(unsigned(a(4*n-1 downto 2*n)))+to_integer(unsigned(a(6*n-1 downto 4*n)))+to_integer(unsigned(a(8*n-1 downto 6*n))),2*n+2));
    b11<=std_logic_vector(to_unsigned(to_integer(unsigned(a(10*n-1 downto 8*n)))+to_integer(unsigned(a(12*n-1 downto 10*n)))+to_integer(unsigned(a(14*n-1 downto 12*n)))+to_integer(unsigned(a(16*n-1 downto 14*n))),2*n+2));
    b12<=std_logic_vector(to_unsigned(to_integer(unsigned(a(18*n-1 downto 16*n)))+to_integer(unsigned(a(20*n-1 downto 18*n)))+to_integer(unsigned(a(22*n-1 downto 20*n)))+to_integer(unsigned(a(24*n-1 downto 22*n))),2*n+2));
    b13<=std_logic_vector(to_unsigned(to_integer(unsigned(a(26*n-1 downto 24*n)))+to_integer(unsigned(a(28*n-1 downto 26*n)))+to_integer(unsigned(a(30*n-1 downto 28*n)))+to_integer(unsigned(a(32*n-1 downto 30*n))),2*n+2));
    b14<=std_logic_vector(to_unsigned(to_integer(unsigned(a(34*n-1 downto 32*n)))+to_integer(unsigned(a(36*n-1 downto 34*n)))+to_integer(unsigned(a(38*n-1 downto 36*n)))+to_integer(unsigned(a(40*n-1 downto 38*n))),2*n+2));
    b15<=std_logic_vector(to_unsigned(to_integer(unsigned(a(42*n-1 downto 40*n)))+to_integer(unsigned(a(44*n-1 downto 42*n)))+to_integer(unsigned(a(46*n-1 downto 44*n)))+to_integer(unsigned(a(48*n-1 downto 46*n))),2*n+2));
    b16<=std_logic_vector(to_unsigned(to_integer(unsigned(a(50*n-1 downto 48*n)))+to_integer(unsigned(a(52*n-1 downto 50*n)))+to_integer(unsigned(a(54*n-1 downto 52*n)))+to_integer(unsigned(a(56*n-1 downto 54*n))),2*n+2));
    b17<=std_logic_vector(to_unsigned(to_integer(unsigned(a(58*n-1 downto 56*n)))+to_integer(unsigned(a(60*n-1 downto 58*n)))+to_integer(unsigned(a(62*n-1 downto 60*n)))+to_integer(unsigned(a(64*n-1 downto 62*n))),2*n+2));
    itter_out1<=itter;
    e_signal1<='1';
    f_signal1<=f;
    end if;
end if;
end process;

process(clk)
begin
if(rising_edge(clk))then
    if(e='1')then
        b1<=std_logic_vector(to_unsigned(to_integer(unsigned(b10))+to_integer(unsigned(b11)),2*n+3));
        b2<=std_logic_vector(to_unsigned(to_integer(unsigned(b12))+to_integer(unsigned(b13)),2*n+3));
        b3<=std_logic_vector(to_unsigned(to_integer(unsigned(b14))+to_integer(unsigned(b15)),2*n+3));
        b4<=std_logic_vector(to_unsigned(to_integer(unsigned(b16))+to_integer(unsigned(b17)),2*n+3));
        itter_out2<=itter_out1;
        e_signal2<=e_signal1;
        f_signal2<=f_signal1;
     end if;
end if;
end process;
process(clk)
begin
	if(rising_edge(clk))then
	if(e='1')then
	b5<=std_logic_vector(to_unsigned(to_integer(unsigned(b1))+ to_integer(unsigned(b2)),2*n+4));

	b6<=std_logic_vector(to_unsigned(to_integer(unsigned(b3))+ to_integer(unsigned(b4)),2*n+4));
	itter_out3<=itter_out2;
	e_signal3<=e_signal2;
	f_signal3<=f_signal2;
	end if;
	end if;
end process;
process(clk)
begin
    if(rising_edge(clk))then
        if(e='1')then
        
            b<=std_logic_vector(to_unsigned(to_integer(unsigned(b5))+to_integer(unsigned(b6)),2*n+5));
            e_out_s<=e_signal3;
            itter_out<=itter_out3;
	    f_out<=f_signal3;
            --itter_out<=itter_register;
         end if;
    end if;
end process;
e_out<=e_out_s;
end behav;
