import keygen
import rsa
import signature

print("Geração de Chaves:")

p, q = keygen.gerarprimos()

print(f"\np = {p}\n")
print(f"q = {q}\n")

print("p é primo ?", keygen.miller_rabin(p))
print("q é primo ?", keygen.miller_rabin(q))

chavepub, chavepriv = keygen.gerarchave(p, q)

print("\nChave pública:")
print(chavepub)

print("\nChave privada:")
print(chavepriv)

with open("mensagem.txt", "rb") as arquivo:
    mensagem = arquivo.read()

print("Mensagem Original:\n")

print(mensagem.decode())

# Assinatura
print("Gerando Assinatura...\n")

assinatura = signature.gerar_assinatura(chavepriv,mensagem)

print("Assinatura gerada com sucesso.")

# RSA + OAEP
print("Criptografando RSA + OAEP\n")

try:
    mensagem_cifrada = rsa.cifra(chavepub,mensagem)
    print("Mensagem cifrada com sucesso.")

except ValueError as erro:
    print("\nErro:", erro)
    exit()

documento = signature.formatar_documento(mensagem_cifrada,assinatura)

with open("mensagem-segura.txt", "w") as arq:
    arq.write(documento)

print("Documento salvo em mensagem-segura.txt")

with open("mensagem-segura.txt", "r") as arq:
    documento = arq.read()

mensagem_cifrada, assinatura = (signature.parse_documento(documento))

mensagem_recuperada = rsa.decifra(chavepriv,mensagem_cifrada)

print("Mensagem Recuperada:\n")
print(mensagem_recuperada.decode())

print("Verificação da Assinatura:\n")
valido = signature.verificar_assinatura(chavepub,mensagem_recuperada,assinatura)
print("\nAssinatura válida?", valido)

print("Verificação da Mensagem:\n")
print("Mensagem recuperada corretamente?",mensagem == mensagem_recuperada)
