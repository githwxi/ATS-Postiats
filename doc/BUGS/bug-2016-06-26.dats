(* ****** ****** *)
//
// Reported by
// AR-2016-06-26
//
(* ****** ****** *)
//
// HX-2016-06-26:
// fixed by removing a call to d3exp_set_type
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

fun
foo
(
// argless
) : void =
{
//
(*
//
// HX: this is fine:
//
val x = '(1, 2)
val res1 = $showtype(cons0 ( x, nil0 () ))
*)
//
val res2 = $showtype(cons0( '(1, 2), nil0() ))
//
} (* end of [foo] *)

(* ****** ****** *)

implement main0 (): void = ()

(* ****** ****** *)

(* end of [bug-2016-06-26.dats] *)
