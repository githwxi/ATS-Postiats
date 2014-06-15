(*
** Merge-sort on linear lists
*)

(* ****** ****** *)

staload "./mylist.dats"

(* ****** ****** *)
//
extern
fun{}
mylist_append
  {m,n:int}
  (xs: mylist(m), ys: mylist(n)): mylist(m+n)
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_append
  {m,n}(xs, ys) = let
//
prval () = lemma_mylist_param (xs)
prval () = lemma_mylist_param (ys)
//
fun
loop{m:pos}
(
  xs: !mylist(m) >> mylist(m+n), ys: mylist(n)
) : void = let
  val xs_tl = mylist_uncons (xs)
in
//
if
isneqz(xs_tl)
then let
  val () = loop (xs_tl, ys)
  prval () = _mylist_cons (xs, xs_tl)
in
  // nothing
end // end of [then]
else let
  val () = mylist_cons (xs, ys)
  prval () = mylist_unnil (xs_tl)
in
  // nothing
end // end of [else]
//
end // end of [loop]
//
in
//
if
isneqz(xs)
then let
  val () = loop (xs, ys) in xs
end // end of [then]
else let
  prval () = mylist_unnil (xs) in ys
end // end of [else]
//
end // end of [mylist_append]

(* ****** ****** *)

extern
fun{}
mylist_quicksort
  {n:int} (xs: mylist(n)): mylist(n)

(* ****** ****** *)

extern
fun{}
mylist_partition
  {l:addr}{n:nat}
(
  x0: !mynode(l), xs: mylist(n)
) : [n1,n2:nat | n1+n2==n] (mylist(n1), mylist(n2))

(* ****** ****** *)

implement
{}(*tmp*)
mylist_partition
  {l}{n} (x0, xs) = let
//
fun loop
  {n:nat}{k1,k2:nat}
(
  x0: !mynode(l), xs: mylist(n)
, xs1: mylist(k1), xs2: mylist(k2)
)
: [
  n1,n2:nat
| n1+n2==n+k1+k2
] (mylist(n1), mylist(n2)) = let
in
//
if
isneqz (xs)
then let
  val (x, xs) = mylist_uncons2 (xs)
  val sgn = compare_mynode_mynode (x, x0)
in
  if sgn < 0
    then loop (x0, xs, mylist_cons2 (x, xs1), xs2)
    else loop (x0, xs, xs1, mylist_cons2 (x, xs2))
  // end of [if]
end // end of [then]
else let
  prval () = mylist_unnil (xs) in (xs1, xs2)
end // end of [else]
//
end // end of [loop]
//
in
  loop (x0, xs, mylist_nil (), mylist_nil ())
end // end of [mylist_partition]

(* ****** ****** *)
//
extern
fun{}
mylist_qsort
  {n:int} (mylist(n), int(n)): mylist(n)
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_qsort
  (xs, n) = let
in
//
if n >= 2
  then let
    val (x, xs) = mylist_uncons2 (xs)
    val (xs1, xs2) = mylist_partition (x, xs)
    val n1 = mylist_length (xs1)
    val xs1 = mylist_qsort (xs1, n1)
    val xs2 = mylist_qsort (xs2, n-1-n1)
  in
    mylist_append (xs1, mylist_cons2 (x, xs2))
  end // end of [then]
  else xs // end of [else]
// end of [if]
//
end // end of [mylist_qsort]

(* ****** ****** *)

implement
{}(*tmp*)
mylist_quicksort
  (xs) = let
//
val n = mylist_length (xs)
//
in
  mylist_qsort (xs, n)
end // end of [mylist_quicksort]

(* ****** ****** *)

(* end of [mylist_quicksort.dats] *)
