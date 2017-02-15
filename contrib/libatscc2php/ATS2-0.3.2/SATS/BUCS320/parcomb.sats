(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2016-11:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_BUCS320_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)

staload "./../../basics_php.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/BUCS320/parcomb.sats"
//
(* ****** ****** *)

(* end of [parcomb.sats] *)
