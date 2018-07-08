(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
#define
ATS_DYNLOADFLAG 0
//
(* ****** ****** *)
//
(*
HX-2014-08:
*)
//
#define
ATS_EXTERN_PREFIX
"ats2js_bucs320_"
#define
ATS_STATIC_PREFIX
"_ats2js_bucs320_parcomb_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
#define
LIBATSCC2JS_targetloc
"$PATSHOME/contrib/libatscc2js"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/mylibies.hats"
//
(* ****** ****** *)
//
#staload "./../SATS/parcomb.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/BUCS320/parcomb/DATS/parcomb.dats"
//
(* ****** ****** *)

(* end of [parcomb.dats] *)
