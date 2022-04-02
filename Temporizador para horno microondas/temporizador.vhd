library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity temporizador is
	port(
		ent_p 							: in std_logic_vector(6 downto 0);
		en_cnt,carga_seg,carga_min,clk,reset_n : in std_logic;
		co,fin									: out std_logic;
		d_a,d_b,d_c,d_d				: out std_logic_vector(6 downto 0)
	);
end temporizador;

architecture structural of temporizador is
	signal co_int 				: std_logic_vector(4 downto 0);
	signal cnt_seg,cnt_min 	: std_logic_vector(6 downto 0);
	
	component ContadorMod50M 
	  port (
	  clk, reset_n, en_cnt  : in  std_logic;
	  co 	               : out std_logic
	  );
	end component;
	component ContadorDescMod10
	  port (
	  clk, reset_n, en, carga  : in  std_logic;
	  e_p                      : in std_logic_vector(3 downto 0);
	  co                       : out std_logic;
     s								: out std_logic_vector(3 downto 0)
	  );
	end component;
	component ContadorDesMod6 
	  port (
	  clk, reset_n, en, carga  : in  std_logic;
	  e_p                      : in std_logic_vector(2 downto 0);
	  co                       : out std_logic;
     s								: out std_logic_vector(3 downto 0)
	  );
	end component;
	component BinA7Seg 
	  port (
		 input   : in std_logic_vector(3 downto 0);
		 output    : out std_logic_vector(6 downto 0)
	  );
	end component;
begin
	i_1:contador50m 
		port map(
			clk => clk,
			reset_n => reset_n,
			en => en_cnt,
			co => co_int(4)
		);
	i_2:contador10mod 
		port map(
			clk => clk,
			reset_n => reset_n,
			en => co_int(4),
			co => co_int(3),
			e_p => ent_p(3 downto 0),
			carga => carga_seg,
			s => cnt_seg(3 downto 0)
		);
	i_3:contador10mod 
		port map(
			clk => clk,
			reset_n => reset_n,
			en => co_int(2),
			co => co_int(1),
			e_p => ent_p(3 downto 0),
			carga => carga_min,
			s => cnt_min(3 downto 0)
		);
	i_4:contador6mod 
		port map(
			clk => clk,
			reset_n => reset_n,
			en => co_int(3),
			co => co_int(2),
			e_p => ent_p(6 downto 4),
			carga => carga_seg,
			s => cnt_seg(6 downto 4)
		);
	i_5:contador6mod 
		port map(
			clk => clk,
			reset_n => reset_n,
			en => co_int(1),
			co => co_int(0),
			e_p => ent_p(6 downto 4),
			carga => carga_min,
			s => cnt_min(6 downto 4)
		);
	i_6:BinA7Seg
		port map(
			entrada => '0'&cnt_min(6 downto 4),
			salida  => d_d
		);
	i_7:BinA7Seg
		port map(
			entrada => cnt_min(3 downto 0),
			salida  => d_c
		);
	i_8:BinA7Seg
		port map(
			entrada => '0'&cnt_seg(6 downto 4),
			salida  => d_b
		);
	i_9:BinA7Seg
		port map(
			entrada => cnt_seg(3 downto 0),
			salida  => d_a
		);
	fin<='1' when cnt_min="0000000" and cnt_seg="0000000" else
	     '0';
end structural;
