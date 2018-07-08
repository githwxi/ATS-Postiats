(*
** For writing ATS code
** that translates into Erlang
*)

(* ****** ****** *)
//
// HX-2015-07:
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

staload "./../basics_erl.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/list.sats"
//
(* ****** ****** *)

(* end of [list.sats] *)
