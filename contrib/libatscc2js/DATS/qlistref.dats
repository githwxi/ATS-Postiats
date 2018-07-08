(*
** For writing ATS code
** that translates into JavaScript
*)

(* ****** ****** *)
//
// HX: list-based queue
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
#define
ATS_STATIC_PREFIX "_ats2jspre_qlistref_"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#include "{$LIBATSCC}/DATS/qlistref.dats"
//
(* ****** ****** *)

(* end of [qlistref.dats] *)
