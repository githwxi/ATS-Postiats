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
ATS_STATIC_PREFIX "_ats2scmpre_stream_vt_"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload "./../basics_scm.sats"
//
(* ****** ****** *)
//
staload "./../SATS/bool.sats"
staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
staload "./../SATS/print.sats"
//
(* ****** ****** *)
//
staload "./../SATS/list.sats"
staload "./../SATS/list_vt.sats"
//
staload "./../SATS/reference.sats"
//
(* ****** ****** *)

staload "./../SATS/stream.sats"
staload "./../SATS/stream_vt.sats"

(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc/ATS2-0.3.2"
//
#include "{$LIBATSCC}/DATS/stream_vt.dats"
//
(* ****** ****** *)

(* end of [stream_vt.dats] *)
