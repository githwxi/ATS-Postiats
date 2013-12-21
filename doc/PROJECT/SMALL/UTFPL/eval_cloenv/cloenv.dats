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

staload "libats/SATS/funmap_list.sats"
staload _ = "libats/DATS/funmap_list.dats"

(* ****** ****** *)
//
typedef key = d2var
typedef itm = value
//
assume cloenv_type = map (key, itm)
//
(* ****** ****** *)

implement
equal_key_key<d2var>
  (d2v1, d2v2) = (d2v1 = d2v2)
// end of [equal_key_key]

(* ****** ****** *)

implement
cloenv_nil () = funmap_nil ()

(* ****** ****** *)

implement
cloenv_extend
  (env, d2v, _val) = env where
{
//
var env = env
val () = funmap_insert_any<key,itm> (env, d2v, _val)
} (* end of [cloenv_extend] *)

(* ****** ****** *)

implement
cloenv_extend_arg
  (env, p2t, d2u) = let
in
//
case+
p2t.p2at_node of
//
| P2Tany () => env
| P2Tvar (d2v) => cloenv_extend (env, d2v, d2u)
//
| P2Tempty () => env
//
| P2Tpat (p2t) => cloenv_extend_arg (env, p2t, d2u)
//
| P2Tignored () => env
//
end // end of [cloenv_extend_arg]

(* ****** ****** *)

implement
cloenv_extend_arglst
  (env, p2ts, d2us) = let
in
//
case+ p2ts of
| list_nil () => env
| list_cons (p2t, p2ts) =>
  (
    case+ d2us of
    | list_nil () => env
    | list_cons
        (d2u, d2us) => let
        val env =
          cloenv_extend_arg (env, p2t, d2u)
        // end of [val]
      in
        cloenv_extend_arglst (env, p2ts, d2us)
      end // end of [list_cons]
  ) (* end of [list_cons] *)
//
end // end of [cloenv_extend_arglst]

(* ****** ****** *)

implement
cloenv_find_exn (env, d2v) = let
//
var res: value?
val ans = funmap_search<key,itm> (env, d2v, res)
//
in
//
if ans
  then
    opt_unsome_get<itm> (res)
  // end of [then]
  else let
    prval () = opt_unnone{itm}(res) in $raise UnboundVarExn(d2v)
  end // end of [else]
//
end // end of [cloenv_find_exn]

(* ****** ****** *)

(* end of [cloenv.dats] *)
