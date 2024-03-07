#/usr/bin/env python3

import argparse
from arch import install_arch
from debian import install_debian, install_debian_server
from fedora import install_fedora, install_fedora_server
from ubuntu import install_ubuntu, install_ubuntu_server
from el import install_al9_server


def get_os() -> str:
    try:
        with open("/etc/os-release", "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("ID="):
                    return line.split("=")[1].strip().replace('"', "")
    except FileNotFoundError:
        pass

    return "unknown"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--server", action="store_true", help="Install in server mode")
    args = parser.parse_args()

    print("Setting up system...")

    this_os = get_os()
    print(f"Detected OS: {this_os}")
    if this_os == "arch":
        install_arch()
    elif this_os == "debian":
        if args.server or input("Is this a server? (y/N) ").lower() == "y":
            install_debian_server()
        else:
            install_debian()
    elif this_os == "fedora":
        if args.server or input("Is this a server? (y/N) ").lower() == "y":
            install_fedora_server()
        else:
            install_fedora()
    elif this_os == "ubuntu":
        if args.server or input("Is this a server? (y/N) ").lower() == "y":
            install_ubuntu_server()
        else:
            install_ubuntu()
    elif this_os == "almalinux":
        install_al9_server()
    else:
        print(f"Unsupported OS: {this_os}")


if __name__ == "__main__":
    main()
