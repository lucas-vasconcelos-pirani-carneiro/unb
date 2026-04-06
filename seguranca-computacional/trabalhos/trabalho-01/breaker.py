# Frequeências em diferentes idiomas

pt = [0.1463, 0.0104, 0.0388, 0.0499, 0.1257, 0.0102, 0.0130, 0.0128, 0.0618,
      0.0040, 0.0002, 0.0278, 0.0474, 0.0505, 0.1073, 0.0252, 0.0120, 0.0653,
      0.0781, 0.0434, 0.0463, 0.0167, 0.0001, 0.0021, 0.0001, 0.0047]

en=[0.0817, 0.0149, 0.0278, 0.0425, 0.1270, 0.0223, 0.0202, 0.0609, 0.0697, 
    0.0015, 0.0077, 0.0403, 0.0241, 0.0675, 0.0751, 0.0193, 0.0010, 0.0599, 
    0.0633, 0.0906, 0.0276, 0.0098, 0.0236, 0.0015, 0.0197, 0.0007]

# Índice de Coincidência

def ic(texto):
    texto = [x for x in texto if x.isalpha()]
    tamanho = len(texto)

    if tamanho <= 1:
        return 0

    frequencia = {}
    for x in texto:
        frequencia[x] = frequencia.get(x, 0) + 1

    num = sum(f * (f - 1) for f in frequencia.values())
    den = tamanho * (tamanho - 1)

    return num / den


def descobrir_tamanho(texto, max_len=20):
    melhor_tam = 1
    maior_ic = 0

    for tam in range(1, min(max_len, len(texto)) + 1):
        ics = []

        for i in range(tam):
            pedaco = texto[i::tam]
            ics.append(ic(pedaco))

        media_ic = sum(ics) / len(ics)

        if media_ic > maior_ic:
            maior_ic = media_ic
            melhor_tam = tam

    return melhor_tam

def cesar(texto, n):
    resultado = ""
    for x in texto:
        if x.isalpha():
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

    if n == 0:
        return 0

    freq_obs = [c / n for c in contagem]

    return sum(freq_obs[i] * lingua[i] for i in range(26))


def recuperar_chave(texto, tamanho, lingua):
    chave = ""

    for i in range(tamanho):
        pedaco = texto[i::tamanho]

        melhor_shift = 0
        melhor_score = -1

        for s in range(26):
            tentativa = cesar(pedaco, s)
            score = chi_quadrado(tentativa, lingua)

            if score > melhor_score:
                melhor_score = score
                melhor_shift = s

        chave += chr(melhor_shift + 65)

    return chave


def reduzir_chave(chave):
    for i in range(1, len(chave)):
        if len(chave) % i == 0:
            padrao = chave[:i]
            if padrao * (len(chave)//i) == chave:
                return padrao
    return chave
