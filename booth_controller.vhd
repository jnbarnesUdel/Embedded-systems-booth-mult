----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jonathan Barnes
-- 
-- Create Date: 03/29/2020 07:33:12 PM
-- Design Name: 
-- Module Name: booth_controller - Behavioral
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

entity booth_controller is
    Port (
             clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           start : in STD_LOGIC;
           count_up : in STD_LOGIC;
           init : out STD_LOGIC;
           loadA : out STD_LOGIC;
           shift : out STD_LOGIC;
           done : out STD_LOGIC);
end booth_controller;

architecture Behavioral of booth_controller is
signal state: std_logic_vector(1 downto 0) := "00";
signal nextState: std_logic_vector(1 downto 0):= "00";
begin
   res: process(clock)
    begin
        if(rising_edge(clock)) then  --syncronous on rising edge
            if(reset = '1') then
                state <= "00";    --re initialize if reset
            else
                state <= nextState;
            end if;
        end if;
    end process;
    
    S0: process(state, start, count_up)
    begin
        if((state = "00")) then  --state 0
            done <= '1';
            init <= '0';
            loadA <= '0';
            shift <= '0';
            if (start = '1') then
                nextState <= "01";
            end if;
        elsif((state = "01")) then  --state 1
            done <= '0';
            init <= '1';
            loadA <= '0';
            shift <= '0';
            nextState <= "10";
        elsif((state = "10")) then  --state 2
            done <= '0';
            init <= '0';
            loadA <= '1';
            shift <= '0';
            nextState <= "11";
        elsif((state = "11")) then  --state 3
            done <= '0';
            init <= '0';
            loadA <= '0';
            shift <= '1';
            if(count_up = '1') then
                nextState <= "00";
            else
                nextState <= "10";
            end if;
        end if;
    end process;

end Behavioral;
