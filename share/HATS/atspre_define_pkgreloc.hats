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
(* ****** ****** *)
//
#define
PATSPRE_targetloc "$PATSHOME/prelude"
#define
PATSLIBC_targetloc "$PATSHOME/libc"
#define
PATSLIBATS_targetloc "$PATSHOME/libats"
//
(* ****** ****** *)
//
#define
ATSLANGWEB "http://www.ats-lang.org"
#define
ATSLANGWEBLIB "http://www.ats-lang.org/LIBRARY"
//
(* ****** ****** *)
//
#define
PCRE_sourceloc "$ATSLANGWEBLIB/contrib/pcre"
#define
PCRE_targetloc "$PATSHOMERELOC/contrib/pcre"
//
(* ****** ****** *)
//
#define
LIBGMP_sourceloc "$ATSLANGWEBLIB/contrib/libgmp"
#define
LIBGMP_targetloc "$PATSHOMERELOC/contrib/libgmp"
//
(* ****** ****** *)
//
#define
ZLOG_targetloc "$PATSHOMERELOC/contrib/zlog"
//
(* ****** ****** *)
//
#define
JSONC_sourceloc "$ATSLANGWEBLIB/contrib/json-c"
#define
JSONC_targetloc "$PATSHOMERELOC/contrib/json-c"
//
(* ****** ****** *)
//
#define
HIREDIS_sourceloc "$ATSLANGWEBLIB/contrib/hiredis"
#define
HIREDIS_targetloc "$PATSHOMERELOC/contrib/hiredis"
//
(* ****** ****** *)
//
#define
OPENSSL_sourceloc "$ATSLANGWEBLIB/contrib/OpenSSL"
#define
OPENSSL_targetloc "$PATSHOMERELOC/contrib/OpenSSL"
//
(* ****** ****** *)
//
#define
LIBCURL_sourceloc "$ATSLANGWEBLIB/contrib/libcurl"
#define
LIBCURL_targetloc "$PATSHOMERELOC/contrib/libcurl"
//
(* ****** ****** *)
//
#define
GLIB_sourceloc "$ATSLANGWEBLIB/contrib/glib"
#define
GLIB_targetloc "$PATSHOMERELOC/contrib/glib"
//
(* ****** ****** *)
//
#define
GTK_sourceloc "$ATSLANGWEBLIB/contrib/GTK"
#define
GTK_targetloc "$PATSHOMERELOC/contrib/GTK"
//
(* ****** ****** *)
//
#define
CAIRO_sourceloc "$ATSLANGWEBLIB/contrib/cairo"
#define
CAIRO_targetloc "$PATSHOMERELOC/contrib/cairo"
//
(* ****** ****** *)
//
#define
SDL2_targetloc "$PATSHOMERELOC/contrib/SDL2"
//
(* ****** ****** *)
//
#define
JNI_targetloc "$PATSHOMERELOC/contrib/JNI"
//
(* ****** ****** *)
//
#define
HTML_targetloc "$PATSHOMERELOC/contrib/HTML"
//
#define
HTML5canvas2d_targetloc "$PATSHOMERELOC/contrib/HTML/canvas-2d"
//
(* ****** ****** *)
//
// HX-2014-05-12:
// This is for backward compatibility
//
#define
LIBATSHWXI_sourceloc "$ATSLANGWEBLIB/contrib/libats-/hwxi"
#define
LIBATSHWXI_targetloc "$PATSHOMERELOC/contrib/libats-/hwxi"
//
#define
LIBATS_HWXI_sourceloc "$ATSLANGWEBLIB/contrib/libats-/hwxi"
#define
LIBATS_HWXI_targetloc "$PATSHOMERELOC/contrib/libats-/hwxi"
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
LIBATSCC2PY_targetloc "$PATSHOMERELOC/contrib/libatscc2py"
//
#define
LIBATSCC2JS_targetloc "$PATSHOMERELOC/contrib/libatscc2js"
//
(* ****** ****** *)

(* end of [atspre_define_pkgreloc.hats] *)
