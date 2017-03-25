(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_BUCS320_"
(*
//
HX: DivideConquer is entirely template-based
//
#define
ATS_STATIC_PREFIX "_ats2jspre_BUCS320_DivideConquer_"
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
