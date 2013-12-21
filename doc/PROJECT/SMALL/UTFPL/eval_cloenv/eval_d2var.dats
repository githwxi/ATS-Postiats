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

implement
eval_d2var (env, d2v) = cloenv_find_exn (env, d2v)

(* ****** ****** *)

(* end of [eval_d2var.dats] *)
