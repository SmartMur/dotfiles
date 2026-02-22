command -v kubectl >/dev/null 2>&1 && alias k='kubectl'
command -v kubectx >/dev/null 2>&1 && alias kc='kubectx'
command -v kubens >/dev/null 2>&1 && alias kn='kubens'
command -v helm >/dev/null 2>&1 && alias h='helm'
command -v terraform >/dev/null 2>&1 && alias tf='terraform'
command -v ansible >/dev/null 2>&1 && alias a='ansible'
command -v ansible-playbook >/dev/null 2>&1 && alias ap='ansible-playbook'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza --icons --group-directories-first -l'
fi

command -v boilerplates >/dev/null 2>&1 && alias bp='boilerplates'
command -v proxmox-manager >/dev/null 2>&1 && alias prx='proxmox-manager'
