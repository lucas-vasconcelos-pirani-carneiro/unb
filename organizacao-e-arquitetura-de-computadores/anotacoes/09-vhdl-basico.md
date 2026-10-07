# VHDL Básico

## Introdução

### VHDL
- VHSIC Hardware Description Language
- VHSIC: Very High Speed Integrated Circuits

### Origem
Departamento de defesa dos EUA
- Desenvolvida entre os anos 70 e 80
- Descrever e modelar circuitos complexos de forma padronizada
- Voltada inicialmente para simulação de circuitos

## Entidade
Descreve o **nome** e as **entradas e saídas** dos módulos.

```vhdl
entity somador is 
    port ( 
        A, B : in std_logic_vector (7 downto 0); 
        S    : out std_logic_vector (7 downto 0) 
    ); 
end entity;
```

## Arquitetura
Descreve o **comportamento ou estrutura** do módulo.

```vhdl
architecture rtl of somador is 
begin 
    S <= A + B; 
end architecture;
```

## Lógica Combinacional
**Saídas** definidas pelos valores nas **entradas apenas**, sem estados internos.
- Somadores 
- Multiplexadores 
- Decodificadores 
- Operadores lógicos 
- ULA

### Comando WHEN-ELSE 
Comando **concorrente**, no corpo da arquitetura.

```vhdl
Y <= A when SEL = '0' 
    else B;

Y <= A when SEL = "00" else  
     B when SEL = "01" else 
     C when SEL = "10" else 
     "00000000";
```

### Comando WITH-SELECT 
Comando **concorrente**, no corpo da arquitetura.

```vhdl
with SEL select 
    Y <= A when "00", 
         B when "01", 
         C when "10", 
         D when others;
```

## Processo Combinacional 
Um processo define um escopo com **comandos sequenciais** 
- Comandos são avaliados sequencialmente.

```vhdl
process(A,B,C) 
begin 
    Y <= (A and B) or C; 
end process;
```

### IF-THEN-ELSE

```vhdl
process(A,B,SEL) 
begin 
    if SEL = '0' then 
        Y <= A; 
    else 
        Y <= B; 
    end if; 
end process;
```

### CASE-WHEN 

```vhdl
case OPCODE is 
    when "00" => Y <= A + B; 
    when "01" => Y <= A - B; 
    when "10" => Y <= A and B; 
    when others => Y <= (others => '0'); 
end case;
```

## Evitar Latches: 

```vhdl
process(cod, ent)  
begin  
    if (cond = '1')  
        then sai <= ent;  
        -- Erro: Falta o 'else'. E se con for '0'?  
        -- O circuito guarda o valor anterior (Latch).  
    end if;  
end process;
```


### IF-THEN-ELSE Incompleto

```vhdl
process(cod, ent)  
begin  
    if (cond = '1')  
        then sai <= ent;  
        else sai <= not(ent);  
    end if;  
end process;

-- Outra forma
process(cod, ent)  
begin  
    sai <= not(ent); 
    if (cond = '1')  
        then sai <= ent;  
    end if;  
end process;
```

### CASE-WHEN Incompleto

```vhdl
process(sel, ent)  
begin  
    case sel is  
        when "00" => saida <= ent;  
        when "01" => saida <= not ent;  
        -- Erro: e se sel for "10" ou "11"?  
        -- ou meta-valores (como 'X', 'U', 'Z')?  
    end case;  
end process;

-- Como Corrigir
process(sel, ent)  
begin  
    case sel is  
        when "00" => saida <= ent;  
        when "01" => saida <= not ent;  
        when others => saida <= (others <= '0'); 
    end case;  
end process;
```

## Registradores
Armazena **dado na subida do relógio**:

```vhdl
process(clk) 
begin 
    if rising_edge(clk) then 
        Q <= D; 
    end if; 
end process;
```

Com ***reset*** **assíncrono**:

```vhdl
process(clk,reset) 
begin 
    if reset = '1' then 
        Q <= (others => '0'); 
    elsif rising_edge(clk) then 
        Q <= D; 
    end if; 
end process;
```

Com ***reset*** **síncrono**:

```vhdl
process(clk,reset) 
begin 
    if rising_edge(clk) then 
        if reset = '1' then 
            Q <= (others => '0'); 
        else Q <= D; 
    end if; 
end process;
```

Com habilitação de escrita:

```vhdl
process(clk) 
begin 
    if rising_edge(clk) then 
        if WEN = '1' then 
            Q <= D; 
        end if; 
    end if; 
end process;
```

### Banco de Registradores
**Exemplo:** 16 registradores de 16 bits.

```vhdl
type reg_array is array(0 to 15) 
    of std_logic_vector(15 downto 0); 
signal breg : reg_array;
```

**Escrita** no Banco: 
- `wradd`: Índice do registrador a ser escrito. 
- `we`: write enable.

```vhdl
process(clk) 
begin 
    if rising_edge(clk) then 
        if we='1' then 
            breg(wradd) <= WR_DATA; 
        end if; 
    end if; 
end process;
```

**Leitura** do Banco: 
- `radd`: Índice do registrador a ser lido. 
- `rdata`: Saída do banco.

```vhdl
process(clk) 
begin 
    rdata <= breg(radd);  
end process;
```

## Testbench
**Estrutura:** 
- Instância do módulo (DUT - Device under Test) 
- Geração de clock 
- Geração de estímulos 
- Verificação dos resultados

```vhdl
-- Declara DUT
entity tb is 
end entity; 

architecture a of tb is 
    signal clk : std_logic :=  '0'; 
    signal a, b : std_logic_vector (15 downto 0); 
    signal s : std_logic_vector (15 downto 0); 
    
    component somador is 
        port (  
            a, b: in std_logic_vector (15 downto 0); 
            s : out std_logic_vector (15 downto 0)
        ) 
    end component; 

-- Instancia DUT
begin 
    dut: somador  
        port map ( 
        a => a, 
        b => b, 
        s => s 
    );

    -- Geração de clock
    clk <= not clk after 5 ns;
 
end;
```

### Geração de Estímulos

```vhdl
process 
begin 
    A <= x"05"; 
    B <= x"03"; 
    
    wait for 100 ns; 
    
    A <= x"10"; 
    B <= x"20"; 
    
    wait; 

end process;
```

### Assert
**Verificando os resultados** com assert:

```vhdl
process 
begin 
    A <= x"05"; 
    B <= x"03"; 
    
    wait for 100 ns; 
    
    assert s = x"08" 
        report “Erro somador” 
        severity error; 
    
    wait; 
end process;
```
