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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main_TB is
--  Port ( );
end main_TB;

architecture tb of main_TB is

    component tally
        port(
            scoresA,scoresB : in  std_logic_vector(2 downto 0);
            winner : out std_logic_vector(1 downto 0)
        );
    end component;
    
    signal testScoresA, testScoresB : std_logic_vector(2 downto 0);
    signal calculatedWinner : std_logic_vector(1 downto 0);
    signal realWinner : std_logic_vector(1 downto 0);

begin

DUT: tally port map (scoresA => testScoresA, scoresB => testScoresB, winner => calculatedWinner);

    process
    
    --Create array type
    type array2D is array(natural range <>) of integer; --1D
    --type array2D is array(natural range <>, natural range <>) of integer; --2D
    
    --Declare variables, constants
    variable W : integer := 0; --Integer to represent result


    --Create function 
    function calculateWinner( i: integer ; j: integer)
        return integer
    is
        variable result : integer;
        variable karnaugh_map: array2D(7 downto 0) := (2,   2,   2,   2,   2,   2,   2,   0); --1D
        --variable karnaugh_map: array2D(1 downto 0,1 downto 0) := (0,   2,   2,   2,   2,   2,   2,   2); --2D
    begin
        case j is                                           -- Karnaugh map has to be reversed here
            when 0 => karnaugh_map := (2,   2,   2,   2,   2,   2,   2,   0); --A  0   2   2   2   2   2   2   2
            when 1 => karnaugh_map := (2,   2,   2,   3,   2,   3,   3,   1); --B  1   3   3   2   3   2   2   2
            when 2 => karnaugh_map := (2,   2,   2,   3,   2,   3,   3,   1); --B  1   3   3   2   3   2   2   2
            when 3 => karnaugh_map := (2,   3,   3,   1,   3,   1,   1,   1); --C  1   1   1   3   1   3   3   2
            when 4 => karnaugh_map := (2,   2,   2,   3,   2,   3,   3,   1); --B  1   3   3   2   3   2   2   2
            when 5 => karnaugh_map := (2,   3,   3,   1,   3,   1,   1,   1); --C  1   1   1   3   1   3   3   2
            when 6 => karnaugh_map := (2,   3,   3,   1,   3,   1,   1,   1); --C  1   1   1   3   1   3   3   2
            when 7 => karnaugh_map := (3,   1,   1,   1,   1,   1,   1,   1); --D  1   1   1   1   1   1   1   3
            when others => karnaugh_map := (10,   10,   10,   10,   10,   10,   10,   10);
        end case;
        
        result := karnaugh_map(i); --Can only be 0, 1, 2 or 3; can be done with karnaugh_map or switchcase
        return result;
    end;
    
    
    --Begin process
    begin
        for i in 0 to 7 loop
            for j in 0 to 7 loop
            
                --Send test signals
                testScoresA <= std_logic_vector(to_unsigned(i, testScoresA'length));
                testScoresB <= std_logic_vector(to_unsigned(j, testScoresB'length));
                
                --Call test function 
                --assert calculateWinner(i,j)
                --W := calculateWinner(testScoresA,testScoresB); --calculateWinner(i,j);
                W := calculateWinner(i,j);
                        --report "ERROR"
                        --severity error;
                                
                realWinner <= std_logic_vector(to_unsigned(W, realWinner'length));
                
                wait for 5ns; -- give time for signals to change
            end loop;
        end loop;
     end process;
        
end tb;


-- KARNAUGH MAPS
--B\A 000 001 010 011 100 101 110 111
--000  00  10  10  10  10  10  10  10
--001  01  11  11  10  11  10  10  10
--010  01  11  11  10  11  10  10  10
--011  01  01  01  11  01  11  11  10
--100  01  11  11  10  11  10  10  10
--101  01  01  01  11  01  11  11  10
--110  01  01  01  11  01  11  11  10
--111  01  01  01  01  01  01  01  11

--B\A 000 001 010 011 100 101 110 111
--000   0   2   2   2   2   2   2   2
--001   1   3   3   2   3   2   2   2
--010   1   3   3   2   3   2   2   2
--011   1   1   1   3   1   3   3   2
--100   1   3   3   2   3   2   2   2
--101   1   1   1   3   1   3   3   2
--110   1   1   1   3   1   3   3   2
--111   1   1   1   1   1   1   1   3

--B\A   0   1   2   3   4   5   6   7
--  0   0   2   2   2   2   2   2   2
--  1   1   3   3   2   3   2   2   2
--  2   1   3   3   2   3   2   2   2
--  3   1   1   1   3   1   3   3   2
--  4   1   3   3   2   3   2   2   2
--  5   1   1   1   3   1   3   3   2
--  6   1   1   1   3   1   3   3   2
--  7   1   1   1   1   1   1   1   3

