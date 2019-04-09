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
aux : expr -> a = lam e0 =>
(
//
case+ e0 of
| Int (i) => cata_expr_Int<a> (i)
| Add (e1, e2) => cata_expr_Add<a> (aux(e1), aux(e2))
| Mul (e1, e2) => cata_expr_Mul<a> (aux(e1), aux(e2))
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

fn{}
string0_append5
(
  x1: NSH(string)
, x2: NSH(string)
, x3: NSH(string)
, x4: NSH(string)
, x5: NSH(string)
) :<!wrt> Strptr1 = let
//
var xs = @[string](x1, x2, x3, x4, x5)
//
in
//
stringarr_concat<>
  ($UNSAFE.cast{arrayref(string,5)}(addr@xs), i2sz(5))
//
end // end of [string0_append5]

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
  (e1, e2) = strptr2string(string0_append5("(", e1, "+", e2, ")"))
implement
cata_expr_Mul<string>
  (e1, e2) = strptr2string(string0_append5("(", e1, "*", e2, ")"))
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
val () = assertloc(7 = ans)
//
val rep =
  expr_tostring(Add(Int(1), Mul(Int(2), Int(3))))
//
val ((*void*)) = println! ("tostring(1+2*3) = ", rep)
val () = assertloc("(1+(2*3))" = rep)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [catamorph.dats] *)
