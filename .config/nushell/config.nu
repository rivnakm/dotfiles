# Nushell Config File
$env.config = {
    show_banner: false
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    rm: {
        always_trash: true
    }
    error_style: "fancy"

    # Whether an error message should be printed if an error of a certain kind is triggered.
    display_errors: {
        exit_code: true
        termination_signal: true
    }
    datetime_format: {
        # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
        # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }

    table: {
        mode: rounded
    }
    cursor_shape: {
        emacs: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape
        vi_insert: line
        vi_normal: block
    }

    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }

    color_config: {
        hints: white_dimmed
    }
    buffer_editor: nvim # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
    use_ansi_coloring: true
    edit_mode: vi # emacs, vi
}

# Aliases
alias l = ls
alias la = ls -a
alias rm = rm -r

alias ff = fastfetch
alias nv = nvim
alias snv = sudo -e
alias na = ninja
alias zj = zellij

alias gs = git status
alias ga = git add
alias gc = git commit -m
alias gpu = git push
alias gpl = git pull
alias gd = git diff
alias gds = git diff --staged

def csd [] {
    chcolors set dark
    lookandfeeltool --apply org.kde.breezedark.desktop
}

def csl [] {
    chcolors set light
    lookandfeeltool --apply org.kde.breeze.desktop
}


# Use starship prompt
use "~/.cache/starship/init.nu"

fastfetch

print ""
projfetch --compact --max-width 72 $"($env.HOME)/Code"
