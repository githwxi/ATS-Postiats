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

dynload "./eval_subst.dats"

(* ****** ****** *)

implement
main0 (argc, argv) =
{
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test.dats] *)
