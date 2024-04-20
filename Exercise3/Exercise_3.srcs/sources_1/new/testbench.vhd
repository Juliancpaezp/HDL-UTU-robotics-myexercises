----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2023 21:39:59
-- Design Name: 
-- Module Name: main_TB - Behavioral
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

-- USE SIM TOTAL TIME OF 22000ns

-- Aca pondria las entradas y salidas pero las test bench no llevan entradas ni salidas
entity main_TB is
--  Port ( ); --NOTHING HERE c:
end main_TB;

architecture tb of main_TB is
    
    -- Aca si van las entradas y salidas simuladas
    component main
        port(
            load, reset, enable, CLOCK : in std_logic;  --INPUT MUST BE CLOCK SIGNAL, GLCK
            down     : in std_logic := '0'; -- Inout as I want to read from it to modify conunter behavior and also write to it, as signal because I want to see it on simulation
            data     : in    STD_LOGIC_VECTOR(7 downto 0);
            over     : out   std_logic := '0';
            my_clock : inout std_logic := '0';
            LEDS     : out STD_LOGIC_VECTOR(7 downto 0); -- Counter range goes from 00 to FF.
            LEDS1    : out   STD_LOGIC_VECTOR(3 downto 0);
            LEDS2    : out   STD_LOGIC_VECTOR(3 downto 0);
            PWM      : out   std_logic := '0'
        );
    end component;
    
    -- Aca van las señales de prueba
    signal CLOCK_test  : std_logic;
    signal my_clock_test : std_logic;
    signal down_test, enable_test : std_logic := '0';
    signal load_test, reset_test : std_logic := '1';  -- Start as 0 to show funcionality and then be 1 the rest of the simulation
    signal over_test   : std_logic;
    signal data_test   : STD_LOGIC_VECTOR(7 downto 0);
    signal LEDS_test   : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal LEDS1_test  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal LEDS2_test  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal PWM_test    : std_logic;


begin

-- Aca se conectan las entradas simuladas con las variables dentro de la simulacion y los valores de main al mismo tiempo o eso creo
DUT: main port map (
                        CLOCK  => CLOCK_test,
                        my_clock  => my_clock_test,
                        enable => enable_test,
                        reset => reset_test,
                        load => load_test,
                        down => down_test,
                        data => data_test,
                        over => over_test,
                        LEDS => LEDS_test,
                        LEDS1 => LEDS1_test,
                        LEDS2 => LEDS2_test,
                        PWM => PWM_test
                   );

    process
      
    -- Declare variables, constants here
    --variable W : integer := 0;
       
    -- Begin process
    begin
        
        -- Test load, reset, downup and enable funcionality, 
        reset_test  <= '0' after 1250 ns; -- Show reset funcionaloty on first ns
        enable_test <= '1' after 500 ns; -- Show disable funcionaloty on first ns
        down_test   <= '1' after 11420 ns; -- Show test funcionaloty on first 1030 ns, now it changes auto
        
        -- Test data input
        load_test <= '0' after 2050 ns; -- Show test funcionaloty on frist ns
        data_test <= "11001000"; --0x200 is 0b11001000
        
        -- Create simulated on-board clock
        for i in std_logic range '0' to '1' loop
        
            --Send test signals
            CLOCK_test <= i;
                            
            --Call test function 
            --assert function(i,j)
                    --report "ERROR"
                    --severity error;
            
            wait for 1ns; -- Give time for signals to change 
        end loop;
        
     end process;
        
end tb;


