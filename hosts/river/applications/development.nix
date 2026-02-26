{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
        bradlc.vscode-tailwindcss
        ms-vscode-remote.vscode-remote-extensionpack
        k--kato.intellij-idea-keybindings
        ms-vsliveshare.vsliveshare
        arrterian.nix-env-selector
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vsc-vira-theme";
        publisher = "vira";
        version = "2026.2.2";
        sha256 = "m5CXm94T3pcJhncYlJYXdOu+FI1tFhK2tanTMZMZZ9g=";
      }
    ];
    })
    git
    jujutsu
    pnpm
    nodejs_25
    nixfmt
  ];
}
