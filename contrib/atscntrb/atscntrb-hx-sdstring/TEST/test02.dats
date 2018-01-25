(*
** For testing sdstring
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#include "./../mylibies.hats"
#include "./../mylibies_link.hats"
//
#staload $SDSTRING // opening it!
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val
foo = sdsnew("foo")
val
foo1 = sdsdup(foo)
//
val foo2 = sdscat(foo1, "foo")
val foo3 = sdscatsds(foo2, foo)
val () =
println!
("foo3 = ", $UNSAFE.castvwtp1{string}(foo3))
//
val bar3 = sdscpy(foo3, "barbarbar")
val () =
println!
("bar3 = ", $UNSAFE.castvwtp1{string}(bar3))
//
val () = sdstoupper(bar3)
val () =
println!
("BAR3 = ", $UNSAFE.castvwtp1{string}(bar3))
//
val () = sdstolower(bar3)
val () =
println!
("bar3 = ", $UNSAFE.castvwtp1{string}(bar3))
//
val () =
sdsmapchars(bar3, "bar", "foo", i2sz(3))
val () =
println!
("bar3 = ", $UNSAFE.castvwtp1{string}(bar3))
//
val ((*freed*)) = sdsfree(foo)
val ((*freed*)) = sdsfree(bar3)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
