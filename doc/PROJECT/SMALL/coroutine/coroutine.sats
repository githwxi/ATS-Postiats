//
// A simple implementation of Co-routines
//
(* ****** ****** *)

abstype
coroutine_type (inp: t@ype-, out: t@ype+)

(* ****** ****** *)

stadef cortn = coroutine_type
stadef coroutine = coroutine_type

(* ****** ****** *)

abstype event_type (a: t@ype+)
typedef event (a:t0p) = event_type (a)

(* ****** ****** *)

fun{a,b:t0p}
co_run (co: &cortn (a, b) >> _, x: a): b

fun{a,b:t0p}
co_run_seq{n:int}
  (co: &cortn (a, b) >> _, xs: list (a, n)): list_vt (b, n)
// end of [co_run_seq]

(* ****** ****** *)

(* end of [coroutine.sats] *)
