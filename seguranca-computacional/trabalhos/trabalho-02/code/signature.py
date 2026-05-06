from hashlib import sha3_256
import rsa
import base64

def gerar_hash(mensagem):
    return sha3_256(mensagem).digest()

def gerar_assinatura(chave_privada, mensagem):
    hash_msg = gerar_hash(mensagem)
    assinatura = rsa.rsa(chave_privada,hash_msg)
    return assinatura

def verificar_assinatura(chave_publica, mensagem, assinatura):
    hash_original = gerar_hash(mensagem)
    hash_recebido = rsa.rsa(chave_publica, assinatura)

    # Retirar zeros à esquerda
    hash_recebido = hash_recebido[-len(hash_original):]

    return hash_original == hash_recebido

def formatar_documento(mensagem_cifrada,assinatura):
    msg_b64 = base64.b64encode(mensagem_cifrada).decode()
    assinatura_b64 = base64.b64encode(assinatura).decode()

    documento = f"""
+----- Inicio da Mensagem -----+

+----- Ciphertext -----+
{msg_b64}

+----- Assinatura -----+
{assinatura_b64}

+----- Fim da Mensagem -----+
"""

    return documento

def parse_documento(documento):
    partes = documento.split("+----- Assinatura -----+")

    parte_msg = partes[0]
    parte_ass = partes[1]

    msg_b64 = (parte_msg.split("+----- Ciphertext -----+")[1].strip())

    assinatura_b64 = (parte_ass.split("+----- Fim da Mensagem -----+")[0].strip())
    
    mensagem_cifrada = base64.b64decode(msg_b64)
    assinatura = base64.b64decode(assinatura_b64)

    return mensagem_cifrada, assinatura
