(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<bool> = fprint_bool
implement
fprint_val<string> = fprint_string

(* ****** ****** *)

implement
{a}(*tmp*)
list0_forall
  (xs, test) = let
//
exception False of ()
//
in
//
try let
//
val () =
list0_foreach<a>
( xs
, lam(x) => if not(test(x)) then $raise False()
)
//
in
  true
end with ~False() => false
//
end // end of [list0_forall]

(* ****** ****** *)

implement
{a}(*tmp*)
list0_exists
  (xs, test) = let
//
exception True of ()
//
in
//
try let
//
val () =
list0_foreach<a>
( xs
, lam(x) => if test(x) then $raise True()
)
//
in
  false
end with ~True() => true
//
end // end of [list0_exists]

(* ****** ****** *)

val xs =
g0ofg1($list{int}(1, 2, 3))

(* ****** ****** *)
//
val () =
println!
("exists_isevn(", xs, ") = ", list0_exists(xs, lam(x) => x%2 = 0))
val () =
println!
("forall_isevn(", xs, ") = ", list0_forall(xs, lam(x) => x%2 = 0))
//
(* ****** ****** *)
//
datatype tree(a:t@ype) =
  | tree_nil of ()
  | tree_cons of (tree(a), a, tree(a))
//
(* ****** ****** *)
//
fun
{a:t@ype}
tree_height
  (t0: tree(a)): int =
(
case+ t0 of
| tree_nil() => 0
| tree_cons(tl, _, tr) =>
  1 + max(tree_height<a>(tl), tree_height<a>(tr))
)
//
(* ****** ****** *)
//
fun
{a:t@ype}
tree_is_perfect
  (t0: tree(a)): bool =
(
case+ t0 of
| tree_nil() => true
| tree_cons(tl, _, tr) =>
  tree_is_perfect<a>(tl) &&
  tree_is_perfect<a>(tr) &&
  (tree_height<a>(tl) = tree_height<a>(tr))
)
//
(* ****** ****** *)
//
fun
{a:t@ype}
tree_is_perfect2
  (t0: tree(a)): bool = let
//
exception NotPerfect of ()
//
fun
aux(t0: tree(a)): int =
case+ t0 of
| tree_nil() => 0
| tree_cons(tl, _, tr) => let
    val hl = aux(tl) and hr = aux(tr)
  in
    if hl = hr then 1+max(hl, hr) else $raise NotPerfect
  end
//
in
  try let val _ = aux(t0) in true end with ~NotPerfect() => false
end // end of [tree_is_perfect2]
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture09.dats] *)
