(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload "./../basics_php.sats"
//
(* ****** ****** *)
//
#include "{$LIBATSCC}/SATS/stream_vt.sats"
//
(* ****** ****** *)

(* end of [stream_vt.sats] *)
