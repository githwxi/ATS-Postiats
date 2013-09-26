(*
** HX-2013-06:
** Statically allocated global variables
*)

(* ****** ****** *)

staload C1 = "./count1.dats"
staload C2 = "./count2.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("$C1.getinc() = ", $C1.getinc ())
val () = println! ("$C1.getinc() = ", $C1.getinc ())
val () = println! ("$C1.getinc() = ", $C1.getinc ())
//
val () = $C1.reset ()
//
val () = println! ("$C1.getinc() = ", $C1.getinc ())
val () = println! ("$C1.getinc() = ", $C1.getinc ())
val () = println! ("$C1.getinc() = ", $C1.getinc ())
//
val () = $C2.set (10)
val () = println! ("$C2.decget() = ", $C2.decget ())
val () = println! ("$C2.decget() = ", $C2.decget ())
val () = println! ("$C2.decget() = ", $C2.decget ())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test02.dats] *)
