(*
** Implementing UTFPL
** with substitution-based evaluation
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "./../utfpl.sats"

(* ****** ****** *)

staload "./eval_subst.sats"

(* ****** ****** *)
//
dynload "../dynloadall.dats"
//
dynload "./eval_subst.sats"
dynload "./eval_subst.dats"

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
