----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: Nov 1th 2023
-- Design Name: First attempt
-- Module Name: top - Behavioral
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

entity top is
-- Declare real inputs and outputs here
  Port (
        --Clock
        GCLK : in std_logic;
        
        -- Button
        BTNC : in std_logic;
        
        --LEDs
        LD0 : out std_logic;
        LD7 : out std_logic
                
        );
        
end top;

architecture Behavioral of top is

    signal my_clock : std_logic;

    component Timer is
        Port (
            CLOCK : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_out : inout std_logic := '0'; -- Frecuency divider output
            Output_CLOCK  : out   std_logic := '0' -- CLOCK viewer
        ); 
    end component Timer;

    component debouncer is
        Port (
            my_clock_in : in std_logic;
            button_in : in std_logic;
            LED_out    : out std_logic := '0'
         );
    end component debouncer;

begin

Timer_connections:
    Entity work.Timer(Behavioral)
    Port map(
        
        -- Clock
        CLOCK => GCLK,
        my_clock_out => my_clock,
        
        -- LEDs
        Output_CLOCK => LD7 
        
        );
        
debouncer_connections:
    Entity work.debouncer(Behavioral)
    Port map(
            
        --Clock
        my_clock_in => my_clock,
    
        -- Button 
        button_in => BTNC,
        
        -- LEDs
        LED_out => LD0
                
        );

end Behavioral;