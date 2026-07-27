{...}: {
  den.aspects.gram = {
    homeManager = {
      pkgs,
      lib,
      ...
    }: let
      # ── clang for Gram's wasm extension builds ─────────────────────────
      # Gram compiles extensions locally. Its extension_builder uses the
      # system toolchain only when `clang`, `wasm-ld` AND `wasm-component-ld`
      # are all on PATH (then it downloads just the wasi-sysroot, which is
      # NixOS-safe). If any is missing it falls back to downloading a prebuilt
      # wasi-sdk whose dynamically linked clang cannot run on NixOS.
      #
      # The wrapped nixpkgs clang injects host (glibc/x86_64) flags that break
      # `--target=wasm32-wasip2`, so we use the UNwrapped driver. That in turn
      # lacks wasm compiler-rt builtins in its resource dir (nixpkgs builds
      # compiler-rt host-only), so we graft the wasi cross build of
      # compiler-rt into a merged resource dir. Both driver layouts are
      # provided (per-target and legacy per-OS).
      #
      # Rust side is covered by rustup (langs.nix) + `rustup target add
      # wasm32-wasip2`.
      clangUnwrapped = pkgs.llvmPackages.clang-unwrapped;
      clangMajor = lib.versions.major clangUnwrapped.version;
      wasmRt = pkgs.pkgsCross.wasi32.llvmPackages.compiler-rt;
      gramClang =
        pkgs.runCommand "gram-clang-${clangUnwrapped.version}" {
          nativeBuildInputs = [pkgs.makeWrapper pkgs.xorg.lndir];
        } ''
          resource=$out/resource-dir
          mkdir -p $resource
          lndir -silent ${lib.getLib clangUnwrapped}/lib/clang/${clangMajor} $resource

          builtins_a=${wasmRt}/lib/wasi/libclang_rt.builtins-wasm32.a
          mkdir -p $resource/lib/wasm32-unknown-wasip2 $resource/lib/wasi
          ln -sf $builtins_a $resource/lib/wasm32-unknown-wasip2/libclang_rt.builtins.a
          ln -sf $builtins_a $resource/lib/wasi/libclang_rt.builtins-wasm32.a

          mkdir -p $out/bin
          makeWrapper ${clangUnwrapped}/bin/clang $out/bin/clang \
            --add-flags "-resource-dir=$resource"
        '';
    in {
      home.packages = with pkgs; [
        gram
        gramClang # only ships bin/clang — no collision with gcc/clang-tools
        lld # provides wasm-ld (same LLVM major as clang)
        wasm-component-ld
      ];
    };
  };
}
