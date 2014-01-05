(* ****** ****** *)
//
// Hx-2014-01-03
// Yoneda Lemma:
// The hardest "trivial" theorem!
//
(* ****** ****** *)

staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
staload
"libats/ML/SATS/option0.sats"

(* ****** ****** *)

sortdef ftype = type -> type

(* ****** ****** *)

infixr (->) ->>

typedef ->> (a:type, b:type) = a -<cloref1> b

typedef
functor(f:ftype) = {a,b:type} (a ->> b) ->> f(a) ->> f(b)

(* ****** ****** *)

typedef
list0 (a:type) = list0 (a)
extern
fun functor_list0 : functor (list0)

(* ****** ****** *)

implement
functor_list0 (f) = lam xs => list0_map (xs, f)

(* ****** ****** *)

typedef
option0 (a:type) = option0 (a)  
extern
fun functor_option0 : functor (option0)
  
(* ****** ****** *)

implement
functor_option0 (f) = lam opt => option0_map (opt, f)

(* ****** ****** *)
//
extern
fun Yoneda1
  : {f:ftype}functor(f) ->> {a:type}({r:type}(a ->> r) ->> f(r)) ->> f(a)
extern
fun Yoneda2
  : {f:ftype}functor(f) ->> {a:type}f(a) ->> ({r:type}(a ->> r) ->> f(r))
//
(* ****** ****** *)

implement
Yoneda1 (ftor) = lam(mf) => mf(lam x => x)
implement
Yoneda2 (ftor) = lam(fx) => lam (m) => ftor(m)(fx)

(* ****** ****** *)

(* end of [YonedaLemma.dats] *)
