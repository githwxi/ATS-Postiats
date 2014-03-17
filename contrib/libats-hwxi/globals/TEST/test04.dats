(*
** HX-2013-06:
** Toplevel list-based stack
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

dynload "./gdeqarray.dats"

(* ****** ****** *)

staload D = "./gdeqarray.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("$D.get_size() = ", $D.get_size())
val () = println! ("$D.get_capacity() = ", $D.get_capacity())
//
val () = $D.insert_atbeg_exn (1.0)
val~None_vt() = $D.insert_atbeg_opt (2.0)
val () = println! ("$D.get_size() = ", $D.get_size())
val x1 = $D.takeout_atend_exn ()
val () = assertloc (x1 = 1.0)
val~Some_vt (x2) = $D.takeout_atend_opt ()
val () = assertloc (x2 = 2.0)
val () = println! ("$D.get_size() = ", $D.get_size())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test04.dats] *)
