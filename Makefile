.PHONY: update
update:
	git add -A && home-manager switch --flake .#lasse -b backup

.PHONY: clean
clean:
	nix-collect-garbage -d

.PHONY: help
help:
	man home-configuration.nix