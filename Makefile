.PHONY: update
update:
	home-manager switch --flake .#lasse

.PHONY: clean
clean:
	nix-collect-garbage -d