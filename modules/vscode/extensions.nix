{pkgs, ...}:
with pkgs.vscode-extensions; [
  nonylene.dark-molokai-theme
  esbenp.prettier-vscode
  golang.go
  bradlc.vscode-tailwindcss
  bbenoist.nix
  ritwickdey.liveserver
  svelte.svelte-vscode
  mkhl.direnv
  rust-lang.rust-analyzer
]
