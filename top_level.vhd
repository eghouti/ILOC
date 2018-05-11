library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
generic(k: integer:=8;
	n: integer:=16);
port(l_p,clk,reset: in std_logic;--l_p=0 => learning process. 
     input_vector: in std_logic_vector(2048*n-1 downto 0);
     input_cls: in std_logic_vector(9 downto 0);
     new_data: in std_logic;
     class: out std_logic_vector(9 downto 0));
end entity;

architecture behav of top_level is

component registre_entrer is
generic(n : integer :=16); 
port(clk: in std_logic;
     d: in std_logic_vector(2048*n-1 downto 0);
     q: out std_logic_vector(2048*n-1 downto 0));
end component;

component compteur is
generic(K: integer:=8);
port(e,clk,reset: in std_logic;
     q:out std_logic_vector(K-1 downto 0));
end component;

component memory is
generic(K : integer:=8; -- the depth of the memory
	n : integer:=16); -- n bits for quantification 
port( e,clk: in std_logic;
          d: in std_logic_vector(32*n-1 downto 0);
          adress: in std_logic_vector(K-1 downto 0);
          out_compteur_memory: out std_logic_vector(K-1 downto 0);
          q: out std_logic_vector(32*n-1 downto 0));
end component;

component compteur_processing is
generic(K: integer:=8);
port(e,clk,reset: in std_logic; --e='1'=> processing
     d: in std_logic_vector(K-1 downto 0);
     f: out std_logic;--f='1'=> the loop is over
     --new_data: in std_logic;--new_data='1'=> new processing data
     q: out std_logic_vector(k-1 downto 0));
     
end component;


component distance_block is
generic(k: integer:=8;
	n: integer :=16);
port(a,b: in std_logic_vector(32*n-1 downto 0);
     clk,l_p: in std_logic;
     itter: in std_logic_vector(k-1 downto 0);
     f : in std_logic;
     f_out: out std_logic;
     itter_best: out std_logic_vector(k-1 downto 0));
     --d: out std_logic_vector(2*n+4 downto 0));
end component;

component vote is
port(cls_ins: in std_logic_vector(639 downto 0);
     init,clk,e: in std_logic;
     valid_flag: out std_logic;
     cls: out std_logic_vector(9 downto 0));
end component;

component memory_cls is
generic(K : integer:=8; -- the depth of the memory
	n : integer:=16); -- n bits for quantification 
port( e,clk: in std_logic;
      d_cls: in std_logic_vector(9 downto 0);
      adress: in std_logic_vector(K-1 downto 0);
      q_cls: out std_logic_vector(9 downto 0));
end component;


--type s_input_type is array(0 to s-1) of std_logic_vector(n-1 downto 0);
--signal s_input: s_input_type;
type itter_type is array(0 to 63) of std_logic_vector(k-1 downto 0);
type output_vector_t is array(0 to 63) of std_logic_vector(32*n-1 downto 0);

signal output_vector: output_vector_t;
signal output_compteur,output_compteur_processing,adress,out_compteur_memory: std_logic_vector(K-1 downto 0); 
signal loop_over: std_logic;
signal f_out: std_logic_vector(63 downto 0);
signal itter_best_signal: itter_type;
signal cls_signal: std_logic_vector(639 downto 0);
signal valid_flag_s: std_logic;
type adress_t is array(0 to 63) of std_logic_vector(K-1 downto 0);
signal adress_cls: adress_t;
signal input_vector_s: std_logic_vector(2048*n-1 downto 0);
type vector_t is array(0 to 63) of std_logic_vector(9 downto 0);
signal vector_cls: vector_t;
signal new_data_s: std_logic;

begin

--u0: registre_entrer port map(clk,input_vector,output_vector);
u1: compteur port map(l_p,clk,reset,output_compteur);
u2: compteur_processing port map(l_p,clk,reset,output_compteur,loop_over,output_compteur_processing);
gener: for i in 0 to 63 generate
u: memory port map(l_p,clk,input_vector((i+1)*32*n-1 downto i*32*n),adress,out_compteur_memory,output_vector(i));
V: memory_cls port map(l_p,clk,input_cls,adress_cls(i),vector_cls(i));

W: distance_block port map(input_vector_s((i+1)*32*n-1 downto i*32*n),output_vector(i),clk,(l_p and not (new_data_s)),out_compteur_memory,loop_over,f_out(i),itter_best_signal(i));

adress_cls(i)<=output_compteur when l_p='0'else
	itter_best_signal(i) when l_p='1';
end generate gener;
adress<=output_compteur when l_p='0'else
	output_compteur_processing when l_p='1';


input_vector_s<=input_vector when new_data_s='1';

cls_signal<=vector_cls(0) & vector_cls(1) & vector_cls(2) & vector_cls(3) & vector_cls(4) & vector_cls(5) & vector_cls(6) & vector_cls(7) & vector_cls(8) & vector_cls(9) & vector_cls(10) & vector_cls(11) & vector_cls(12) & vector_cls(13) & vector_cls(14) & vector_cls(15) & vector_cls(16) & vector_cls(17) & vector_cls(18) & vector_cls(19) & vector_cls(20) & vector_cls(21) & vector_cls(22) & vector_cls(23) & vector_cls(24) & vector_cls(25) & vector_cls(26) & vector_cls(27) & vector_cls(28) & vector_cls(29) & vector_cls(30) & vector_cls(31) & vector_cls(32) & vector_cls(33) & vector_cls(34) & vector_cls(35) & vector_cls(36) & vector_cls(37) & vector_cls(38) & vector_cls(39) & vector_cls(40) & vector_cls(41) & vector_cls(42) & vector_cls(43) & vector_cls(44) & vector_cls(45) & vector_cls(46) & vector_cls(47) & vector_cls(48) & vector_cls(49) & vector_cls(50) & vector_cls(51) & vector_cls(52) & vector_cls(53) & vector_cls(54) & vector_cls(55) & vector_cls(56) & vector_cls(57) & vector_cls(58) & vector_cls(59) & vector_cls(60) & vector_cls(61) & vector_cls(62) & vector_cls(63);
u3: vote port map(cls_signal,reset,clk,f_out(0),valid_flag_s,class);
new_data_s <='1' when output_compteur_processing="00000000" else
            '0';
end behav;











