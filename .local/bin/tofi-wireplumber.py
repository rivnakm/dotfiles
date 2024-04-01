#!/usr/bin/env python

import re
import subprocess
from typing import List, Tuple

def show_tofi(options: List[str]) -> str:
    process = subprocess.Popen(["tofi", "--prompt-text", "pipewire: ", "--width", "400", "--height", "200"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    result = process.communicate(input="\n".join(options).encode())
    return result[0].decode().strip()

def get_sinks() -> List[Tuple[str, str]]:
    status = subprocess.check_output(["wpctl", "status"]).decode()
    sinks_section = status.split("Sinks:")[1].split("Sources:")[0]
    matches = re.findall(r"^(?: │[ *]{6}(\d+)\. (.+\S+)\s+\[vol: \d+\.\d+\])$", sinks_section, re.MULTILINE)

    return [(sink_id, sink_name) for sink_id, sink_name in matches]

def main():
    ignored_sinks = [ "HDMI" ]
    sinks = get_sinks()
    sinks = [(sink_id, sink_name) for sink_id, sink_name in sinks if not any(ignored in sink_name for ignored in ignored_sinks)]
    sinks_dict = {sink_name: sink_id for sink_id, sink_name in sinks}
    sink_name = show_tofi(list(sinks_dict.keys()))
    sink = sinks_dict[sink_name]

    subprocess.run(["wpctl", "set-default", sink], check=True)

if __name__ == "__main__":
    main()
