######
#
# Author: Shea Levy
# Authoremail: sheaATshealevyDOTcom
# Start time: April, 2015
#
######

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
