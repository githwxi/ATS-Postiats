(*
** For integer sets
*)

(* ****** ****** *)
//
staload
"libats/SATS/ilist_prf.sats"
//
(* ****** ****** *)
//
sortdef iset = int
(*
datasort iset = // abstract sort
*)
//
(* ****** ****** *)
//
dataprop
ISETEQ(iset, iset) =
  {s:iset} ISETEQ(s, s) of ()
//
(* ****** ****** *)

stacst iset_nil : () -> iset
stacst iset_int : (int) -> iset
stacst iset_int2 : (int, int) -> iset
stacst iset_int3 : (int, int, int) -> iset

(* ****** ****** *)

stacst iset_list : (ilist) -> iset

(* ****** ****** *)
//
stadef
iset() = iset_nil()
//
stadef iset = iset_int
stadef iset = iset_int2
stadef iset = iset_int3
//
stadef iset = iset_list
//
(* ****** ****** *)
//
stacst
iset_size: (iset) -> int
//
stadef size = iset_size
//
(* ****** ****** *)

stacst
iset_is_nil: iset -> bool
stacst
iset_is_full: (iset, int) -> bool

stadef isnil = iset_is_nil
stadef isful = iset_is_full

(* ****** ****** *)
//
stacst
eq_iset_iset
  : (iset, iset) -> bool
//
stadef == = eq_iset_iset
//
praxi
lemma_iset_equal_p2b
  {s1,s2:iset}
  (pf: ISETEQ(s1,s2)): [s1==s2] unit_p
//
praxi
lemma_iset_equal_b2p
  {s1,s2:iset| s1 == s2}(): ISETEQ(s1,s2)
//
(* ****** ****** *)
//
stacst
iset_member
  : (iset, int) -> bool
//
stadef ismbr = iset_member
//
(* ****** ****** *)
//
stacst
iset_add_elt
  : (iset, int) -> iset
stadef + = iset_add_elt
//
(* ****** ****** *)
//
stacst
iset_union
  : (iset, iset) -> iset
stacst
iset_intersect
  : (iset, iset) -> iset
//
stadef + = iset_union
stadef * = iset_intersect
//
(* ****** ****** *)
//
stacst
iset_ncomplement
  : (int, iset) -> iset
//
stadef ncomp = iset_ncomplement
//
(* ****** ****** *)
//
praxi
lemma_iset_sing_is_member
  {x:int}
  ((*void*)): [ismbr(iset(x), x)] void
praxi
lemma_iset_sing_isnot_member
  {x,y:int | x != y}
  ((*void*)): [~ismbr(iset(x), y)] void
//
praxi
lemma_iset_sing_isnot_nil
  {x:int}
  ((*void*)): [~isnil(iset(x))] void
//
(* ****** ****** *)
//
praxi
lemma_iset_ncomp_2_0_1
  ((*void*)): ISETEQ(iset(0), ncomp(2,iset(1)))
praxi
lemma_iset_ncomp_2_1_0
  ((*void*)): ISETEQ(iset(1), ncomp(2,iset(0)))
//
(* ****** ****** *)
//
// HX-2016-03:
//
// intset(n, xs)
// is for a set of natural
// numbers xs such that each x in xs
// is less than n.
//
abstype
intset(n:int, xs: iset) = ptr
//
typedef intset(n:int) = [xs:iset] intset(n, xs)
typedef intset(*void*) = [n:int;xs:iset] intset(n, xs)
//
(* ****** ****** *)
//
fun{}
intset_nil
  {n:nat}(): intset(n, iset())
//
fun{}
intset_int
  {n:int}{i:nat | i < n}
  (i: int(i)): intset(n, iset(i))
//
fun{}
intset_int2
{n:int}
{ i1,i2:nat
| i1 < i2; i2 < n
} (i1:int(i1), i2:int(i2)): intset(n, iset(i1, i2))
fun{}
intset_int3
{n:int}
{ i1,i2,i3:nat
| i1 < i2; i2 < i3; i3 < n}
  (int(i1), int(i2), int(i3)): intset(n, iset(i1, i2, i3))
//
(* ****** ****** *)
//
fun{}
intset_add_elt
{n:int}
{xs:iset}
{i:nat | i < n}
  (xs: intset(n, xs), i: int(i)): intset(n, xs+i)
//
(* ****** ****** *)
//
fun{}
intset_union
  {n:int}{xs1,xs2:iset}
  (intset(n, xs1), intset(n, xs2)): intset(n, xs1+xs2)
//
fun{}
intset_intersect
  {n:int}{xs1,xs2:iset}
  (intset(n, xs1), intset(n, xs2)): intset(n, xs1*xs2)
//
(* ****** ****** *)
//
fun{}
intset_ncomplement
  {xs:iset}{n:nat}
  (xs: intset(n, xs), n: int(n)): intset(n, ncomp(n, xs))
//
(* ****** ****** *)
//
fun{}
intset_foreach_cloref
  {n:int}{xs:iset}
(
  xs: intset(n, xs)
, fwork: (natLt(n)) -<cloref1> void
) : void // end-of-function
//
fun{}
intset2_foreach_cloref
  {n:int}{xs1,xs2:iset}
(
  xs1: intset(n, xs1)
, xs2: intset(n, xs2)
, fwork: (natLt(n), natLt(n)) -<cloref1> void
) : void // end-of-function
//
(* ****** ****** *)
//
fun{}
cintset_foreach_cloref
  {n:int}{xs:iset}
(
  n: int(n), xs: intset(n, xs)
, fwork: (natLt(n)) -<cloref1> void
) : void // end-of-function
//
(* ****** ****** *)
//
fun{}
print_intset : intset -> void
fun{}
prerr_intset : intset -> void
//
overload print with print_intset
overload prerr with prerr_intset
//
fun{}
fprint_intset: fprint_type(intset)
//
overload fprint with fprint_intset
//
(* ****** ****** *)

(* end of [basis_intset.sats] *)
