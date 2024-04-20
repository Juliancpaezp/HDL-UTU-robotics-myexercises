----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2023 19:07:27
-- Design Name: 
-- Module Name: loopyTestBench - Behavioral
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

entity loopyTestBench is
--  Port ( );
end loopyTestBench;

architecture Behavioral of loopyTestBench is
    
    component tally
        port(
           scoresA0,scoresA1,scoresA2 : in STD_LOGIC;
           winner : out STD_LOGIC 
        );
    end component;
    
    signal testA0, testA1, testA2, winnerT : STD_LOGIC;
    
begin

    DUT: tally port map ( scoresA0 => testA0, scoresA1 => testA1, scoresA2 => testA2, winner => winnerT );
    
   
    process
    begin
        for i in std_logic range '0' to '1' loop
            for j in std_logic range '0' to '1' loop
                for k in std_logic range '0' to '1' loop
                    testA0 <= i;
                    testA1 <= j;
                    testA2 <= k;
                    wait for 10ns;
                    --assert test_Z = (i or j)
                    --    report "ERROR"
                    --    severity error;
                end loop;
            end loop;
        end loop;
    end process; 
    
end Behavioral;
