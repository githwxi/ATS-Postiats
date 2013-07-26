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

(* end of [coroutine.sats] *)
