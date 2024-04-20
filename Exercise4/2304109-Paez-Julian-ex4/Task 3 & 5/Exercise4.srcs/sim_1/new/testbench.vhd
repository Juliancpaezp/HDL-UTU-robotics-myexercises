----------------------------------------------------------------------------------
-- Company: University of Turku
-- Engineer: Julian Camilo Paez Piñeros
-- 
-- Create Date: Nov 1th 2023
-- Design Name: First attempt
-- Module Name: testbench - Behavioral
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

-- Aca pondria las entradas y salidas pero las test bench no llevan entradas ni salidas
entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

    -- Aca si van las entradas y salidas simuladas main
    component Timer
        port(
            CLOCK, sim_switch, speed1 : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_out : inout std_logic := '0'; -- Frecuency divider output
            Output_CLOCK  : out   std_logic := '0' -- CLOCK viewer
        ); 
    end component;
    
    component LED_Driver
        port(
            CLOCK, backwards, reset : in std_logic;  --CLOCK is input and comes from GLCK on Zedboard
            my_clock_in : in std_logic := '0'; -- Frecuency divider input
            PWM_1    : out   std_logic := '0'; -- Output to send to LED 1
            PWM_2    : out   std_logic := '0'; -- Output to send to LED 2
            PWM_3    : out   std_logic := '0'; -- Output to send to LED 3
            state_v  : out   STD_LOGIC_VECTOR(2 downto 0) := "000"
        ); 
    end component;

-- Aca van las señales de prueba a generar con esta test bench
-- Tambien aca se define el orden de como se muestran en la sim
    signal CLOCK_t      : std_logic;
    signal my_clock_t   : std_logic;
    signal sim_switch_t : std_logic := '1'; -- SIM mode enabled
    signal reset_t      : std_logic := '1';
    signal speed1_t     : std_logic := '0';
    --signal speed2_t     : std_logic := '0';
    signal backwards_t  : std_logic := '0';
    signal PWM_1_t      : std_logic;
    signal PWM_2_t      : std_logic;
    signal PWM_3_t      : std_logic;
    signal state_v_t    : STD_LOGIC_VECTOR(2 downto 0);

begin

-- Aca se conectan las entradas simuladas con las variables dentro
-- de la simulacion y los valores de main al mismo tiempo o eso creo
DUT_Timer: Timer port map (
    CLOCK      => CLOCK_t,
    speed1    => speed1_t,
    sim_switch => sim_switch_t,
    my_clock_out  => my_clock_t
);

DUT_LED_Driver: LED_Driver port map (
    CLOCK     => CLOCK_t,
    my_clock_in  => my_clock_t,
    --speed1    => speed1_t,
    --speed2    => speed2_t,
    reset     => reset_t,
    backwards => backwards_t,
    PWM_1     => PWM_1_t,
    PWM_2     => PWM_2_t,
    PWM_3     => PWM_3_t,
    state_v   => state_v_t
);

process
      
    -- Declare variables, constants here
    variable current_time : integer := 0;
    --variable mode_rem : integer := 0;

    -- Begin process
    begin
        
        current_time := current_time + 1; -- Add one each 10 ns, or each clock cycle
        
        -- Reset is 1 and then 0
        if current_time > 10_000 then reset_t <= '0'; end if;
        
        -- Speed tester
        if current_time > 102_000 then speed1_t <= '1'; end if; 
        --if current_time = 522_522 then speed2_t <= '1'; end if; 
        
        -- Loop is in continuos mode with 0 and backwards mode with 1
        if current_time > 183_000 then backwards_t <= '1'; end if; 
        --mode_rem := current_time rem 200_000;
        --if mode_rem = 199_999 then backwards_t <= not backwards_t; end if;
        
        -- Create simulated on-board clock
        for i in std_logic range '0' to '1' loop
            CLOCK_t <= i; 
            wait for 5ns; -- then 10 nanoseconds for one cycle to complete at a clock frequency of 100MHz
        end loop;
        
     end process;
        
end Behavioral;