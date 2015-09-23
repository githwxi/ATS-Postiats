(* ****** ****** *)
//
// HX-2015-09-22
//
// Please visit the link:
// https://groups.google.com/forum/#!topic/ats-lang-users/tfEnAR2vIOA
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
infixr (->) ->>
//
typedef
->> (a:type, b:type) = a -<cloref1> b
//
(* ****** ****** *)

sortdef
ftype = type -> type

(* ****** ****** *)

typedef
Functor(F:ftype) =
  {a,b:type} (a ->> b) ->> F(a) ->> F(b)

(* ****** ****** *)

typedef
Algebra (f:ftype, a:type) = f(a) ->> a

(* ****** ****** *)
//
datatype
Fix (f:ftype) = Fix_fold of (f (Fix f))
//
extern
fun
Fix_unfold{f:ftype} : Fix(f) -> f (Fix(f))
implement
Fix_unfold(f) = let val+Fix_fold(f) = f in f end
//
(* ****** ****** *)
//
extern
fun Cata
  : {f:ftype}Functor(f) ->
  {a:type}Algebra (f,a) ->> (Fix f ->> a)
//
implement
Cata(map) =
  lam(alg) => lam(f) => alg(map(Cata(map)(alg))(Fix_unfold(f)))
//
(* ****** ****** *)
//
datatype
fexpr(a:type) =
| Int of int
| Add of (a, a)
| Mul of (a, a)
//
typedef expr = Fix(fexpr)
//
(* ****** ****** *)
//
extern
val
fexpr_map : Functor(fexpr)
//
implement
fexpr_map(f) = lam(e0) =>
(
case+ e0 of
| Int (i) => Int (i)
| Add (e1, e2) => Add (f(e1), f(e2))
| Mul (e1, e2) => Mul (f(e1), f(e2))
)
//
(* ****** ****** *)
//
datatype
intx = Box of (int)
//
fun unBox(Box(i): intx): int = i
//
(* ****** ****** *)
//
extern
fun
fexpr_eval
  : fexpr(intx) -> intx
//
implement
fexpr_eval(e0) =
(
case+ e0 of
| Int(i) => Box(i)
| Add(e1, e2) => Box(unBox(e1) + unBox(e2))
| Mul(e1, e2) => Box(unBox(e1) * unBox(e2))
)
//
(* ****** ****** *)
//
val Int_1 = Fix_fold(Int(1)): expr
val Int_2 = Fix_fold(Int(2)): expr
val Int_3 = Fix_fold(Int(3)): expr
val Mul_2_3 = Fix_fold(Mul(Int_2, Int_3)): expr
val Add_1_Mul_2_3 = Fix_fold(Add(Int_1, Mul_2_3)): expr
//
(* ****** ****** *)
val
ans =
Cata
(lam(f)=>fexpr_map(f))
(lam(e)=>fexpr_eval(e))(Add_1_Mul_2_3)
//
val () = println! ("eval(1+2*3) = ", unBox(ans))
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [F-algebra.dats] *)
