_: _final: prev: {
  # Strip ImageMagick: Handled via standard .override
  imagemagick = prev.imagemagick.override {
    openexrSupport = false;
    ghostscriptSupport = false;
    openjpegSupport = false;
  };

  # Strip Curl: Handled via standard .override
  #curl = prev.curl.override {
  #  ldapSupport = false;
  #  gssSupport = false;
  #};

  # Strip libjxl: Must use overrideAttrs because it doesn't
  # expose openexrSupport as a top-level function argument.
  libjxl = prev.libjxl.overrideAttrs (oldAttrs: {
    buildInputs =
      (oldAttrs.buildInputs or [ ])
      ++ (
        # We filter out openexr from the list of inputs
        builtins.filter (pkg: (pkg.pname or "") != "openexr") oldAttrs.buildInputs
      );
    # Also disable any explicit cmake flags if they exist
    cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [
      "-DJPEGXL_ENABLE_OPENEXR=OFF"
    ];
  });
}
