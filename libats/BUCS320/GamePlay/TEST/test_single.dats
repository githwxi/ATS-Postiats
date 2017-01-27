(*
** For testing
** GamePlay_single.dats
*)

(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"./../DATS/GamePlay_single.dats"
//
(* ****** ****** *)

implement
main0() = () where
{
//
val S0 =
$UN.cast{state}(the_null_ptr)
//
val () = GamePlay$main_loop(S0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test_single.dats] *)
