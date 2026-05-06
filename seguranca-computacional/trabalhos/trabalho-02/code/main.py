import keygen
import signature
import rsa

print('Geração de Chaves')

p, q = keygen.gerarprimos()

print(f'p = {p}\nq = {q}')

print("p eh primo?", keygen.miller_rabin(p))
print("q eh primo?", keygen.miller_rabin(q))

chavepub, chavepriv = keygen.gerarchave(p, q)

print("Chave pública:", chavepub)
print("Chave privada:", chavepriv)

with open("mensagem.txt", "rb") as arquivo:
    mensagem = arquivo.read()

print("\nMensagem original:\n")
print(mensagem.decode())

# Rsa + OAEP

print("RSA usando OAEP")

cifrada = rsa.cifra(chavepub, mensagem)

print("\nMensagem cifrada:\n")
print(cifrada)

decifrada = rsa.decifra(chavepriv, cifrada)

print("\nMensagem decifrada:\n")
print(decifrada.decode())

print("\nFuncionou?", mensagem == decifrada)

# Assinatura

print("\nGerando assinatura:")

documento_assinado = signature.assinar(chavepriv,mensagem)

# salva documento assinado
with open("assinado.txt", "w") as arquivo:
    arquivo.write(documento_assinado)

with open("assinado.txt", "r") as arquivo:
    documento = arquivo.read()

valido = signature.verificar(chavepub,documento)

print("\nAssinatura válida?", valido)
