----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jonathan Barnes
-- 
-- Create Date: 03/29/2020 02:21:52 PM
-- Design Name: 
-- Module Name: ShiftReg - Behavioral
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

entity ShiftReg is
 Port ( 
    clock: in std_logic;
    clear: in std_logic;
    shift: in std_logic;
    load: in std_logic;
    init: in std_logic;
    serial_in: in std_logic;
    parallel_in: in std_logic_vector(23 downto 0);
    serial_out: out std_logic;
    inside: out std_logic_vector(23 downto 0);
    parallel_out: out std_logic_vector(23 downto 0)
    );
end ShiftReg;

architecture Behavioral of ShiftReg is
signal A: std_logic_vector(23 downto 0) := "000000000000000000000000";
signal b: std_logic := '0';
begin
    process(clock)
    begin
        if(rising_edge(clock)) then
            if(clear = '1') then
                A <= "000000000000000000000000";
            else
                if (shift = '1') then
                    b <= A(0);
                    A(22 downto 0) <= A(23 downto 1); 
                    A(23) <= serial_in;
                elsif (load = '1') then
                    parallel_out <= A;
                    A <= parallel_in;
                elsif(init = '1') then
                    A <= parallel_in;
                else
                    A <= A;
                    b <= b;
                end if;
            end if;
        end if;    
    end process;

inside <= A;
serial_out <= b;

end Behavioral;
