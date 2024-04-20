----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: 01.11.2023 11:45:23
-- Design Name: First attempt
-- Module Name: LED_Driver - Behavioral
-- Project Name: Exercise 4
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
entity LED_Driver is 
    Port (  CLOCK, backwards, reset, speed1, speed2 : in std_logic;
            my_clock_in : in std_logic := '0';
            PWM_1    : out   std_logic := '0'; -- Output to send to LED 1
            PWM_2    : out   std_logic := '0'; -- Output to send to LED 2
            PWM_3    : out   std_logic := '0'; -- Output to send to LED 3
            state_v  : out   STD_LOGIC_VECTOR(2 downto 0) := "000"
        );  
end LED_Driver;


--------- And then the architecture contains the actual functionality of the module. --------------
architecture Behavioral of LED_Driver is

    -- Signals for variable speed counter
    signal speed_counter : integer := 0; 
    
    -- Signals for PWM 
    signal duty_cycle_1 : integer := 0; -- Change this only from 0 to 255
    signal duty_cycle_2 : integer := 0; -- Change this only from 0 to 255
    signal duty_cycle_3 : integer := 0; -- Change this only from 0 to 255
    
    -- Signals for LED_Driver
    signal speed : integer := 0;
    signal standby_counter : integer := 0;
    signal cycles_to_start : integer := 40;
    type integer_array is array (integer range <>) of integer;
    signal continuous_cycle : integer_array(0 to 4):= (1,6,2,3,7);
    signal backwards_cycle  : integer_array(0 to 3):= (3,2,6,7);
    signal state : integer := 4;

begin
     
    ----------------------- LED_Driver status handler process, changes only with "my_clock_in" ------------
    process(my_clock_in)
        
        variable state_iterator : integer := 0;
        
        begin
        
            if rising_edge(my_clock_in) then
            
                -- Count the first standby seconds by counting cycles on my_clock_in
                -- each 10 counts here are 1 second
                standby_counter <= standby_counter + 1;
                
                -- Adding the reset funcionality
                if reset = '1' then standby_counter <= 0; end if;
                
                -- States moving contiuous or backwards 
                if standby_counter < cycles_to_start then state <= 4; -- default state
                elsif standby_counter >= cycles_to_start then 
                
                    speed_counter <= speed_counter + 1;
            
                    -- Select speed according to speed switches
                    if speed1 = '0' and speed2 = '0' then speed <= 10; end if; -- 1 sec speed
                    if speed1 = '0' and speed2 = '1' then speed <= 10; end if; -- 1 sec speed
                    if speed1 = '1' and speed2 = '0' then speed <= 30; end if; -- 3 sec speed
                    if speed1 = '1' and speed2 = '1' then speed <= 50; end if; -- 5 sec speed
                    
                    -- Go trough states either countinously or backwardsly
                    if ( speed_counter >= speed ) then
                        if backwards = '0' then
                            state <= continuous_cycle( state_iterator );
                            state_iterator := state_iterator + 1;
                            if state_iterator > continuous_cycle'length-1 then state_iterator := 0; end if;
                        elsif backwards = '1' then
                            state_iterator := state_iterator + 1;
                            if state_iterator > backwards_cycle'length-1 then state_iterator := 0; end if;
                            state <= backwards_cycle( state_iterator );
                        end if;
                        speed_counter <= 0;
                    end if;
                    
                end if;
                
                -- Write LEDs status depending on state_iterator
                case state is
                    when 1 => duty_cycle_1 <= 255; duty_cycle_2 <= 0;   duty_cycle_3 <= 0;  
                    when 2 => duty_cycle_1 <= 0;   duty_cycle_2 <= 255; duty_cycle_3 <= 0; 
                    when 3 => duty_cycle_1 <= 0;   duty_cycle_2 <= 0;   duty_cycle_3 <= 255; 
                    when 4 => duty_cycle_1 <= 255; duty_cycle_2 <= 255; duty_cycle_3 <= 255; 
                    when 5 => duty_cycle_1 <= 0;   duty_cycle_2 <= 0;   duty_cycle_3 <= 0; 
                    when 6 => duty_cycle_1 <= 255; duty_cycle_2 <= 255; duty_cycle_3 <= 0; 
                    when 7 => duty_cycle_1 <= 128; duty_cycle_2 <= 0;   duty_cycle_3 <= 128; 
                    when others => duty_cycle_1 <= 0; duty_cycle_2 <= 0; duty_cycle_3 <= 0; 
                end case;
                
                -- Saving state value on status vizualization signal
                state_v <= std_logic_vector(to_unsigned(state, state_v'length));
                
            end if;
        end process;
        
        
     --------------------------------------- PWM_1 generator ------------------------------------
     process(CLOCK)
     
        variable clock_counter_PWM : integer := 0; 
              
        begin
            --duty_cycle_1 := 50; -- change only between 0 and 255
            if rising_edge(CLOCK) then
                clock_counter_PWM := clock_counter_PWM + 1;
                if ( clock_counter_PWM <= duty_cycle_1 ) then PWM_1 <= '1';
                else PWM_1 <= '0'; end if;
                --Reset clock counter when full
                if ( clock_counter_PWM >= 255 ) then clock_counter_PWM := 0; end if;
            end if;
         end process;
         
     --------------------------------------- PWM_2 generator ---------------------------------------
     process(CLOCK)
     
        variable clock_counter_PWM : integer := 0; 
              
        begin
            --duty_cycle_2 := 50; -- change only between 0 and 255
            if rising_edge(CLOCK) then
                clock_counter_PWM := clock_counter_PWM + 1;
                if ( clock_counter_PWM <= duty_cycle_2 ) then PWM_2 <= '1';
                else PWM_2 <= '0'; end if;
                --Reset clock counter when full
                if ( clock_counter_PWM >= 255 ) then clock_counter_PWM := 0; end if;
            end if;
         end process;
         
     --------------------------------------- PWM_2 generator ---------------------------------------
     process(CLOCK)
     
        variable clock_counter_PWM : integer := 0; 
              
        begin
            --duty_cycle_3 := 50; -- change only between 0 and 255
            if rising_edge(CLOCK) then clock_counter_PWM := clock_counter_PWM + 1;
                if clock_counter_PWM <= duty_cycle_3
                    then PWM_3 <= '1';
                    else PWM_3 <= '0';
                end if;
                --Reset clock counter when full 
                if ( clock_counter_PWM >= 255 ) then clock_counter_PWM := 0; end if;
            end if;
         end process;
      
end Behavioral;
