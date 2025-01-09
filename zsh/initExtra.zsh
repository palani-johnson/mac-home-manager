# dev shell patch

alias nix-shell='nix-shell --run zsh'

nix() {
  if [[ $1 == "develop" ]]; then
    shift
    command nix develop -c zsh "$@"
  else
    command nix "$@"
  fi
}
