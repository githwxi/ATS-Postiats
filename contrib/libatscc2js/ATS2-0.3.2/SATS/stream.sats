(* ****** ****** *)
(*
** For writing ATS code
** that translates into JavaScript
*)
(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2jspre_"
//
(* ****** ****** *)
//
#define
LIBATSCC_targetloc
"$PATSHOME\
/contrib/libatscc/ATS2-0.3.2"
//
#staload "./../basics_js.sats"
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
