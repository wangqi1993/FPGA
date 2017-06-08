----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:57 02/20/2017 
-- Design Name: 
-- Module Name:    spi_interface - Behavioral 
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

entity SPI_Interface is
port(
data  :in std_logic_vector(31 downto 0);
clk   :in std_logic;
clr   :in std_logic;

cs    :out std_logic;
din     :out std_logic;
sclk    :out std_logic);
end SPI_Interface ;
architecture behave of SPI_Interface is
signal ss:std_logic_vector(31 downto 0);
signal s: integer range 0 to 70;

begin
process(clr,clk)
begin
if clr='0' then
	s<=0;
	cs<='1';
	sclk<='0'; 
	din<='0'; 
	ss<=data;
elsif rising_edge(clk) then
	if s<70 then
		s<=s+1;
	else 
		s<=70;
	end if;
	case s is
	  when 2 =>din<=ss(31); cs<='0';sclk<='0'; 
	  when 3 =>din<=ss(31); cs<='0';sclk<='1'; 
	  when 4 =>din<=ss(30); cs<='0';sclk<='0'; 
	  when 5 =>din<=ss(30); cs<='0';sclk<='1'; 
	  when 6 =>din<=ss(29); cs<='0';sclk<='0'; 
	  when 7 =>din<=ss(29); cs<='0';sclk<='1'; 
	  when 8 =>din<=ss(28); cs<='0';sclk<='0'; 
	  when 9 =>din<=ss(28); cs<='0';sclk<='1'; 
	  when 10 =>din<=ss(27); cs<='0';sclk<='0'; 
	  when 11 =>din<=ss(27); cs<='0';sclk<='1';
	  when 12 =>din<=ss(26); cs<='0';sclk<='0'; 
	  when 13 =>din<=ss(26); cs<='0';sclk<='1'; 
	  when 14 =>din<=ss(25); cs<='0';sclk<='0'; 
	  when 15 =>din<=ss(25); cs<='0';sclk<='1';
	  when 16 =>din<=ss(24); cs<='0';sclk<='0'; 
	  when 17 =>din<=ss(24); cs<='0';sclk<='1'; 
	  when 18 =>din<=ss(23); cs<='0';sclk<='0'; 
	  when 19 =>din<=ss(23); cs<='0';sclk<='1'; 
	  when 20 =>din<=ss(22); cs<='0';sclk<='0'; 
	  when 21 =>din<=ss(22); cs<='0';sclk<='1'; 
	  when 22 =>din<=ss(21); cs<='0';sclk<='0'; 
	  when 23 =>din<=ss(21); cs<='0';sclk<='1'; 
	  when 24 =>din<=ss(20); cs<='0';sclk<='0'; 
	  when 25 =>din<=ss(20); cs<='0';sclk<='1'; 
	  when 26 =>din<=ss(19); cs<='0';sclk<='0'; 
	  when 27 =>din<=ss(19); cs<='0';sclk<='1'; 
	  when 28 =>din<=ss(18); cs<='0';sclk<='0'; 
	  when 29 =>din<=ss(18); cs<='0';sclk<='1'; 
	  when 30 =>din<=ss(17); cs<='0';sclk<='0'; 
	  when 31 =>din<=ss(17); cs<='0';sclk<='1'; 
	  when 32 =>din<=ss(16); cs<='0';sclk<='0'; 
	  when 33 =>din<=ss(16); cs<='0';sclk<='1';
	  when 34 =>din<=ss(15); cs<='0';sclk<='0';
	  when 35 =>din<=ss(15); cs<='0';sclk<='1';
	  when 36 =>din<=ss(14); cs<='0';sclk<='0';
	  when 37 =>din<=ss(14); cs<='0';sclk<='1';
	  when 38 =>din<=ss(13); cs<='0';sclk<='0';
	  when 39 =>din<=ss(13); cs<='0';sclk<='1';
	  when 40 =>din<=ss(12); cs<='0';sclk<='0';
	  when 41 =>din<=ss(12); cs<='0';sclk<='1';
	  when 42 =>din<=ss(11); cs<='0';sclk<='0';
	  when 43 =>din<=ss(11); cs<='0';sclk<='1';
	  when 44 =>din<=ss(10); cs<='0';sclk<='0';
	  when 45 =>din<=ss(10); cs<='0';sclk<='1';
	  when 46 =>din<=ss(9); cs<='0';sclk<='0';
	  when 47 =>din<=ss(9); cs<='0';sclk<='1';
	  when 48 =>din<=ss(8); cs<='0';sclk<='0';
	  when 49 =>din<=ss(8); cs<='0';sclk<='1';
	  when 50 =>din<=ss(7); cs<='0';sclk<='0';
	  when 51 =>din<=ss(7); cs<='0';sclk<='1';
	  when 52 =>din<=ss(6); cs<='0';sclk<='0';
	  when 53 =>din<=ss(6); cs<='0';sclk<='1';
	  when 54 =>din<=ss(5); cs<='0';sclk<='0';
	  when 55 =>din<=ss(5); cs<='0';sclk<='1';
	  when 56 =>din<=ss(4); cs<='0';sclk<='0';
	  when 57 =>din<=ss(4); cs<='0';sclk<='1';
	  when 58 =>din<=ss(3); cs<='0';sclk<='0';
	  when 59 =>din<=ss(3); cs<='0';sclk<='1';
	  when 60 =>din<=ss(2); cs<='0';sclk<='0';
	  when 61 =>din<=ss(2); cs<='0';sclk<='1';
	  when 62 =>din<=ss(1); cs<='0';sclk<='0';
	  when 63 =>din<=ss(1); cs<='0';sclk<='1';

	  when 64 =>din<=ss(0); cs<='0';sclk<='0';
	  when 65 =>din<=ss(0); cs<='0';sclk<='1';
	  when 66 =>din<=ss(0); cs<='0';sclk<='0';
	  when 67 =>din<=ss(0); cs<='1';sclk<='0';
	  when others  =>din<='0';cs<='0';sclk<='0';
	  end case;
end if;
end process;
end behave;

