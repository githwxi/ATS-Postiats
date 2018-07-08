(*
** For writing ATS code
** that translates into R(stat)
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
#define
ATS_STATIC_PREFIX "_ats2r34pre_list_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
(* ****** ****** *)
//
#staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#staload "./../basics_r34.sats"

(* ****** ****** *)
//
#staload "./../SATS/integer.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/print.sats"
#staload "./../SATS/filebas.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/list.sats"
//
(* ****** ****** *)
//
#staload "./../SATS/stream.sats"
#staload _ = "./../DATS/stream.dats"
//
#staload "./../SATS/stream_vt.sats"
#staload _ = "./../DATS/stream_vt.dats"
//
(* ****** ****** *)

#define ATSCC_STREAM 1
#define ATSCC_STREAM_VT 1

(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/list.dats"
//
(* ****** ****** *)

(* end of [list.dats] *)
