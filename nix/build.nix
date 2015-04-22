{
  stdenv, gmp, tarball, version
}:

stdenv.mkDerivation
rec {
  name = "ATS2-Postiats-${version}";
  src = tarball;
  buildInputs = [ gmp ];
}
