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
#include "{$LIBATSCC}/SATS/ML/array0.sats"
//
(* ****** ****** *)

(* end of [array0.sats] *)
