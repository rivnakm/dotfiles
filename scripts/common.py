from os import path
import os
import shutil
import subprocess


dotfiles_dir = path.dirname(path.dirname(path.abspath(__file__)))


def install_dots():
    print("Installing dotfiles...")
    shutil.copy2(f"{dotfiles_dir}/.zshrc", f"{path.expanduser('~')}/.zshrc")
    shutil.copytree(
        f"{dotfiles_dir}/.config/bottom",
        f"{path.expanduser('~')}/.config/bottom",
        dirs_exist_ok=True,
    )
    shutil.copytree(
        f"{dotfiles_dir}/.config/tmux",
        f"{path.expanduser('~')}/.config/tmux",
        dirs_exist_ok=True,
    )
    shutil.copy2(
        f"{dotfiles_dir}/.config/starship.toml",
        f"{path.expanduser('~')}/.config/starship.toml",
    )
    if path.exists(f"{path.expanduser('~')}/.config/nvim"):
        subprocess.run(
            ["git", "pull"], cwd=f"{path.expanduser('~')}/.config/nvim", check=True
        )
    else:
        subprocess.run(
            ["git", "clone", "https://github.com/mrivnak/neovim-config.git", "nvim"],
            cwd=f"{path.expanduser('~')}/.config",
            check=True,
        )

    print("Installing Oh My Zsh...")
    shutil.rmtree(f"{path.expanduser('~')}/.oh-my-zsh", ignore_errors=True)
    subprocess.run(
        [
            "curl",
            "-L",
            "https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh",
            "--output",
            "install_omz.sh",
        ],
        cwd="/tmp",
        check=True,
    )
    subprocess.run(
        [
            "sh",
            "/tmp/install_omz.sh",
        ],
        check=True,
        env={"RUNZSH": "no", "KEEP_ZSHRC": "yes", "CHSH": "yes"},
    )

    print("installing zsh plugins...")
    if not path.exists(
        f"{path.expanduser('~')}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    ):
        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/zsh-users/zsh-autosuggestions",
                f"{path.expanduser('~')}/.oh-my-zsh/custom/plugins/zsh-autosuggestions",
            ],
            check=True,
        )

    if not path.exists(
        f"{path.expanduser('~')}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    ):
        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/zsh-users/zsh-syntax-highlighting.git",
                f"{path.expanduser('~')}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting",
            ],
            check=True,
        )


def install_kde():
    print("Installing KDE config...")
    shutil.copy2(
        f"{dotfiles_dir}/.config/konsolerc", f"{path.expanduser('~')}/.config/konsolerc"
    )
    shutil.copytree(
        f"{dotfiles_dir}/.local/share/konsole",
        f"{path.expanduser('~')}/.local/share/konsole",
        dirs_exist_ok=True,
    )


def install_fonts():
    print("Installing fonts...")

    subprocess.run(
        [
            "curl",
            "-L",
            "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/CascadiaMono.zip",
            "--output",
            "cascadia.zip",
        ],
        cwd="/tmp",
        check=True,
    )
    os.makedirs("/tmp/cascadia", exist_ok=True)
    subprocess.run(["unzip", "/tmp/cascadia.zip", "-d", "/tmp/cascadia"], check=True)
    subprocess.run("sudo mkdir -p /usr/share/fonts/caskaydia", shell=True, check=True)
    subprocess.run(
        "sudo cp /tmp/cascadia/*.ttf /usr/share/fonts/caskaydia/",
        shell=True,
        check=True,
    )

    subprocess.run(["fc-cache", "-f", "-v"], check=True)


def install_starship():
    print("Installing starship...")
    env = os.environ.copy()
    env["PATH"] = f"{env['PATH']}:{path.expanduser('~')}/.cargo/bin"
    subprocess.run(["cargo", "install", "starship"], check=True, env=env)


def install_fastfetch():
    print("Installing fastfetch...")
    subprocess.run(
        ["git", "clone", "https://github.com/fastfetch-cli/fastfetch"],
        cwd="/tmp",
        check=True,
    )
    os.makedirs("/tmp/fastfetch/build", exist_ok=True)
    subprocess.run(
        ["cmake", "..", "-G", "Unix Makefiles"], cwd="/tmp/fastfetch/build", check=True
    )
    subprocess.run(
        ["make", f"-j{os.cpu_count()}", "fastfetch"],
        cwd="/tmp/fastfetch/build",
        check=True,
    )
    subprocess.run(
        ["sudo", "cp", "fastfetch", "/usr/local/bin"],
        cwd="/tmp/fastfetch/build",
        check=True,
    )
    shutil.rmtree("/tmp/fastfetch")


def install_pfetch():
    print("Installing pfetch-rs...")
    env = os.environ.copy()
    env["PATH"] = f"{env['PATH']}:{path.expanduser('~')}/.cargo/bin"
    subprocess.run(["cargo", "install", "pfetch"], check=True, env=env)


def install_rust():
    print("Installing Rust...")
    subprocess.run(
        [
            "curl",
            "https://sh.rustup.rs",
            "--output",
            "rustup.sh",
        ],
        cwd="/tmp",
        check=True,
    )
    subprocess.run(["sh", "rustup.sh", "-y"], cwd="/tmp", check=True)
    os.unlink("/tmp/rustup.sh")


def install_gh_cli_deb():
    print("Installing GitHub CLI...")
    subprocess.run(
        "type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)",
        shell=True,
        check=True,
    )
    subprocess.run(
        """curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
            | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
            && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
            && echo "deb [arch=$(dpkg --print-architecture) \
                signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
                https://cli.github.com/packages stable main" \
            | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null""",
        shell=True,
        check=True,
    )
    subprocess.run(["sudo", "apt", "update"], check=True)
    subprocess.run(["sudo", "apt", "install", "-y", "gh"], check=True)


def install_gh_cli_rpm():
    subprocess.run(
        [
            "sudo",
            "dnf",
            "config-manager",
            "--add-repo",
            "https://cli.github.com/packages/rpm/gh-cli.repo",
        ],
        check=True,
    )
    subprocess.run(["sudo", "dnf", "install", "-y", "gh"], check=True)


def install_vscode_deb():
    print("Installing Visual Studio Code...")
    subprocess.run(
        "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg",
        shell=True,
        check=True,
    )
    subprocess.run(
        [
            "sudo",
            "install",
            "-D",
            "-o",
            "root",
            "-g",
            "root",
            "-m",
            "644",
            "packages.microsoft.gpg",
            "/etc/apt/keyrings/packages.microsoft.gpg",
        ],
        check=True,
    )
    subprocess.run(
        """sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'""",
        shell=True,
        check=True,
    )
    os.unlink("packages.microsoft.gpg")

    subprocess.run(["sudo", "apt", "update"], check=True)
    subprocess.run(["sudo", "apt", "install", "-y", "code"], check=True)


def install_vscode_rpm():
    subprocess.run(
        [
            "sudo",
            "rpm",
            "--import",
            "https://packages.microsoft.com/keys/microsoft.asc",
        ],
        check=True,
    )
    subprocess.run(
        """sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'""",
        shell=True,
        check=True,
    )
    subprocess.run(["sudo", "dnf", "install", "code", "-y"], check=True)


def install_zig():
    return  # I should install zig manually for now
    print("Installing Zig...")
    get_version = subprocess.run(
        """git ls-remote --tags --sort="v:refname" https://github.com/ziglang/zig | grep -v '{}' | cut -f 3 -d '/' | tail -n 1""",
        shell=True,
        check=True,
        capture_output=True,
        text=True,
    )
    version = get_version.stdout.strip()

    subprocess.run(
        [
            "wget",
            f"https://ziglang.org/download/{version}/zig-linux-x86_64-{version}.tar.xz",
        ],
        cwd="/tmp",
        check=True,
    )
    subprocess.run(
        ["tar", "xf", f"zig-linux-x86_64-{version}.tar.xz"], cwd="/tmp", check=True
    )
    shutil.copytree(f"/tmp/zig-linux-x86_64-{version}", "/tmp/zig", dirs_exist_ok=True)
    subprocess.run(
        ["sudo", "cp", "-v", "/tmp/zig/zig", "/usr/local/bin"],
        check=True,
    )
    subprocess.run(
        ["sudo", "cp", "-rv", "/tmp/zig/lib", "/usr/local"],
        check=True,
    )
    shutil.rmtree("/tmp/zig")

    subprocess.run(
        [
            "curl",
            "-LO",
            f"https://github.com/zigtools/zls/releases/download/{version}/zls-x86-linux.tar.gz",
        ],
        cwd="/tmp",
        check=True,
    )
    os.makedirs("/tmp/zls", exist_ok=True)
    subprocess.run(["tar", "xf", "../zls-x86-linux.tar.gz"], cwd="/tmp/zls", check=True)
    subprocess.run(
        ["sudo", "cp", "-v", "/tmp/zls/bin/zls", "/usr/local/bin"],
        check=True,
    )
    shutil.rmtree("/tmp/zls")


def install_fzf():
    print("Installing fzf...")
    subprocess.run(
        ["git", "clone", "--depth", "1", "https://github.com/junegunn/fzf.git"],
        cwd="/tmp",
        check=True,
    )
    subprocess.run(
        ["./install", "--all"],
        cwd="/tmp/fzf",
        check=True,
    )
