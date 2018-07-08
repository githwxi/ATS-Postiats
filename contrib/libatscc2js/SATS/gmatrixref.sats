(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-10:
// prefix for external names
//
#define
ATS_PACKNAME
"ATSCC2JS.gmatrixref"
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_js.sats"
//
#include "{$LIBATSCC}/SATS/gmatrixref.sats"
//
(* ****** ****** *)

(* end of [gmatrixref.sats] *)
