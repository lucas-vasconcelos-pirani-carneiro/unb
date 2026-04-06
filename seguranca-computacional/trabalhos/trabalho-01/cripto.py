def limpar(texto):
    # Limpar o texto
    return "".join([x for x in texto.upper() if x.isalpha()])

def cifrador(texto, chave):
    # Criptografia
    resultado = []
    indice = 0
    texto = texto.upper()
    chave = chave.upper()

    for x in texto:
        if x.isalpha():
            newletter = (ord(x) - 65 + ord(chave[indice]) - 65) % 26
            resultado.append(chr(newletter + 65))
            indice = (indice + 1) % len(chave)
        else:
            resultado.append(x)

    return "".join(resultado)


def decifrador(texto, chave):
    # Descriptografia
    resultado = []
    indice = 0
    texto = texto.upper()
    chave = chave.upper()

    for x in texto:
        if x.isalpha():
            newletter = (ord(x) - 65 - (ord(chave[indice]) - 65)) % 26
            resultado.append(chr(newletter + 65))
            indice = (indice + 1) % len(chave)
        else:
            resultado.append(x)

    return "".join(resultado)
