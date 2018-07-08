(*
** HX-2013-06:
** Statically allocated global variables
*)

(* ****** ****** *)

staload I =
{
//
typedef T = int
//
fun initize (x: &T? >> T): void = x := 0
//
#include "./../HATS/globvar.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

staload F =
{
//
typedef T = double
//
fun initize (x: &T? >> T): void = x := 0.0
//
#include "./../HATS/globvar.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("$I.get() = ", $I.get ())
val () = $I.set (1)
val () = println! ("$I.get() = ", $I.get ())
val () = $I.set (2)
val () = println! ("$I.get() = ", $I.get ())
//
val () = println! ("$F.get() = ", $F.get ())
val () = $F.set (1.0)
val () = println! ("$F.get() = ", $F.get ())
val () = $F.set (2.0)
val () = println! ("$F.get() = ", $F.get ())
//
val (pf, fpf | p) = $F.getref ()
val () = !p := 3.0
prval () = fpf (pf)
//
val () = println! ("$F.get() = ", $F.get ())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
