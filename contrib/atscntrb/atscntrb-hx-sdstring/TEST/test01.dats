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
val () =
assertloc(ptrcast(foo) > the_null_ptr)
//
val () =
println! ("foo = ", $UNSAFE.castvwtp1{string}(foo))
//
val foobar = sdscat(foo, "bar")
val () =
assertloc(ptrcast(foobar) > the_null_ptr)
//
val () =
println! ("foobar = ", $UNSAFE.castvwtp1{string}(foobar))
//
val ((*freed*)) = sdsfree(foobar)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
