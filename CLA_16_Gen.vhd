----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2020 02:22:54 PM
-- Design Name: 
-- Module Name: CLA_16_Gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLA_16_Gen is
    Port ( GG : in STD_LOGIC_VECTOR (3 downto 0);
           PG : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
		   C: out STD_LOGIC_VECTOR(3 downto 0));
end CLA_16_Gen;

architecture Behavioral of CLA_16_Gen is
signal temp : std_logic;
begin
    C(0) <= GG(0) or (PG(0) and Cin);
    C(1) <= GG(1) or (PG(1) and GG(0)) or (PG(1) and PG(0) and Cin);
    temp <= GG(2) or (PG(2) and GG(1)) or (PG(2) and PG(1) and GG(0)) or (PG(2) and PG(1) and PG(0) and Cin);
    C(2) <= temp;
    C(3) <= GG(3) or (PG(3) and temp);
end Behavioral;
