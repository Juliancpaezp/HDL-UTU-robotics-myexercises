----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: 14.11.2023 10:16:53
-- Design Name: First attempt
-- Module Name: Timer - Behavioral
-- Project Name: Exercise 4 - Debouncer
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
            CLOCK : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_out : inout std_logic := '0'; -- Frecuency divider output
            Output_CLOCK  : out   std_logic := '0' -- CLOCK viewer
          );
end Timer;

architecture Behavioral of Timer is

    -- Signals for timer entity
    signal clock_counter : integer := 0;

begin

    process(CLOCK)
        
    begin

        if rising_edge(CLOCK) then
            clock_counter <= clock_counter + 1;
            -- Clock speed on Zedboard is 100 MHz 
            -- so we have to achive output of 200 Hz
            
            if ( clock_counter >= 500_000 ) then  
                my_clock_out <= not my_clock_out;
                Output_CLOCK <= my_clock_out;
                clock_counter <= 0;
            end if;
            
         end if;
     end process;

end Behavioral;
