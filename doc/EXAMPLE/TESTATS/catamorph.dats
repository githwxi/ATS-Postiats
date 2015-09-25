//
// A simple example of catamorphism
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start time: the 24th of September, 2015
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
datatype
expr =
| Int of int
| Add of (expr, expr)
| Mul of (expr, expr)
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
cata_expr_Int : (int) -> a
extern
fun
{a:t@ype}
cata_expr_Add : (a, a) -> a
extern
fun
{a:t@ype}
cata_expr_Mul : (a, a) -> a
//
(* ****** ****** *)
//
extern
fun
{a:t@ype}
cata_expr : (expr) -> a
//
(* ****** ****** *)

implement
{a}(*tmp*)
cata_expr(e0) = aux(e0) where
{
//
fun
aux : $d2ctype(cata_expr<a>) = lam e0 =>
(
//
case+ e0 of
| Int (i) => cata_expr_Int<a> (i)
| Add (e1, e2) => cata_expr_Add (aux(e1), aux(e2))
| Mul (e1, e2) => cata_expr_Mul (aux(e1), aux(e2))
//
) (* end of [aux] *)
//
} (* end of [cata_expr] *)

(* ****** ****** *)
//
extern
fun
expr_eval : expr -> int
//
(* ****** ****** *)

implement
expr_eval(e0) = let
//
implement
cata_expr_Int<int> (i) = i
implement
cata_expr_Add<int> (e1, e2) = e1 + e2
implement
cata_expr_Mul<int> (e1, e2) = e1 * e2
//
in
  cata_expr<int> (e0)
end // end of [expr_eval]

(* ****** ****** *)
//
extern
fun
expr_tostring : expr -> string
//
(* ****** ****** *)

implement
expr_tostring
  (e0) = let
//
implement
cata_expr_Int<string>
  (i) = strptr2string(g0int2string(i))
implement
cata_expr_Add<string>
  (e1, e2) = strptr2string(string_append("(", e1, "+", e2, ")"))
implement
cata_expr_Mul<string>
  (e1, e2) = strptr2string(string_append("(", e1, "*", e2, ")"))
//
in
  cata_expr<string> (e0)
end // end of [expr_tostring]

(* ****** ****** *)

implement
main0 () =
{
//
val ans =
  expr_eval(Add(Int(1), Mul(Int(2), Int(3))))
//
val ((*void*)) = println! ("eval(1+2*3) = ", ans)
//
val rep =
  expr_tostring(Add(Int(1), Mul(Int(2), Int(3))))
//
val ((*void*)) = println! ("tostring(1+2*3) = ", rep)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [catamorph.dats] *)
