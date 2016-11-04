(*
Depth-first search
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
(*
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

stacst fact : int -> int

extern
fun{
a:t@ype
} permute
  {n:nat}
(
xs: list(a, n)
) : list(list(a, n), fact(n))

(* ****** ****** *)

extern
fun
{a:t@ype}
permute0(xs: list0(INV(a))): list0(list0(a))

(* ****** ****** *)
//
extern
fun
{a:t@ype}
choose_1_rest(xs: list0(INV(a))): list0(@(a, list0(a)))
//
implement
{a}(*tmp*)
choose_1_rest(xs) =
(
case+ xs of
| list0_nil() =>
  list0_nil()
| list0_cons(x1, xs2) =>
  list0_cons
  (
    (x1, xs2)
  , list0_map<(a, list0(a))><(a, list0(a))>
      (choose_1_rest(xs2), lam(xxs) => (xxs.0, list0_cons(x1, xxs.1)))
    // list0_map
  )
)
//
implement
{a}(*tmp*)
permute0(xs) =
case+ xs of
| list0_nil() =>
  list0_sing
  (
    list0_nil()
  )
| list0_cons _ =>
  list0_concat
  (
    list0_map<(a, list0(a))><list0(list0(a))>
      (choose_1_rest(xs), lam(@(x, xs)) => list0_mapcons(x, permute0(xs)))
    // end of [list0_map]
  )
//
(* ****** ****** *)

extern
fun
{a:t@ype}
mylist_sing(x: a): list(a, 1)
extern
fun
{a:t@ype}
mylist_concat{m,n:int}(list(list(INV(a), n), m)): list(a, m*n)
extern
fun
{a:t@ype}
mylist_mapcons{m,n:int}(a, list(list(INV(a), n), m)): list(list(a, n+1), m)
extern
fun
{a:t@ype}
{b:t@ype}
mylist_map{n:int}(list(INV(a), n), a -<cloref1> b): list(b, n)
extern
fun
{a:t@ype}
mychoose_1_rest{n:int}(xs: list(INV(a), n)): list(@(a, list(a, n-1)), n)

implement
{a}(*tmp*)
permute
{n}(xs) = let
//
extern
praxi
lemma_fact_0(): [fact(0)==1] void
extern
praxi
lemma_fact_1{n:pos}(): [fact(n)==n*fact(n-1)] void
//
in
//
case+ xs of
| nil() =>
  mylist_sing(nil()) where
  {
    prval () = lemma_fact_0()
  } (* end of [nil] *)
| cons _ => let
    prval () = lemma_fact_1{n}()
  in
  //
  mylist_concat
  (
    mylist_map<(a, list(a, n-1))><list(list(a, n), fact(n-1))>
      (mychoose_1_rest(xs), lam(@(x, xs)) => mylist_mapcons(x, permute(xs)))
  )
  //
  end // end of [cons]
//
end // end of [permute]

(* ****** ****** *)
//
// HX: Some testing code
//
(* ****** ****** *)

implement
main0() =
{
//
val xs = $list{int}(1,2,3,4,5)
val xss = permute0(g0ofg1(xs))
//
val () =
fprintln!
( stdout_ref
, "Listing all the permutations of (1, 2, 3, 4, 5):"
) (* val *)
//
val () = fprint_listlist0_sep(stdout_ref, xss, "\n", ",")
//
val () = fprint_newline(stdout_ref)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [permute.dats] *)
