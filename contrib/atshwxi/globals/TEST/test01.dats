(*
** HX-2013-06:
** Statically allocated global references
*)

(* ****** ****** *)

staload I = "intref.dats"
staload F = "floatref.dats"

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
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
