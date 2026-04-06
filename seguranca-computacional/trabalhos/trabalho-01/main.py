from cripto import cifrador, decifrador, limpar
from breaker import descobrir_tamanho, recuperar_chave, reduzir_chave, pt

if __name__ == "__main__":

    texto_original = """Muitas vezes, encarar o inicio de um projeto e como observar o mar em um dia de nevoa.
    A criptografia e uma area fundamental da computacao que permite proteger informacoes contra acessos nao autorizados.
    Desde a antiguidade tecnicas de cifra tem sido utilizadas para garantir a confidencialidade de mensagens.""" * 5

    chave_real = "AGUA"

    print("Texto Original:")
    print(texto_original)

    # 1. Cifrar/Criptografar
    cifrado = cifrador(texto_original, chave_real)
    print("\nTexto Cifrado:")
    print(cifrado)

    # 2. Decifrar/Descriptografar
    decifrado = decifrador(cifrado, chave_real)
    print("\nDecifrar:")
    print(decifrado)

    # 3. Limpar Texto
    texto_limpo = limpar(cifrado)

    # 4. Descobrit o tamanho da chave
    tam = descobrir_tamanho(texto_limpo)
    print("\nTamanho Estimado:")
    print(tam)

    # 5. Recuperar a chave
    chave_descoberta = recuperar_chave(texto_limpo, tam, pt)
    chave_final = reduzir_chave(chave_descoberta)
    print("\nChave Descoberta:")
    print(chave_final)

    # 6. Descriptogrfar/decifrar sem saber a chave
    texto_quebrado = decifrador(cifrado, chave_descoberta)
    print("\nTexto Quebradado:")
    print(texto_quebrado)
