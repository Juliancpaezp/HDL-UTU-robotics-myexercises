----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.09.2023 18:14:03
-- Design Name: 
-- Module Name: tally - loopy
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tally is
    Port ( scoresA : in STD_LOGIC_VECTOR (2 downto 0);
           scoresB : in STD_LOGIC_VECTOR (2 downto 0);
           winner : out STD_LOGIC_VECTOR (1 downto 0));
end tally;

architecture loopy of tally is
begin
    process 
        variable totalA : integer := 0;
        variable totalB : integer := 0;
    begin
        --Clear last iteration values for totalA and totalB
        totalA := 0;
        totalB := 0;
        
        -- for statement to sum up the votes for A and B
        for i in 0 to 2 loop
            
            -- summing up votes for A on value "totalA"
            if (scoresA(i) = '1') then
                totalA := totalA + 1;
            end if;
            
            -- summing up votes for B on value "totalB"
            if (scoresB(i) = '1') then
                totalB := totalB + 1;
            end if;
            
        end loop;
        
        -- Assinign a winner based on sum up results     
        if (totalA > totalB) then
            winner <= "10";
        end if;
        
        if (totalA < totalB) then
            winner <= "01";
        end if;
        
        if (totalA = totalB) then
            winner <= "11";
        end if;
        
        if (totalA = 0 and totalB = 0) then
            winner <= "00";
        end if;
        
    wait for 5ns;
    
    end process;
end loopy;
