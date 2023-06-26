{pkgs, ...}: {
  services.envfs.enable = true;

  environment.systemPackages = with pkgs; [
    fuse
  ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      openssl
      curl
      glib
      util-linux
      icu
      libunwind
      libuuid
      zlib
      libsecret
      fuse
    ];
  };
}
