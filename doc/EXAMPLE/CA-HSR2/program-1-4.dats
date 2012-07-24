//
// Recursive permuation generator
//

(* ****** ****** *)

extern
fun{a:vt0p}
Perm__fwork {n:int} (A: &array (a, n), n: int n): void

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

macdef i2u (x) = g1int2uint ,(x)

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
  val () = Perm__fwork<a> (!p1, n)
  prval (pf1_, pf2_) = array_v_split_at (pf | k)
in
  pf1 := pf1_ ; pf2 := pf2_
end // end of [if]
//
end // end of [Perm]

implement{a}
Perm_aux (
  pf1, pf2 | p1, p2, k, n, k2
) = let
//
prval () = lemma_array_v_param (pf1)
prval () = lemma_array_v_param (pf2)
//
in
//
if k2 < n then let
  val () =
    array_exchange (!p2, (i2u)0, i2u(k2-k))
  prval (
    pf21, pf22
  ) = array_v_uncons (pf2)
  prval pf11 =
    array_v_extend (pf1, pf21)
  val () = Perm<a>
    (pf11, pf22 | p1, ptr1_succ<a> (p2), k+1, n)
  prval (pf1_, pf21) = array_v_unextend (pf11)
  prval () = pf1 := pf1_
  prval () = pf2 := array_v_cons (pf21, pf22)
in
  Perm_aux<a> (pf1, pf2 | p1, p2, k, n, k2+1)
end else () // end of [if]
//
end // end of [Perm_aux]

(* ****** ****** *)

(* end of [program-1-4.dats] *)
