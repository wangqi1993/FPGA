----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:10:30 02/13/2017 
-- Design Name: 
-- Module Name:    w_r_mod - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY w_r_mod24 IS
port( aw_r_in_L       :in std_logic;
      aw_r_in_H       :in std_logic;
      clkin           :in std_logic;
      busdata       :inout std_logic_vector(15 downto 0);
      rstout          :OUT std_logic_vector(23 downto 0)
);
end w_r_mod24;

ARCHITECTURE behave OF w_r_mod24 IS
signal aa :std_logic;  
signal ab :std_logic;
signal cc :std_logic;  
signal cb :std_logic;
signal rstouts_L:std_logic_vector(15 downto 0);
signal rstouts_H:std_logic_vector(15 downto 0);
begin
   
process(clkin)
      --variable  count:INTEGER RANGE 0 TO 65535;
   begin
    
    if (clkin'event and clkin='1') then
       aa<=aw_r_in_L;
       ab<=aa; 
		 cc<=aw_r_in_H;
       cb<=cc; 
       if(aa='1' and ab='0')then 
         rstouts_L<=busdata;
        else
         rstouts_L<=rstouts_L; 
       end if;  
		 if(cc='1' and cb='0')then 
         rstouts_H<=busdata;
        else
         rstouts_H<=rstouts_H; 
       end if;
    end if;     

end process;

rstout <= rstouts_H(7 downto 0) & rstouts_L;
   
end behave;