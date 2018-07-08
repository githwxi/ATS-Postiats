(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_ML_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../../basics_r34.sats"
//
#include "{$LIBATSCC}/SATS/ML/option0.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_option0
  (R34filr, option0(INV(a))): void = "mac#%"
//
overload fprint with fprint_option0 of 100
//
(* ****** ****** *)

(* end of [option0.sats] *)
