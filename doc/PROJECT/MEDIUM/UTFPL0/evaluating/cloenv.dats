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
staload
"libats/SATS/funmap_list.sats"
staload _ =
"libats/DATS/funmap_list.dats"
//
(* ****** ****** *)
//
typedef key = d2var
typedef itm = value
//
assume cloenv_type = map (key, itm)
//
(* ****** ****** *)

implement
equal_key_key<d2var> (d2v1, d2v2) = (d2v1 = d2v2)

(* ****** ****** *)

implement
cloenv_nil () = funmap_nil ()

(* ****** ****** *)

local

implement
fprint_val<key> = fprint_d2var
implement
fprint_val<itm> = fprint_value

in (* in of [local] *)

implement
fprint_cloenv (out, env) = fprint_funmap<key,itm> (out, env)

end // end of [local]

(* ****** ****** *)

implement
cloenv_extend
  (env, d2v, d2u) = env where
{
(*
//
val out = stdout_ref
val () =
fprintln! (out, "cloenv_extend: d2v = ", d2v)
val () =
fprintln! (out, "cloenv_extend: d2u = ", d2u)
//
*)
var env = env
val () = funmap_insert_any<key,itm> (env, d2v, d2u)
(*
val () = fprintln! (out, "cloenv_extend: env = ", env)
*)
} (* end of [cloenv_extend] *)

(* ****** ****** *)

implement
cloenv_extend_pat
  (env, p2t, d2u) = let
in
//
case+
p2t.p2at_node of
//
| P2Tany () => env
| P2Tvar (d2v) =>
    cloenv_extend (env, d2v, d2u)
//
| P2Tempty () => env
//
| P2Tpat (p2t) =>
    cloenv_extend_pat (env, p2t, d2u)
//
| P2Trec (knd, npf, lp2ts) =>
  (
    case+ d2u of
    | VALrec (ld2us) =>
        cloenv_extend_labpatlst (env, lp2ts, ld2us)
    | _(*type-error*) => env
  ) (* end of [P2Trec] *)
//
| P2Tignored () => env
//
end // end of [cloenv_extend_pat]

(* ****** ****** *)

implement
cloenv_extend_patlst
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
          cloenv_extend_pat (env, p2t, d2u)
        // end of [val]
      in
        cloenv_extend_patlst (env, p2ts, d2us)
      end // end of [list_cons]
  ) (* end of [list_cons] *)
//
end // end of [cloenv_extend_patlst]

(* ****** ****** *)

implement
cloenv_find
  (env, d2v) = funmap_search_opt<key,itm> (env, d2v)
// end of [cloenv_find]

(* ****** ****** *)

(* end of [cloenv.dats] *)
