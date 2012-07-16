(*
** Some functions for left-folding aggregates
*)

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "contrib/atshwxi/testing/SATS/foldleft.sats"

(* ****** ****** *)

implement{res}
foldleft_int (n, ini) = let
//
fun loop
  {n:int}
  {i:nat | i <= n} .<n-i>. (
  n: int n, i: int i, acc: res
) : res =
  if i < n then let
    val acc = foldleft_int__fwork (acc, i) in loop (n, succ(i), acc)
  end else acc // end of [if]
(* end of [loop] *)
//
in
  loop (n, 0, ini)
end // end of [foldleft_int]

(* ****** ****** *)

implement
{x}{res}
foldleft_list
  (xs, ini) = let
//
 prval () = lemma_list_param (xs)
//
fun loop
  {n:nat} .<n>. (
  xs: list (x, n), acc: res
) : res =
  case+ xs of
  | list_cons (x, xs) => let
      val acc =
        foldleft_list__fwork<x> (acc, x) in loop (xs, acc)
      // end of [val]
    end // end of [list_cons]
  | list_nil () => acc
(* end of [loop] *)
//
in
  loop (xs, ini)
end // end of [foldleft_list]

(* ****** ****** *)

implement
{x}{res}
foldleft_list_vt
  (xs, ini) = let
//
prval () = lemma_list_vt_param (xs)
//
fun loop
  {n:nat} .<n>. (
  xs: !list_vt (x, n), acc: res
) : res =
  case+ xs of
  | @list_vt_cons (x, xs1) => let
      val acc =
        foldleft_list_vt__fwork<x> (acc, x)
      val res = loop (xs1, acc)
      prval () = fold@ (xs)
    in
      res
    end // end of [list_cons]
  | list_vt_nil () => acc
(* end of [loop] *)
//
in
  loop (xs, ini)
end // end of [foldleft_list_vt]

(* ****** ****** *)

implement
{a}{res}
foldleft_array
  (A, n, ini) = let
//
prval () = lemma_array_param (A)
//
fun loop
  {l:addr}
  {n:nat} .<n>. (
  pf: !array_v (a, l, n) | p: ptr l, n: size_t n, acc: res
) : res =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons (pf)
    val acc = foldleft_array__fwork<a> (acc, !p)
    val res = loop (pf2 | ptr1_succ<a> (p), pred(n), acc)
    prval () = pf := array_v_cons (pf1, pf2)
  in
    res
  end else acc // end of [if]
(* end of [loop] *)
//
in
  loop (view@(A) | addr@(A), n, ini)
end // end of [foldleft_array]

(* ****** ****** *)

(* end of [foldleft.dats] *)
