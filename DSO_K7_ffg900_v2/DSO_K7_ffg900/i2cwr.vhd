----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:43:47 03/13/2017 
-- Design Name: 
-- Module Name:    i2cwr - Behavioral 
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

entity i2cwr is
port(
start,clk,dir,sdain:in std_logic;
sda :out std_logic;
scl,sdadir,over :out std_logic;
data  :in std_logic_vector(7 downto 0);
addr  :in std_logic_vector(15 downto 0);
outdata    :out std_logic_vector(7 downto 0)
);
end i2cwr ;
architecture behave of i2cwr is
--signal ss:std_logic_vector(19 downto 0);
signal s:std_logic_vector(7 downto 0);
signal ss:std_logic_vector(7 downto 0);
signal datas:std_logic_vector(7 downto 0);
signal addrs:std_logic_vector(15 downto 0);
signal dirs: std_logic;
signal outdatas:std_logic_vector(7 downto 0);
signal ms5_Count:std_logic_vector(11 downto 0);
begin

process(start,clk)
begin 
   if start='0' then 
   ms5_Count<="000000000000";
   elsif rising_edge(clk)   
   then ms5_Count<=ms5_Count+1;
   end if;
      
end process;


process(start,clk)
--variable i:integer;
begin
if start='0' then
	--ss<=data;
	s<="00000000";
	ss<="00000000";
	sda<='1';
	scl<='1';
	outdata<="00000000";
	over<='0';
	datas<=data;
	addrs<=addr;
	dirs<=dir;	
	sdadir<='1';
elsif rising_edge(clk) then
   if dirs='1' then -- write 
	 if s<"10011110" then
		--i:=i+1;
		s<=s+1;
	 else 
	    s<="10011110";
	 end if;
	 case s is
	  	 
	  when "00000000" =>sda<='0';scl<='1';sdadir<='1';
	  when "00000001" =>sda<='0';scl<='1'; --start
	  when "00000010" =>sda<='0';scl<='0'; 
	  when "00000011" =>sda<='1';scl<='0';
	  when "00000100" =>sda<='1';scl<='1'; 
	  when "00000101" =>sda<='1';scl<='1';
	  when "00000110" =>sda<='1';scl<='0'; --1
	  when "00000111" =>sda<='0';scl<='0'; 
	  when "00001000" =>sda<='0';scl<='1'; 
	  when "00001001" =>sda<='0';scl<='1';
	  when "00001010" =>sda<='0';scl<='0'; --0
	  when "00001011" =>sda<='1';scl<='0'; 
	  when "00001100" =>sda<='1';scl<='1'; 
	  when "00001101" =>sda<='1';scl<='1';
	  when "00001110" =>sda<='1';scl<='0'; --1
	  when "00001111" =>sda<='0';scl<='0'; 
	  when "00010000" =>sda<='0';scl<='1'; 
	  when "00010001" =>sda<='0';scl<='1';
	  when "00010010" =>sda<='0';scl<='0'; --0
	  when "00010011" =>sda<='0';scl<='0';
	  when "00010100" =>sda<='0';scl<='1'; 
	  when "00010101" =>sda<='0';scl<='1';
	  when "00010110" =>sda<='0';scl<='0'; --0
	  when "00010111" =>sda<='0';scl<='0'; 
	  when "00011000" =>sda<='0';scl<='1';
	  when "00011001" =>sda<='0';scl<='1';
	  when "00011010" =>sda<='0';scl<='0'; --0
	  when "00011011" =>sda<='0';scl<='0'; 
	  when "00011100" =>sda<='0';scl<='1'; 
	  when "00011101" =>sda<='0';scl<='1';
	  when "00011110" =>sda<='0';scl<='0'; --0
	  when "00011111" =>sda<='0';scl<='0'; 
	  when "00100000" =>sda<='0';scl<='1'; 
	  when "00100001" =>sda<='0';scl<='1';
	  when "00100010" =>sda<='0';scl<='0'; --w
	  when "00100011" =>scl<='0';sdadir<='0';
	  when "00100100" =>scl<='1'; 
	  when "00100101" =>scl<='1'; 
	  when "00100110" =>scl<='0';                      --ack time
	  when "00100111" =>sda<=addrs(15);scl<='0';sdadir<='1'; 
	  when "00101000" =>sda<=addrs(15);scl<='1';
	  when "00101001" =>sda<=addrs(15);scl<='1'; 
	  when "00101010" =>sda<=addrs(15);scl<='0'; --addr15
	  when "00101011" =>sda<=addrs(14);scl<='0';
	  when "00101100" =>sda<=addrs(14);scl<='1'; 
	  when "00101101" =>sda<=addrs(14);scl<='1';
	  when "00101110" =>sda<=addrs(14);scl<='0';  --addr14
	  when "00101111" =>sda<=addrs(13);scl<='0'; 
	  when "00110000" =>sda<=addrs(13);scl<='1'; 
	  when "00110001" =>sda<=addrs(13);scl<='1';
	  when "00110010" =>sda<=addrs(13);scl<='0';  --addr13
	  when "00110011" =>sda<=addrs(12);scl<='0';
	  when "00110100" =>sda<=addrs(12);scl<='1';
	  when "00110101" =>sda<=addrs(12);scl<='1';
	  when "00110110" =>sda<=addrs(12);scl<='0';  --addr12
	  when "00110111" =>sda<=addrs(11);scl<='0'; 
	  when "00111000" =>sda<=addrs(11);scl<='1';
	  when "00111001" =>sda<=addrs(11);scl<='1'; 
	  when "00111010" =>sda<=addrs(11);scl<='0';  --addr11 
	  when "00111011" =>sda<=addrs(10);scl<='0'; 
	  when "00111100" =>sda<=addrs(10);scl<='1';
	  when "00111101" =>sda<=addrs(10);scl<='1';
	  when "00111110" =>sda<=addrs(10);scl<='0';  --addr10
	  when "00111111" =>sda<=addrs(9);scl<='0';
	  when "01000000" =>sda<=addrs(9);scl<='1';
	  when "01000001" =>sda<=addrs(9);scl<='1';
	  when "01000010" =>sda<=addrs(9);scl<='0';   --addr9
	  when "01000011" =>sda<=addrs(8);scl<='0';
	  when "01000100" =>sda<=addrs(8);scl<='1';
	  when "01000101" =>sda<=addrs(8);scl<='1';
	  when "01000110" =>sda<=addrs(8);scl<='0';   --addr8  
	  when "01000111" =>scl<='0';sdadir<='0';
	  when "01001000" =>scl<='1';
	  when "01001001" =>scl<='1';
	  when "01001010" =>scl<='0';                 --ack time
	  when "01001011" =>sda<=addrs(7);scl<='0';sdadir<='1';
	  when "01001100" =>sda<=addrs(7);scl<='1';
	  when "01001101" =>sda<=addrs(7);scl<='1';
	  when "01001110" =>sda<=addrs(7);scl<='0';   --addr7
	  when "01001111" =>sda<=addrs(6);scl<='0';
	  when "01010000" =>sda<=addrs(6);scl<='1';
	  when "01010001" =>sda<=addrs(6);scl<='1';
	  when "01010010" =>sda<=addrs(6);scl<='0';   --addr6
	  when "01010011" =>sda<=addrs(5);scl<='0';
	  when "01010100" =>sda<=addrs(5);scl<='1';
	  when "01010101" =>sda<=addrs(5);scl<='1';
	  when "01010110" =>sda<=addrs(5);scl<='0';    --addr5
	  when "01010111" =>sda<=addrs(4);scl<='0';
	  when "01011000" =>sda<=addrs(4);scl<='1';
	  when "01011001" =>sda<=addrs(4);scl<='1';
	  when "01011010" =>sda<=addrs(4);scl<='0';   --addr4
	  when "01011011" =>sda<=addrs(3);scl<='0';
	  when "01011100" =>sda<=addrs(3);scl<='1';
	  when "01011101" =>sda<=addrs(3);scl<='1';
	  when "01011110" =>sda<=addrs(3);scl<='0';   --addr3
	  when "01011111" =>sda<=addrs(2);scl<='0';
	  when "01100000" =>sda<=addrs(2);scl<='1';
	  when "01100001" =>sda<=addrs(2);scl<='1';
	  when "01100010" =>sda<=addrs(2);scl<='0';   --addr2
	  when "01100011" =>sda<=addrs(1);scl<='0';
	  when "01100100" =>sda<=addrs(1);scl<='1';
	  when "01100101" =>sda<=addrs(1);scl<='1';
	  when "01100110" =>sda<=addrs(1);scl<='0';  --addr1
	  when "01100111" =>sda<=addrs(0);scl<='0';
	  when "01101000" =>sda<=addrs(0);scl<='1';
	  when "01101001" =>sda<=addrs(0);scl<='1';
	  when "01101010" =>sda<=addrs(0);scl<='0';  --addr0
	  when "01101011" =>scl<='0';sdadir<='0';
	  when "01101100" =>scl<='1';
	  when "01101101" =>scl<='1';
	  when "01101110" =>scl<='0'; --ack time
	  when "01101111" =>sda<=datas(7);scl<='0';sdadir<='1';
	  when "01110000" =>sda<=datas(7);scl<='1';
	  when "01110001" =>sda<=datas(7);scl<='1';
	  when "01110010" =>sda<=datas(7);scl<='0';  --data7
	  when "01110011" =>sda<=datas(6);scl<='0';
	  when "01110100" =>sda<=datas(6);scl<='1';
	  when "01110101" =>sda<=datas(6);scl<='1';
	  when "01110110" =>sda<=datas(6);scl<='0'; --data6
	  when "01110111" =>sda<=datas(5);scl<='0';
	  when "01111000" =>sda<=datas(5);scl<='1';
	  when "01111001" =>sda<=datas(5);scl<='1';
	  when "01111010" =>sda<=datas(5);scl<='0';  --data5
	  when "01111011" =>sda<=datas(4);scl<='0';
	  when "01111100" =>sda<=datas(4);scl<='1';
	  when "01111101" =>sda<=datas(4);scl<='1';
	  when "01111110" =>sda<=datas(4);scl<='0';  --data4
	  when "01111111" =>sda<=datas(3);scl<='0';
	  when "10000000" =>sda<=datas(3);scl<='1';
	  when "10000001" =>sda<=datas(3);scl<='1';
	  when "10000010" =>sda<=datas(3);scl<='0';   --data3
	  when "10000011" =>sda<=datas(2);scl<='0';
	  when "10000100" =>sda<=datas(2);scl<='1';
	  when "10000101" =>sda<=datas(2);scl<='1';
	  when "10000110" =>sda<=datas(2);scl<='0';  --data2
	  when "10000111" =>sda<=datas(1);scl<='0';
	  when "10001000" =>sda<=datas(1);scl<='1';
	  when "10001001" =>sda<=datas(1);scl<='1';
	  when "10001010" =>sda<=datas(1);scl<='0';   --data1
	  when "10001011" =>sda<=datas(0);scl<='0';
	  when "10001100" =>sda<=datas(0);scl<='1';
	  when "10001101" =>sda<=datas(0);scl<='1';
	  when "10001110" =>sda<=datas(0);scl<='0';   --data0
	  when "10001111" =>scl<='0';sdadir<='0';
	  when "10010000" =>scl<='1';
	  when "10010001" =>scl<='1';
	  when "10010010" =>scl<='0'; --ack time
	  when "10010011" =>sda<='0';scl<='0';sdadir<='1';
	  when "10010100" =>sda<='0';scl<='1'; 
	  when "10010101" =>sda<='1';scl<='1'; --stop

      when "10011101" =>if ms5_Count(11)='1' 
                        then  over<='1';
	                    else  s<="10011101";
	                    end if;
      
	  when others => sda<='1';scl<='1';sdadir<='1';
	  end case;
     
   else -- read
      if ss<"11000110" then
		ss<=ss+1;
	 else 
	    ss<="11000110";
	 end if;
	 case ss is
	  when "00000000" =>sda<='0';scl<='1';sdadir<='1';
	  when "00000001" =>sda<='0';scl<='0'; --start
	  when "00000010" =>sda<='1';scl<='0';
	  when "00000011" =>sda<='1';scl<='1'; 
	  when "00000100" =>sda<='1';scl<='1'; 
	  when "00000101" =>sda<='1';scl<='0'; --1
	  when "00000110" =>sda<='0';scl<='0'; 
	  when "00000111" =>sda<='0';scl<='1';
	  when "00001000" =>sda<='0';scl<='1'; 
	  when "00001001" =>sda<='0';scl<='0'; --0
	  when "00001010" =>sda<='1';scl<='0'; 
	  when "00001011" =>sda<='1';scl<='1';
	  when "00001100" =>sda<='1';scl<='1'; 
	  when "00001101" =>sda<='1';scl<='0'; --1
	  when "00001110" =>sda<='0';scl<='0'; 
	  when "00001111" =>sda<='0';scl<='1'; 
	  when "00010000" =>sda<='0';scl<='1';
	  when "00010001" =>sda<='0';scl<='0'; --0
	  when "00010010" =>sda<='0';scl<='0';
	  when "00010011" =>sda<='0';scl<='1';
	  when "00010100" =>sda<='0';scl<='1'; 
	  when "00010101" =>sda<='0';scl<='0'; --0
	  when "00010110" =>sda<='0';scl<='0'; 
	  when "00010111" =>sda<='0';scl<='1';
	  when "00011000" =>sda<='0';scl<='1';
	  when "00011001" =>sda<='0';scl<='0'; --0
	  when "00011010" =>sda<='0';scl<='0'; 
	  when "00011011" =>sda<='0';scl<='1';
	  when "00011100" =>sda<='0';scl<='1'; 
	  when "00011101" =>sda<='0';scl<='0'; --0
	  when "00011110" =>sda<='0';scl<='0'; 
	  when "00011111" =>sda<='0';scl<='1';
	  when "00100000" =>sda<='0';scl<='1'; 
	  when "00100001" =>sda<='0';scl<='0'; --w
	  when "00100010" =>scl<='0';sdadir<='0';
	  when "00100011" =>scl<='1';
	  when "00100100" =>scl<='1'; 
	  when "00100101" =>scl<='0';          --ack time	 
	  when "00100110" =>sda<=addrs(15);scl<='0';sdadir<='1'; 
	  when "00100111" =>sda<=addrs(15);scl<='1';
	  when "00101000" =>sda<=addrs(15);scl<='1'; 
	  when "00101001" =>sda<=addrs(15);scl<='0'; --addr15
	  when "00101010" =>sda<=addrs(14);scl<='0';
	  when "00101011" =>sda<=addrs(14);scl<='1';
	  when "00101100" =>sda<=addrs(14);scl<='1'; 
	  when "00101101" =>sda<=addrs(14);scl<='0';  --addr14
	  when "00101110" =>sda<=addrs(13);scl<='0'; 
	  when "00101111" =>sda<=addrs(13);scl<='1';
	  when "00110000" =>sda<=addrs(13);scl<='1'; 
	  when "00110001" =>sda<=addrs(13);scl<='0';  --addr13
	  when "00110010" =>sda<=addrs(12);scl<='0';
	  when "00110011" =>sda<=addrs(12);scl<='1';
	  when "00110100" =>sda<=addrs(12);scl<='1';
	  when "00110101" =>sda<=addrs(12);scl<='0';  --addr12
	  when "00110110" =>sda<=addrs(11);scl<='0'; 
	  when "00110111" =>sda<=addrs(11);scl<='1';
	  when "00111000" =>sda<=addrs(11);scl<='1'; 
	  when "00111001" =>sda<=addrs(11);scl<='0';  --addr11 
	  when "00111010" =>sda<=addrs(10);scl<='0'; 
	  when "00111011" =>sda<=addrs(10);scl<='1';
	  when "00111100" =>sda<=addrs(10);scl<='1';
	  when "00111101" =>sda<=addrs(10);scl<='0';  --addr10
	  when "00111110" =>sda<=addrs(9);scl<='0';
	  when "00111111" =>sda<=addrs(9);scl<='1';
	  when "01000000" =>sda<=addrs(9);scl<='1';
	  when "01000001" =>sda<=addrs(9);scl<='0';   --addr9
	  when "01000010" =>sda<=addrs(8);scl<='0';
	  when "01000011" =>sda<=addrs(8);scl<='1';
	  when "01000100" =>sda<=addrs(8);scl<='1';
	  when "01000101" =>sda<=addrs(8);scl<='0';   --addr8
	  when "01000110" =>scl<='0';sdadir<='0';
	  when "01000111" =>scl<='1';
	  when "01001000" =>scl<='1';
	  when "01001001" =>scl<='0';   --ack time
	  when "01001010" =>sda<=addrs(7);scl<='0';sdadir<='1';
	  when "01001011" =>sda<=addrs(7);scl<='1';
	  when "01001100" =>sda<=addrs(7);scl<='1';
	  when "01001101" =>sda<=addrs(7);scl<='0';   --addr7
	  when "01001110" =>sda<=addrs(6);scl<='0';
	  when "01001111" =>sda<=addrs(6);scl<='1';
	  when "01010000" =>sda<=addrs(6);scl<='1';
	  when "01010001" =>sda<=addrs(6);scl<='0';   --addr6
	  when "01010010" =>sda<=addrs(5);scl<='0';
	  when "01010011" =>sda<=addrs(5);scl<='1';
	  when "01010100" =>sda<=addrs(5);scl<='1';
	  when "01010101" =>sda<=addrs(5);scl<='0';    --addr5
	  when "01010110" =>sda<=addrs(4);scl<='0';
	  when "01010111" =>sda<=addrs(4);scl<='1';
	  when "01011000" =>sda<=addrs(4);scl<='1';
	  when "01011001" =>sda<=addrs(4);scl<='0';   --addr4
	  when "01011010" =>sda<=addrs(3);scl<='0';
	  when "01011011" =>sda<=addrs(3);scl<='1';
	  when "01011100" =>sda<=addrs(3);scl<='1';
	  when "01011101" =>sda<=addrs(3);scl<='0';   --addr3
	  when "01011110" =>sda<=addrs(2);scl<='0';
	  when "01011111" =>sda<=addrs(2);scl<='1';
	  when "01100000" =>sda<=addrs(2);scl<='1';
	  when "01100001" =>sda<=addrs(2);scl<='0';   --addr2
	  when "01100010" =>sda<=addrs(1);scl<='0';
	  when "01100011" =>sda<=addrs(1);scl<='1';
	  when "01100100" =>sda<=addrs(1);scl<='1';
	  when "01100101" =>sda<=addrs(1);scl<='0';  --addr1
	  when "01100110" =>sda<=addrs(0);scl<='0';
	  when "01100111" =>sda<=addrs(0);scl<='1';
	  when "01101000" =>sda<=addrs(0);scl<='1';
	  when "01101001" =>sda<=addrs(0);scl<='0';  --addr0
	  when "01101010" =>scl<='0';sdadir<='0';
	  when "01101011" =>scl<='1';
	  when "01101100" =>scl<='1';
	  when "01101101" =>scl<='0'; --ack time
	  when "01101110" =>sda<='1';scl<='0';sdadir<='1';--?
	  when "01101111" =>sda<='1';scl<='1';
	  when "01110000" =>sda<='0';scl<='1';   --start
	  when "01110001" =>sda<='0';scl<='0';  
	  when "01110010" =>sda<='1';scl<='0';
	  when "01110011" =>sda<='1';scl<='1'; 
	  when "01110100" =>sda<='1';scl<='1';
	  when "01110101" =>sda<='1';scl<='0'; --1
	  when "01110110" =>sda<='0';scl<='0'; 
	  when "01110111" =>sda<='0';scl<='1';
	  when "01111000" =>sda<='0';scl<='1'; 
	  when "01111001" =>sda<='0';scl<='0'; --0
	  when "01111010" =>sda<='1';scl<='0'; 
	  when "01111011" =>sda<='1';scl<='1'; 
	  when "01111100" =>sda<='1';scl<='1';
	  when "01111101" =>sda<='1';scl<='0'; --1
	  when "01111110" =>sda<='0';scl<='0'; 
	  when "01111111" =>sda<='0';scl<='1';
	  when "10000000" =>sda<='0';scl<='1'; 
	  when "10000001" =>sda<='0';scl<='0'; --0
	  when "10000010" =>sda<='0';scl<='0';
	  when "10000011" =>sda<='0';scl<='1';
	  when "10000100" =>sda<='0';scl<='1';
	  when "10000101" =>sda<='0';scl<='0'; --0
	  when "10000110" =>sda<='0';scl<='0'; 
	  when "10000111" =>sda<='0';scl<='1';
	  when "10001000" =>sda<='0';scl<='1';
	  when "10001001" =>sda<='0';scl<='0'; --0
	  when "10001010" =>sda<='0';scl<='0'; 
	  when "10001011" =>sda<='0';scl<='1';
	  when "10001100" =>sda<='0';scl<='1'; 
	  when "10001101" =>sda<='0';scl<='0'; --0
	  when "10001110" =>sda<='1';scl<='0'; 
	  when "10001111" =>sda<='1';scl<='1';
	  when "10010000" =>sda<='1';scl<='1';
	  when "10010001" =>sda<='1';scl<='0'; --r
	  when "10010010" =>scl<='0';sdadir<='0';
	  when "10010011" =>scl<='1';
	  when "10010100" =>scl<='1';
	  when "10010101" =>scl<='0'; --ack time
	  when "10010110" =>         scl<='0';sdadir<='0';
	  when "10010111" =>                   scl<='1';
	  when "10011000" =>outdatas(7)<=sdain;scl<='1';
	  when "10011001" =>scl<='0';  --data7
	  when "10011010" =>scl<='0';
	  when "10011011" =>scl<='1';
	  when "10011100" =>outdatas(6)<=sdain;scl<='1';
	  when "10011101" =>scl<='0';  --data6
	  when "10011110" =>scl<='0';
	  when "10011111" =>scl<='1';
	  when "10100000" =>outdatas(5)<=sdain;scl<='1';
	  when "10100001" =>scl<='0';  --data5
	  when "10100010" =>scl<='0';
	  when "10100011" =>scl<='1';
	  when "10100100" =>outdatas(4)<=sdain;scl<='1';
	  when "10100101" =>scl<='0';  --data4
	  when "10100110" =>scl<='0';
	  when "10100111" =>scl<='1';
	  when "10101000" =>outdatas(3)<=sdain;scl<='1';
	  when "10101001" =>scl<='0';  --data3
	  when "10101010" =>scl<='0';
	  when "10101011" =>scl<='1';
	  when "10101100" =>outdatas(2)<=sdain;scl<='1';
	  when "10101101" =>scl<='0';  --data2
	  when "10101110" =>scl<='0';
	  when "10101111" =>scl<='1';
	  when "10110000" =>outdatas(1)<=sdain;scl<='1';
	  when "10110001" =>scl<='0';  --data1
	  when "10110010" =>scl<='0';
	  when "10110011" =>scl<='1';
	  when "10110100" =>outdatas(0)<=sdain;scl<='1';
	  when "10110101" =>scl<='0';  --data0	  
	  when "10110110" =>scl<='0';sdadir<='0';
	  when "10110111" =>scl<='1';
	  when "10111000" =>scl<='1';
	  when "10111001" =>scl<='0'; --ack time
	  when "10111010" =>sda<='0';scl<='0';sdadir<='1';
	  when "10111011" =>sda<='0';scl<='1'; 
	  when "10111100" =>sda<='1';scl<='1'; --stop
	  when "10111101" =>outdata<=outdatas; 

	  when "11000101" =>sda<='1';scl<='1';over<='1';
	  
	  when others => sda<='1';scl<='1';sdadir<='1';
	  end case;
      
      
      
      
   end if;
end if;   
end process;



end behave;


