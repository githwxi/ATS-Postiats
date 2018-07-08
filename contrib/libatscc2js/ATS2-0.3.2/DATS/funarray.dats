(* ****** ****** *)
(*
** For writing ATS code
** that translates into Javascript
*)
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
ATS_STATIC_PREFIX "_ats2jspre_funarray_"
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
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
(*
#staload "./../SATS/print.sats"
#staload "./../SATS/filebas.sats"
*)
//
(* ****** ****** *)
//
#staload "./../SATS/funarray.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/funarray.dats"
//
(* ****** ****** *)

(* end of [funarray.dats] *)
