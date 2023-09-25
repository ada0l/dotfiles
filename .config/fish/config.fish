if status is-interactive
    # Commands to run in interactive sessions can go here
end

# editor
set -gx EDITOR (which helix)
set -gx VISUAL $EDITOR
set -gx SUDO_EDITOR $EDITOR
set -gx PYENV_ROOT $HOME/.pyenv
set -gx GEM_HOME (gem env user_gemhome)
set -gx DISABLE_AUTO_TITLE true

# path
fish_add_path ~/go/bin/
fish_add_path ~/.local/bin/
fish_add_path ~/.cargo/bin/
fish_add_path ~/anaconda3/condabin/
fish_add_path ~/.local/share/nvim/mason/bin/
fish_add_path $GEM_HOME/bin

set -Ux fish_term24bit 1

# go
set -Ux GOPATH ~/go

# dnf
abbr dnfi "sudo dnf install"
abbr dnfs "sudo dnf search"
abbr dnfr "sudo dnf remove"
abbr dnfu "sudo dnf upgrade --refresh"

# lazy
abbr lg lazygit
abbr ld lazydocker

# git
abbr g git
abbr ga "git add"
abbr glg "git log --graph"
abbr gd "git diff"
abbr gds "git diff --staged"
abbr glo 'git log --pretty=format:"%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s"'

# tmux
abbr t tmux
abbr tl 'tmux ls'
abbr tx tmuxinator

# zellij
abbr z zellij

# helix
abbr hx helix

# neovim
abbr n nvim

abbr r ranger

# files
alias ls="exa --color=always --icons --group-directories-first"
alias la="exa --color=always --icons --group-directories-first --all"
alias ll="exa --color=always --icons --group-directories-first --all --long"
abbr l ll

# wireguard
abbr wg 'wg-quick up'
abbr wg 'wg-quick down'
abbr wu1 'wg-quick up wg1'
abbr wd1 'wg-quick down wg1'
abbr wub 'wg-quick up banana'
abbr wdb 'wg-quick down banana'

# docker
alias ssd='sudo systemctl start docker'
abbr dps 'docker ps'
abbr dpsa 'docker ps -a'
abbr di 'docker images'
abbr dex 'docker execute -i -t'

# fzf
set fzf_fd_opts --hidden --exclude=.git

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
pyenv init - | source

set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf
