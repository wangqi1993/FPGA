----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:26:51 02/23/2017 
-- Design Name: 
-- Module Name:    DAC_out - Behavioral 
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

entity DAC_OUT is
port(
data  :in std_logic_vector(31 downto 0);
clk   :in std_logic;
clr   :in std_logic;

cs    :out std_logic;
din     :out std_logic;
sclk    :out std_logic);
end DAC_OUT ;
architecture behave of DAC_OUT is
signal ss:std_logic_vector(31 downto 0);
signal s:std_logic_vector(6 downto 0);

begin
process(clr,clk)
begin
if clr='0' then
	s<="0000000";
	cs<='1';
	sclk<='0'; 
	din<='0'; 
elsif rising_edge(clk) then
	if s<"1000010" then
		s<=s+1;
	else 
		s<="1000010";
	end if;
	case s is
	  when "0000001" =>ss<=data; cs<='1';sclk<='0'; 
	  when "0000010" =>din<=ss(31); cs<='0';sclk<='0'; 
	  when "0000011" =>din<=ss(31); cs<='0';sclk<='1'; 
	  when "0000100" =>din<=ss(30); cs<='0';sclk<='0'; 
	  when "0000101" =>din<=ss(30); cs<='0';sclk<='1'; 
	  when "0000110" =>din<=ss(29); cs<='0';sclk<='0'; 
	  when "0000111" =>din<=ss(29); cs<='0';sclk<='1'; 
	  when "0001000" =>din<=ss(28); cs<='0';sclk<='0'; 
	  when "0001001" =>din<=ss(28); cs<='0';sclk<='1'; 
	  when "0001010" =>din<=ss(27); cs<='0';sclk<='0'; 
	  when "0001011" =>din<=ss(27); cs<='0';sclk<='1';
	  when "0001100" =>din<=ss(26); cs<='0';sclk<='0'; 
	  when "0001101" =>din<=ss(26); cs<='0';sclk<='1'; 
	  when "0001110" =>din<=ss(25); cs<='0';sclk<='0'; 
	  when "0001111" =>din<=ss(25); cs<='0';sclk<='1';
	  when "0010000" =>din<=ss(24); cs<='0';sclk<='0'; 
	  when "0010001" =>din<=ss(24); cs<='0';sclk<='1'; 
	  when "0010010" =>din<=ss(23); cs<='0';sclk<='0'; 
	  when "0010011" =>din<=ss(23); cs<='0';sclk<='1'; 
	  when "0010100" =>din<=ss(22); cs<='0';sclk<='0'; 
	  when "0010101" =>din<=ss(22); cs<='0';sclk<='1'; 
	  when "0010110" =>din<=ss(21); cs<='0';sclk<='0'; 
	  when "0010111" =>din<=ss(21); cs<='0';sclk<='1'; 
	  when "0011000" =>din<=ss(20); cs<='0';sclk<='0'; 
	  when "0011001" =>din<=ss(20); cs<='0';sclk<='1'; 
	  when "0011010" =>din<=ss(19); cs<='0';sclk<='0'; 
	  when "0011011" =>din<=ss(19); cs<='0';sclk<='1'; 
	  when "0011100" =>din<=ss(18); cs<='0';sclk<='0'; 
	  when "0011101" =>din<=ss(18); cs<='0';sclk<='1'; 
	  when "0011110" =>din<=ss(17); cs<='0';sclk<='0'; 
	  when "0011111" =>din<=ss(17); cs<='0';sclk<='1'; 
	  when "0100000" =>din<=ss(16); cs<='0';sclk<='0'; 
	  when "0100001" =>din<=ss(16); cs<='0';sclk<='1'; 
	  when "0100010" =>din<=ss(15); cs<='0';sclk<='0'; 
	  when "0100011" =>din<=ss(15); cs<='0';sclk<='1'; 
	  when "0100100" =>din<=ss(14); cs<='0';sclk<='0'; 
	  when "0100101" =>din<=ss(14); cs<='0';sclk<='1'; 
	  when "0100110" =>din<=ss(13); cs<='0';sclk<='0'; 
	  when "0100111" =>din<=ss(13); cs<='0';sclk<='1'; 
	  when "0101000" =>din<=ss(12); cs<='0';sclk<='0'; 
	  when "0101001" =>din<=ss(12); cs<='0';sclk<='1'; 
	  when "0101010" =>din<=ss(11); cs<='0';sclk<='0'; 
	  when "0101011" =>din<=ss(11); cs<='0';sclk<='1';
	  when "0101100" =>din<=ss(10); cs<='0';sclk<='0'; 
	  when "0101101" =>din<=ss(10); cs<='0';sclk<='1'; 
	  when "0101110" =>din<=ss(9); cs<='0';sclk<='0'; 
	  when "0101111" =>din<=ss(9); cs<='0';sclk<='1';
	  when "0110000" =>din<=ss(8); cs<='0';sclk<='0'; 
	  when "0110001" =>din<=ss(8); cs<='0';sclk<='1'; 
	  when "0110010" =>din<=ss(7); cs<='0';sclk<='0'; 
	  when "0110011" =>din<=ss(7); cs<='0';sclk<='1'; 
	  when "0110100" =>din<=ss(6); cs<='0';sclk<='0'; 
	  when "0110101" =>din<=ss(6); cs<='0';sclk<='1'; 
	  when "0110110" =>din<=ss(5); cs<='0';sclk<='0'; 
	  when "0110111" =>din<=ss(5); cs<='0';sclk<='1'; 
	  when "0111000" =>din<=ss(4); cs<='0';sclk<='0'; 
	  when "0111001" =>din<=ss(4); cs<='0';sclk<='1'; 
	  when "0111010" =>din<=ss(3); cs<='0';sclk<='0'; 
	  when "0111011" =>din<=ss(3); cs<='0';sclk<='1'; 
	  when "0111100" =>din<=ss(2); cs<='0';sclk<='0'; 
	  when "0111101" =>din<=ss(2); cs<='0';sclk<='1'; 
	  when "0111110" =>din<=ss(1); cs<='0';sclk<='0'; 
	  when "0111111" =>din<=ss(1); cs<='0';sclk<='1'; 
	  when "1000000" =>din<=ss(0); cs<='0';sclk<='0'; 
	  when "1000001" =>din<=ss(0); cs<='0';sclk<='1'; 
	  when others  =>din<='0';cs<='1';sclk<='0';  --cs<='1'
	  end case;
end if;
end process;
end behave;

