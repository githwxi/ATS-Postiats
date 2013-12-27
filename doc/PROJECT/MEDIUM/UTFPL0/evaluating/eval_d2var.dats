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

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"./../utfpl.sats"
staload
"./../utfpleval.sats"
//
staload "./eval.sats"
//
(* ****** ****** *)

implement
eval_d2var
  (env, d2v) = let
  val opt = d2var_get_bind (d2v)
in
//
if opt > 0
  then let
    val d2e = $UN.cast{d2exp}(opt)
  in
    eval_d2exp (env, d2e)
  end // end of [then]
  else let
    val opt = cloenv_find (env, d2v)
  in
    case+ opt of
    | ~Some_vt (d2u) => d2u | ~None_vt () => VALvar (d2v)
  end // end of [else]
//
end // end of [eval_d2var]

(* ****** ****** *)

(* end of [eval_d2var.dats] *)
