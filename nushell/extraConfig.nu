$env.config = {
    show_banner: false

    ls: {
        use_ls_colors: true
        clickable_links: true
    }

    buffer_editor: "code"

    history: {
        file_format: sqlite
        max_size: 100_000
        sync_on_enter: true
        isolation: true
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: false
            max_results: 100
            completer: null
        }
        use_ls_colors: true
    }
}

# Update nix system and user configurations
def update-nix [
    --system (-s) # Update system configuration
    --user (-u) # Update user configuration
    --garbage (-g) # Collect garbage
] {
    if not $system and not $user {
        return "Please specify --system (-s) or --user (-u)"
    }

    if $system {
        let darwin_config = $"($env.XDG_CONFIG_HOME)/nix-darwin"
        nix flake update --flake $darwin_config | print
        darwin-rebuild switch --flake $darwin_config | print

    }

    if $user {
        let home_config = $"($env.XDG_CONFIG_HOME)/home-manager"
        nix flake update --flake $home_config | print
        home-manager switch | print
    }

    if $garbage {
        print "Collecting garbage..."
        nix-collect-garbage
    }
}



# Dev shell patches

alias nix-shell = nix-shell --run nu
alias "nix develop" = nix develop -c nu
