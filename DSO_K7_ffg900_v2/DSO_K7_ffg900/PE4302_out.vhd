----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:36:10 02/24/2017 
-- Design Name: 
-- Module Name:    PE4302_out - Behavioral 
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

entity PE4302_out is
port(
data_p  :in std_logic_vector(5 downto 0);
clk   :in std_logic;
clr   :in std_logic;
sel   :in std_logic;

le1       :out std_logic;
le2       :out std_logic;
data     :out std_logic;
sclk     :out std_logic);
end PE4302_out ;

architecture behave of PE4302_out is
signal ss:std_logic_vector(5 downto 0);
signal s:std_logic_vector(6 downto 0);
begin
process(clr,clk)
begin
if clr='0' then
	s<="0000000";
	le1<='0';
	le2<='0';
	sclk<='0'; 
	data<='0'; 
elsif rising_edge(clk) then
	if s<"0001111" then
		s<=s+1;
	else 
		s<="0001111";
	end if;
	
	if(sel='0') then
	case s is
	  when "0000001" =>ss<=data_p;  le1<='0';sclk<='0'; 
	  when "0000010" =>data<=ss(5); le1<='0';sclk<='0'; 
	  when "0000011" =>data<=ss(5); le1<='0';sclk<='1'; 
	  when "0000100" =>data<=ss(4); le1<='0';sclk<='0'; 
	  when "0000101" =>data<=ss(4); le1<='0';sclk<='1'; 
	  when "0000110" =>data<=ss(3); le1<='0';sclk<='0'; 
	  when "0000111" =>data<=ss(3); le1<='0';sclk<='1'; 
	  when "0001000" =>data<=ss(2); le1<='0';sclk<='0'; 
	  when "0001001" =>data<=ss(2); le1<='0';sclk<='1'; 
	  when "0001010" =>data<=ss(1); le1<='0';sclk<='0'; 
	  when "0001011" =>data<=ss(1); le1<='0';sclk<='1';
	  when "0001100" =>data<=ss(0); le1<='0';sclk<='0'; 
	  when "0001101" =>data<=ss(0); le1<='0';sclk<='1'; 
	  when "0001110" =>data<='0';   le1<='1';sclk<='0'; 	  
	  when others    =>data<='0';   le1<='0';sclk<='0'; 
	  end case;
   else
	case s is
	  when "0000001" =>ss<=data_p;  le2<='0';sclk<='0'; 
	  when "0000010" =>data<=ss(5); le2<='0';sclk<='0'; 
	  when "0000011" =>data<=ss(5); le2<='0';sclk<='1'; 
	  when "0000100" =>data<=ss(4); le2<='0';sclk<='0'; 
	  when "0000101" =>data<=ss(4); le2<='0';sclk<='1'; 
	  when "0000110" =>data<=ss(3); le2<='0';sclk<='0'; 
	  when "0000111" =>data<=ss(3); le2<='0';sclk<='1'; 
	  when "0001000" =>data<=ss(2); le2<='0';sclk<='0'; 
	  when "0001001" =>data<=ss(2); le2<='0';sclk<='1'; 
	  when "0001010" =>data<=ss(1); le2<='0';sclk<='0'; 
	  when "0001011" =>data<=ss(1); le2<='0';sclk<='1';
	  when "0001100" =>data<=ss(0); le2<='0';sclk<='0'; 
	  when "0001101" =>data<=ss(0); le2<='0';sclk<='1'; 
	  when "0001110" =>data<='0';   le2<='1';sclk<='0'; 	  
	  when others    =>data<='0';   le2<='0';sclk<='0'; 
	  end case;	  
	 end if; 
	  
	  end if;
end process;
end behave;


