{
  name,
  self,
}: final: prev: let
  packageOverrides = luaself: luaprev: {
    zig-tools-nvim = luaself.callPackage ({buildLuarocksPackage}:
      buildLuarocksPackage {
        pname = name;
        version = "scm-1";
        knownRockspec = "${self}/zig-tools.nvim-scm-1.rockspec";
        src = self;
      }) {};
  };

  lua5_1 = prev.lua5_1.override {
    inherit packageOverrides;
  };
  lua51Packages = final.lua5_1.pkgs;

  zig-tools = final.neovimUtils.buildNeovimPlugin {
    pname = name;
    src = self;
    version = "dev";
  };
in {
  inherit
    lua5_1
    lua51Packages
    ;

  vimPlugins =
    prev.vimPlugins
    // {
      inherit zig-tools;
    };
}
