----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: 01.11.2023 11:45:23
-- Design Name: First attempt
-- Module Name: debouncer - Behavioral
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
entity debouncer is 
    Port (  
            my_clock_in : in std_logic;
            button_in : in std_logic;
            LED_out    : out std_logic := '0'
        );  
end debouncer;


--------- And then the architecture contains the actual functionality of the module. --------------
architecture Behavioral of debouncer is

    signal delay1, delay2, delay3 : std_logic := '0';
    signal LED_buffer : std_logic := '0';
    signal clc : std_logic := '0';

begin
    process (my_clock_in)
    begin
        if rising_edge(my_clock_in) then 
            delay1 <= button_in;
            delay2 <= delay1;
            delay3 <= delay2;
        end if;
        
        if delay1 = '1' and delay2 = '1' and delay3 = '1' then
            LED_buffer <= not LED_buffer;
            LED_out <= LED_buffer;
        end if; 
        
    end process;


end Behavioral;