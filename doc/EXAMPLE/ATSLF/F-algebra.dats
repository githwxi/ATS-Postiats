(* ****** ****** *)
//
// HX-2015-09-22
//
// Please visit the link:
// https://groups.google.com/forum/#!topic/ats-lang-users/tfEnAR2vIOA
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
typedef
Algebra (f:ftype, a:type) = f(a) ->> a

(* ****** ****** *)
//
extern
fun Map{f:ftype}{a,b:type} (a ->> b): f a ->> f b
//
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
fun
Cata{f:ftype}{a:type}
  (alg: Algebra (f,a)): (Fix f ->> a) =
  lam (f: Fix(f)) => alg(Map(Cata(alg))(Fix_unfold(f)))
//
(* ****** ****** *)

(* end of [F-algebra.dats] *)
