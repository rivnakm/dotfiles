cd $HOME;
echo 'Cloning dotfiles...';
tempnum = (awk -v min=1 -v max=100 'BEGIN{srand(); print int(min+rand()*(max-min+1))}');
git clone https://github.com/mrivnak/dotfiles.git /tmp/dotfiles${tempnum};

echo 'Changing Shell to Zsh...';
if ! has 'zsh' then
    echo 'Cannot continue, Zsh is not installed!';
    exit;
fi
sudo chsh -s $(which zsh) $USER

echo 'Installing Oh My Zsh...';
sh -c '$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)';

echo 'Installing Powerlevel10k...';
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k;

echo 'Installing Fonts...';
mkdir -p ~/.local/share/fonts/Hack_Nerd_Font;
cd ~/.local/share/fonts/Hack_Nerd_Font;
curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf;
curl -fLo "Hack Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete%20Mono.ttf;
curl -fLo "Hack Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf;
curl -fLo "Hack Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete%20Mono.ttf;
curl -fLo "Hack Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete.ttf;
curl -fLo "Hack Bold Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/BoldItalic/complete/Hack%20Bold%20Italic%20Nerd%20Font%20Complete%20Mono.ttf;
curl -fLo "Hack Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf;
curl -fLo "Hack Bold Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete%20Mono.ttf;
cd $HOME;

echo 'Installing Fast Syntax Highlighting...';
git clone https://github.com/zdharma/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting;

echo 'Installing Zsh Autosuggestions...';
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo 'Copying Dotfiles...';
fd -f /tmp/dotfiles${tempnum} -E ".git*(ND)" -x cp -r {} $HOME/;

echo 'Cleaning up...';
rm -rf /tmp/dotfiles${tempnum};