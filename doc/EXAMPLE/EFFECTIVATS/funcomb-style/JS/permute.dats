(*
Listing Permutations
*)

(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "thePermute_start"
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
staload
"{$LIBATSCC2JS}/SATS/print.sats"
staload _(*anon*) =
"{$LIBATSCC2JS}/DATS/print.dats"
//
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
choose_1_rest(xs: list0(INV(a))): list0($tup(a, list0(a)))
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
    $tup(x1, xs2)
  , list0_map{$tup(a,list0(a))}{$tup(a,list0(a))}
      (choose_1_rest(xs2), lam(xxs) => $tup(xxs.0, list0_cons(x1, xxs.1)))
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
    list0_map{$tup(a,list0(a))}{list0(list0(a))}
      (choose_1_rest(xs), lam($tup(x, xs)) => list0_map(permute0(xs), lam(xs) => list0_cons(x, xs)))
  )
//
(* ****** ****** *)
//
// HX: Some testing code
//
(* ****** ****** *)

implement
(a)(*tmp*)
print_val<list0(a)> = print_list0<a>

(* ****** ****** *)

val () =
{
//
#define :: list0_cons
//
val xs = 1::2::3::nil0()
//
val xss = permute0<int>(xs)
//
val () =
println!
(
  "Listing all the permutations of (1, 2, 3):"
) (* val *)
//
val () =
(
  print_list0_sep<list0(int)>(xss, "\n"); print_newline((*void*))
)
//
} (* end of [val] *)

(* ****** ****** *)
//
%{$
//
ats2jspre_the_print_store_clear();
thePermute_start();
alert(ats2jspre_the_print_store_join());
//
%} // end of [%{$]
//
(* ****** ****** *)

(* end of [permute.dats] *)
