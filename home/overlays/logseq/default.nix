self: super: {
  logseq = super.logseq.overrideAttrs (old: rec {
    pname = "logseq";
    version = "0.5.8";
    src = builtins.fetchurl {
      url =
        "https://github.com/logseq/logseq/releases/download/${version}/logseq-linux-x64-${version}.AppImage";
      sha256 = "1vblav210gf55vim3ani4aqdiss6i9lbrl4690914mlb58l731ss";
      name = "${pname}-${version}.AppImage";
    };

    appimageContents = super.appimageTools.extract {
      name = "${pname}-${version}";
      inherit src;
    };
    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    nativeBuildInputs = [ super.makeWrapper ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share/${pname} $out/share/applications
      cp -a ${appimageContents}/{locales,resources} $out/share/${pname}
      cp -a ${appimageContents}/Logseq.desktop $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace Exec=Logseq Exec=${pname} \
        --replace Icon=Logseq Icon=$out/share/${pname}/resources/app/icons/logseq.png
      runHook postInstall
    '';

    postFixup = ''
      makeWrapper ${super.electron_15}/bin/electron $out/bin/${pname} \
        --add-flags $out/share/${pname}/resources/app
    '';

    passthru.updateScript = ./update.sh;
  });
}
