(*
** for testing [prelude/checkast]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () =
{
val x0 = (10): int
val [i:int] x0 = ckastloc_intLte(x0, 10)
prval ((*void*)) = prop_verify{i <= 10}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (10): int
val [i:int] x0 = ckastloc_intGte(x0, 10)
prval ((*void*)) = prop_verify{i >= 10}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (10): int
val [i:int] x0 = ckastloc_intBtw(x0, 10, 11)
prval ((*void*)) = prop_verify{10 <= i && i < 11}()
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_checkast.dats] *)
