(*
** libatscc-common
*)

(* ****** ****** *)

(*
//
staload "./../SATS/qlistref.sats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
*)

(* ****** ****** *)
//
datatype
qlistref
(a:vt@ype) = Q of
(
  ref(List0_vt(a)), ref(List0_vt(a))
)
//
assume qlistref_type(a) = qlistref(a)
//
(* ****** ****** *)
//
implement
qlistref_make_nil
  {a}((*void*)) = Q(f, r) where
{
//
val f = ref(list_vt_nil) and r = ref(list_vt_nil)
//
} (* end of [qlistref_make_nil] *)
//
(* ****** ****** *)

implement
qlistref_length
  {a}(que) = let
//
val+Q(r0, r1) = que
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
val r1 =
  $UN.cast{ref(List0(a?))}(r1)
//
in
  list_length(r0[]) + list_length(r1[])
end // end of [qlistref_length]

(* ****** ****** *)

implement
qlistref_enqueue
  {a}(que, x0) = let
//
val+Q(r0, r1) = que
//
val x0 =
  $UN.castvwtp0{a?}(x0)
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
val r1 =
  $UN.cast{ref(List0(a?))}(r1)
//
in
  r0[] := list_cons{a?}(x0, r0[])
end // end of [qlistref_enqueue]

(* ****** ****** *)

implement
qlistref_dequeue_opt
  {a}(que) = let
//
val+Q(r0, r1) = que
//
val r0 =
  $UN.cast{ref(List0(a?))}(r0)
val r1 =
  $UN.cast{ref(List0(a?))}(r1)
//
in
//
case+ r1[] of
| list_nil() => let
    val xs = r0[]
    val () = r0[] := list_nil()
  in
    case+ xs of
    | list_nil() =>
        None_vt(*void*)
    | list_cons(x0, xs) =>
      (
        r1[] := xs;
        Some_vt($UN.castvwtp0{a}(x0))
      )
  end // end of [list_nil]
| list_cons(x0, xs) =>
  (
    r1[] := xs; Some_vt($UN.castvwtp0{a}(x0))
  ) (* end of [list_cons] *)
//
end // end of [qlistref_dequeue_opt]

(* ****** ****** *)

implement
qlistref_foldleft
  {res}{a}
  (que, init, fopr) = let
//
val+Q(r0, r1) = que
//
val r0 =
  $UN.cast{ref(List0(a))}(r0)
val r1 =
  $UN.cast{ref(List0(a))}(r1)
//
val fopr = $UN.cast{(res, a) -<cloref1> res}(fopr)
//
fun
auxl
(
  res: res, xs: List0(a)
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => auxl(fopr(res, x), xs)
)
//
fun
auxr
(
  xs: List0(a), res: res
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => fopr(auxr(xs, res), x)
)
//
in
  auxr(r0[], auxl(init, r1[]))
end // end of [qlistref_foldleft]

(* ****** ****** *)

implement
qlistref_foldright
  {a}{res}
  (que, fopr, sink) = let
//
val+Q(r0, r1) = que
//
val r0 =
  $UN.cast{ref(List0(a))}(r0)
val r1 =
  $UN.cast{ref(List0(a))}(r1)
//
val fopr = $UN.cast{(a, res) -<cloref1> res}(fopr)
//
fun
auxl
(
  res: res, xs: List0(a)
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => auxl(fopr(x, res), xs)
)
//
fun
auxr
(
  xs: List0(a), res: res
) : res =
(
case+ xs of
| list_nil() => res
| list_cons(x, xs) => fopr(x, auxr(xs, res))
)
//
in
  auxr(r1[], auxl(sink, r0[]))
end // end of [qlistref_foldright]

(* ****** ****** *)

(* end of [qlistref.dats] *)
