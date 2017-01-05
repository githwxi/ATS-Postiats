(*
** For ATS2-package relocation
*)
(* ****** ****** *)
//
// HX-2014-08:
// PATSHOME is pre-defined
// PATSHOMERELOC is pre-defined
//
#define
PATSHOME_targetloc "$PATSHOME"
#define
PATSHOMERELOC_targetloc "$PATSHOMERELOC"
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
ATSLANGWEB "http://www.ats-lang.org"
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
#define
PCRE_targetloc "$PATSHOMERELOC/contrib/pcre"
//
(* ****** ****** *)
//
#define
LIBGMP_targetloc "$PATSHOMERELOC/contrib/libgmp"
//
(* ****** ****** *)
//
#define
JSONC_targetloc "$PATSHOMERELOC/contrib/json-c"
//
(* ****** ****** *)
//
#define
HIREDIS_targetloc "$PATSHOMERELOC/contrib/hiredis"
//
(* ****** ****** *)
//
#define
OPENSSL_targetloc "$PATSHOMERELOC/contrib/OpenSSL"
//
(* ****** ****** *)
//
#define
LIBCURL_targetloc "$PATSHOMERELOC/contrib/libcurl"
//
(* ****** ****** *)
//
#define
GTK_targetloc "$PATSHOMERELOC/contrib/GTK"
//
(* ****** ****** *)
//
#define
GLIB_targetloc "$PATSHOMERELOC/contrib/glib"
//
(* ****** ****** *)
//
#define
CAIRO_targetloc "$PATSHOMERELOC/contrib/cairo"
//
(* ****** ****** *)
//
#define
JNI_targetloc "$PATSHOMERELOC/contrib/JNI"
//
(* ****** ****** *)
//
#define
SDL2_targetloc "$PATSHOMERELOC/contrib/SDL2"
//
(* ****** ****** *)
//
#define
GUROBI_targetloc "$PATSHOMERELOC/contrib/gurobi"
//
(* ****** ****** *)
//
#define
KERNELATS_targetloc "$PATSHOMERELOC/contrib/kernelats"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOMERELOC/contrib/libatscc"
//
#define
LIBATSCC2JS_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2js"
//
#define
LIBATSCC2PL_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2pl"
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2py3"
//
#define
LIBATSCC2ERL_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2erl"
//
#define
LIBATSCC2SCM_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2scm"
#define
LIBATSCC2CLJ_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2clj"
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOMERELOC/contrib/libatscc/libatscc2php"
//
(* ****** ****** *)
//
#define
ZLOG_targetloc "$PATSHOMERELOC/contrib/zlog"
//
(* ****** ****** *)
//
#define
ZEROMQ_targetloc "$PATSHOMERELOC/contrib/zeromq"
//
(* ****** ****** *)
//
// HX-2014-05-12:
// This is for backward compatibility
//
#define
LIBATSHWXI_targetloc "$PATSHOMERELOC/contrib/libats-/hwxi"
#define
LIBATS_HWXI_targetloc "$PATSHOMERELOC/contrib/libats-/hwxi"
//
(* ****** ****** *)
//
// For applying ATS to AVR programming
//
#define AVR_targetloc "$PATSHOMERELOC/contrib/AVR"
//
#define ARDUINO_targetloc "$PATSHOMERELOC/contrib/arduino"
//
(* ****** ****** *)
//
// For applying ATS to Linux kernel programming
//
#define LINUX_targetloc "$PATSHOMERELOC/contrib/linux"
//
(* ****** ****** *)
//
// For exporting constraints for solving externally
//
#define EXTSOLVE_targetloc "$PATSHOMERELOC/contrib/extsolve"
//
(* ****** ****** *)
//
#define LIBATSEXT_LIBC_targetloc "$PATSHOMERELOC/libatsext/libc"
//
(* ****** ****** *)

(* end of [atspre_define_pkgreloc.hats] *)
