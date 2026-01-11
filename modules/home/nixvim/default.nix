{lib, ...}: {
  fooOption = lib.nixvim.mkRaw "print('hello')";
}
