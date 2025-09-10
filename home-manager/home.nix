{
  config,
  pkgs,
  unstable,
  ...
}:

{
  home.username = "bow";

  home.homeDirectory = "/home/bow";

  home.packages = with pkgs; [
    # Non-GUI.
    age
    aria2
    asciidoctor-with-extensions
    unstable.asdf-vm
    autojump
    bat
    btop
    ccls
    clangStdenv
    cloc
    curl
    curlie
    deadnix
    delve
    difftastic
    direnv
    distrobox
    dmidecode
    dnsmasq
    dnsutils
    docker
    docker-buildx
    docker-compose
    dos2unix
    dua
    duf
    elinks
    entr
    ethtool
    eza
    fd
    file
    findutils
    fzf
    gcc
    gdb
    gh
    ghostty
    git
    glow
    gnugrep
    gnumake
    gnupatch
    gnupg
    gnused
    go
    graphviz
    grpcurl
    gzip
    hexyl
    htop
    iftop
    imagemagick
    inetutils
    iotop
    ipcalc
    iperf3
    iproute2
    jq
    just
    ldns
    libvirt
    lld
    lldb
    lshw
    ltrace
    lzip
    minify
    mpd
    mtr
    ncmpcpp
    neovim
    nerdctl
    nixfmt-rfc-style
    nmap
    nodejs
    ntfs3g
    p7zip
    packer
    pass
    pciutils
    pdftk
    unstable.poetry
    pv
    python3
    unstable.pyenv
    qemu
    readline
    redshift
    restic
    ripgrep
    unstable.rustup
    sequoia-sq
    shfmt
    socat
    starship
    stow
    strace
    stylua
    sysstat
    terraform
    texlab
    texliveFull
    tmux
    tree
    tree-sitter
    unrar
    unzip
    usbutils
    unstable.uv
    valgrind
    vim
    virt-manager
    virt-viewer
    weechat
    wget
    which
    whois
    wrk
    xan
    xz
    yazi
    zip
    zoxide
    zstd

    # Fonts.
    font-awesome
    iosevka

    # GUI.
    evince
    firefox
    feh
    geany
    gparted
    maim
    obsidian
    veracrypt
    zathura
    vlc
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
