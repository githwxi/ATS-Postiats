(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/slistref.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
assume
slistref_type
  (a:vt0p) = ref(List0_vt(a))
//
(* ****** ****** *)
//
implement
slistref_make_nil
  {a}((*void*)) =
  ref(list_vt_nil((*void*)))
//
(* ****** ****** *)

implement
slistref_length
  {a}(r0) = let
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
//
in
  list_length(r0[])
end // end of [slistref_length]

(* ****** ****** *)

implement
slistref_push
  {a}(r0, x0) = let
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
//
in
  r0[] := list_cons{a?}($UN.castvwtp0(x0), r0[])
end // end of [slistref_push]

(* ****** ****** *)

implement
slistref_pop_opt
  {a}(r0) = let
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
//
in
//
case+ r0[] of
| list_nil() => None_vt(*void*)
| list_cons(x0, xs) =>
  (
    r0[] := xs; Some_vt($UN.castvwtp0{a}(x0))
  )
//
end // end of [slistref_pop_opt]

(* ****** ****** *)

implement
slistref_foldleft
  {res}{a}
  (r0, init, fopr) = let
//
val r0 =
  $UN.cast{ref(List0(a))}(r0)
//
val fopr =
  $UN.cast{(res, a)-<cloref1>res}(fopr)
//
in
  list_foldleft{res}{a}(r0[], init, fopr)
end // end of [slistref_foldleft]

(* ****** ****** *)

implement
slistref_foldright
  {a}{res}
  (r0, fopr, sink) = let
//
val r0 =
  $UN.cast{ref(List0(a))}(r0)
//
val fopr =
  $UN.cast{(a, res)-<cloref1>res}(fopr)
//
in
  list_foldright{a}{res}(r0[], fopr, sink)
end // end of [slistref_foldright]

(* ****** ****** *)

(* end of [slistref.dats] *)
