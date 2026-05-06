import keygen
import signature
import rsa

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

print('RSA usando OAEP')

mensagem = b"Ouviram do Ipiranga as margens placidas \n De um povo heroico o brado retumbante \n E o sol da Liberdade em raios fulgidos \n Brilhou no ceu da Patria nesse instante.\n"

print("Mensagem original: \n", mensagem)

cifrada = rsa.cifra(chavepub, mensagem)
print("Mensagem após criptografar com RSA: \n", cifrada)

decifrada = rsa.decifra(chavepriv, cifrada)
print("Mensagem após descriptografar com RSA: \n", decifrada)

print("Mensagem recuperada: \n", decifrada)
print("Funcionou?", mensagem == decifrada)


"""
primos = keygen.gerarprimos()
print (primos)
chaves = keygen.gerarchave(primos[0], primos[1])
print("\n")
print(chaves)

signature.hasher("exemplo.jpeg",chaves[1][0],chaves[1][1])
"""
