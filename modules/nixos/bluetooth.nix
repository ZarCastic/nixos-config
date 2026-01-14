{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # show battery charge of connected devices (name is misleading)
        FastConnectable = true; # Allow devcies to connect faster -> higher power consumption
      };
      Policy = {
        AutoEnable = true; # Enable all adapters automagically
      };
    };
  };
}
