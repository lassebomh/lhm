.PHONY: update
update:
	git add -A && home-manager switch --flake .#lasse

.PHONY: clean
clean:
	nix-collect-garbage -d