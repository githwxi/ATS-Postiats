(*
** For writing ATS code
** that translates into Erlang
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2erlpre_"
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
staload "./../basics_erl.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/intrange.sats"
//
(* ****** ****** *)

(* end of [intrange.sats] *)
