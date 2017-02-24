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
staload "./../SATS/sdstring.sats"
//
staload _ = "./../DATS/sdstring.dats"
//
(* ****** ****** *)

implement
main0((*void*)) =
{
//
val
foo = sdsnew("foo")
val () =
println!
("foo = ", $UNSAFE.castvwtp1{string}(foo))
//
implement{env}
sdstring_foreach$fwork(c, env) = c := toupper(c)
//
val n = sdstring_foreach(foo)
val () =
println!
("foo = ",
  $UNSAFE.castvwtp1{string}(foo))
val () = println! ("length(foo) = ", n)
//
#define i2c int2char0
//
val () =
assertloc (i2c(foo[0]) = 'F')
val () =
assertloc (i2c(foo[1]) = 'O')
val () =
assertloc (i2c(foo[2]) = 'O')
//
val () =
assertloc (sdstring_set_at(foo, 0, 'f') = 0)
val () =
assertloc (sdstring_set_at(foo, 1, 'o') = 0)
val () =
assertloc (sdstring_set_at(foo, 2, 'o') = 0)
val () =
assertloc (sdstring_set_at(foo, 3, '?') < 0)
//
val ((*freed*)) = sdsfree(foo)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test2.dats] *)
