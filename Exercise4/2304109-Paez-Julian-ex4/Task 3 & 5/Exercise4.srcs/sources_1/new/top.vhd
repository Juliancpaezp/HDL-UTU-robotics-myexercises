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
        
        --Switches
        SW0 : in std_logic;
        --SW1 : in std_logic;
        --SW2 : in std_logic;
        --SW3 : in std_logic;
        SW4 : in std_logic;
        SW5 : in std_logic;
        SW6 : in std_logic;
        --SW7 : in std_logic;
        
        -- Buttons
        --BTNU : in std_logic;
        --BTND : in std_logic;
        --BTNL : in std_logic;
        --BTNR : in std_logic;
        
        --LEDs
        LD0 : out std_logic;
        LD1 : out std_logic;
        LD2 : out std_logic;
        --LD3 : out std_logic;
        --LD4 : out std_logic;
        --LD5 : out std_logic;
        --LD6 : out std_logic;
        LD7: out std_logic
                
        );
        
end top;

architecture Behavioral of top is

    signal my_clock : std_logic;

    component Timer is
        Port (
            CLOCK, sim_switch, speed1 : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_out : inout std_logic := '0'; -- Frecuency divider output
            Output_CLOCK  : out   std_logic := '0' -- CLOCK viewer
        ); 
    end component Timer;

    component LED_Driver is
        Port (
                CLOCK, backwards, reset : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
                my_clock_in : in std_logic := '0'; -- Frecuency divider input
                PWM_1    : out   std_logic := '0'; -- Output to send to LED 1
                PWM_2    : out   std_logic := '0'; -- Output to send to LED 1
                PWM_3    : out   std_logic := '0'; -- Output to send to LED 1
                state_v  : out   STD_LOGIC_VECTOR(2 downto 0) := "000"
         );
    end component LED_Driver;

begin

Timer_connections:
    Entity work.Timer(Behavioral)
    Port map(
        
        -- Clock
        CLOCK => GCLK,
        my_clock_out => my_clock,
        
        -- Switches 
        sim_switch   => SW0,
        speed1    => SW6,
        
        -- LEDs
        Output_CLOCK  => LD7
        
        );
        
LED_Driver_connections:
    Entity work.LED_Driver(Behavioral)
    Port map(
            
        --Clock
        CLOCK => GCLK,
        my_clock_in => my_clock,
    
        -- Switches 
        --input   => SW0,
        --input   => SW1,
        --input   => SW2,
        --input   => SW3,
        backwards => SW4,
        reset     => SW5,
        --speed1    => SW6,
        --speed2    => SW7,
        
        -- LEDs
        PWM_1 => LD0,
        PWM_2 => LD1,
        PWM_3 => LD2
                
        );

end Behavioral;