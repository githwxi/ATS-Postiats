(* ****** ****** *)
(*
** For writing ATS code
** that translates into R(stat)
*)
(* ****** ****** *)
//
// HX-2017-10:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2r34pre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME/contrib/libatscc"
//
#staload "./../basics_r34.sats"
//
#include "{$LIBATSCC}/SATS/stream.sats"
//
(* ****** ****** *)
//
fun
stream_nth_exn
  {a:t0p}
(
  xs: stream(INV(a)), n: intGte(0)
) : (a) = "mac#%" // end-of-function
//
overload [] with stream_nth_exn of 100
//
(* ****** ****** *)

(* end of [stream.sats] *)
