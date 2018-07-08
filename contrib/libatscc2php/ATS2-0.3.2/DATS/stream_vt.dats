(*
** For writing ATS code
** that translates into PHP
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2phppre_"
#define
ATS_STATIC_PREFIX "_ats2phppre_stream_vt_"
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
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#staload "./../basics_php.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/print.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/list.sats"
#staload "./../SATS/list_vt.sats"
//
#staload "./../SATS/reference.sats"
//
(* ****** ****** *)

#staload "./../SATS/stream.sats"
#staload "./../SATS/stream_vt.sats"

(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/stream_vt.dats"
//
(* ****** ****** *)

(* end of [stream_vt.dats] *)
