(*
** Abstract interface for linear lists
*)

(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

absvtype mynode(l:addr) = ptr(l)

(* ****** ****** *)

extern
fun{}
compare_mynode_mynode
  {l1,l2:addr} (!mynode(l1), !mynode(l2)): int
overload compare with compare_mynode_mynode

(* ****** ****** *)

absvtype mylist(l:addr, n:int) = ptr(l)

(* ****** ****** *)

vtypedef mylist(n:int) = [l:addr] mylist (l, n)

(* ****** ****** *)
//
extern
praxi
lemma_mylist_param
  {l:addr}{n:int}
  (xs: !mylist(l, n)): [l >= null; n >= 0] void
//
extern
praxi
lemma_mylist_param2
  {l:addr}{n:int}
(
  xs: !mylist(l, n)
) : [(l==null && n==0) || (l > null && n > 0)] void
//
(* ****** ****** *)

extern
fun
mylist_is_nil
  {l:addr}{n:int}
  (xs: !mylist(l,n)): bool(n==0) = "mac#atspre_ptr_is_null"
extern
fun
mylist_isnot_nil
  {l:addr}{n:int}
  (xs: !mylist(l,n)): bool(n > 0) = "mac#atspre_ptr_isnot_null"
//
overload iseqz with mylist_is_nil
overload isneqz with mylist_isnot_nil
//
(* ****** ****** *)
//
extern
fun
mylist_nil ()
  : mylist(null, 0) = "mac#atspre_ptr_null"
extern
fun{}
mylist_cons
  {l1,l2:addr}{n:nat}
(
  !mynode(l1) >> mylist(l1,n+1), mylist(l2, n)
) :<!wrt> void // end of [mylist_cons]
extern
prfun
_mylist_cons
  {l1,l2:addr}{n:nat}
(
  !mynode(l1) >> mylist(l1, n+1), mylist(l2, n)
) :<prf> void // end of [_mylist_cons]
//
extern
fun{}
mylist_cons2
  {l1,l2:addr}{n:nat}
  (x_hd: mynode(l1), xs_tl: mylist(l2, n)):<!wrt> mylist(l1, n+1)
//
(* ****** ****** *)
//
implement
{}(*tmp*)
mylist_cons2
  (x, xs) =
  let val () = mylist_cons (x, xs) in x end
//
(* ****** ****** *)
//
extern
prfun
mylist_unnil
  {l:addr} (mylist(l,0)): void
//
extern
fun{}
mylist_uncons
  {l:addr}
  {n:int | n > 0}
  (!mylist(l, n) >> mynode(l)): mylist(n-1)
//
extern
fun{}
mylist_uncons2
  {l:addr}
  {n:int | n > 0}
  (xs: mylist(l, n)): (mynode(l), mylist(n-1))
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_uncons2
  (xs) = let
  val xs2 = mylist_uncons (xs) in (xs, xs2)
end // end of [mylist_uncons2]
 
(* ****** ****** *)
//
extern
fun{}
mylist_length{n:int} (xs: !mylist(n)): int(n)
//
(* ****** ****** *)

implement
{}(*tmp*)
mylist_length (xs) = let
//
fun loop
  {i,j:nat} .<i>.
(
  xs: !mylist(i), j: int(j)
) : int(i+j) =
if
isneqz (xs)
then let
  val xs2 = mylist_uncons (xs)
  val res = loop (xs2, j + 1)
  prval () = _mylist_cons (xs, xs2)
in
  res
end // end of [then]
else (j) // end of [else]
//
prval () = lemma_mylist_param (xs)
//
in
  loop (xs, 0)
end // end of [mylist_length]

(* ****** ****** *)

(*
//
absvtype myrlist(l1:addr, l2:addr, n:int) = ptr(l2)
//
(* ****** ****** *)
//
extern
fun
myrlist_sing
  {l:addr} (mynode(l)): myrlist (l, l, 1)
extern
fun{}
myrlist_cons
  {l1,l2,l3:addr}{n:int}
  (myrlist(l1,l2, n), mynode(l3)): myrlist(l1,l3,n+1)
//
*)

(* ****** ****** *)

(* end of [mylist.dats] *)
