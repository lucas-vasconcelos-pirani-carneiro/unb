library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
    port (
    	S : in std_logic;
	    A, B : in std_logic_vector (31 downto 0);
    	Y : out std_logic_vector (31 downto 0)
    );
end entity mux2x1;

architecture behavioral of mux2x1 is
    begin
	
    process (S, A, B)
	begin
        if S = '0' then
	        Y <= A;
	    else
	        Y <= B;
	    end if;     
    end process;
end behavioral;
