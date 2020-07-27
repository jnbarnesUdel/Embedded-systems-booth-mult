----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jonathan Barnes
-- 
-- Create Date: 04/05/2020 10:39:41 AM
-- Design Name: 
-- Module Name: Booth_Mult - Behavioral
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

entity Booth_Mult is
    Port ( 
            Clock : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Start : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (23 downto 0);
           B : in STD_LOGIC_VECTOR (23 downto 0);
           Product : out STD_LOGIC_VECTOR (47 downto 0);
           Done : out STD_LOGIC);
end Booth_Mult;

architecture Behavioral of Booth_Mult is

component CLA_24
 port (
    A : in STD_LOGIC_VECTOR (23 downto 0);
 B : in STD_LOGIC_VECTOR (23 downto 0);
 M:in STD_LOGIC;
 S : out STD_LOGIC_VECTOR (23 downto 0);
 Overflow: out STD_LOGIC
     );
end component;

component ShiftReg
 port (
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
end component;

component booth_controller
 port (
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    start : in STD_LOGIC;
    count_up : in STD_LOGIC;
    init : out STD_LOGIC;
    loadA : out STD_LOGIC;
    shift : out STD_LOGIC;
    done : out STD_LOGIC
     );
end component;

component Counter
 port (
clock : in std_logic;
shift : in std_logic;
 count_up: out std_logic
     );
end component;

component Flip_flop
 port (
clock : in STD_LOGIC;
             reset: in std_logic;
             shift: in std_logic;
            D : in STD_LOGIC;
            Q : out STD_LOGIC
     );
end component;

signal part, o, out_0, out_1 , c_0, c_1, multiplicand: std_logic_vector(23 downto 0):= "000000000000000000000000";
signal op_0, op_1, s, cu, ini, loa, shi, overfl, lp, re : std_logic;
signal so: std_logic := '0';
signal cont: std_logic_vector (1 downto 0);

begin

 multiplicand <=A;
lp <= loa and (c_0(0) xor op_0);
re <= Reset or ini;

add: CLA_24 port map(A => c_1 , B => multiplicand, M => c_0(0), S => part, Overflow => overfl);
partal: ShiftReg port map(clock => Clock, clear => ini, shift => shi, load => lp, init => '0', serial_in => c_1(23), parallel_in => part, serial_out => so, inside => c_1, parallel_out => out_1);
multiplier: ShiftReg port map(clock => Clock, clear => Reset, shift => shi, load => '0', init => ini, serial_in => c_1(0), parallel_in => B, serial_out => op_1, inside => c_0,  parallel_out => out_0 );
control: booth_controller port map(clock => Clock, reset => Reset, start => Start, count_up => cu, init=> ini, loadA => loa, shift => shi, done => Done );
count: Counter port map(clock => Clock, shift => shi, count_up => cu);
extraBit: Flip_flop port map(clock => Clock, D => c_0(0),reset => re, shift => shi, Q=>op_0);

Product(47 downto 24) <= c_1;
Product(23 downto 0) <= c_0;
end Behavioral;
