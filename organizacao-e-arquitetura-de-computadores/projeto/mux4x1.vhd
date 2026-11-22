library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is
    port (
        I0, I1, I2, I3 : in  std_logic_vector (31 downto 0);
        S              : in  std_logic_vector (1 downto 0);
        Y              : out std_logic_vector(31 downto 0)
    );
end mux4x1;

architecture behavioral of mux4x1 is
begin
    process(I0, I1, I2, I3, S)
    begin
        case S is
            when "00"   => Y <= I0;
            when "01"   => Y <= I1;
            when "10"   => Y <= I2;
            when "11"   => Y <= I3;
            when others => Y <= '0';
        end case;
    end process;
end behavioral;

