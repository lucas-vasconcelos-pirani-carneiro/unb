def cifrador(texto, chave):
    resultado = []
    indice = 0
    texto = texto.upper()
    chave = chave.upper()
    for x in texto:
        if(x.isalpha()):
            newletter = (ord(x) - 65 + ord(chave[indice]) - 65) % 26
            resultado.append(chr(newletter + 65))
            indice = indice + 1
            if (indice >= len(chave)):
                indice = 0
        else:
            resultado.append(x)
    return "".join(resultado)

def decifrador(texto, chave):
    resultado = []
    indice = 0
    texto = texto.upper()
    chave = chave.upper()
    for x in texto:
        if(x.isalpha()):
            newletter = (ord(x) - ord(chave[indice])) % 26
            resultado.append(chr(newletter + 65))
            indice = indice + 1
            if(indice >= len(chave)):
                indice = 0
        else:
            resultado.append(x)
    return "".join(resultado)

print("ABCD")
test = cifrador("Muitas vezes, encarar o inicio de um projeto e como observar o mar em um dia de névoa: sabemos que a imensidão está lá, mas os contornos ainda são incertos. A página em branco não deve ser vista como um obstáculo, mas como um convite à liberdade.","agua")
print(test)
test2 = decifrador(test,'agua')
print(test2)
