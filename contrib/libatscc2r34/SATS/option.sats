(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2017-10:
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
#include "{$LIBATSCC}/SATS/option.sats"
//
(* ****** ****** *)
//
fun{a:t0p}
fprint_option
  (R34filr, Option(INV(a))): void = "mac#%"
//
(* ****** ****** *)

(* end of [option.sats] *)
