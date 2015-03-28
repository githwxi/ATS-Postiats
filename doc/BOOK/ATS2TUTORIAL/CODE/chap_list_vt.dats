(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
//
datavtype
list_vt(a:vt@ype) =
  | list_vt_nil (a, 0)
  | {n:nat}
    list_vt_cons (a, n+1) of (a, list_vt(a, n))
//
*)

(* ****** ****** *)

fun
{a:vt@ype}
list_vt_length
  (xs: !list_vt(a, n)): int(n) =
(
case+ xs of
| list_vt_nil() => 0
| list_vt_cons(_, xs) => 1 + list_vt_length(xs)
)

(* ****** ****** *)

fun
{a:vt@ype}
list_vt_foreach
(
  xs: !list_vt(a, n)
, fwork: (&(a) >> _) -<cloref1> void
) : void =
(
case+ xs of
| list_vt_nil() => ()
| @list_vt_cons(x, xs2) => (fwork(x); list_vt_foreach<a> (xs2, fwork); fold@(xs))
) (* end of [list_vt_foreach] *)

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_list_vt.dats] *)
