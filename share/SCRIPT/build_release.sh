#!/usr/bin/env sh

######
#
# HX-2018-12-09:
# Submitted by Richard Kent
# after fixes added to support
# the build and release of both
# ATS2-intknd and ATS2-gmpknd
#
######
#
# HX-2018-03-17:
# Created based on a version by
# Brandon Barker
# <brandon dot barker at cornell dot edu>
#
# The following packages are built by the script:
# ATS-Postiats, ATS-Postiats-contrib, and ATS-include
#
######
#
# HX-2018-03-18:
# A typical use of this script
# (for versions 0.3.10+ of ATS only):
# the first argument to the script is the release to be built:
#
# cd /tmp
# sh ${PATSHOME}/share/SCRIPT/build_release.sh 0.3.10
# <
# Upload the following three built packages
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-x.y.z.tgz
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-contrib-x.y.z.tgz
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-include-x.y.z.tgz
# >
# rm -rf /tmp/ATS-Postiats
# rm -rf /tmp/ATS-Postiats-contrib
#
######
######
#
# PWD=$(pwd)
#
######

PATSVERSION=$1

######

GIT=$(which git)
ATSCC=$(which atscc)

######

check_git() {
    if [ -x "$GIT" ] ;
    then echo "$GIT found.";
    else echo "$GIT not found." && exit 1;
    fi
}

######

check_atscc() {
    if [ -x "$ATSCC" ] ;
    then echo "$ATSCC found.";
    else echo "$ATSCC not found." && exit 1;
    fi
}

######

export_pats() {
    export PATSHOME=${PWD}/ATS-Postiats
    export PATSCONTRIB=${PWD}/ATS-Postiats-contrib
}

######

clone_Postiats() {
    $GIT clone --depth 1 \
	 https://github.com/githwxi/ATS-Postiats.git \
	|| (cd ATS-Postiats && $GIT pull origin master)
}

######

clone_Postiats_contrib() {
    $GIT clone --depth 1 \
	 https://github.com/githwxi/ATS-Postiats-contrib.git \
	|| (cd ATS-Postiats-contrib && $GIT pull origin master)
}

######

check_version() {
    if [ -z "$PATSVERSION" ] ; then
	PATSVERSION=$(cat "${PATSHOME}/VERSION")
    fi
}

######

check_ac_init_version() {

    CONFIGURE_AC="${PATSHOME}/doc/DISTRIB/ATS-Postiats/configure.ac"
    AC_INIT_VERSION="AC_INIT([ATS2/Postiats], [${PATSVERSION}], [gmpostiats@gmail.com])"

    if grep -Fxq "$AC_INIT_VERSION" ${CONFIGURE_AC}
    then
	echo "SUCCESS: Correct Postiats version found in configure.ac!"
    else
	echo "FAILURE: Incorrect Postiats version found in configure.ac!"
	#
	# HX: negative exit values are usually for systems code
	#
	exit 1;
    fi
}

######

checkout_build() {
    ( cd "$PATSHOME" && \
	    $GIT checkout -b "tags/v${PATSVERSION}"
    )
}

build_release_int() {
    ( cd "$PATSHOME" && \
      make -f Makefile_devl C3NSTRINTKND=intknd && \
      make -C src -f Makefile CBOOTint && \
      (cp ./bin/*_env.sh.in ./doc/DISTRIB/ATS-Postiats/bin/.) && \
      (cd ./doc/DISTRIB/ATS-Postiats && \
        sh ./autogen.sh && ./configure) && \
      make -C src/CBOOT/libc -f Makefile && \
      make -C src/CBOOT/libats -f Makefile && \
      make -C src/CBOOT/prelude -f Makefile && \
      make -C doc/DISTRIB -f Makefile atspackaging && \
      make -C doc/DISTRIB -f Makefile atspacktarzvcf_int
      make -C doc/DISTRIB -f Makefile_inclats tarzvcf
    )
}

######

build_release_gmp() {
    ( cd "$PATSHOME" && \
      make -f Makefile_devl C3NSTRINTKND=gmpknd && \
      make -C src -f Makefile CBOOTgmp && \
      (cp ./bin/*_env.sh.in ./doc/DISTRIB/ATS-Postiats/bin/.) && \
      (cd ./doc/DISTRIB/ATS-Postiats && \
        sh ./autogen.sh && ./configure) && \
      make -C src/CBOOT/libc -f Makefile && \
      make -C src/CBOOT/libats -f Makefile && \
      make -C src/CBOOT/prelude -f Makefile && \
      make -C doc/DISTRIB -f Makefile atspackaging && \
      make -C doc/DISTRIB -f Makefile atspacktarzvcf_gmp
      make -C doc/DISTRIB -f Makefile_inclats tarzvcf
    )
}

######

build_release_contrib() {
    clone_Postiats_contrib

    ( cd "$PATSHOME" &&
	    make -C doc/DISTRIB -f Makefile atscontribing && \
	    make -C doc/DISTRIB -f Makefile atscontribtarzvcf
    )
}

######

build_cleanall() {
    (cd $PATSHOME && make -f Makefile_devl src_cleanall)
    (cd $PATSHOME && make -f Makefile_devl atslib_cleanall)
}

_usage() {
    echo "$1"
    local usage="usage: $(basename "$0") [VERSION] [KIND]"
    echo "$usage"
    echo "VERSION"
    echo "x.x.x         release version"
    echo
    echo "KIND"
    echo "intknd        ATS2-int: no need for gmplib"
    echo "gmpknd        ATS2-gmp: dependency on gmplib"
    echo "contrib       ATS2-contrib: contributed packages"
    exit
}


main() {

    [ -z "$2" ] && _usage "Please specify build KIND"
    [ -z "$1" ] && _usage "Please specify build VERSION"

    check_git
    check_atscc
    export_pats
    clone_Postiats
    check_version
    check_ac_init_version
    checkout_build

    case "$2" in
	intknd)
	    build_release_int && build_cleanall ;;
	gmpknd)
	    build_release_gmp && build_cleanall ;;
	both)
	    build_release_int && build_cleanall
	    build_release_gmp && build_cleanall ;;
	contrib)
	    build_release_contrib && build_cleanall ;;
	*) _usage ;;
    esac

    ls -alh "$PATSHOME/doc/DISTRIB/"ATS2-*.tgz

}

main "$1" "$2"

###### end of [build_release.sh] ######
