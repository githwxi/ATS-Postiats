(*
** Merge-sort on linear lists
*)

(* ****** ****** *)

staload "./mylist.dats"

(* ****** ****** *)

extern
fun{}
mylist_mergesort{n:int} (xs: mylist(n)): mylist(n)

(* ****** ****** *)
//
extern
fun{}
mylist_split
  {n:int}{k:nat | k <= n}
  (xs: mylist(n), k: int(k)): (mylist(k), mylist(n-k))
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_split
  (xs, k) = let
in
//
if
k > 0
then let
  val (x, xs) = mylist_uncons2 (xs)
  val (xs1, xs2) = mylist_split (xs, k-1)
in
  (mylist_cons (x, xs1), xs2)
end // end of [then]
else (mylist_nil (), xs) // end of [else]
//
end // end of [mylist_split]

(* ****** ****** *)

extern
fun{}
mylist_merge
  {n1,n2:int}
  (xs1: mylist(n1), xs2: mylist(n2)): mylist(n1+n2)

(* ****** ****** *)

implement
{}(*tmp*)
mylist_merge
  (xs1, xs2) = let
//
prval () = lemma_mylist_param (xs1)
prval () = lemma_mylist_param (xs2)
//
in
//
if
isneqz(xs1)
then (
if
isneqz(xs2)
then let
  val (x1, xs1) = mylist_uncons2 (xs1)
  val (x2, xs2) = mylist_uncons2 (xs2)
in
  if x1 <= x2
    then let
      val xs2 = _mylist_cons2(x2, xs2)
    in
      mylist_cons (x1, mylist_merge (xs1, xs2))
    end // end of [then]
    else let
      val xs1 = _mylist_cons2(x1, xs1)
    in
      mylist_cons (x2, mylist_merge (xs1, xs2))
    end // end of [else]
end // end of [then]
else let
  prval () = mylist_unnil (xs2) in xs1
end // end of [else]
) (* end of [then] *)
else let
  prval () = mylist_unnil (xs1) in xs2
end // end of [else]
//
end // end of [mylist_merge]

(* ****** ****** *)
//
extern
fun{}
mylist_msort
  {n:int} (mylist(n), int(n)): mylist(n)
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_msort
  (xs, n) = let
in
//
if n >= 2
  then let
    val n1 = half(n)
    val (xs1, xs2) = mylist_split (xs, n1)
    val xs1 = mylist_msort (xs1, n1)
    val xs2 = mylist_msort (xs2, n - n1)
  in
    mylist_merge (xs1, xs2)
  end // end of [then]
  else xs // end of [else]
// end of [if]
end // end of [mylist_msort]

(* ****** ****** *)

implement
{}(*tmp*)
mylist_mergesort
  (xs) = let
//
val n = mylist_length (xs)
//
in
  mylist_msort (xs, n)
end // end of [mylist_mergesort]

(* ****** ****** *)

(* end of [mylist_mergesort.dats] *)
