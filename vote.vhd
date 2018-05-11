library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vote is
port(cls_ins: in std_logic_vector(639 downto 0);
     init,clk,e: in std_logic;
     valid_flag: out std_logic;
     cls: out std_logic_vector(9 downto 0));
end entity;

architecture behav of vote is
signal somme_result,somme_resultg: std_logic_vector(59 downto 0);

-- need to reshape-----

signal somme_result_1,somme_result_2,somme_result_1g,somme_result_2g: std_logic_vector(59 downto 0);

signal index: integer:=0;
type Etat is (Etat0,Etat1,Etat2);
Signal Etat_present: Etat := Etat0;
signal comparaison_retenu: std_logic_vector(5 downto 0);
signal comparaison_indice : std_logic_vector(3 downto 0);
--signal somme_result_g_1: std_logic_vector(59 downto 0);
signal f1,f2 : std_logic;
begin

g:for i in 0 to 9 generate

	somme_result_1g(6*(i+1)-1 downto 6*i)<=std_logic_vector(to_unsigned(to_integer(unsigned(cls_ins(0+i downto 0+i)))+ to_integer(unsigned(cls_ins(10+i downto 10+i))) + to_integer(unsigned(cls_ins(20+i downto 20+i)))+ to_integer(unsigned(cls_ins(30+i downto 30+i)))+to_integer(unsigned(cls_ins(40+i downto 40+i)))+ to_integer(unsigned(cls_ins(50+i downto 50+i))) + to_integer(unsigned(cls_ins(60+i downto 60+i)))+ to_integer(unsigned(cls_ins(70+i downto 70+i)))+to_integer(unsigned(cls_ins(80+i downto 80+i)))+ to_integer(unsigned(cls_ins(90+i downto 90+i))) + to_integer(unsigned(cls_ins(100+i downto 100+i)))+ to_integer(unsigned(cls_ins(110+i downto 110+i))) + to_integer(unsigned(cls_ins(120+i downto 120+i)))+ to_integer(unsigned(cls_ins(130+i downto 130+i)))+to_integer(unsigned(cls_ins(140+i downto 140+i)))+ to_integer(unsigned(cls_ins(150+i downto 150+i))) + to_integer(unsigned(cls_ins(160+i downto 160+i)))+ to_integer(unsigned(cls_ins(170+i downto 170+i)))+to_integer(unsigned(cls_ins(180+i downto 180+i)))+ to_integer(unsigned(cls_ins(190+i downto 190+i))) + to_integer(unsigned(cls_ins(200+i downto 200+i)))+ to_integer(unsigned(cls_ins(210+i downto 210+i))) + to_integer(unsigned(cls_ins(220+i downto 220+i)))+ to_integer(unsigned(cls_ins(230+i downto 230+i)))+to_integer(unsigned(cls_ins(240+i downto 240+i)))+ to_integer(unsigned(cls_ins(250+i downto 250+i))) + to_integer(unsigned(cls_ins(260+i downto 260+i)))+ to_integer(unsigned(cls_ins(270+i downto 270+i)))+to_integer(unsigned(cls_ins(280+i downto 280+i)))+ to_integer(unsigned(cls_ins(290+i downto 290+i))) + to_integer(unsigned(cls_ins(300+i downto 300+i)))+ to_integer(unsigned(cls_ins(310+i downto 310+i))),6));
    somme_result_2g(6*(i+1)-1 downto 6*i)<=std_logic_vector(to_unsigned(to_integer(unsigned(cls_ins(320+i downto 320+i)))+ to_integer(unsigned(cls_ins(330+i downto 330+i)))+to_integer(unsigned(cls_ins(340+i downto 340+i)))+ to_integer(unsigned(cls_ins(350+i downto 350+i))) + to_integer(unsigned(cls_ins(360+i downto 360+i)))+ to_integer(unsigned(cls_ins(370+i downto 370+i)))+to_integer(unsigned(cls_ins(380+i downto 380+i)))+ to_integer(unsigned(cls_ins(390+i downto 390+i))) + to_integer(unsigned(cls_ins(400+i downto 400+i)))+ to_integer(unsigned(cls_ins(410+i downto 410+i))) + to_integer(unsigned(cls_ins(420+i downto 420+i)))+ to_integer(unsigned(cls_ins(430+i downto 430+i)))+to_integer(unsigned(cls_ins(440+i downto 440+i)))+ to_integer(unsigned(cls_ins(450+i downto 450+i))) + to_integer(unsigned(cls_ins(460+i downto 460+i)))+ to_integer(unsigned(cls_ins(470+i downto 470+i)))+to_integer(unsigned(cls_ins(480+i downto 480+i)))+ to_integer(unsigned(cls_ins(490+i downto 490+i))) + to_integer(unsigned(cls_ins(500+i downto 500+i)))+ to_integer(unsigned(cls_ins(510+i downto 510+i))) + to_integer(unsigned(cls_ins(520+i downto 520+i)))+ to_integer(unsigned(cls_ins(530+i downto 530+i)))+to_integer(unsigned(cls_ins(540+i downto 540+i)))+ to_integer(unsigned(cls_ins(550+i downto 550+i))) + to_integer(unsigned(cls_ins(560+i downto 560+i)))+ to_integer(unsigned(cls_ins(570+i downto 570+i)))+to_integer(unsigned(cls_ins(580+i downto 580+i)))+ to_integer(unsigned(cls_ins(590+i downto 590+i))) + to_integer(unsigned(cls_ins(600+i downto 600+i)))+ to_integer(unsigned(cls_ins(610+i downto 610+i))) + to_integer(unsigned(cls_ins(620+i downto 620+i)))+ to_integer(unsigned(cls_ins(630+i downto 630+i))),6));
    somme_resultg(6*(i+1)-1 downto 6*i)<=std_logic_vector(to_unsigned(to_integer(unsigned(somme_result_1(6*(i+1)-1 downto 6*i)))+ to_integer(unsigned(somme_result_2(6*(i+1)-1 downto 6*i))),6));
end generate g;


    process(clk)
    begin
        if(rising_edge(clk))then
            somme_result<=somme_resultg;
            somme_result_1<=somme_result_1g;
            somme_result_2<=somme_result_2g;
            f1<=e;
            f2<=f1;
        end if;
    end process;
    
	process(init,clk)
	begin
		if(init='1')then
			Etat_present<=Etat0;
			index<=0;
			valid_flag<='0';
			comparaison_retenu<=(others=>'0');
		elsif(rising_edge(clk))then
			case Etat_present is
		when Etat0=>
		valid_flag<='0';
		index<=0;
		comparaison_retenu<=(others=>'0');
		if(f2='1')then 
			Etat_present<=Etat1;
		end if;	
		when Etat1=>
		if(index=9)then
				Etat_present<=Etat2;
				index<=0;
		else index<=index+1;
		end if; 
		if(to_integer(unsigned(somme_result(6*(index+1)-1 downto 6*index)))>to_integer(unsigned(comparaison_retenu(5 downto 0))))then
			comparaison_retenu(5 downto 0)<=somme_result(6*(index+1)-1 downto 6*index);
			comparaison_indice<=std_logic_vector(to_unsigned(index,4));
		end if;
		when others=>
			cls<=(others=>'0');
			cls(to_integer(unsigned(comparaison_indice)))<='1';
			valid_flag<='1';
			Etat_present<=Etat0;	
		end case;
		end if;
	end process;
end behav;