library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genImm32 is
    port 
    ( 
        instr : in std_logic_vector(31 downto 0); 
        imm32 : out signed(31 downto 0)
    );
end genImm32;

architecture rtl of genImm32 is

    signal opcode : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);

begin
    opcode <= instr(6 downto 0);
    funct3 <= instr(14 downto 12);

    identifier : process( opcode, funct3, instr )

    begin
        
        imm32 <= (others => '0');
        
        if (opcode = "0010011") and (funct3 = "101") and ( instr(30) = '1' ) then -- Tipo-I*
            imm32 <= signed( resize( unsigned( instr(24 downto 20) ), 32));
        
        elsif (opcode = "0000011") or (opcode = "0010011") or (opcode = "1100111") then -- Tipo-I
            imm32 <= resize( signed( instr(31 downto 20) ), 32); 
                    
        elsif (opcode = "0100011") then -- Tipo-S
            imm32 <= resize( signed( instr(31 downto 25) & instr(11 downto 7) ), 32);

        elsif (opcode = "1100011") then -- Tipo-SB
            imm32 <= resize( signed( instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32);

        elsif (opcode = "1101111") then -- Tipo-UJ
            imm32 <= resize( signed( instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32);

        elsif (opcode = "0110111") then -- Tipo-U
            imm32 <= signed( resize( unsigned( instr(31 downto 12) & "000000000000" ), 32));

        else
            imm32 <= (others => '0'); -- Tipo-R
        
        end if;

    end process;
    
end architecture rtl;
