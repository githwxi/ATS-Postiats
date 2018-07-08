(* ****** ****** *)
(*
** For writing ATS code
** that translates into Perl
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
ATS_EXTERN_PREFIX "ats2plpre_"
#define
ATS_STATIC_PREFIX "_ats2plpre_qlistref_"
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
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include "./../staloadall.hats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/qlistref.dats"
//
(* ****** ****** *)

(* end of [qlistref.dats] *)
