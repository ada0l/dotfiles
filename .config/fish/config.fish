if status is-interactive
    # Commands to run in interactive sessions can go here
end

# editor
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PYENV_ROOT $HOME/.pyenv

# path
fish_add_path ~/go/bin/
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/
fish_add_path ~/anaconda3/condabin/
fish_add_path ~/.local/share/nvim/mason/bin/

set -Ux fish_term24bit 1

# go
set -Ux GOPATH ~/go

# dnf
abbr dnfi "sudo dnf install"
abbr dnfs "sudo dnf search"
abbr dnfr "sudo dnf remove"
abbr dnfu "sudo dnf upgrade --refresh"

# lazy
abbr lg "lazygit"
abbr ld "lazydocker"

# git
abbr g "git"
abbr ga "git add"
abbr glg "git log --graph"
abbr gd "git diff"
abbr gds "git diff --staged"
abbr glo 'git log --pretty=format:"%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s"'

# tmux
abbr t tmux
abbr tl 'tmux ls'

# files
alias ls="exa --color=always --icons --group-directories-first"
alias la="exa --color=always --icons --group-directories-first --all"
alias ll="exa --color=always --icons --group-directories-first --all --long"
abbr l ll

# wireguard
abbr wu 'wg-quick up'
abbr wu1 'wg-quick up wg1'
abbr wd 'wg-quick down'
abbr wd1 'wg-quick down wg1'

# docker
alias sd='sudo systemctl start docker'
abbr dps 'docker ps'
abbr dpsa 'docker ps -a'
abbr di 'docker images'
abbr dex 'docker execute -i -t'


# fzf
set fzf_fd_opts --hidden --exclude=.git
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

# Load pyenv automatically by appending
# the following to ~/.config/fish/config.fish:

pyenv init - | source
