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
-- ------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Aca pondria las entradas y salidas pero las test bench no llevan entradas ni salidas
entity main_TB is
--  Port ( ); --NOTHING HERE c:
end main_TB;

architecture tb of main_TB is
    
    -- Aca si van las entradas y salidas simuladas
    component main
        port(
           CLOCK, down, load, reset, enable : in  std_logic;
           my_clock : inout std_logic := '0';
           data : in  STD_LOGIC_VECTOR(3 downto 0);
           over : out std_logic := '0';
           LEDS : out STD_LOGIC_VECTOR(3 downto 0) := "0000" --;
        );
    end component;
    
    -- Aca van las señales de prueba

    signal CLOCK_test, my_clock_test, enable_test, down_test : std_logic := '0';
    signal reset_test, load_test : std_logic := '1'; -- Start as 1 to show funcionality and then be 0 the rest of the simulation
    signal LEDS_test  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal over_test  : std_logic;
    signal data_test  : STD_LOGIC_VECTOR(3 downto 0);

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
                        LEDS => LEDS_test
                   );

    process
      
    -- Declare variables, constants here
    --variable W : integer := 0;
       
    -- Begin process
    begin
        
        -- Test load, reset, downup and enable funcionality, 
        enable_test <= '1' after 7 ns; 
        reset_test  <= '0' after 20 ns; 
        down_test   <= '1' after 325 ns; 
        
        -- Test data input
        load_test <= '0' after 30 ns; 
        data_test <= "1010";
        
        -- Create simulated on-board clock
        for i in std_logic range '0' to '1' loop
                    
            CLOCK_test <= i; --Send test signals 
            wait for 5ns; -- give time for signals to change
            
        end loop;
        
     end process;
        
end tb;


