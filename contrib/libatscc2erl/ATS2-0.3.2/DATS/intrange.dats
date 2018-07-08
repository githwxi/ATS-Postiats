(*
** For writing ATS code
** that translates into Erlang
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2erlpre_"
#define
ATS_STATIC_PREFIX "_ats2erlpre_intrange_"
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
staload "./../SATS/list.sats"
//
staload "./../SATS/integer.sats"
//
staload "./../SATS/intrange.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/intrange.dats"
//
(* ****** ****** *)

(* end of [intrange.dats] *)
