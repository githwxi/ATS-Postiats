(*
** Some functions for traversing aggregates
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "contrib/atshwxi/testing/foreach.sats"

(* ****** ****** *)

implement{a}
foreach_list (xs) = let
//
fun loop
  {n:nat} .<n>. (
  xs: list (a, n)
) : void =
  case+ xs of
  | list_cons (x, xs) => let
      val () =
        foreach_list__fwork<a> (x) in loop (xs)
      // end of [val]
    end // end of [list_cons]
  | list_nil () => ()
(* end of [loop] *)
//
in
  loop (xs)
end // end of [foreach_list]

(* ****** ****** *)

implement{a}
iforeach_list (xs) = let
//
fun loop
  {n:nat} .<n>. (
  xs: list (a, n), i: size_t
) : void =
  case+ xs of
  | list_cons (x, xs) => let
      val () =
        iforeach_list__fwork<a> (i, x)
      // end of [val]
    in
      loop (xs, succ(i))
    end // end of [list_cons]
  | list_nil () => ()
(* end of [loop] *)
//
in
  loop (xs, $UN.cast2size(0))
end // end of [iforeach_list]

(* ****** ****** *)

implement{a}
foreach_list_vt (xs) = let
//
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (a, n)
) : void =
  case+ xs of
  | @list_vt_cons
      (x, xs1) => let
      val () =
        foreach_list_vt__fwork<a> (x)
      val () = loop (xs1)
      prval () = fold@ (xs)
    in
      // nothing
    end // end of [list_vt_cons]
  | list_vt_nil () => ()
(* end of [loop] *)
//
in
  loop (xs)
end // end of [foreach_list_vt]

(* ****** ****** *)

implement{a}
iforeach_list_vt (xs) = let
//
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (a, n), i: size_t
) : void =
  case+ xs of
  | @list_vt_cons (x, xs1) => let
      val () =
        iforeach_list_vt__fwork<a> (i, x)
      val () = loop (xs1, succ(i))
      prval () = fold@ (xs)
    in
      // nothing
    end // end of [list_vt_cons]
  | list_vt_nil () => ()
(* end of [loop] *)
//
in
  loop (xs, $UN.cast2size(0))
end // end of [iforeach_list_vt]

(* ****** ****** *)

implement{a}
foreach_array (A, n) = let
//
prval () = lemma_array_v_param (view@(A))
//
fun loop
  {l:addr}
  {n:nat} .<n>. (
  pf: !array_v (a, l, n) | p: ptr l, n: size_t n
) : void =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons (pf)
    val () = foreach_array__fwork<a> (!p)
    val () = loop (pf2 | p+sizeof<a>, pred(n))
    prval () = pf := array_v_cons (pf1, pf2)
  in
    // nothing
  end // end of [if]
(* end of [loop] *)
//
in
  loop (view@(A) | addr@(A), n)
end // end of [foreach_array]

(* ****** ****** *)

implement{a}
iforeach_array {n0} (A, n0) = let
//
prval () = lemma_array_v_param (view@(A))
//
fun loop
  {l:addr}
  {n:nat} .<n>. (
  pf: !array_v (a, l, n)
| p: ptr l, n: size_t n, i: size_t
) : void =
  if n > 0 then let
    prval (
      pf1, pf2
    ) = array_v_uncons (pf)
    val () = iforeach_array__fwork<a> (i, !p)
    val () = loop (pf2 | p+sizeof<a>, pred(n), succ(i))
    prval () = pf := array_v_cons (pf1, pf2)
  in
    // nothing
  end // end of [if]
(* end of [loop] *)
//
in
  loop (view@(A) | addr@(A), n0, $UN.cast2size(0))
end // end of [iforeach_array]

(* ****** ****** *)

implement{a}
initialize_array
  {n0} (A, n0) = let
//
implement
iforeach_array__fwork<a> (i, x) = let
  prval () = __assert (view@(x)) where {
    extern praxi __assert {l:addr} (pf: !a@l >> (a?)@l): void
  } // end of [prval]
in
  initialize_array__fwork (i, x)
end // end of [iforeach_array__fwork]
//
val () = let
  extern praxi __assert
    {l:addr} (pf: !array_v (a?, l, n0) >> array_v (a, l, n0)): void
  // end of [__assert]
in
  __assert (view@ (A))
end // end of [let] // end of [val]
//
in
  iforeach_array (A, n0)
end // end of [initialize_array]

(* ****** ****** *)

implement{a}
uninitialize_array
  {n0} (A, n0) = let
//
implement
foreach_array__fwork<a> (x) = let
  val () = uninitialize_array__fwork (x)
  extern praxi __assert {l:addr} (pf: !(a?)@l >> a@l): void
in
  __assert (view@(x))
end // end of [iforeach_array__fwork]
//
val () = foreach_array (A, n0)
//
extern praxi __assert
  {l:addr} (pf: !array_v (a, l, n0) >> array_v (a?, l, n0)): void
// end of [__assert]
in
  __assert (view@ (A))
end // end of [uninitialize_array]

(* ****** ****** *)

(* end of [foreach.dats] *)
