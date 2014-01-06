(* ****** ****** *)
//
// HX-2014-01
// CoYoneda Lemma:
//
(* ****** ****** *)

sortdef ftype = type -> type

(* ****** ****** *)

infixr (->) ->>
typedef ->> (a:type, b:type) = a -<cloref1> b

(* ****** ****** *)

typedef
functor(F:ftype) =
  {a,b:type} (a ->> b) ->> F(a) ->> F(b)

(* ****** ****** *)

datatype
CoYoneda
 (F:ftype, r:type) = {a:type} CoYoneda of (a ->> r, F(a))
// end of [CoYoneda]

(* ****** ****** *)
//
extern
fun CoYoneda_phi
  : {F:ftype}functor(F) -> {r:type} (F (r) ->> CoYoneda (F, r))
extern
fun CoYoneda_psi
  : {F:ftype}functor(F) -> {r:type} (CoYoneda (F, r) ->> F (r))
//
(* ****** ****** *)

implement
CoYoneda_phi(ftor) = lam (fx) => CoYoneda (lam x => x, fx)
implement
CoYoneda_psi(ftor) = lam (CoYoneda(f, fx)) => ftor (f) (fx)

(* ****** ****** *)

(* end of [CoYonedaLemma.dats] *)
