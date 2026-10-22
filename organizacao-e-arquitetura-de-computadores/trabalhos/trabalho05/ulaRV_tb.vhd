library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV_tb is
end ulaRV_tb;

architecture tb of ulaRV_tb is
    constant WSIZE : natural := 32;

    signal opcode : std_logic_vector(3 downto 0);
    signal A, B   : std_logic_vector(WSIZE - 1 downto 0);
    signal Z      : std_logic_vector(WSIZE - 1 downto 0);
    signal cond   : std_logic;

begin

    dut : entity work.ulaRV
        generic map ( WSIZE => WSIZE )
        port map 
        (
            opcode => opcode,
            A      => A,
            B      => B,
            Z      => Z,
            cond   => cond
        );

    process
    begin
        -- ADD: resultado positivo (5 + 3 = 8)
        opcode <= "0000";
        A <= std_logic_vector(to_signed(5, WSIZE));
        B <= std_logic_vector(to_signed(3, WSIZE));
        wait for 1 ns;
        assert Z = x"00000008" and cond = '0'
            report "Falhou: ADD com resultado positivo"
            severity error;

        -- ADD: resultado zero (5 + -5 = 0)
        opcode <= "0000";
        A <= std_logic_vector(to_signed(5, WSIZE));
        B <= std_logic_vector(to_signed(-5, WSIZE));
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: ADD com resultado zero"
            severity error;

        -- ADD: resultado negativo (-5 + -3 = -8)
        opcode <= "0000";
        A <= std_logic_vector(to_signed(-5, WSIZE));
        B <= std_logic_vector(to_signed(-3, WSIZE));
        wait for 1 ns;
        assert Z = x"FFFFFFF8" and cond = '0'
            report "Falhou: ADD com resultado negativo"
            severity error;

        -- SUB: resultado positivo (5 - 3 = 2)
        opcode <= "0001";
        A <= std_logic_vector(to_signed(5, WSIZE));
        B <= std_logic_vector(to_signed(3, WSIZE));
        wait for 1 ns;
        assert Z = x"00000002" and cond = '0'
            report "Falhou: SUB com resultado positivo"
            severity error;

        -- SUB: resultado zero (5 - 5 = 0)
        opcode <= "0001";
        A <= std_logic_vector(to_signed(5, WSIZE));
        B <= std_logic_vector(to_signed(5, WSIZE));
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SUB com resultado zero"
            severity error;

        -- SUB: resultado negativo (3 - 5 = -2)
        opcode <= "0001";
        A <= std_logic_vector(to_signed(3, WSIZE));
        B <= std_logic_vector(to_signed(5, WSIZE));
        wait for 1 ns;
        assert Z = x"FFFFFFFE" and cond = '0'
            report "Falhou: SUB com resultado negativo"
            severity error;

        -- AND
        opcode <= "0010";
        A <= x"F0F0A55A";
        B <= x"0FF00FF0";
        wait for 1 ns;
        assert Z = x"00F00550" and cond = '0'
            report "Falhou: AND"
            severity error;

        -- OR
        opcode <= "0011";
        A <= x"F0F0A55A";
        B <= x"0FF00FF0";
        wait for 1 ns;
        assert Z = x"FFF0AFFA" and cond = '0'
            report "Falhou: OR"
            severity error;

        -- XOR
        opcode <= "0100";
        A <= x"F0F0A55A";
        B <= x"0FF00FF0";
        wait for 1 ns;
        assert Z = x"FF00AAAA" and cond = '0'
            report "Falhou: XOR"
            severity error;

        -- SLL: desloca 1 quatro posições à esquerda
        opcode <= "0101";
        A <= x"00000001";
        B <= x"00000004";
        wait for 1 ns;
        assert Z = x"00000010" and cond = '0'
            report "Falhou: SLL"
            severity error;

        -- SRL: deslocamento lógico à direita, preenche com zeros
        opcode <= "0110";
        A <= x"80000001";
        B <= x"00000001";
        wait for 1 ns;
        assert Z = x"40000000" and cond = '0'
            report "Falhou: SRL"
            severity error;

        -- SRA: deslocamento aritmético à direita, preserva o sinal
        opcode <= "0111";
        A <= x"80000001";
        B <= x"00000001";
        wait for 1 ns;
        assert Z = x"C0000000" and cond = '0'
            report "Falhou: SRA"
            severity error;

        -- SLT: comparação com sinal verdadeira (-1 < 1)
        opcode <= "1000";
        A <= std_logic_vector(to_signed(-1, WSIZE));
        B <= std_logic_vector(to_signed(1, WSIZE));
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SLT verdadeira"
            severity error;

        -- SLT: comparação com sinal falsa (5 < 3)
        opcode <= "1000";
        A <= std_logic_vector(to_signed(5, WSIZE));
        B <= std_logic_vector(to_signed(3, WSIZE));
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SLT falsa"
            severity error;

        -- SLTU: comparação sem sinal verdadeira (1 < FFFFFFFF)
        opcode <= "1001";
        A <= x"00000001";
        B <= x"FFFFFFFF";
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SLTU verdadeira"
            severity error;

        -- SLTU: comparação sem sinal falsa (FFFFFFFF < 1)
        opcode <= "1001";
        A <= x"FFFFFFFF";
        B <= x"00000001";
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SLTU falsa"
            severity error;

        -- SGE: comparação com sinal verdadeira (1 >= -1)
        opcode <= "1010";
        A <= std_logic_vector(to_signed(1, WSIZE));
        B <= std_logic_vector(to_signed(-1, WSIZE));
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SGE verdadeira"
            severity error;

        -- SGE: comparação com sinal falsa (-1 >= 1)
        opcode <= "1010";
        A <= std_logic_vector(to_signed(-1, WSIZE));
        B <= std_logic_vector(to_signed(1, WSIZE));
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SGE falsa"
            severity error;

        -- SGEU: comparação sem sinal verdadeira (FFFFFFFF >= 1)
        opcode <= "1011";
        A <= x"FFFFFFFF";
        B <= x"00000001";
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SGEU verdadeira"
            severity error;

        -- SGEU: comparação sem sinal falsa (1 >= FFFFFFFF)
        opcode <= "1011";
        A <= x"00000001";
        B <= x"FFFFFFFF";
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SGEU falsa"
            severity error;

        -- SEQ: operandos iguais
        opcode <= "1100";
        A <= x"12345678";
        B <= x"12345678";
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SEQ verdadeira"
            severity error;

        -- SEQ: operandos diferentes
        opcode <= "1100";
        A <= x"12345678";
        B <= x"12345679";
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SEQ falsa"
            severity error;

        -- SNE: operandos diferentes
        opcode <= "1101";
        A <= x"12345678";
        B <= x"12345679";
        wait for 1 ns;
        assert Z = x"00000001" and cond = '1'
            report "Falhou: SNE verdadeira"
            severity error;

        -- SNE: operandos iguais
        opcode <= "1101";
        A <= x"12345678";
        B <= x"12345678";
        wait for 1 ns;
        assert Z = x"00000000" and cond = '0'
            report "Falhou: SNE falsa"
            severity error;

        assert false
            report "Todos os testes foram executados."
            severity note;
        wait;
    end process;

end architecture tb;
