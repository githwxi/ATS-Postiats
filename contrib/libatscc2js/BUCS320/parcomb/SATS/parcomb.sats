(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2016-11:
//
#define
ATS_EXTERN_PREFIX
"ats2js_bucs320_" //
// prefix for external names
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
#staload
"{$LIBATSCC2JS}/basics_js.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/BUCS320/parcomb/SATS/parcomb.sats"
//
(* ****** ****** *)

(* end of [parcomb.sats] *)
