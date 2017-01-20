(* ****** ****** *)
//
// HX-2016-12:
// For testing
// STL/deque_queue
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#staload
"./../DATS/deque_queue.dats"
//
(* ****** ****** *)

implement
main0() = () where
{
//
val () =
println!
(
"Hello from test_deque_queue!"
) (* end of [val] *)
//
val Q0 =
  queue_make_nil<int>()
//
val-(0) = sz2i(length(Q0))
//
val () = Q0.insert(1)
//
val-(1) = sz2i(length(Q0))
//
val () = Q0.insert(2)
//
val-(2) = sz2i(length(Q0))
//
val-(1) = Q0.takeout()
//
val (1) = sz2i(length(Q0))
//
val-(2) = Q0.takeout()
//
val (0) = sz2i(length(Q0))
//
val ((*freed*)) = queue_free_nil(Q0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_deque_queue.dats] *)
