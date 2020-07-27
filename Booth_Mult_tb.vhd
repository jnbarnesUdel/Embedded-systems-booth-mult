----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2020 07:42:55 PM
-- Design Name: 
-- Module Name: Booth_Mult_tb - Behavioral
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
use ieee.std_logic_signed.all; 
use ieee.numeric_std.ALL;
use ieee.std_logic_textio.all;
use STD.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Booth_Mult_tb is
--  Port ( );
end Booth_Mult_tb;

architecture Behavioral of Booth_Mult_tb is
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
  component LFSR_16
 Port
  (
  clock :    in STD_LOGIC;                       --driven clock
  reload:    in STD_LOGIC;                       --load seed from input D
  D :    in STD_LOGIC_VECTOR (15 downto 0); --input for loading seed
  en :    in STD_LOGIC;                       --enable random generation
  Q :    out STD_LOGIC_VECTOR (15 downto 0) --ouptput for random number
  );
 end component;

   ----------------define procedure for print error info---------------------------
   procedure echo(arg : in string := "") is
begin
  std.textio.write(std.textio.output, arg & LF);
end procedure echo;
--inputs
signal A : std_logic_vector(23 downto 0):= (others => '0');
signal B : std_logic_vector(23 downto 0):= (others => '0') ;
signal J : std_logic_vector(23 downto 0):= (others => '0');
signal K : std_logic_vector(23 downto 0):= (others => '0') ;
--outputs
signal Reset, Start: std_logic := '0';
signal Clk : std_logic := '0';
signal reload, en, Overflow : std_logic := ('0');
signal Done: std_logic;
signal D1 : std_logic_vector(15 downto 0) := (others => '0');
signal D2 : std_logic_vector(15 downto 0) := (others => '0');
signal D3 : std_logic_vector(15 downto 0) := (others => '0');
signal I : std_logic_vector(15 downto 0) := (others => '0');
signal Product : std_logic_vector(47 downto 0);
signal first : std_logic := '1';
signal state : std_logic_vector(1 downto 0) := "00";
constant clk_period : time := 10 ns;
begin
clk_process: process
  begin
      Clk <= '0';
      wait for clk_period/2;
      Clk <= '1';
      wait for clk_period/2;
end process;


-------------------Seed with random inputs--------------------------
stimu:process
begin
    reload <= '1';
    en <= '0';
    D1 <= x"0505";
    D2 <= x"7272";
    D3 <= x"a1a1";
    wait for 10 ns;
    
    reload <= '0';
    en <= '1';
    wait;
end process;

-------------------Start and Reset--------------------------
startReset:process(Clk)
begin
    if((first = '1') and (Clk = '1') and (Clk'event)) then    --only reset first time
    Reset <= '1';
    first <= '0';
    end if;
    
    if((Done = '1') and(Clk = '1') and (Clk'event) and (first /= '1')) then
    Reset <= '0';
    Start <= '1';
    end if;
    
    if((Start = '1') and (Clk = '1') and (Clk'event)) then
    Start <= '0';
    end if;

-------------------When can input be takesn--------------------------
    
    if( (Clk = '1') and (Clk'event) and (Start = '1')) then --may need to wait on start
        if(state = "00") then   --both positive
            A <= "000000000000000001000100";
            B <= "000000000000001000011100";
            state <= "01";
        elsif(state ="01") then
            A <= "100000001000000011000100";
            B <= "011100000010001000000100";
            state <= "10";
        elsif(state ="10") then --other pos other neg
            A <= "000000001000000011000100";
            B <= "111100000010001000000100";
            state <= "11";
        end if;
        elsif(state ="11") then
            A <= "100000001000000011000100";
            B <= "111100000010001000000100";
    end if;
end process;

-------------------result check process--------------------------
asserts:process
   variable s :line;
 begin
 wait for 5ns;
 
  if(Done='1') then--if its done
      if((Product /= A*B)) then
      write(s, string'("Error: "));
      hwrite(s, Product);
      write(s, string'(" \= "));
      write(s, integer'image(to_integer(signed(A))));
      write(s, string'(" * "));
      write(s, integer'image(to_integer(signed(B))));
      writeline(output, s);
      --echo("Error: " & integer'image(to_integer(signed(Product))) & " /= " & integer'image(to_integer(signed(A))) &" * " & integer'image(to_integer(signed(B))) );
      end if;
   end if;
   
 wait for 5ns;
end process;

  LFS1: LFSR_16 port map ( clock => Clk, reload => reload, D => D1, en => en, Q => J(15 downto 0));
  LFS2: LFSR_16 port map ( clock => Clk, reload => reload, D => D2, en => en, Q => I);
  LFS3: LFSR_16 port map ( clock => Clk, reload => reload, D => D3, en => en, Q => K(15 downto 0));
  DUT: Booth_Mult port map(Clock => Clk, Reset => Reset, Start => Start, A => A, B => B, Product => Product, Done => Done);
  K(23 downto 16) <= I(7 downto 0);
  J(23 downto 16) <= I(15 downto 8);


end Behavioral;
