(*
** For writing ATS code
** that translates into Scheme
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2scmpre_"
#define
ATS_STATIC_PREFIX "_ats2scmpre_reference_"
//
(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../basics_scm.sats"
//
(* ****** ****** *)
//
staload "./../SATS/reference.sats"
//
(* ****** ****** *)

(* end of [reference.dats] *)
