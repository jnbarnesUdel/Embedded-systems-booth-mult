----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2020 03:01:12 PM
-- Design Name: 
-- Module Name: booth_wrapper - Behavioral
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

entity booth_wrapper is
    Port ( ARG : in STD_LOGIC_VECTOR (23 downto 0);
           Reset : in STD_LOGIC;
           Start : in STD_LOGIC;
           clk: in STD_LOGIC;
           Product : out STD_LOGIC_VECTOR (47 downto 0);
           Done : out STD_LOGIC;
           sel : in std_logic
           );
end boooth_wrapper;

architecture Behavioral of booth_wrapper is

component Booth_Mult
  Port
    (
  Clock : in STD_LOGIC;
             Reset : in STD_LOGIC;
             Start : in STD_LOGIC;
             A : in STD_LOGIC_VECTOR (23 downto 0);
             B : in STD_LOGIC_VECTOR (23 downto 0);
             Product : out STD_LOGIC_VECTOR (47 downto 0);
             Done : out STD_LOGIC
    );
end component;


signal A_reg, B_reg : STD_LOGIC_VECTOR(23 downto 0);
signal S_reg : STD_LOGIC_VECTOR(47 downto 0);
signal D_reg, Start_reg, Reset_reg : STD_LOGIC;


begin

process(clk) begin
    if rising_edge(clk) then
        if(sel = '1') then
            A_reg <= ARG;
        else
            B_reg <= ARG;
        end if;
        Done <= D_reg;
        Product <= S_reg;
        Reset_reg <= Reset;
        Start_reg <= Start;
    end if;
end process;


 addsub0: Booth_Mult port map(clk, Reset_reg, Start_reg, A_reg, B_reg, S_reg, D_reg);
--addsub0: ripple24_addsub port map(A_reg, B_reg, M_reg, S_reg, Overflow_reg);

end Behavioral;
