######
#
# Author: Shea Levy
# Authoremail: sheaATshealevyDOTcom
# Start time: April, 2015
#
######

{ stdenv
, ats
, gmp
, autoconf
, automake
, version
}:

stdenv.mkDerivation rec {
  name = "ATS2-Postiats-${version}.tgz";

  buildInputs = [ autoconf automake gmp ];

  src = builtins.filterSource (path: type:
    (toString path) != (toString ../.git)
  ) ../.;

  ATSHOME = "${ats}/lib/ats-anairiats-${ats.version}";

  ATSHOMERELOC = "ATS-${ats.version}";

  configurePhase = ''
    patchShebangs doc/DISTRIB/ATS-Postiats/autogen.sh
    export PATSHOME=$PWD
    make -f codegen/Makefile_atslib
  '';
 
  buildPhase = ''
    make -C src all
    make -C src CBOOT
    make -C src/CBOOT/prelude
    make -C src/CBOOT/libc
    make -C src/CBOOT/libats
    make -C doc/DISTRIB atspackaging
    make -C doc/DISTRIB atspacktarzvcf
  '';

  installPhase = ''
    mv doc/DISTRIB/${name} $out
  '';

  shellHook = ''
    export PATSHOME=$PWD
    source ./nix/path_hack.sh
  '';
}
