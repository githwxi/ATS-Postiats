(* ****** ****** *)
(*
** For writing ATS code
** that translates into PHP
*)
(* ****** ****** *)
//
// HX-2014-10:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../basics_php.sats"
//
#include "{$LIBATSCC}/SATS/matrixref.sats"
//
(* ****** ****** *)

(* end of [matrixref.sats] *)
