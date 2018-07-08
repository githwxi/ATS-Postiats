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
ATS_STATIC_PREFIX "_ats2jspre_option_"
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
#staload "./../SATS/option.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/option.dats"
//
(* ****** ****** *)

(* end of [option.dats] *)
