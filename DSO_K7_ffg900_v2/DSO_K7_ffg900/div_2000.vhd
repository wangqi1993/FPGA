----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:05:03 03/13/2017 
-- Design Name: 
-- Module Name:    div_2000 - Behavioral 
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

entity div_2000 is
port(
clkin      :in std_logic;
clkout     :out std_logic);
end div_2000 ;
architecture behave of div_2000 is
signal c:std_logic_vector(9 downto 0):="0000000000";
begin
process(clkin)
begin

 
 if (clkin'event and clkin='1') then
    if (c<1999) then
        c<=c+1;
    else
        c<="0000000000";
    end if;  
    
    if  (c<1000)  then
        clkout<='1';
    else
        clkout<='0';
    end if;
        
  end if;  
end process;
end behave;

