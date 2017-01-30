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
"$PATSHOME/contrib/atscntrb-libgmp"
//
#define
LIBPCRE_targetloc
"$PATSHOME/contrib/atscntrb-libpcre"
//
#define
LIBCURL_targetloc
"$PATSHOME/contrib/atscntrb-libcurl"
//
#define
LIBJSONC_targetloc
"$PATSHOME/contrib/atscntrb-libjson-c"
#define
LIBJSON_C_targetloc
"$PATSHOME/contrib/atscntrb-libjson-c"
//
(* ****** ****** *)
//
#define
HX_INTINF_targetloc
"$PATSHOME/contrib/atscntrb-hx-intinf"
#define
HX_CSTREAM_targetloc
"$PATSHOME/contrib/atscntrb-hx-cstream"
#define
HX_GLOBALS_targetloc
"$PATSHOME/contrib/atscntrb-hx-globals"
//
#define
HX_MYTESTING_targetloc
"$PATSHOME/contrib/atscntrb-hx-mytesting"
//
(* ****** ****** *)
//
#define
JNI_targetloc "$PATSCONTRIB/contrib/JNI"
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
ZLOG_targetloc "$PATSCONTRIB/contrib/zlog"
//
(* ****** ****** *)
//
#define
ZEROMQ_targetloc "$PATSCONTRIB/contrib/zeromq"
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
