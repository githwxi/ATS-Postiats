(*
** testing code for GNU-readline
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

staload "./../SATS/history.sats"
staload "./../SATS/readline.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val line =
  readline ("Please enter: ")
//
val () = println! ("line = ", line)
//
val () = strptr_free (line)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
