----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jonathan Barnes
-- 
-- Create Date: 02/22/2018 03:03:29 PM
-- Design Name: 
-- Module Name: CLA_24 - CLA_24
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

entity CLA_24 is
--  Port ( );
  Port
    ( 
    A : in STD_LOGIC_VECTOR (23 downto 0);
    B : in STD_LOGIC_VECTOR (23 downto 0);
    M:in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (23 downto 0);
	Overflow: out STD_LOGIC
    );
end CLA_24;

architecture CLA_24 of CLA_24 is
component CLA_4_Gen
 port (
	 G : in STD_LOGIC_VECTOR (3 downto 0);
     P : in STD_LOGIC_VECTOR (3 downto 0);
     Cin : in STD_LOGIC;
	 C: out STD_LOGIC_VECTOR(3 downto 0);
	 PG: out STD_LOGIC;
	 GG: out STD_LOGIC;
	 Cout: out StD_LOGIC
     );
end component;

component CLA_16_Gen
 port (
	 GG : in STD_LOGIC_VECTOR (3 downto 0);
     PG : in STD_LOGIC_VECTOR (3 downto 0);
     Cin : in STD_LOGIC;
	 C: out STD_LOGIC_VECTOR(3 downto 0)
     );
end component;

signal P, G, C, BM : std_logic_vector(23 downto 0);
signal PG, GG, CO : std_logic_vector(3 downto 0);
signal C_out : std_logic_vector(5 downto 0);

begin

	Min:process (B, M)
	begin
		case M is
			when '1' =>
				BM <= B xor "111111111111111111111111";
			when others =>
				BM <= B;
		end case;
	end process;
	--need to do xor for B thing
    P <= A xor BM;
	G <= A and BM;
    CG1: CLA_4_Gen port map( G => G(3 downto 0), P => P(3 downto 0), Cin=> M, C => C(3 downto 0), Cout => C_out(0));
	CG2: CLA_4_Gen port map( G => G(7 downto 4), P => P(7 downto 4), Cin=> C_out(0), C => C(7 downto 4), Cout => C_out(1));
	--these go into 16 bit cla
	CG3: CLA_4_Gen port map( G => G(11 downto 8), P => P(11 downto 8), Cin=> C_out(1), C => C(11 downto 8), PG => PG(0), GG => GG(0));
	CG4: CLA_4_Gen port map( G => G(15 downto 12), P => P(15 downto 12), Cin=> CO(0), C => C(15 downto 12), PG => PG(1), GG => GG(1));
	CG5: CLA_4_Gen port map( G => G(19 downto 16), P => P(19 downto 16), Cin=> CO(1), C => C(19 downto 16), PG => PG(2), GG => GG(2));
	CG6: CLA_4_Gen port map( G => G(23 downto 20), P => P(23 downto 20), Cin=> CO(2), C => C(23 downto 20), PG => PG(3), GG => GG(3));
    CG21: CLA_16_Gen port map( GG => GG, PG => PG, Cin => C_out(1), C => CO);              
	
	S <= C xor P;
	Overflow <= CO(3) xor C(23);
end CLA_24;