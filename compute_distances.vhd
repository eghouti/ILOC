library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compute_distances is
generic(k: integer :=8;
        n : integer :=16); -- represent the float size which can change if you do a good quantification.
port(e: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     a,b: in std_logic_vector(n-1 downto 0);
	clk,f: in std_logic;
	c : out std_logic_vector(2*n-1 downto 0);
	e_out,f_out: out std_logic;
	itter_out: out std_logic_vector(k-1 downto 0));
end entity;

architecture behav of compute_distances is

component registre_soustraction is
generic(n: integer :=16);
port(clk,f: in std_logic;
     d: in std_logic_vector(n-1 downto 0);
     f_out: out std_logic;
     q: out std_logic_vector(n-1 downto 0));
end component;

component soustracteur is
generic(n: integer :=16);
port(a,b: in std_logic_vector(n-1 downto 0);
     c: out std_logic_vector(n-1 downto 0));
end component;


component registre_multiplier is
generic(n: integer :=16);
port(clk,f: in std_logic;
     d: in std_logic_vector(2*n-1 downto 0);
     f_out: out std_logic;
     q: out std_logic_vector(2*n-1 downto 0));
end component;

component multiplier is
generic(n: integer :=16);
port(a,b: in std_logic_vector(n-1 downto 0);
     c: out std_logic_vector(2*n-1 downto 0));
end component;
signal s_out,r_out: std_logic_vector(n-1 downto 0);
signal m_out: std_logic_vector(2*n-1 downto 0);
signal e_out_s: std_logic:='0';
signal f_out1: std_logic;
--signal itter_register: std_logic_vector(k-1 downto 0):=(others=>'0');
begin
u0: soustracteur port map(a,b,s_out);

u1: registre_soustraction port map(clk,f,s_out,f_out1,r_out);

u2: multiplier port map(r_out,r_out,m_out);

u3: registre_multiplier port map(clk,f_out1,m_out,f_out,c);

process(clk)
begin
    if(rising_edge(clk))then
        if(e='1')then
            e_out_s<='1';
            itter_out<=itter;
	        --f_out<=f;
            --itter_out<=itter_register;
        end if;
    end if;
end process;
e_out<=e_out_s;
end behav;
