import oaep

def rsa(chave, msg_bytes):
    exp, n = chave
    k = (n.bit_length() + 7) // 8

    m_int = int.from_bytes(msg_bytes, "big")
    c_int = pow(m_int, exp, n)

    return c_int.to_bytes(k, "big")

# Primeiro aplicamos o OAEP e depois RSA 
def cifra(chave_publica, msg):
    msg_oaep = oaep.cifra_oaep(chave_publica[1], msg)
    return rsa(chave_publica, msg_oaep)

# Primeiro aplicamos o RSA e depois OAEP
def decifra(chave_privada, txt_cifrado):
    msg_oaep = rsa(chave_privada, txt_cifrado)
    return oaep.decifra_oaep(chave_privada[1], msg_oaep)
