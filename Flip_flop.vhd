----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2020 03:38:43 PM
-- Design Name: 
-- Module Name: Flip_flop - Behavioral
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

entity Flip_flop is
    Port ( clock : in STD_LOGIC;
            reset: in std_logic;
            shift: in std_logic;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
end Flip_flop;

architecture Behavioral of Flip_flop is
signal temp : std_logic := '0';
begin
process(clock)
begin
    if(rising_edge(clock)) then
        if(reset = '1') then
            Q <= '0';
        elsif (shift = '1') then
            Q <= D;
        end if;
    end if;
end process;


end Behavioral;
