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
}

# Dev shell patches

alias nix-shell = nix-shell --run nu
alias "nix develop" = nix develop -c nu
