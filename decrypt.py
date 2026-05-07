#! /usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.14"
# dependencies = ["tqdm","click","cryptography"]
# ///

import getpass
import os
import tarfile
from base64 import urlsafe_b64encode
from hashlib import sha256

import click
from cryptography.fernet import Fernet, InvalidToken


def derive_key(passphrase: str) -> bytes:
    # Fernet expects a URL-safe base64-encoded 32-byte key
    return urlsafe_b64encode(sha256(passphrase.encode()).digest())


def decrypt_file(input_file, output_file, key):
    fernet = Fernet(key)

    with open(input_file, "rb") as f:
        encrypted_data = f.read()

    decrypted = fernet.decrypt(encrypted_data)

    with open(output_file, "wb") as f:
        f.write(decrypted)


def extract_tarball(tarball_name, extract_to="."):
    with tarfile.open(tarball_name, "r:gz") as tar:
        tar.extractall(path=extract_to)


@click.command()
@click.argument("encrypted_file", type=click.Path(exists=True))
@click.option(
    "-o",
    "--output",
    default="answers.tar.gz",
    help="Temporary decrypted tarball filename",
)
@click.option("--extract-to", default="facit", help="Directory to extract files into")
def main(encrypted_file, output, extract_to):
    """Decrypt and extract an encrypted answer archive."""

    passphrase = getpass.getpass("Enter decryption passphrase: ")
    key = derive_key(passphrase)

    try:
        decrypt_file(encrypted_file, output, key)
        extract_tarball(output, extract_to)
    except InvalidToken:
        print("ERROR: Incorrect passphrase or corrupted file.")
    except Exception as e:
        print(f"ERROR: {e}")

    os.remove(output)


if __name__ == "__main__":
    main()
