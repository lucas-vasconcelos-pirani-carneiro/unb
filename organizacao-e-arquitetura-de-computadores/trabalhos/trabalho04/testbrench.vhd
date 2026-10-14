library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture tb of testbench is
    
    signal instr : std_logic_vector(31 downto 0);
    signal imm32 : signed(31 downto 0);

begin
    
    dut: entity work.genImm32
        port map 
        (
            instr => instr,
            imm32 => imm32
        );


    process
    
    begin
        
        -- add t0, zero, zero 0x000002b3 R-type inexiste: 0 0x00000000
        instr <= x"000002B3";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"00000000" report "Falhou: add (R-type)" severity error;

        -- lw t0, 16(zero) 0x01002283 I-type0 16     0x00000010
        instr <= x"01002283"; 
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"00000010" report "Falhou: lw (I-type0)" severity error;

        -- addi t1, zero, -100 0xf9c00313 I-type1 -100 0xFFFFFF9C
        instr <= x"F9C00313";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"FFFFFF9C" report "Falhou: addi (I-type1)" severity error;
        
        -- xori t0, t0, -1 0xfff2c293 I-type1 -1 0xFFFFFFFF
        instr <= x"FFF2C293";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"FFFFFFFF" report "Falhou: xori (I-type1)" severity error;

        -- addi t1, zero, 354 0x16200313 I-type1 354   0x00000162
        instr <= x"16200313";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"00000162" report "Falhou: addi (I-type1)" severity error;

        -- jalr zero, zero, 0x18 0x01800067 I-type2 24  0x00000018
        instr <= x"01800067";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"00000018" report "Falhou: jalr (I-type2)" severity error;

        -- srai t1, t2, 10 0x40a3d313 I-type* 10 0x0000000A
        instr <= x"40A3D313";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"0000000A" report "Falhou: srai (I-type*)" severity error;

        -- lui s0, 2 0x00002437 U-type 0x2000 0x00002000
        instr <= x"00002437";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"00002000" report "Falhou: lui (U-type)" severity error;

        -- sw t0, 60(s0) 0x02542e23 S-type 60 0x0000003C
        instr <= x"02542E23";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"0000003C" report "Falhou: sw (S-type)" severity error;

        -- bne t0, t0, main 0xfe5290e3 SB-type -32C 0xFFFFFFE0
        instr <= x"FE5290E3";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"FFFFFFE0" report "Falhou: bne (SB-type)" severity error;

        -- jal rot 0x00c000ef UJ-type 12 0x0000000C
        instr <= x"00C000EF";
        wait for 1 ns;
        assert std_logic_vector(imm32) = x"0000000C" report "Falhou: jal (UJ-type)" severity error;

        assert false report "Testes executados." severity note;
        wait;
    
    end process;

end architecture tb;
