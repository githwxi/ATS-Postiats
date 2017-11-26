(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
//
#define
ATS_EXTERN_PREFIX
"ats2js_bucs320_" //
// prefix for external names
(*
//
// HX:
// DivideConquer
// is entirely template-based
//
#define
ATS_STATIC_PREFIX
"_ats2js_bucs320_divideconquer_"
*)
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload "./../../../basics_js.sats"
//
(* ****** ****** *)
//
#staload "./../../../SATS/bool.sats"
#staload "./../../../SATS/integer.sats"
//
#staload "./../../../SATS/ML/list0.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/BUCS320/DivideConquer/DATS/DivideConquer.dats"
//
(* ****** ****** *)

(* end of [DivideConquer.dats] *)
