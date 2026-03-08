_:

prev: {
  imagemagick = prev.imagemagick.override {
    openexrSupport = false; # Clears OpenEXR 7.5+ hits
    ghostscriptSupport = false; # Clears Ghostscript 9.0+ hits
    openjpegSupport = false;
  };

  curl = prev.curl.override {
    ldapSupport = false; # Clears 9.8 Criticals
    gssSupport = false;
  };
}
