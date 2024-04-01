#!/usr/bin/env python
import subprocess
from typing import List

def show_tofi(options: List[str]) -> str:
    process = subprocess.Popen(["tofi", "--prompt-text", "bluetooth: ", "--width", "400", "--height", "200"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    result = process.communicate(input="\n".join(options).encode())
    return result[0].decode().strip()

def pick_device(filter: str) -> str:
    paired_devices = subprocess.check_output(["bluetoothctl", "devices", filter]).decode().split("\n")
    paired_devices = [device for device in paired_devices if device.strip()]
    device_dict = {}
    for device in paired_devices:
        _, device_mac, device_name = device.split(maxsplit=2)
        device_dict[device_name] = device_mac

    device_name = show_tofi(list(device_dict.keys()))
    return device_dict[device_name]

def connect():
    device_mac = pick_device("Paired")
    subprocess.run(["bluetoothctl", "connect", device_mac], check=True)

def disconnect():
    device_mac = pick_device("Connected")
    subprocess.run(["bluetoothctl", "disconnect", device_mac], check=True)

def pair():
    all_devices = subprocess.check_output(["bluetoothctl", "devices"]).decode().split("\n")
    paired_devices = subprocess.check_output(["bluetoothctl", "devices"]).decode().split("\n")
    unpaired_devices = [device for device in all_devices if device not in paired_devices]

    device_dict = {}
    for device in unpaired_devices:
        _, device_mac, device_name = device.split(maxsplit=2)
        device_dict[device_name] = device_mac

    device_name = show_tofi(list(device_dict.keys()))
    device_mac = device_dict[device_name]

    subprocess.run(["bluetoothctl", "pair", device_mac], check=True)

def unpair():
    device_mac = pick_device("Paired")
    subprocess.run(["bluetoothctl", "remove", device_mac], check=True)

def main():
    actions = ["connect", "disconnect", "pair", "unpair"]
    action = show_tofi(actions)
    match action:
        case "connect":
            connect()
        case "disconnect":
            disconnect()
        case "pair":
            pair()
        case "unpair":
            unpair()

if __name__ == "__main__":
    main()
