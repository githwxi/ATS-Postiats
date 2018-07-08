(*
** For writing ATS code
** that translates into Clojure
*)

(* ****** ****** *)
//
// HX: list-bsaed stack
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2cljpre_"
#define
ATS_STATIC_PREFIX "_ats2cljpre_slistref_"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#include "./../staloadall.hats"
//
#include "{$LIBATSCC}/DATS/slistref.dats"
//
(* ****** ****** *)

(* end of [slistref.dats] *)
