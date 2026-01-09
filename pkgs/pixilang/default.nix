{
  stdenv,
  autoPatchelfHook,
  fetchzip,
  SDL2,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pixilang";
  version = "3.8.6f";

  src = fetchzip {
    urls = [
      "https://www.warmplace.ru/soft/${finalAttrs.pname}/${finalAttrs.pname}-${finalAttrs.version}.zip"
    ];
    hash = "sha256-E3xrthCcjRaBUlpt45JwRgyjJWOKbrG5OYcBrCFBd4U=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    SDL2
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv pixilang3/bin/linux_x86_64/* $out/bin/

    runHook postInstall
  '';
})
