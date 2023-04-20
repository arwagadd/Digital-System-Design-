library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Medication is 
generic(ClockFrequencyHz : integer:=50000000);
port(
	Clk 	  : in std_logic;
	nRst	  : in std_logic; -- Negative reset
	
	--Seconds_out : out integer;
	sensor : in std_logic;
	buzzer : out std_logic;
	motor  : out std_logic;
	leds: out std_logic_vector(1 To 7);
	leds2: out std_logic_vector(1 To 7));

end Medication;


architecture arch of Medication is

signal Seconds :  integer;
signal rBuzzer: STD_LOGIC;
signal save : integer;

		-- Signal for counting clock periods
		signal Ticks : integer;
begin

			process(Clk) is
			begin
			
		if rising_edge(Clk) then
		
					-- If the negative reset signal is active
					if nRst = '0' then
						  Ticks   <= 0 ;
						  Seconds <= 0 ;

					else
						
						-- True once every second
						if Ticks = ClockFrequencyHz - 1 then 
							Ticks <= 0;
							
							-- True once every minute
							if Seconds = 59 then
								Seconds <= 0;						
								leds <= "0000001";
								leds2 <= "0000001";
	
							else
								Seconds <= Seconds + 1;
									CASE seconds mod 10 IS           
	                         WHEN 0 => leds <= "0000001";
									 WHEN 1 => leds <= "1001111";
							  		 WHEN 2 => leds <= "0010010";
									 WHEN 3 => leds <= "0000110";
									 WHEN 4 => leds <= "1001100";
									 WHEN 5 => leds <= "0100100";
									 WHEN 6 => leds <= "0100000";
									 WHEN 7 => leds <= "0001111";
									 WHEN 8 => leds <= "0000000";
									 WHEN 9 => leds <= "0001100";
	 
                            WHEN OTHERS => leds <= "-------";
			                  end case;
									
									CASE seconds - (seconds mod 10) IS           
	                         WHEN 0 => leds2 <= "0000001";
									 WHEN 10 => leds2 <= "1001111";
							  		 WHEN 20 => leds2 <= "0010010";
									 WHEN 30 => leds2 <= "0000110";
									 WHEN 40 => leds2 <= "1001100";
									 WHEN 50 => leds2 <= "0100100";
									 WHEN 60 => leds2 <= "0100000";
									 WHEN 70 => leds2 <= "0001111";
									 WHEN 80 => leds2 <= "0000000";
									 WHEN 90 => leds2 <= "0001100";
	 
                            WHEN OTHERS => leds2 <= "-------";
			                  end case;
							end if;
	
							
						else
							Ticks <= Ticks + 1;
						end if;
					
				 	if Seconds = 10 then
					save <= seconds;
					rbuzzer<='1';
				 	end if;
					

					     if (sensor = '0' AND rBuzzer = '1') then
				   	motor <= '1';
				   	rBuzzer<= '0';
						buzzer<='0';
					
					
				
							
						  else
						  if(seconds-save >5) then
					   	 
							 motor <= '0';
							 end if;
				         	end if;
					 
					
		
	end if;
	
					 buzzer <= rbuzzer;
	end if;
				
							
				buzzer<= rBuzzer;
			end process;
		--	Seconds_out <= Seconds;
			
end arch;
