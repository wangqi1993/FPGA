----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:11 02/13/2017 
-- Design Name: 
-- Module Name:    w_r_mod_1 - Behavioral 
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

ENTITY w_r_mod_1 IS
port( aw_r_in         :in std_logic;
      clkin           :in std_logic;
      busdata:        inout std_logic;
      rstout          :OUT std_logic
);
end w_r_mod_1;

ARCHITECTURE behave OF w_r_mod_1 IS
signal aa :std_logic;  
signal ab :std_logic;
signal rstouts:std_logic;
begin
   
process(clkin)
      --variable  count:INTEGER RANGE 0 TO 65535;
   begin
    
    if (clkin'event and clkin='1') then
       aa<=aw_r_in;
       ab<=aa; 
       if(aa='1' and ab='0')then 
         rstouts<=busdata;
        else
         rstouts<=rstouts; 
       end if;  
    end if;     

end process;

rstout<=rstouts;
   
end behave;

