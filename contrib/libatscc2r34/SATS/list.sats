(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_r34.sats"
//
#include "{$LIBATSCC}/SATS/list.sats"
//
(* ****** ****** *)

(* end of [list.sats] *)
