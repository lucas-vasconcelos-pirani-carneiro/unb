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

    type FORMAT_RV is (R_type, I_type, S_type, SB_type, UJ_type, U_type);
    
    signal opcode : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal formato : FORMAT_RV;
    
begin

    opcode <= instr(6 downto 0);
    funct3 <= instr(14 downto 12);

    p_formato : process( opcode )
    begin
        if (opcode = "0000011") or (opcode = "0010011") or (opcode = "1100111") then
            formato <= I_type;

        elsif opcode = "0100011" then
            formato <= S_type;

        elsif opcode = "1100011" then
            formato <= SB_type;

        elsif opcode = "1101111" then
            formato <= UJ_type;

        elsif opcode = "0110111" then
            formato <= U_type;

        else
            formato <= R_type;
        
        end if;
    end process;
    
    p_gerador : process( opcode, formato, funct3, instr )
    begin
        case( formato ) is
        
            when I_type =>
                if (opcode = "0010011") and (funct3 = "101") and (instr(30) = '1') then
                    imm32 <= signed( resize(unsigned( instr(24 downto 20)), 32));
                else
                    imm32 <= resize( signed(instr(31 downto 20)), 32);
                end if;

            when S_type =>
                imm32 <= resize( signed(instr(31 downto 25) & instr(11 downto 7)), 32);

            when SB_type =>
                imm32 <= resize( signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'), 32 );

            when UJ_type =>
                imm32 <= resize( signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'), 32);

            when U_type =>
                imm32 <= signed( resize(unsigned(instr(31 downto 12) & "000000000000"), 32));

            when R_type =>
                imm32 <= (others => '0');

            when others => 
                imm32 <= (others => '0');
        
        end case ;
    end process;

end architecture rtl;
