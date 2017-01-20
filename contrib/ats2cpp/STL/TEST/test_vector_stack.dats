(* ****** ****** *)
//
// HX-2016-12:
// For testing
// STL/vector_stack
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#staload
"./../DATS/vector_stack.dats"
//
(* ****** ****** *)
//
implement
main0() = () where
{
//
val () =
println!
(
"Hello from [test_vector_stack]!"
) (* end of [val] *)
//
val S0 =
  stack_make_nil<int>()
//
val-(0) = sz2i(length(S0))
//
val () = S0.insert(1)
//
val-(1) = sz2i(length(S0))
//
val () = S0.insert(2)
//
val-(2) = sz2i(length(S0))
//
val-(2) = S0.takeout()
//
val (1) = sz2i(length(S0))
//
val-(1) = S0.takeout()
//
val+true = iseqz(S0)
val+false = isneqz(S0)
//
val (0) = sz2i(length(S0))
//
val ((*freed*)) = stack_free_nil(S0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_vector_stack.dats] *)
