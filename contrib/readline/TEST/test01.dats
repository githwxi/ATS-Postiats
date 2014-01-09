(*
** testing code for GNU-readline
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/readline.sats"

(* ****** ****** *)

implement
main0 () = () where
{
//
val line = readline ("Enter a line: ")
val ((*void*)) = println! ("line = ", line)
val ((*void*)) = strptr_free (line)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)
