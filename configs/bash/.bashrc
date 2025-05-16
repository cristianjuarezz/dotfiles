# ~/.bashrc - configurado por Mr Zeruja

# ─── VARIABLES DE ENTORNO ──────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$PATH"

# ─── INICIALIZAR STARSHIP PROMPT ───────────────────────────────────────
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# ─── ALIAS ÚTILES ───────────────────────────────────────────────────────
alias ll='ls -lah --color=auto'
alias gs='git status'
alias gc='git commit -m'
alias gp='git push'
alias ani='ani-cli'
alias serve='npx serve'

# ─── INFORMACIÓN DE BIENVENIDA ─────────────────────────────────────────
if [ -n "$PS1" ]; then
  clear
  neofetch --ascii_distro arch
  echo
  fortune | cowsay -f tux
fi

# ─── FUNCIONES PERSONALIZADAS ──────────────────────────────────────────

# Mostrar la rama Git en el prompt (sólo si no usa starship)
# function parse_git_branch() {
#   git branch 2> /dev/null | grep '\*' | sed 's/* //'
# }

# PS1 personal si no usa Starship:
# PS1='\u@\h:\w$(parse_git_branch && echo " (\$(parse_git_branch))")\$ '

# ─── FINAL ─────────────────────────────────────────────────────────────
