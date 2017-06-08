----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:11:17 12/30/2016 
-- Design Name: 
-- Module Name:    D_flip_flop - Behavioral 
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

entity D_flip_flop is
port(
		prn,clrn,clk: in std_logic;
		d: in std_logic;
		q,qb: out std_logic
		);
end D_flip_flop;

architecture D0 of D_flip_flop is
signal q_temp,qb_temp:std_logic;
begin
process(prn,clrn,clk,d)
	begin
		if(prn = '1' and clrn = '0')then
		q_temp <= '0';
		qb_temp <= '1';
		elsif(prn = '0')then
		q_temp <= '1';
		qb_temp <= '0';
		elsif(clk = '1' and clk'event)then
		q_temp <= d;
		qb_temp <= not d;
		end if;		
	end process;
q <= q_temp;
qb <= qb_temp;
end D0;

