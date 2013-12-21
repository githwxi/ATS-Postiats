(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../utfpl.sats"
//
staload "./eval.sats"
//
(* ****** ****** *)
//
dynload
"../dynloadall.dats"
//
dynload "./eval.sats"
dynload "./print.dats"
dynload "./cloenv.dats"
dynload "./eval_d2cst.dats"
dynload "./eval_d2var.dats"
dynload "./eval_d2sym.dats"
dynload "./eval_d2exp.dats"
dynload "./eval_d2ecl.dats"
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
