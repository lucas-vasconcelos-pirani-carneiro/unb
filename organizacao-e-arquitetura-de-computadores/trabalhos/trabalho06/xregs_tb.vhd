library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xregs_tb is
end entity xregs_tb;

architecture test of xregs_tb is

    constant WSIZE : natural := 32;

    signal clk  : std_logic := '0';
    signal wren : std_logic := '0';

    signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
    signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
    signal rd  : std_logic_vector(4 downto 0) := (others => '0');

    signal data : std_logic_vector(WSIZE-1 downto 0) := (others => '0');

    signal ro1 : std_logic_vector(WSIZE-1 downto 0);
    signal ro2 : std_logic_vector(WSIZE-1 downto 0);

    signal clock_enable : boolean := true;

begin

    DUT: entity work.XREGS
        generic map (
            WSIZE => WSIZE
        )
        port map (
            clk  => clk,
            wren => wren,
            rs1  => rs1,
            rs2  => rs2,
            rd   => rd,
            data => data,
            ro1  => ro1,
            ro2  => ro2
        );

    clock_process : process
    begin
        while clock_enable loop
            clk <= '0';
            wait for 5 ns;

            clk <= '1';
            wait for 5 ns;
        end loop;

        -- Interrompe o clock
        clk <= '0';
        wait;
    end process;

    stimulus : process

        variable expected : std_logic_vector(WSIZE-1 downto 0);

    begin
        report "Teste 1: Tentativa de escrita em x0"
            severity note;

        wren <= '1';
        rd   <= "00000";
        data <= x"DEADBEEF";

        wait until rising_edge(clk);
        wait for 1 ns;

        rs1 <= "00000";
        rs2 <= "00000";

        wait for 1 ns;

        assert ro1 = x"00000000"
            report "ERRO: ro1 deveria retornar zero para x0"
            severity error;

        assert ro2 = x"00000000"
            report "ERRO: ro2 deveria retornar zero para x0"
            severity error;

        report "Teste 1 concluido"
            severity note;

        report "Teste 2: Preenchimento dos registradores"
            severity note;

        for i in 1 to 31 loop

            rd <= std_logic_vector(
                to_unsigned(i, rd'length)
            );

            data <= std_logic_vector(
                to_unsigned(i * 100 + 7, WSIZE)
            );

            wren <= '1';

            wait until rising_edge(clk);
            wait for 1 ns;

        end loop;

        report "Teste 2 concluido"
            severity note;

        report "Teste 3: Escrita desabilitada"
            severity note;

        wren <= '0';

        rd <= std_logic_vector(
            to_unsigned(5, rd'length)
        );

        data <= x"DEADBEEF";

        wait until rising_edge(clk);
        wait for 1 ns;

        rs1 <= std_logic_vector(
            to_unsigned(5, rs1'length)
        );

        wait for 1 ns;

        expected := std_logic_vector(
            to_unsigned(507, WSIZE)
        );

        assert ro1 = expected
            report "ERRO: x5 foi alterado com wren = 0"
            severity error;

        report "Teste 3 concluido"
            severity note;


        report "Teste 4: Verificacao das portas de leitura"
            severity note;

        wren <= '0';

        for i in 1 to 31 loop

            rs1 <= std_logic_vector(
                to_unsigned(i, rs1'length)
            );

            rs2 <= std_logic_vector(
                to_unsigned(32 - i, rs2'length)
            );

            wait for 1 ns;

            expected := std_logic_vector(
                to_unsigned(i * 100 + 7, WSIZE)
            );

            assert ro1 = expected
                report "ERRO na leitura de ro1, registrador x"
                       & integer'image(i)
                severity error;

            expected := std_logic_vector(
                to_unsigned((32 - i) * 100 + 7, WSIZE)
            );

            assert ro2 = expected
                report "ERRO na leitura de ro2, registrador x"
                       & integer'image(32 - i)
                severity error;

        end loop;

        report "Teste 4 concluido"
            severity note;

        report "Teste 5: Verificacao final de x0"
            severity note;

        rs1 <= "00000";
        rs2 <= "00000";

        wait for 1 ns;

        assert ro1 = x"00000000"
            report "ERRO: ro1 nao retornou zero para x0"
            severity error;

        assert ro2 = x"00000000"
            report "ERRO: ro2 nao retornou zero para x0"
            severity error;

        report "Teste 5 concluido"
            severity note;


        report "todos os testes foram executados."
            severity note;

        -- Desabilita a geracao do clock
        clock_enable <= false;

        wait for 1 ns;

        report "Fim do testbench."
            severity note;

        wait;

    end process;

end architecture test;
