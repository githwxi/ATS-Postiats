(*
** For package reloc
*)
(* ****** ****** *)
//
// HX-2014-08:
// PATSHOME is pre-defined
// PATSCONTRIB is pre-defined
//
#define
PATSHOME_targetloc "$PATSHOME"
#define
PATSCONTRIB_targetloc "$PATSCONTRIB"
//
// HX-2016-01-05:
// PATSHOMERELOCS is *SPECIALLY* treated!
//
#define
PATSHOMERELOCS_targetloc "$PATSHOMERELOCS"
//
(* ****** ****** *)
//
#define
PATSPRE_targetloc "$PATSHOME/prelude"
#define
PATSLIBATS_targetloc "$PATSHOME/libats"
#define
PATSLIBATSML_targetloc "$PATSHOME/libats/ML"
#define
PATSLIBATSLIBC_targetloc "$PATSHOME/libats/libc"
//
(* ****** ****** *)
//
(*
#define
ATSLANGWEB "http://www.ats-lang.org"
#define
ATSLANGORG "http://www.ats-lang.org"
#define
ATSLANGCOM "http://www.ats-lang.com"
*)
//
(* ****** ****** *)
//
#define
LIBGMP_targetloc
"$PATSHOME/atscntrb/atscntrb-libgmp"
//
#define
LIBJSONC_targetloc
"$PATSHOME/atscntrb/atscntrb-libjson-c"
#define
LIBJSON_C_targetloc
"$PATSHOME/atscntrb/atscntrb-libjson-c"
//
(* ****** ****** *)
//
#define
HX_INTINF_targetloc
"$PATSHOME/atscntrb/atscntrb-hx-intinf"
#define
HX_CSTREAM_targetloc
"$PATSHOME/atscntrb/atscntrb-hx-cstream"
#define
HX_GLOBALS_targetloc
"$PATSHOME/atscntrb/atscntrb-hx-globals"
//
#define
HX_MYTESTING_targetloc
"$PATSHOME/atscntrb/atscntrb-hx-mytesting"
//
(* ****** ****** *)
//
#define
PCRE_targetloc "$PATSCONTRIB/contrib/pcre"
//
(* ****** ****** *)
//
#define
HIREDIS_targetloc "$PATSCONTRIB/contrib/hiredis"
//
(* ****** ****** *)
//
#define
OPENSSL_targetloc "$PATSCONTRIB/contrib/OpenSSL"
//
(* ****** ****** *)
//
#define
LIBCURL_targetloc "$PATSCONTRIB/contrib/libcurl"
//
(* ****** ****** *)
//
#define
GTK_targetloc "$PATSCONTRIB/contrib/GTK"
//
(* ****** ****** *)
//
#define
GLIB_targetloc "$PATSCONTRIB/contrib/glib"
//
(* ****** ****** *)
//
#define
CAIRO_targetloc "$PATSCONTRIB/contrib/cairo"
//
(* ****** ****** *)
//
#define
JNI_targetloc "$PATSCONTRIB/contrib/JNI"
//
(* ****** ****** *)
//
#define
SDL2_targetloc "$PATSCONTRIB/contrib/SDL2"
//
(* ****** ****** *)
//
#define
GUROBI_targetloc "$PATSCONTRIB/contrib/gurobi"
//
(* ****** ****** *)
//
#define
KERNELATS_targetloc "$PATSCONTRIB/contrib/kernelats"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSCONTRIB/contrib/libatscc"
//
#define
LIBATSCC2JS_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2js"
//
#define
LIBATSCC2PL_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2pl"
//
#define
LIBATSCC2PY3_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2py3"
//
#define
LIBATSCC2ERL_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2erl"
//
#define
LIBATSCC2SCM_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2scm"
#define
LIBATSCC2CLJ_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2clj"
//
#define
LIBATSCC2PHP_targetloc
"$PATSCONTRIB/contrib/libatscc/libatscc2php"
//
(* ****** ****** *)
//
#define
ZLOG_targetloc "$PATSCONTRIB/contrib/zlog"
//
(* ****** ****** *)
//
#define
ZEROMQ_targetloc "$PATSCONTRIB/contrib/zeromq"
//
(* ****** ****** *)
//
// HX-2014-05-12:
// This is for backward compatibility
//
#define
LIBATSHWXI_targetloc "$PATSCONTRIB/contrib/libats-/hwxi"
#define
LIBATS_HWXI_targetloc "$PATSCONTRIB/contrib/libats-/hwxi"
//
(* ****** ****** *)
//
// For applying ATS to AVR programming
//
#define AVR_targetloc "$PATSCONTRIB/contrib/AVR"
//
#define ARDUINO_targetloc "$PATSCONTRIB/contrib/arduino"
//
(* ****** ****** *)
//
// For applying ATS to Linux kernel programming
//
#define LINUX_targetloc "$PATSCONTRIB/contrib/linux"
//
(* ****** ****** *)
//
// For exporting constraints for solving externally
//
#define EXTSOLVE_targetloc "$PATSCONTRIB/contrib/extsolve"
//
(* ****** ****** *)
//
#define LIBATSEXT_LIBC_targetloc "$PATSCONTRIB/libatsext/libc"
//
(* ****** ****** *)

(* end of [atspre_define_pkgreloc.hats] *)
