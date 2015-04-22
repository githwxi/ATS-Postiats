# author: Shea Levy (sheaATshealevyDOTcom)
{ stdenv
, gmp
, tarball
, version
}:

stdenv.mkDerivation {
  name = "ATS2-Postiats-${version}";
  src = tarball;
  buildInputs = [ gmp ];
}
