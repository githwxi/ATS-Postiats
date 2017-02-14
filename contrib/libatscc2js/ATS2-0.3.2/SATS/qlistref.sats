(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_PACKNAME
"ATSCC2JS.qlistref"
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../basics_js.sats"
//
#include "{$LIBATSCC}/SATS/qlistref.sats"
//
(* ****** ****** *)

(* end of [qlistref.sats] *)
