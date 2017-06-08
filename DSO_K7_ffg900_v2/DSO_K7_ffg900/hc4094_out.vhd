----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:46:58 02/23/2017 
-- Design Name: 
-- Module Name:    hc4094_out - Behavioral 
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

entity hc4094_out is
port(
data  :in std_logic_vector(7 downto 0);
clk   :in std_logic;
clr   :in std_logic;

ch_str    :out std_logic;
din     :out std_logic;
sclk    :out std_logic);
end hc4094_out ;
architecture behave of hc4094_out is
signal s:std_logic_vector(4 downto 0);
signal ss:std_logic_vector(7 downto 0);
begin
process(clr,clk)
--variable i:integer;
begin
if clr='0' then
	s<="00000";
	ch_str<='0';
	sclk<='0'; 
	din<='0'; 
		
	
elsif rising_edge(clk) then
	if s<"10011" then
		s<=s+1;
	else 
		s<="10011";
	end if;
	case s is
	  when "00001" =>ss<=data; ch_str<='0';sclk<='0'; 
	  when "00010" =>din<=ss(7); ch_str<='1';sclk<='0'; 
	  when "00011" =>din<=ss(7); ch_str<='1';sclk<='1'; 
	  when "00100" =>din<=ss(6); ch_str<='1';sclk<='0'; 
	  when "00101" =>din<=ss(6); ch_str<='1';sclk<='1'; 
	  when "00110" =>din<=ss(5); ch_str<='1';sclk<='0'; 
	  when "00111" =>din<=ss(5); ch_str<='1';sclk<='1'; 
	  when "01000" =>din<=ss(4); ch_str<='1';sclk<='0'; 
	  when "01001" =>din<=ss(4); ch_str<='1';sclk<='1'; 
	  when "01010" =>din<=ss(3); ch_str<='1';sclk<='0'; 
	  when "01011" =>din<=ss(3); ch_str<='1';sclk<='1';
	  when "01100" =>din<=ss(2); ch_str<='1';sclk<='0'; 
	  when "01101" =>din<=ss(2); ch_str<='1';sclk<='1'; 
	  when "01110" =>din<=ss(1); ch_str<='1';sclk<='0'; 
	  when "01111" =>din<=ss(1); ch_str<='1';sclk<='1';
	  when "10000" =>din<=ss(0); ch_str<='1';sclk<='0'; 
	  when "10001" =>din<=ss(0); ch_str<='1';sclk<='1'; 
	  when "10010" =>din<='Z'; ch_str<='0';sclk<='0'; 
	  when others  =>din<='Z';ch_str<='0';sclk<='Z';
	  end case;
end if;
end process;
end behave;

