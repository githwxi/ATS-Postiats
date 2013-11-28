(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "./parsing.sats"

(* ****** ****** *)
//
dynload "../dynloadall.dats"
//
dynload "./parsing.sats"
dynload "./parsing.dats"
dynload "./parsing_d2var.dats"
dynload "./parsing_p2at.dats"
dynload "./parsing_d2exp.dats"
dynload "./parsing_d2ecl.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () = println! ("Hello from [parsing]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
