# GitHub Dark Color Palette
set -l foreground b1bac4
set -l autosuggestion 484f58
set -l selection 163356
set -l comment 8b949e
set -l red ff7b72
set -l orange d18616
set -l yellow d29922
set -l green 3fb950
set -l purple bc8cff
set -l cyan 39c5cf
set -l pink d2a8ff
set -l blue 58a6ff
set -l string a5d6ff

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $blue
set -g fish_color_keyword $purple
set -g fish_color_quote $string
set -g fish_color_redirection $orange
set -g fish_color_end $green
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $autosuggestion
set -g fish_color_statement_terminators $green

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
