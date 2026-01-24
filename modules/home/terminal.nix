{ lib, ... }:
{
  programs = {
    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = lib.mkForce "Monaspace Xenon Var:size=11";
        };
        scrollback = {
          lines = 100000;
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
