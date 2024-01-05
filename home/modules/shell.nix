{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ fd ];
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        htop = "sudo htop";
        cat = "bat";
        fzf= "fzf-tmux -p --reverse";
        nvim = "fd --type f --hidden --exclude .git | fzf | xargs nvim";
        vim = "nvim";
        vi = "nvim";

      };
      bashrcExtra = ''
        if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
            tmux attach -t default || tmux new -s default
        fi'';
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };
  };

}
