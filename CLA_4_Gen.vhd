----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2020 02:22:54 PM
-- Design Name: 
-- Module Name: CLA_4_Gen - Behavioral
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

entity CLA_4_Gen is
    Port ( 
           G : in STD_LOGIC_VECTOR (3 downto 0);
           P : in STD_LOGIC_VECTOR (3 downto 0);
           Cin : in STD_LOGIC;
		   C: out STD_LOGIC_VECTOR(3 downto 0);
		   PG: out STD_LOGIC;
		   GG: out STD_LOGIC;
		   Cout: out StD_LOGIC);
end CLA_4_Gen;

architecture Behavioral of CLA_4_Gen is
signal C_in : std_logic;
begin

C(0) <= Cin;
C(1) <= G(0) OR (P(0) AND Cin);
C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Cin);
C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Cin);
Cout <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and Cin);
PG <= P(0) And P(1) And P(2) And P(3);
GG <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0));
end Behavioral;
