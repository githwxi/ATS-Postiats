(*
** Quick-sort on linear lists
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

staload "./mylist.dats"
staload "./mylist_quicksort.dats"

(* ****** ****** *)
//
extern
fun{a:vt0p}
quicksort_list_vt
  {n:int} (xs: list_vt (a, n)): list_vt (a, n)
//
(* ****** ****** *)

implement
{a}(*tmp*)
quicksort_list_vt
  {n}(xs) = xs where
{
//
implement
compare_mynode_mynode<>
  (x, y) = ans where
{
//
  val x =
  $UN.castvwtp1{list_vt_cons_pstruct(a,ptr)}(x)
  val y =
  $UN.castvwtp1{list_vt_cons_pstruct(a,ptr)}(y)
  val+list_vt_cons (x_1, x_2) = x
  val+list_vt_cons (y_1, y_2) = y
  val ans = gcompare_ref<a> (x_1, y_1)
  prval () = $UN.cast2void ((view@x_1, view@x_2 | x))
  prval () = $UN.cast2void ((view@y_1, view@y_2 | y))
//
} // end of [compare_mynode_mynode]
//
implement
mylist_cons<>
  {l1,l2}{n}
  (x, xs) = let
//
  val x2 =
  $UN.castvwtp1{list_vt_cons_pstruct(a,ptr)}(x)
  val+list_vt_cons (x2_1, x2_2) = x2
  val () = x2_2 := $UN.castvwtp0{list_vt(a,n)}(xs)
  prval () = fold@ (x2)
  prval () = $UN.cast2void (x2)
//
  prval () = $UN.castview2void{mylist(l1,n+1)}(x)
//
in
  // nothing
end // end of [mylist_cons]
//
implement
{}(*tmp*)
mylist_uncons
  {l}{n}(xs) = xs2_ where
{
  val xs1 = $UN.castvwtp1{list_vt(a,n)}(xs)
  val+list_vt_cons (_, xs2) = xs1
  val xs2_ = $UN.castvwtp1{mylist(n-1)}(xs2)
  prval ((*void*)) = $UN.cast2void (xs1)
  prval ((*void*)) = $UN.castview2void{mynode(l)}(xs)
} // end of [mylist_uncons]
//
val xs = $UN.castvwtp0{mylist(n)}(xs)
val xs = mylist_quicksort (xs)
val xs = $UN.castvwtp0{list_vt(a,n)}(xs)
//
} (* end of [quicksort_list_vt] *)

(* ****** ****** *)

implement
main0 () =
{
//
val xs =
$list_vt{int}(0,9,2,4,3,8,5,1,7,6)
val () = println! ("xs(bef) = ", xs)
//
val xs = quicksort_list_vt<int> (xs)
val () = println! ("xs(aft) = ", xs)
//
val ((*void*)) = list_vt_free (xs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [quicksort_list_vt.dats] *)

