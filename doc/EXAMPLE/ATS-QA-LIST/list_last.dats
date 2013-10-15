(* ****** ****** *)
//
// HX-2013-08:
//
// How to find the last element in a given list?
// Several implementations of different styles
// are presented as follows. While this problem
// may sound too simple, the solutions given below
// can still allow one to appreciate the power of
// dependent types in helping construct high-quality
// code that is correct and efficient.
//
(* ****** ****** *)
//
// HX: the current plan is for this
// to reside in the "cloud" eventually.
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{a:t0p}
list_last
  {n:int | n > 0} (xs: list (a, n)): a
// end of [list_last]

(* ****** ****** *)

implement{a}
list_last (xs) = let
//
val+list_cons (x, xs1) = xs
//
in
//
case+ xs1 of
| list_cons _ => list_last<a> (xs1) | _ => x
//
end // end of [list_last]

(* ****** ****** *)

extern
fun{a:t0p}
list_last_exn (xs: List (a)): a

implement{a}
list_last_exn
  (xs) = let
in
//
case+ xs of
| list_cons _ => list_last<a> (xs)
| list_nil () => $raise ListSubscriptExn()
//
end // end of [list_last_exn]

(* ****** ****** *)

extern
fun{a:t0p}
list_last_opt (xs: List (a)): Option_vt(a)

implement{a}
list_last_opt
  (xs) = let
in
//
case+ xs of
| list_cons _ =>
    Some_vt{a}(list_last<a> (xs))
| list_nil () => None_vt{a}((*void*))
//
end // end of [list_last_opt]

(* ****** ****** *)

extern
fun{a:t0p}
list_last_opt2
(
  xs: List (a), res: &a? >> opt(a, b)
) : #[b:bool] bool(b) // endfun

implement{a}
list_last_opt2
  (xs, res) = let
in
//
case+ xs of
| list_cons _ => let
    val () = res := list_last<a> (xs)
    prval () = opt_some{a}(res) in true(*found*)
  end // end of [list_cons]
| list_nil () => let
    prval () = opt_none{a}(res) in false(*notfound*)
  end // end of [list_nil]
//
end // end of [list_last_opt2]

(* ****** ****** *)
//
// Some testing code
// for the functions implemented above
//
val () =
{
//
val xs =
$list{int}(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
//
val-9 = list_last_exn<int> (xs)
val-~Some_vt(9) = list_last_opt<int> (xs)
//
var res: int
val-true = list_last_opt2<int> (xs, res)
prval () = opt_unsome (res)
val () = assertloc (res = 9)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [list_last.dats] *)
