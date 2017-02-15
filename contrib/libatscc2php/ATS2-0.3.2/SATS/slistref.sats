(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-09:
// prefix for external names
//
#define
ATS_PACKNAME
"ATSCC2PHP.slistref"
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
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/slistref.sats"
//
(* ****** ****** *)

(* end of [slistref.sats] *)
