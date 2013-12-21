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
eval_d2var
  (env, d2v) = let
  val opt = cloenv_find (env, d2v)
in
  case+ opt of
  | ~Some_vt (d2u) => d2u | ~None_vt () => VALvar (d2v)
end // end of [eval_d2var]

(* ****** ****** *)

(* end of [eval_d2var.dats] *)
