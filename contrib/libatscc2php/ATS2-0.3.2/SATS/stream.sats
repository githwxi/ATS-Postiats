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
#define
ATS_STATIC_PREFIX "_ats2phppre_stream_"
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
#include "{$LIBATSCC}/SATS/stream.sats"
//
(* ****** ****** *)

(* end of [stream.sats] *)
