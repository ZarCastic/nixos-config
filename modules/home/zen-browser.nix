{
  zen-browser,
  firefox-addons,
  pkgs,
  ...
}:
{
  imports = [
    zen-browser.homeModules.twilight
  ];
  programs.zen-browser = {
    enable = true;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles."default" = {
      extensions.packages = with firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        ublock-origin
        proton-pass
        bitwarden
        vimium
      ];
      search = {
        force = true; # Needed for nix to overwrite search settings on rebuild
        default = "ddg"; # Aliased to duckduckgo, see other aliases in the link above
        engines = {
          # My nixos Option and package search shortcut
          mynixos = {
            name = "My NixOS";
            urls = [
              {
                template = "https://mynixos.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@nx" ]; # Keep in mind that aliases defined here only work if they start with "@"
          };
          home-manager-options = {
            name = "Home Manager Options";
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
          };
        };
      };
      settings = {
        "browser.tags.warnOnClose" = false;
        "zen.workspaces.continue-where-left-off" = true;
      };
    };
  };
}
