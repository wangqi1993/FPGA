----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:47 02/13/2017 
-- Design Name: 
-- Module Name:    s2p - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity s2p is
port(
load ,clk:in std_logic;
data  :in std_logic_vector(23 downto 0);
sdata    :out std_logic;
sldn     :out std_logic;
sclk    :out std_logic);
end s2p ;
architecture behave of s2p is
signal ss:std_logic_vector(23 downto 0);
signal s:std_logic_vector(5 downto 0);

begin
process(load,clk)
--variable i:integer;
begin
if load='0' then
	ss<=data;
	s<="000000";
	sldn<='1'; 
		
	
elsif rising_edge(clk) then
	if s<"110010" then
		--i:=i+1;
		s<=s+1;
	else 
		s<="110010";
	end if;
	case s is
	  when "000000" =>sldn<='0';sclk<='0'; 
	  when "000001" =>sdata<=ss(23); sldn<='0';sclk<='0';
	  when "000010" =>sdata<=ss(23); sldn<='0';sclk<='1';
	  when "000011" =>sdata<=ss(22); sldn<='0';sclk<='0'; 
	  when "000100" =>sdata<=ss(22); sldn<='0';sclk<='1'; 
	  when "000101" =>sdata<=ss(21); sldn<='0';sclk<='0'; 
	  when "000110" =>sdata<=ss(21); sldn<='0';sclk<='1'; 
	  when "000111" =>sdata<=ss(20); sldn<='0';sclk<='0'; 
	  when "001000" =>sdata<=ss(20); sldn<='0';sclk<='1'; 
	  when "001001" =>sdata<=ss(19); sldn<='0';sclk<='0'; 
	  when "001010" =>sdata<=ss(19); sldn<='0';sclk<='1';
	  when "001011" =>sdata<=ss(18); sldn<='0';sclk<='0'; 
	  when "001100" =>sdata<=ss(18); sldn<='0';sclk<='1'; 
	  when "001101" =>sdata<=ss(17); sldn<='0';sclk<='0'; 
	  when "001110" =>sdata<=ss(17); sldn<='0';sclk<='1';
	  when "001111" =>sdata<=ss(16); sldn<='0';sclk<='0'; 
	  when "010000" =>sdata<=ss(16); sldn<='0';sclk<='1'; 
	  when "010001" =>sdata<=ss(15); sldn<='0';sclk<='0'; 
	  when "010010" =>sdata<=ss(15); sldn<='0';sclk<='1';
	  when "010011" =>sdata<=ss(14); sldn<='0';sclk<='0'; 
	  when "010100" =>sdata<=ss(14); sldn<='0';sclk<='1'; 
	  when "010101" =>sdata<=ss(13); sldn<='0';sclk<='0'; 
	  when "010110" =>sdata<=ss(13); sldn<='0';sclk<='1';
	  when "010111" =>sdata<=ss(12); sldn<='0';sclk<='0'; 
	  when "011000" =>sdata<=ss(12); sldn<='0';sclk<='1'; 
	  when "011001" =>sdata<=ss(11); sldn<='0';sclk<='0'; 
	  when "011010" =>sdata<=ss(11); sldn<='0';sclk<='1';
	  when "011011" =>sdata<=ss(10); sldn<='0';sclk<='0'; 
	  when "011100" =>sdata<=ss(10); sldn<='0';sclk<='1';
	  when "011101" =>sdata<=ss(9); sldn<='0';sclk<='0'; 
	  when "011110" =>sdata<=ss(9); sldn<='0';sclk<='1'; 
	  when "011111" =>sdata<=ss(8); sldn<='0';sclk<='0'; 
	  when "100000" =>sdata<=ss(8); sldn<='0';sclk<='1';
	  when "100001" =>sdata<=ss(7); sldn<='0';sclk<='0'; 
	  when "100010" =>sdata<=ss(7); sldn<='0';sclk<='1';
	  when "100011" =>sdata<=ss(6); sldn<='0';sclk<='0'; 
	  when "100100" =>sdata<=ss(6); sldn<='0';sclk<='1'; 
	  when "100101" =>sdata<=ss(5); sldn<='0';sclk<='0'; 
	  when "100110" =>sdata<=ss(5); sldn<='0';sclk<='1';
	  when "100111" =>sdata<=ss(4); sldn<='0';sclk<='0'; 
	  when "101000" =>sdata<=ss(4); sldn<='0';sclk<='1';
	  when "101001" =>sdata<=ss(3); sldn<='0';sclk<='0'; 
	  when "101010" =>sdata<=ss(3); sldn<='0';sclk<='1'; 
	  when "101011" =>sdata<=ss(2); sldn<='0';sclk<='0';   
	  when "101100" =>sdata<=ss(2); sldn<='0';sclk<='1'; 
	  when "101101" =>sdata<=ss(1); sldn<='0';sclk<='0'; 
	  when "101110" =>sdata<=ss(1); sldn<='0';sclk<='1'; 
	  when "101111" =>sdata<=ss(0); sldn<='0';sclk<='0'; 
	  when "110000" =>sdata<=ss(0); sldn<='0';sclk<='1'; 
	  when "110001" =>sldn<='1';sclk<='0'; 
	  
	  when others  =>sldn<='1';sclk<='0';
	  end case;
end if;
end process;

	end behave;

