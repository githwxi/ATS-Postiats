//
// Testing funarg-pattern
//

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fun{
a:t@ype
} head (cons (x, _): List(a)): a = x

(* ****** ****** *)

implement
main0 () =
{
val xs = $list{int}(0, 1, 2)
val () = println! ("head[", xs, "] = ", head<int>(xs))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [funargpat.dats] *)
