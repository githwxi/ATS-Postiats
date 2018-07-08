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
ATS_EXTERN_PREFIX "ats2r34pre_"
#define
ATS_STATIC_PREFIX "_ats2r34pre_stream_"
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
//
#staload "./../basics_r34.sats"
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
//
#staload "./../SATS/stream.sats"
//
(* ****** ****** *)
(*
#define ATSCC_ARRAYREF 1
#define ATSCC_REFERENCE 1
*)
(* ****** ****** *)
//
#include "{$LIBATSCC}/DATS/stream.dats"
//
(* ****** ****** *)
//
extern
fun
StreamSubscriptExn_throw{a:vt0p}(): (a) = "mac#%"
//
(* ****** ****** *)

implement
stream_nth_exn
  (xs, n) = let
//
val opt =
  stream_nth_opt(xs, n)
//
in
//
case+ opt of
| ~Some_vt(x) => x
| ~None_vt((*void*)) => StreamSubscriptExn_throw()
//
end // end of [stream_nth_exn]

(* ****** ****** *)

(* end of [stream.dats] *)
