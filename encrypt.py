#! /usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.13"
# dependencies = ["tqdm","click","cryptography"]
# ///

import getpass
import os
import tarfile
from base64 import urlsafe_b64encode
from hashlib import sha256

import click
from cryptography.fernet import Fernet
from tqdm import tqdm


def create_tarball(output_name, files):
    with tarfile.open(output_name, "w:gz") as tar:
        for file in tqdm(files, desc="Adding files"):
            tar.add(file)
    print(f"Created tarball: {output_name}")


def derive_key(passphrase):
    digest = sha256(passphrase.encode()).digest()
    return urlsafe_b64encode(digest)


def encrypt_file(input_file, output_file, key):
    fernet = Fernet(key)
    with open(input_file, "rb") as f:
        data = f.read()
    encrypted = fernet.encrypt(data)
    with open(output_file, "wb") as f:
        f.write(encrypted)
    print(f"Encrypted tarball saved as: {output_file}")


@click.command()
@click.argument("files", nargs=-1, type=click.Path(exists=True))
@click.option(
    "-o", "--output", "output_filename", type=click.Path(), default="facit.tar.gz"
)
def main(output_filename, files):
    """Encrypt a list of files into a tarball."""
    create_tarball(output_filename, files)

    passphrase = getpass.getpass(
        "Enter a passphrase to encrypt the tarball: ",
    )
    key = derive_key(passphrase)
    encrypt_file(output_filename, f"{output_filename}.enc", key)


if __name__ == "__main__":
    main()
