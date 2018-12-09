#!/usr/bin/env sh

######
#
# HX-2018-03-17:
# Created based on a version of
# Brandon Barker
# <brandon dot barker at cornell dot edu>
#
# The following packages are built by the script:
# ATS-Postiats, ATS-Postiats-contrib, and ATS-include
#
######
#
# HX-2018-03-18:
# Here is a typical use of this script (for versions 0.3.10+ of ATS only);
# the first argument to the script is the release to be built:
#
# cd /tmp
# sh ${PATSHOME}/share/SCRIPT/buildRelease.sh 0.3.10
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

# PWD=$(pwd)
PATSVERSION=$1
GIT=$(which git)
ATSCC=$(which atscc)

######

check_git() {
    if [ -x "$GIT" ] ; 
    then echo "$GIT found.";
    else echo "$GIT not found." exit 1;
    fi
}

######

check_atscc() {
    if [ -x "$ATSCC" ] ; 
    then echo "$ATSCC found.";
    else echo "$ATSCC not found." exit 1;
    fi
}

######

export_pats() {
    export PATSHOME=${PWD}/ATS-Postiats
    export PATSCONTRIB=${PWD}/ATS-Postiats-contrib
}

######

clone_ATS_Postiats() {
    $GIT clone --depth 1\
	 https://github.com/sparverius/ATS-Postiats.git \
	|| (cd ATS-Postiats && $GIT pull origin master)
        # https://github.com/githwxi/ATS-Postiats.git \
}

######

clone_ATS_Postiats_contrib() {
    $GIT clone --depth 1\
	 https://github.com/githwxi/ATS-Postiats-contrib.git \
	|| (cd ATS-Postiats-contrib && $GIT pull origin master)
}

######

check_version() {
    if [ -z "$PATSVERSION" ] ; then
	PATSVERSION=$(cat "${PATSHOME}/VERSION")
    fi
}

check_ac_init_version() {
    AC_INIT_VERSION="AC_INIT([ATS2/Postiats], [${PATSVERSION}], [gmpostiats@gmail.com])"
    if grep -Fxq "$AC_INIT_VERSION" "${PATSHOME}/doc/DISTRIB/ATS-Postiats/configure.ac"
    then
	echo "Correct version found in configure.ac"
    else
	echo "Failure: Didn't find correct Postiats version for AC_INIT in configure.ac!"
	exit -1;
    fi
}

######

checkout_build() {
    (cd "$PATSHOME" && \
	 $GIT checkout -b "tags/v${PATSVERSION}")
}

build_release_intmin() {
    (cd "$PATSHOME" && \
	 make -f Makefile_devl C3NSTRINTKND=intknd && \
	 make -C src -f Makefile CBOOTint && \
	 (cp ./bin/*_env.sh.in ./doc/DISTRIB/ATS-Postiats/bin/.) && \
	 (cd ./doc/DISTRIB/ATS-Postiats && \
	      sh ./autogen.sh && ./configure) && \
	 make -C src/CBOOT/libc -f Makefile && \
	 make -C src/CBOOT/libats -f Makefile && \
	 make -C src/CBOOT/prelude -f Makefile && \
	 make -C doc/DISTRIB -f Makefile atspackaging && \
	 make -C doc/DISTRIB -f Makefile atspacktarzvcf_intmin
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
	    make -C doc/DISTRIB -f Makefile atspacktarzvcf && \
	    make -C doc/DISTRIB -f Makefile atscontribing && \
	    make -C doc/DISTRIB -f Makefile atscontribtarzvcf && \
	    make -C doc/DISTRIB -f Makefile_inclats tarzvcf
    )
}

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
    echo "intknd        ats-intmin"
    echo "gmpknd        full ats install"
    echo "all           to build both"
    exit
}


main() {

    [ -z "$1" ] && _usage "Please specify build VERSION and KIND"
    [ -z "$2" ] && _usage "Please specify build KIND"

    check_git 
    check_atscc
    export_pats
    clone_ATS_Postiats
    clone_ATS_Postiats_contrib
    check_version
    check_ac_init_version

    checkout_build


    case "$2" in
	gmpknd) build_release_gmp ;;
	intknd) build_release_intmin ;;
	all)
	    build_release_intmin && \
		build_cleanall && \
		build_release_gmp
	    ;;
	*) _usage ;; 
    esac

    ls -alh "$PATSHOME/doc/DISTRIB/"ATS2-*.tgz

}

main "$1" "$2"

###### end of [buildRelease.sh] ######
