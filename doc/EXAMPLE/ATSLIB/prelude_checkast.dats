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
val x0 = (5): int
val [i:int] x0 = ckastloc_gintLt(x0, 6)
prval ((*void*)) = prop_verify{i <= 5}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (5): int
val [i:int] x0 = ckastloc_gintLte(x0, 5)
prval ((*void*)) = prop_verify{i <= 5}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (5): int
val [i:int] x0 = ckastloc_gintGt(x0, 4)
prval ((*void*)) = prop_verify{i >= 5}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (5): int
val [i:int] x0 = ckastloc_gintGte(x0, 5)
prval ((*void*)) = prop_verify{i >= 5}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (10): int
val [i:int] x0 = ckastloc_gintBtw(x0, 10, 11)
prval ((*void*)) = prop_verify{10 <= i && i < 11}()
} (* end of [val] *)

(* ****** ****** *)

val () =
{
val x0 = (10): int
val [i:int] x0 = ckastloc_gintBtwe(x0, 10, 11)
prval ((*void*)) = prop_verify{10 <= i && i <= 11}()
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_checkast.dats] *)
