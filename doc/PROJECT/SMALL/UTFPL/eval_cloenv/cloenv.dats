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
cloenv_extendlst
  (env, xs, vs) = let
in
//
case+ xs of
| list_cons
    (x, xs) =>
  (
    case+ vs of
    | list_cons (v, vs) => let
        val env =
          cloenv_extend (env, x, v) in cloenv_extendlst (env, xs, vs)
      end // end of [list_cons]
    | list_nil ((*void*)) => env
  )
| list_nil ((*void*)) => env
//
end // end of [cloenv_extendlst]

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
    prval () = opt_unnone{itm}(res) in $raise UnboundVarExn (d2v)
  end // end of [else]
//
end // end of [cloenv_find_exn]

(* ****** ****** *)

(* end of [cloenv.dats] *)
