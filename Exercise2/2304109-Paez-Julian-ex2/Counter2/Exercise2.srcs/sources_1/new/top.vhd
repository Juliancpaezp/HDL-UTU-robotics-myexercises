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
        
-- Declare real nputs and outputs here
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
        --BTNC : in std_logic;
        
        --LEDs
        LD0 : out std_logic;
        LD1 : out std_logic;
        LD2 : out std_logic;
        LD3 : out std_logic;
        LD7 : out std_logic
                
        );
        
end top;

architecture Behavioral of top is

    component main is
        Port (  CLOCK, down, load, reset, enable : in std_logic;
                data : in STD_LOGIC_VECTOR(3 downto 0);
                over : out std_logic := '0';
                LEDS : out STD_LOGIC_VECTOR(3 downto 0)
                );
    end component main;
    
begin
    main_connections:
    Entity work.main(Behavioral)
    Port map(
    
        --Clock
        CLOCK => GCLK,
    
        -- Switches 
        data(0) => SW0,
        data(1) => SW1,
        data(2) => SW2,
        data(3) => SW3,
        enable  => SW4,
        down    => SW5,
        reset   => SW6,
        load    => SW7,
        
        -- LEDs
        LEDS(0) => LD0,
        LEDS(1) => LD1,
        LEDS(2) => LD2,
        LEDS(3) => LD3,
        over    => LD7
        
        );
    
end Behavioral;
