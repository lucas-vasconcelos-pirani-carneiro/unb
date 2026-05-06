import keygen
import signature

print('Geração de Chaves')
p, q = keygen.gerarprimos()

print(f'p = {p}\n q = {q}')

print("p eh primo?", keygen.miller_rabin(p))
print("q eh primo?", keygen.miller_rabin(q))

chavepub, chavepriv = keygen.gerarchave(p, q)

e, n = chavepub
d, _ = chavepriv

print("Chave pública: ", chavepub)
print("Chave privada: ", chavepriv)

"""
primos = keygen.gerarprimos()
print (primos)
chaves = keygen.gerarchave(primos[0], primos[1])
print("\n")
print(chaves)

signature.hasher("exemplo.jpeg",chaves[1][0],chaves[1][1])
"""
