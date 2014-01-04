(* ****** ****** *)
//
// Hx-2014-01-03
// Yoneda Lemma: The "hardest" trivial theorem!
//
(* ****** ****** *)

sortdef ftype = type -> type
typedef functor(f:ftype) = {a,b:type} (a -> b) -> f(a) -> f(b)

(* ****** ****** *)
//
extern
fun Yoneda1
  : {f:ftype}functor(f) -> {a:type}({r:type}(a -> r) -> f(r)) -> f(a)
extern
fun Yoneda2
  : {f:ftype}functor(f) -> {a:type}f(a) -> ({r:type}(a -> r) -> f(r))
//
(* ****** ****** *)

implement
Yoneda1 (ftor) = lam(mf) => mf(lam x => x)
implement
Yoneda2 (ftor) = lam(fx) => lam(m) => ftor(m)(fx)

(* ****** ****** *)

staload "libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef
list0 (a:type) = list0 (a)
extern
fun functor_list0 : functor (list0)

(* ****** ****** *)

(* end of [YonedaLemma.dats] *)
