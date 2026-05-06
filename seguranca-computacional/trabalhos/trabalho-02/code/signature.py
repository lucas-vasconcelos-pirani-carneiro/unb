from hashlib import sha3_256
import base64
import rsa

def gerar_hash(mensagem):
    return sha3_256(mensagem).digest()


def assinar(chave_privada, mensagem):
    hash_msg = gerar_hash(mensagem)
    assinatura = rsa.rsa(chave_privada, hash_msg)
    assinatura_b64 = base64.b64encode(assinatura).decode()

    documento = (
        "-----BEGIN SIGNED MESSAGE-----\n"
        + mensagem.decode()
        + "\n-----SIGNATURE-----\n"
        + assinatura_b64
    )

    return documento

def parse_documento(documento):
    partes = documento.split("\n-----SIGNATURE-----\n")

    mensagem = partes[0].replace(
        "-----BEGIN SIGNED MESSAGE-----\n",
        ""
    )

    assinatura_b64 = partes[1]
    assinatura = base64.b64decode(assinatura_b64)
    return mensagem.encode(), assinatura

def verificar(chave_publica, documento):
    mensagem, assinatura = parse_documento(documento)
    hash_original = gerar_hash(mensagem)
    hash_recebido = rsa.rsa(chave_publica, assinatura)
    # Retirar zeros à esquerda
    hash_recebido = hash_recebido[-len(hash_original):]
    return hash_original == hash_recebido
