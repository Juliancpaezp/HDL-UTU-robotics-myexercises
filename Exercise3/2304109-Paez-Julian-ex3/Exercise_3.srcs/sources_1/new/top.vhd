----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
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

entity top is
        
-- Declare real inputs and outputs here
  Port (
        --Clock
        GCLK : in std_logic;
        
        --Switches
        SW0 : in std_logic;
        SW1 : in std_logic;
        SW2 : in std_logic;
        SW3 : in std_logic;
        SW4 : in std_logic;
        SW5 : in std_logic;
        SW6 : in std_logic;
        SW7 : in std_logic;
        
        -- Buttons
        --BTNU : in std_logic;
        --BTND : in std_logic;
        --BTNL : in std_logic;
        --BTNR : in std_logic;
        
        
        --LEDs
        LD0 : out std_logic;
        LD1 : out std_logic
        --LD2 : out std_logic;
        --LD1 : out std_logic;
        --LD2 : out std_logic;
        --LD3 : out std_logic;
        --LD4 : out std_logic;
        --LD5 : out std_logic;
        --LD6 : out std_logic;
        --LD7 : out std_logic
        --LD9 : out std_logic
                
        );
        
end top;

architecture Behavioral of top is

    component main is
        Port (  load, reset, enable, CLOCK : in std_logic;
                --down : out std_logic; --Cannot use it manually now, it has to be auto to make counter a periodic signal
                data : in STD_LOGIC_VECTOR(7 downto 0);
                over : out std_logic;
                --LEDS : out STD_LOGIC_VECTOR(7 downto 0);
                PWM  : out std_logic := '0'
              );
    end component main;
    
begin
    main_connections:
    Entity work.main(Behavioral)
    Port map(
    
        -- Buttons
        --data(7) => BTNU,
        --data(6) => BTND,
        --data(5) => BTNL,
        --data(4) => BTNR,
        
        --Clock
        CLOCK => GCLK,
    
        -- Switches 
        enable => SW7,
        down   => SW6, --Cannot use it manually now, it has to be auto to make counter a periodic signal
        reset  => SW5,
        load   => SW4,
        data(7) => SW3,
        data(6) => SW2,
        data(5) => SW1,
        data(4) => SW0,
        data(3) => SW3,
        data(2) => SW2,
        data(1) => SW1,
        data(0) => SW0,
        
        -- LEDs
        PWM => LD0,
        over => LD1
        --LEDS(0) => LD0,
        --LEDS(1) => LD1,
        --LEDS(2) => LD2,
        --LEDS(3) => LD3,
        --LEDS(4) => LD4,
        --LEDS(5) => LD5,
        --LEDS(6) => LD6,
        --LEDS(7) => LD7
        
        );
    
end Behavioral;
