(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_ML_"
#define
ATS_STATIC_PREFIX "_ats2r34pre_ML_option0_"
//
(* ****** ****** *)
//
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../../basics_r34.sats"
//
(* ****** ****** *)
//
#staload "./../../SATS/ML/option0.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/ML/option0.dats"
//
(* ****** ****** *)

(* end of [option0.dats] *)
