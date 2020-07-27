----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jonathan Barnes
-- 
-- Create Date: 04/05/2020 10:09:05 AM
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity Counter is
Port ( 
clock : in std_logic;
shift : in std_logic;
count_up: out std_logic);
end Counter;

architecture Behavioral of Counter is

signal ct, o: std_logic_vector(23 downto 0) := "000000000000000000000000";
signal b: std_logic_vector(23 downto 0) := "000000000000000000000001";
signal over: std_logic;

component CLA_24
 port (
    A : in STD_LOGIC_VECTOR (23 downto 0);
 B : in STD_LOGIC_VECTOR (23 downto 0);
 M:in STD_LOGIC;
 S : out STD_LOGIC_VECTOR (23 downto 0);
 Overflow: out STD_LOGIC
     );
end component;

begin

add: CLA_24 port map ( A => ct, B => b, M => '0', S =>o, Overflow => over);
    process (shift)
    begin
        if(rising_edge(shift)) then
        if((ct /= "000000000000000000010111") and (shift = '1') ) then    --may need to make it every other since shift every other 
           ct <= o;
           count_up <= '0';
        elsif (ct = "000000000000000000010111") then
            ct <= "000000000000000000000000";
            count_up <= '1';
        else
            
        end if;
        end if;
    end process;

end Behavioral;
