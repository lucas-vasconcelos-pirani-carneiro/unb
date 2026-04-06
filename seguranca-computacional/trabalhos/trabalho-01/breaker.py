def ic(texto):
    texto = texto.upper()
    tamanho = len(texto)
    frequencia = {}
    for x in texto:
        frequencia[x] = frequencia.get(x, 0) + 1
    num = sum (f * (f-1) for f in frequencia.values())
    den = tamanho * (tamanho-1) 
    return num/den

def tamanho (texto , max_len = 20):
    texto = texto.upper()
    melhor_tam = 1
    maior_ic = 0
    for tam in range (1,max_len + 1):
        ics = []
        for x in range (tam):
            pedaco = texto[x::tam]
            ics.append(ic(pedaco))
        media_ic = sum(ics)/len(ics)
        
        if media_ic > maior_ic:
            maior_ic = media_ic
            melhor_tam = tam
    return melhor_tam

pt=[0.1463, 0.0104, 0.0388, 0.0499, 0.1257, 0.0102, 0.0130, 0.0128, 0.0618, 
    0.0040, 0.0002, 0.0278, 0.0474, 0.0505, 0.1073, 0.0252, 0.0120, 0.0653, 
    0.0781, 0.0434, 0.0463, 0.0167, 0.0001, 0.0021, 0.0001, 0.0047]

en=[0.0817, 0.0149, 0.0278, 0.0425, 0.1270, 0.0223, 0.0202, 0.0609, 0.0697, 
    0.0015, 0.0077, 0.0403, 0.0241, 0.0675, 0.0751, 0.0193, 0.0010, 0.0599, 
    0.0633, 0.0906, 0.0276, 0.0098, 0.0236, 0.0015, 0.0197, 0.0007]

def cesar(texto, n):
    resultado = ""
    for x in texto:
        num = (ord(x) - 65 - n) % 26
        resultado += chr(num + 65)
    return resultado

def chi_quadrado(pedaco, lingua):
    contagem = [0] * 26
    n = 0
    for x in pedaco:
        if 'A' <= x <= 'Z':
            contagem[ord(x) - 65] += 1
            n += 1 
    if n == 0: return 0 
    pontos = 0

    for x in range(26):
        pontos += (contagem[x] / n) * lingua[x]
    return pontos

def recuperar_chave(texto,tamanho, lingua):
    texto = texto.upper()
    chave = ""
    for x in range(tamanho):
        pedaco = texto[x::tamanho]
        melhorshift = 0
        maiorpontos = -1
        for y in range (26):
            tentativa = cesar(pedaco,y)
            pontos = chi_quadrado(tentativa,lingua)
            if pontos > maiorpontos:
                maiorpontos = pontos
                melhorshift = y
        chave += chr(melhorshift + 65)
    return chave

texto = "TCXXRTJVZLATRTBFRRVQCMTJCUEBUEVFKSKOLKDQFPPJEYDPVFNOIETCBHZBRVNLDDEJBPVMVAFYVBWDEUAXHRPSJTHTPQRTCJCVVISIOCJAPVSEJBCZNJMGXFTOOGANQCEVNPIAUKDRRPRVVLATVMJGKAJWBSLNCSSAIRYCPARSJWBSLNQFNCQIIRMWSEYLPHV"
tamanho = tamanho(texto,20)
chave = recuperar_chave(texto,tamanho,pt)
print(chave)
