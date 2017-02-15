(*
** For writing ATS code
** that translates into Python3
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2pypre_BUCS320_"
#define
ATS_STATIC_PREFIX "_ats2pypre_BUCS320_parcomb_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
(* ****** ****** *)
//
#staload
"./../../../basics_py.sats"
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
