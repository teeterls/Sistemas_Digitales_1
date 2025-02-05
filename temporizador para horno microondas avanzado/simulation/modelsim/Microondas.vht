-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/05/2018 16:11:13"
                                                            
-- Vhdl Test Bench template for design  :  Microondas
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Microondas_vhd_tst IS
END Microondas_vhd_tst;
ARCHITECTURE Microondas_arch OF Microondas_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL abierta : STD_LOGIC;
SIGNAL boton : STD_LOGIC;
SIGNAL clk : STD_LOGIC:='0';
SIGNAL d_a : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL d_b : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL d_c : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL d_d : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL e_p : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL fin : STD_LOGIC;
SIGNAL horno_on : STD_LOGIC;
SIGNAL puerta : STD_LOGIC;
SIGNAL reset_n : STD_LOGIC;
COMPONENT Microondas
	PORT (
	abierta : OUT STD_LOGIC;
	boton : IN STD_LOGIC;
	clk : IN STD_LOGIC;
	d_a : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	d_b : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	d_c : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	d_d : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	e_p : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
	fin : OUT STD_LOGIC;
	horno_on : OUT STD_LOGIC;
	puerta : IN STD_LOGIC;
	reset_n : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Microondas
	PORT MAP (
-- list connections between master ports and signals
	abierta => abierta,
	boton => boton,
	clk => clk,
	d_a => d_a,
	d_b => d_b,
	d_c => d_c,
	d_d => d_d,
	e_p => e_p,
	fin => fin,
	horno_on => horno_on,
	puerta => puerta,
	reset_n => reset_n
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;     
clk <= not clk after 10 ns;
                                      
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list 
		 reset_n <= '0';
 puerta <= '0';
 boton <= '1'; -- Activo a nivel bajo
 e_p <= "0000010";
 wait for 31 ns;
 reset_n <= '1';
 wait for 100 ns;
 boton <= '0';
 wait for 20 ns;
 boton <= '1';
 wait for 100 ns;
 e_p <= "0000011";
 boton <= '0';
 wait for 20 ns;
 boton <= '1';
 wait for 100 ns;
 assert horno_on = '1'
 report "Error, el horno no se enciende despues de la segunda pulsacion"
 severity failure;
 wait for 50000 ns;
 puerta <= '1'; -- Se abre la puerta
 wait for 100 ns;
 assert horno_on = '0'
 report "Error, el horno no se apaga al abrir la puerta"
 severity failure;
 puerta <= '0'; -- Se cierra la puerta
 wait for 100 ns;
 assert horno_on = '1'
 report "Error, el horno no se enciende al cerrar la puerta"
 severity failure;
 wait for 73000 ns;
 wait for 100 ns;
 assert horno_on = '0'
 report "Error, el horno no se apaga al finalizar el tiempo"
 severity failure;
 assert fin = '1'
 report "Error, la señal de fin no se enciende al finalizar el tiempo"
 severity failure;

 assert false report "Fin de la simulacion." severity failure;		
                                                        
END PROCESS always;                                          
END Microondas_arch;
