(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)
//
// HX-2014-10:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./../basics_scm.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/arrayref.sats"
//
(* ****** ****** *)

(* end of [arrayref.sats] *)
