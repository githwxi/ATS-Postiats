(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_BUCS320_"
#define
ATS_STATIC_PREFIX "_ats2phppre_BUCS320_parcomb_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"./../../../basics_php.sats"
//
(* ****** ****** *)
//
staload "./../../../SATS/list.sats"
staload "./../../../SATS/list_vt.sats"
//
(* ****** ****** *)
//
staload
"./../../../SATS/BUCS320/parcomb.sats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC}/DATS/BUCS320/parcomb/parcomb.dats"
//
(* ****** ****** *)

(* end of [parcomb.dats] *)
