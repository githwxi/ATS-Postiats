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
ATS_EXTERN_PREFIX
"ats2jspre_BUCS320_"
#define
ATS_STATIC_PREFIX
"_ats2jspre_BUCS320_parcomb_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
"./../../../basics_js.sats"
//
(* ****** ****** *)
//
#staload "./../../../SATS/list.sats"
#staload "./../../../SATS/list_vt.sats"
//
(* ****** ****** *)
//
#staload
"./../../../SATS/BUCS320/parcomb.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/DATS/BUCS320/parcomb/parcomb.dats"
//
(* ****** ****** *)

(* end of [parcomb.dats] *)
