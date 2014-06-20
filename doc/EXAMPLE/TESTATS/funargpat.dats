//
// Testing funarg-pattern
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

fn{
a:t@ype
} head (list_cons (x, _): List1(a)): a = x

(* ****** ****** *)

implement
main0 () =
{
val xs = $list{int}(0, 1, 2)
val () = println! ("head[", xs, "] = ", head<int>(xs))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [funargpat.dats] *)
