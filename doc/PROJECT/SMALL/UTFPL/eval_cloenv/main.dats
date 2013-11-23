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

staload "./eval_cloenv.sats"

(* ****** ****** *)
//
dynload "../dynloadall.dats"
//
dynload "./eval_cloenv.sats"
dynload "./print.dats"
dynload "./cloenv.dats"
dynload "./eval_cloenv.dats"
//
(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
val () = println! ("Hello from [eval_cloenv]!")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [main.dats] *)
