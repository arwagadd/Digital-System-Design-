Library IEEE;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all ;

ENTITY adder4 IS 
	PORT (
	      X,Y : IN UNSIGNED(3 DOWNTO 0);
			S: OUT UNSIGNED(3 DOWNTO 0);
			Cout : OUT STD_LOGIC;
			leds : OUT STD_LOGIC_VECTOR(1 TO 7);
			leds2 : OUT STD_LOGIC_VECTOR(1 TO 7));
END adder4;			

ARCHITECTURE BEHAVIOR OF adder4 IS 
	SIGNAL Sum : UNSigned(4 DOWNTO 0);
	SiGnal V : UNSIGNED(4 DOWNTO 0);
	SIGNAL bcd : UNSIGNED(3 DOWNTO 0);
     
   SIGNAL M :UNSIGNED(4 DOWNTO 0);
   SIGNAL N :STD_LOGIC;
BEGIN
    Sum<= ('0' & X ) + ('0' & Y);
	 S <= Sum(3 DOWNTO 0);
	 Cout <= Sum(4);
	 M <= Sum(4 DOWNTO 0);
    V  <= M WHEN ( M< 10 )ELSE M+6;
	 N <= V(4);
	 bcd <= v(3 DOWNTO 0);
	
	  
 PROCESS(bcd)
BEGIN
	 CASE bcd IS           
	 WHEN "0000" => leds <= "0000001";
	 WHEN "0001" => leds <= "1001111";
	 WHEN "0010" => leds <= "0010010";
	 WHEN "0011" => leds <= "0000110";
	 WHEN "0100" => leds <= "1001100";
	 WHEN "0101" => leds <= "0100100";
	 WHEN "0110" => leds <= "0100000";
	 WHEN "0111" => leds <= "0001111";
	 WHEN "1000" => leds <= "0000000";
	 WHEN "1001" => leds <= "0001100";
         WHEN OTHERS => leds <= "-------";

	END CASE;
END process;
	 leds2 <= "1001111" WHEN (N='1') ELSE "0000001";
	 
	 
END BEHAVIOR;