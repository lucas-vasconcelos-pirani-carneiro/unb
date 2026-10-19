library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV is 
    generic (WSIZE : natural := 32); 
    port 
    (
        opcode : in std_logic_vector(3 downto 0);
        A, B   : in std_logic_vector(WSIZE - 1 downto 0);
        Z      : out std_logic_vector(WSIZE - 1 downto 0);
        cond   : out std_logic
    );
end ulaRV;

architecture behavioral of ulaRV is

    -- Opcode das operações
    constant ADD_OP : std_logic_vector(3 downto 0) := "0000";
    constant SUB_OP : std_logic_vector(3 downto 0) := "0001";
    constant AND_OP : std_logic_vector(3 downto 0) := "0010";
    constant OR_OP : std_logic_vector(3 downto 0) := "0011";
    constant XOR_OP : std_logic_vector(3 downto 0) := "0100";
    constant SLL_OP : std_logic_vector(3 downto 0) := "0101";
    constant SRL_OP : std_logic_vector(3 downto 0) := "0110";
    constant SRA_OP : std_logic_vector(3 downto 0) := "0111";
    constant SLT_OP : std_logic_vector(3 downto 0) := "1000";
    constant SLTU_OP : std_logic_vector(3 downto 0) := "1001";
    constant SGE_OP : std_logic_vector(3 downto 0) := "1010";
    constant SGEU_OP : std_logic_vector(3 downto 0) := "1011";
    constant SEQ_OP : std_logic_vector(3 downto 0) := "1100";
    constant SNE_OP : std_logic_vector(3 downto 0) := "1101";

    -- Sinal Intermediário
    signal a32 : std_logic_vector(WSIZE - 1 downto 0);

begin

    proc_ula : process( A, B, opcode)
    begin
        
        cond <= '0';

        case( opcode ) is
        
            when ADD_OP =>
                a32 <= std_logic_vector(signed(A) + signed(B)); 

            when SUB_OP =>
                a32 <= std_logic_vector(signed(A) - signed(B)); 
    
            when AND_OP =>
                a32 <= A and B;
        
            when OR_OP =>
                a32 <= A or B;

            when XOR_OP =>
                a32 <= A xor B;

            when SLL_OP =>
                a32 <= std_logic_vector( shift_left( unsigned(A), to_integer( unsigned( B(4 downto 0) ) ) ) );

            when SRL_OP =>
                a32 <= std_logic_vector(shift_right(unsigned(A), to_integer( unsigned( B(4 downto 0) ) )));

            when SRA_OP =>
                a32 <= std_logic_vector(shift_right(signed(A), to_integer( unsigned( B(4 downto 0) ) )));

            when SLT_OP =>
                if signed(A) < signed(B) then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when SLTU_OP =>
                if unsigned(A) < unsigned(B) then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when SGE_OP =>
                if signed(A) >= signed(B) then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when SGEU_OP =>
                if unsigned(A) >= unsigned(B) then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when SEQ_OP =>
                if A = B then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when SNE_OP =>
                if A /= B then
                    a32 <= (others => '0');
                    a32(0) <= '1';
                    cond <= '1';
                else
                    a32 <= (others => '0');
                    cond <= '0';
                end if;

            when others => -- Não sei o que colocar aqui
                a32 <= (others => '0');

        end case ;

        if a32 = x"00000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;

    end process ; -- proc_ula

    Z <= a32;
    
end behavioral ; -- behavioral
