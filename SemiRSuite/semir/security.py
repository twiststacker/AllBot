import ssl
import os

def get_ssl_context(certfile="cert.pem", keyfile="key.pem"):
    try:
        context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
        context.load_cert_chain(certfile=certfile, keyfile=keyfile)
        return context
    except FileNotFoundError as e:
        raise RuntimeError(f"Certificate files not found: {str(e)}")
    except ssl.SSLError as e:
        raise RuntimeError(f"SSL configuration error: {str(e)}")

def get_secret(name: str):
    secret = os.environ.get(name)
    if secret is None:
        raise ValueError(f"Secret '{name}' not found in environment variables.")
    return secret
