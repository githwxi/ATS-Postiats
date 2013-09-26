//
// Recursive permuation generator
//

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun{a:vt0p}
Perm$fwork {n:int} (A: &array (a, n), n: int n): void

(* ****** ****** *)

extern
fun{a:vt0p}
Perm {
  l1,l2:addr;k,n:int
| l2==l1+k*sizeof(a)
} (
  pf1: !array_v (a, l1, k)
, pf2: !array_v (a, l2, n-k)
| p1: ptr l1, p2: ptr l2, k: int k, n: int n
) : void // end of [Perm]
and
Perm_aux {
  l1,l2:addr;k,n:int;k2:nat
| l2==l1+k*sizeof(a);k <= k2; k2 <= n
} (
  pf1: !array_v (a, l1, k)
, pf2: !array_v (a, l2, n-k)
| p1: ptr l1, p2: ptr l2, k: int k, n: int n, k2: int k2
) : void // end of [Perm_aux]

(* ****** ****** *)

implement{a}
Perm {l1,l2,k,n} (
  pf1, pf2 | p1, p2, k, n
) = let
//
prval () = lemma_array_v_param (pf1)
prval () = lemma_array_v_param (pf2)
//
in
//
if k < n then
  Perm_aux<a> (pf1, pf2 | p1, p2, k, n, k)
else let
  prval pf = array_v_unsplit (pf1, pf2)
  val () = Perm$fwork<a> (!p1, n)
  prval (pf1_, pf2_) = array_v_split_at (pf | (i2sz)k)
  prval () = pf1 := pf1_ and () = pf2 := pf2_
in
  // nothing
end // end of [if]
//
end // end of [Perm]

(* ****** ****** *)

implement{a} Perm_aux
(
  pf1, pf2 | p1, p2, k, n, k2
) = let
//
prval () = lemma_array_v_param (pf1)
prval () = lemma_array_v_param (pf2)
//
in
//
if k2 < n then let
//
val () =
  array_subcirculate (!p2, (i2sz)0, i2sz(k2-k))
//
prval
(pf21, pf22) = array_v_uncons (pf2)
prval pf11 = array_v_extend (pf1, pf21)
//
val () = Perm<a> (pf11, pf22 | p1, ptr1_succ<a> (p2), k+1, n)
//
prval
(pf1_, pf21) = array_v_unextend (pf11)
prval pf2_ = array_v_cons (pf21, pf22)
val (pf2_ | p2) = viewptr_match (pf2_ | p2)
//
prval () = pf1 := pf1_ and () = pf2 := pf2_
//
val () =
  array_subcirculate (!p2, i2sz(k2-k), (i2sz)0)
//
in
  Perm_aux<a> (pf1, pf2 | p1, p2, k, n, k2+1)
end else () // end of [if]
//
end // end of [Perm_aux]

(* ****** ****** *)
//
// HX-2013-05: Some testing code
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

implement{a}
Perm$fwork (A, n) =
{
//
prval () = lemma_array_param (A)
//
val out = stdout_ref
val ((*void*)) = fprint_array (out, A, i2sz(n))
val ((*void*)) = fprint_newline (out)
} // end of [Perm$fwork]  

(* ****** ****** *)

implement
main0 () =
{
#define N 5
//
val A =
  arrayptr_make_intrange (0, N)
//
val
(
pf | p
) = arrayptr_takeout_viewptr{int}(A)
//
prval pf1 = array_v_nil () and pf2 = pf
//
val () = Perm (pf1, pf2 | p, p, 0, N)
//
prval () = array_v_unnil (pf1) and () = arrayptr_addback (pf2 | A)
//
val () = arrayptr_free (A)
//
} // end of [main0]


(* ****** ****** *)

(* end of [program-1-4.dats] *)
