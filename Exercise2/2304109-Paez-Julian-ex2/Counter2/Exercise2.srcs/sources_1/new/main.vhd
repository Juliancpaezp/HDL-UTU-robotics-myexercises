----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: Sept 19th 2023
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
    Port ( CLOCK, down, load, reset, enable : in std_logic;
        my_clock   : inout std_logic := '0'; -- Main frecuency divider output
        data : in STD_LOGIC_VECTOR(3 downto 0);
        over : out std_logic := '0';
        LEDS : out STD_LOGIC_VECTOR(3 downto 0)
        );
end main;
     

--------- And then the architecture contains the actual functionality of the module. --------------
architecture Behavioral of main is

    signal counter : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin

---------- Main frequency divider ---------- 
    process(CLOCK)
        variable clock_counter : integer := 0; 
    begin
        if rising_edge(CLOCK) then
            clock_counter := clock_counter + 1;
            if ( clock_counter = 1 ) then  --Clock speed on Zedboard is 100Mhz - use 50000000 to have a run per second (100 000 000 / 2 = 50 000 000) and divided by 2 again as we count rising edge. 1 for sim
                my_clock <= not my_clock;
                clock_counter := 0;
            end if;
         end if;
     end process;

---------- First counter ---------- 
   process(my_clock)--, reset, load, enable, down, data)
   
   -- Here I put my process local variables
   --variable counter : integer range 0 to 15 := 0;
   variable over_flag : integer := 0;
       
   -- And here the actual functionality of this process starts
   begin
   
        if  (reset = '1') then
            counter <= "0000";
            LEDS <= counter;
        else
            if (enable = '1') then 
            
                if rising_edge(my_clock) then 
                
                    if (down = '0') then
                            for i in 0 to 3 loop
                                if counter(i) = '0' then
                                    counter(i) <= '1';
                                    LEDS <= counter;
                                    exit;  -- Exit the loop after toggling the bit
                                else
                                    counter(i) <= '0';
                                    LEDS <= counter;
                                end if;
                        end loop;
                    end if;   
                    
                    if (down = '1') then
                            for i in 0 to 3 loop
                                if counter(i) = '1' then
                                    counter(i) <= '0';
                                    LEDS <= counter;
                                    exit;  -- Exit the loop after toggling the bit
                                else
                                    counter(i) <= '1';
                                    LEDS <= counter;
                                end if;
                            end loop;
                    end if; 
                    
                end if; 
                                
            end if;
           
            if (load = '1') then --Make LEDS input show DATA input
                LEDS <= data;
            else
                -- Saving counter value on LEDS array
                LEDS <= counter;
            end if;
            
            if (over_flag = 1) then
                over <= '0';
                over_flag := 0;
            end if;
            
            if (counter = "1111" or counter = "0000") then
                over <= '1';
                over_flag := 1;
            end if; 
        
        end if;    
        
   end process;
end Behavioral;
