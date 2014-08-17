(*
** Merge-sort on singly-linked lists
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload "libats/SATS/gnode.sats"
staload "libats/SATS/sllist.sats"
//
staload _ = "libats/DATS/gnode.dats"
staload _ = "libats/DATS/sllist.dats"
//
(* ****** ****** *)

staload "./mylist.dats"
staload "./mylist_mergesort.dats"

(* ****** ****** *)
//
extern
fun{a:vt0p}
mergesort_sllist
  {n:int} (xs: sllist (a, n)): sllist (a, n)
//
(* ****** ****** *)

implement
{a}(*tmp*)
mergesort_sllist
  {n}(xs) = xs where
{
//
implement
compare_mynode_mynode<>
  (x, y) = ans where
{
//
  val x =
    $UN.castvwtp1{g2node1(a)}(x)
  and y =
    $UN.castvwtp1{g2node1(a)}(y)
  val p_x = gnode_getref_elt (x)
  and p_y = gnode_getref_elt (y)
  val (pf_x, fpf_x | p_x) = $UN.cptr_vtake{a}(p_x)
  and (pf_y, fpf_y | p_y) = $UN.cptr_vtake{a}(p_y)
  val ans = gcompare_ref<a> (!p_x, !p_y)
  prval () = fpf_x (pf_x) and () = fpf_y (pf_y)
//
} // end of [compare_mynode_mynode]
//
implement
mylist_cons<>
  {l1,l2}{n}
  (x, xs) = let
  val x2 = $UN.castvwtp1{g2node1(a)}(x)
  val xs = $UN.castvwtp0{sllist(a,n)}(xs)
  val _(*ptr*) = $UN.castvwtp0{ptr}(sllist_cons_ngc (x2, xs))
  prval () = $UN.castview2void{mylist(l1,n+1)}(x)
in
  // nothing
end // end of [mylist_cons]
//
implement
mylist_uncons<>
  {l}{n}(xs) = let
  val xs1 =
    $UN.castvwtp1{sllist(a,n)}(xs)
  prval () =
    $UN.castview2void{mynode(l)}(xs)
  val p_nxt = sllist_getref_next (xs1)
  prval ((*void*)) = $UN.castvwtp0 (xs1)
in
  $UN.ptr0_get<mylist(n-1)> (p_nxt)
end // end of [mylist_uncons]
//
val xs = $UN.castvwtp0{mylist(n)}(xs)
val xs = mylist_mergesort (xs)
val xs = $UN.castvwtp0{sllist(a,n)}(xs)
//
} (* end of [mergesort_sllist] *)

(* ****** ****** *)

implement
main0 () =
{
//
val out = stdout_ref
//
val xs =
$list_vt{int}(0,9,2,4,3,8,5,1,7,6)
val xs = sllist_make_list_vt (xs)
val () = fprintln! (out, "xs(bef) = ", xs)
//
val xs = mergesort_sllist<int> (xs)
val () = fprintln! (out, "xs(aft) = ", xs)
//
val ((*void*)) = sllist_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [mergesort_sllist.dats] *)
