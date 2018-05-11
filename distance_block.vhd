library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity distance_block is
generic(k: integer:=8;
	n: integer :=16);
port(a,b: in std_logic_vector(32*n-1 downto 0);
     clk,l_p: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     f : in std_logic;
     f_out: out std_logic;
     itter_best: out std_logic_vector(k-1 downto 0));
     --d: out std_logic_vector(2*n+4 downto 0));
end entity;

architecture behav of distance_block is

component compute_distances is
generic(k: integer:=8;
        n : integer:=16); -- represent the float size which can change if you do a good quantification.
port(e: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     a,b: in std_logic_vector(n-1 downto 0);
	clk,f: in std_logic;
	c : out std_logic_vector(2*n-1 downto 0);
	e_out,f_out: out std_logic;
	itter_out: out std_logic_vector(k-1 downto 0));
end component;

component sommateur is
generic(k: integer:=8;
        n: integer:=16);
port(e,clk,f: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     a : in std_logic_vector(32*2*n-1 downto 0);
     b : out std_logic_vector(2*n+4 downto 0);
     e_out,f_out: out std_logic;
     itter_out: out std_logic_vector(k-1 downto 0));
end component;

component comparaison is
generic(k : integer:=8;
        n: integer:=16);
port(c: in std_logic_vector(2*n+4 downto 0);
     itter: in std_logic_vector(k-1 downto 0);
     e,clk,f: in std_logic;
     f_out: out std_logic;
     itter_best: out std_logic_vector(k-1 downto 0));
end component;


signal d_out: std_logic_vector(32*2*n-1 downto 0);
signal distance_register: std_logic_vector(2*n+4 downto 0):=(others=>'1');
signal c : std_logic_vector(2*n+4 downto 0);
signal enable1 : std_logic_vector(31 downto 0);
signal enable2: std_logic;
type itter_t is array(0 to 31) of std_logic_vector(k-1 downto 0); 
signal itter1: itter_t;
signal itter2: std_logic_vector(k-1 downto 0);
signal f_out1: std_logic_vector(31 downto 0);
signal f_out2: std_logic;
begin
g:for i in 0 to 31 generate
u: compute_distances port map(l_p,itter,a((i+1)*n-1 downto i*n ),b((i+1)*n-1 downto i*n),clk,f,d_out((i+1)*n*2-1 downto i*n*2),enable1(i),f_out1(i),itter1(i));
end generate g;
u1: sommateur port map(enable1(0),clk,f_out1(0),itter1(0),d_out,c,enable2,f_out2,itter2);
u2: comparaison port map(c,itter2,enable2,clk,f_out2,f_out,itter_best);

end behav;

