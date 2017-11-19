(* ****** ****** *)
(*
** For writing ATS code
** that translates into Perl5
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../basics_pl.sats"
//
#include "{$LIBATSCC}/SATS/funarray.sats"
//
(* ****** ****** *)

(* end of [funarray.sats] *)
