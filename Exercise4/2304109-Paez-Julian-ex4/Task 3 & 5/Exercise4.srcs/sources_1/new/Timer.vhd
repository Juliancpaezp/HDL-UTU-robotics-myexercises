----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: 14.11.2023 10:16:53
-- Design Name: First attempt
-- Module Name: Timer - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Timer is

  Port ( 
            CLOCK, sim_switch, speed1 : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_out : inout std_logic := '0'; -- Frecuency divider output
            Output_CLOCK  : out   std_logic := '0' -- CLOCK viewer
          );
end Timer;

architecture Behavioral of Timer is

    -- Signals for timer entity
    signal clock_counter : integer := 0; 
    signal limit : integer := 0;

begin

    process(CLOCK)
        
    begin

        if rising_edge(CLOCK) then
            clock_counter <= clock_counter + 1;
            -- Clock speed on Zedboard is 100 MHz 
            -- so we have to count 10 000 000 cycles
            -- to achive output of 1/10 th of a second
            -- or 1 000 000 cycles for 1/100 th of a sec
            
            -- Select speed according to speed switches
            if sim_switch = '0' then
                if    speed1 = '1' then 
                    limit <= 10_000_000; -- 1/10  th of a second
                elsif speed1 = '0' then 
                    limit <= 1_000_000;  -- 1/100 th of a second
                end if;
            elsif sim_switch = '1' then -- Simulation speeds
                if    speed1 = '1' then 
                    limit <= 10_000; -- 1/10_000  th of a second
                elsif speed1 = '0' then 
                    limit <= 1_000;  -- 1/100_000 th of a second
                end if;
            end if;         
            
            if ( clock_counter > limit ) then  
                my_clock_out <= not my_clock_out;
                Output_CLOCK <= my_clock_out;
                clock_counter <= 0;
            --elsif ( clock_counter < limit ) then
            --    my_clock_out <= '0';
            --   Output_CLOCK <= '0';
            end if;
            
         end if;
     end process;

end Behavioral;
