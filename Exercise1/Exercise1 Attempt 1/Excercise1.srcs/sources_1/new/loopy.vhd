----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2023 13:43:02
-- Design Name: 
-- Module Name: tally - Behavioral
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

entity tally is
    port ( 
            scoresA,scoresB : in STD_LOGIC_VECTOR (2 downto 0);
            winner : out STD_LOGIC_VECTOR (1 downto 0)
    );
end entity;

architecture loopy of tally is
        
    signal sumOfBitsA  : STD_LOGIC_VECTOR(2 downto 0);
        
begin
        process(scoresA,scoresB)
        begin
            sumOfBitsA  <= scoresA(0) & scoresA(1) & scoresA(2);
            winner <= sumOfBitsA;
        end process;
end loopy;
