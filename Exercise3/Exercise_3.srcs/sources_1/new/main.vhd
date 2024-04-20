----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: Oct 5th 2023
-- Design Name: First attempt
-- Module Name: main - Behavioral
-- Project Name: Exercise 3
-- Target Devices: Zedboard
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

---------- The entity definition includes the inputs and outputs of our module.  ---------------
entity main is 
    Port (  load, reset, enable, CLOCK : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            down       : in std_logic := '0'; -- Inout as I want to read from it to modify conunter behavior and also write to it, as signal because I want to see it on simulation
            data       : in    STD_LOGIC_VECTOR(7 downto 0); 
            over       : out   std_logic := '0';
            my_clock   : inout std_logic := '0'; -- Main frecuency divider output
            LEDS       : out STD_LOGIC_VECTOR(7 downto 0); -- Counter range goes from 00 to FF.
            LEDSbuffer : inout STD_LOGIC_VECTOR(7 downto 0); -- LEDS as inout to read from it to extract LEDS1 and LEDS2 from it later.
            LEDS1      : out   STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- Required output 1
            LEDS2      : out   STD_LOGIC_VECTOR(3 downto 0) := "0000"; -- Requider output 2
            PWM        : out   std_logic := '0' -- Required output to send to LED
        );
end main;


--------- And then the architecture contains the actual functionality of the module. --------------
architecture Behavioral of main is
    
    -- Variables to share between process 
    shared variable counter : integer range 0 to 255 := 10; -- Shared to manipulate it on main process but also read it on PWM generator

begin


    -- Main frequency divider
    process(CLOCK)
        variable clock_counter : integer := 0; 
    begin
        if rising_edge(CLOCK) then
            clock_counter := clock_counter + 1;
            if ( clock_counter = 10 ) then  --Clock speed on Zedboard is 100Mhz - use 250000; 10 for sim
                my_clock <= not my_clock;
                clock_counter := 0;
            end if;
         end if;
     end process;
     
     
     
     -- PWM generator ( it should take about 50 ms per period? ) 
     process(CLOCK)
     
        variable clock_counter_PWM : integer := 0; 
        variable duty_cycle : integer := 0; -- Change this only from 0 to 255
        
        
        begin
            duty_cycle := counter; -- Make the caunter be the duty cycle itself
            if rising_edge(CLOCK) then
                clock_counter_PWM := clock_counter_PWM + 1;
                if ( clock_counter_PWM < duty_cycle ) then
                    PWM <= '1';
                else
                    PWM <= '0';
                end if;
                if ( clock_counter_PWM = 255 ) then --Reset clock counter when full
                    clock_counter_PWM := 0;
                end if;
             end if;
         end process;



    -- Main counter process, changes only with "my_clock"
    process(my_clock)
    
        -- Creating internal needed variables
        variable over_flag : integer := 0;
       
    -- Here is the main part of the process
    begin
           
        if  (reset = '1') then
            counter := 0;
            LEDS <= std_logic_vector(to_unsigned(counter, LEDS'length));
            LEDSbuffer <= std_logic_vector(to_unsigned(counter, LEDS'length)); --Split LEDS into LEDS1 and LEDS2
        else
            if (enable = '1') then 
            
                if rising_edge(my_clock) then 
                
                    if (down = '0') then
                        counter := counter + 1;
                    end if;
                    
                    if (down = '1') then
                        counter := counter - 1;
                    end if;
                    
                    if (over_flag = 1) then
                        over <= '0';
                        over_flag := 0;
                    end if;
                    
                    if (counter = 255) then
                        over <= '1';
                        over_flag := 1;
                        --down <= '1'; -- Make the counter go down when reaches 255
                    end if; 
                
                    if (counter = 0) then
                        over <= '1';
                        over_flag := 1;
                        --down <= '0'; -- Make the counter go up when reaches 0
                    end if; 
                    
                end if; 
                                
            end if;
           
           
            if (load = '1') then --Make LEDS input show DATA input
                LEDS <= data;
                LEDSbuffer <= data; --Split LEDS into LEDS1 and LEDS2
            else
                -- Saving counter value on LEDS array
                LEDS <= std_logic_vector(to_unsigned(counter, LEDS'length));
                LEDSbuffer <= std_logic_vector(to_unsigned(counter, LEDS'length)); --Split LEDS into LEDS1 and LEDS2
            end if;
            
            
            
        end if;   
               
    end process;

LEDS1(3) <= LEDSbuffer(7);   
LEDS1(2) <= LEDSbuffer(6);   
LEDS1(1) <= LEDSbuffer(5);   
LEDS1(0) <= LEDSbuffer(4); 
  
LEDS2(3) <= LEDSbuffer(3);   
LEDS2(2) <= LEDSbuffer(2);   
LEDS2(1) <= LEDSbuffer(1);   
LEDS2(0) <= LEDSbuffer(0); 

end Behavioral;
