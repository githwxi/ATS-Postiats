(* ****** ****** *)
(*
** Testing code for [json]
*)
(* ****** ****** *)

(*
** Author: Hongwei Xi
** Start Time: May, 2013
** Authoremail: gmhwxiATgmailDOTedu
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/arraylist.sats"

(* ****** ****** *)

implement
main0 () =
{
//
fun free_fn (x: ptr): void = ()
//
val AL = array_list_new (free_fn)
val () = assertloc (ptrcast(AL) > 0)
//
val () = println! ("AL.length = ", array_list_length (AL))
//
val () = assertloc (array_list_add (AL, string2ptr"0") = 0)
val () = println! ("AL.length = ", array_list_length (AL))
//
val () = assertloc (array_list_add (AL, string2ptr"1") = 0)
val () = println! ("AL.length = ", array_list_length (AL))
//
val () = println! ("AL[0] = ", $UN.cast{string}(array_list_get_idx (AL, 0)))
val () = println! ("AL[1] = ", $UN.cast{string}(array_list_get_idx (AL, 1)))
//
val () = array_list_free (AL)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test02.dats] *)
