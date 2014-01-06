(* ****** ****** *)
//
// Hx-2014-01
// Yoneda Lemma:
// The hardest "trivial" theorem :)
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

(* ****** ****** *)

typedef
functor(F:ftype) =
  {a,b:type} (a ->> b) ->> F(a) ->> F(b)

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

extern
fun functor_homres
  : {a:type} functor (lam(r:type) => a ->> r)

(* ****** ****** *)

implement
functor_homres{a} (f) = lam (r) => lam (x) => f (r(x))

(* ****** ****** *)
//
extern
fun Yoneda_phi : {F:ftype}functor(F) ->>
  {a:type}F(a) ->> ({r:type}(a ->> r) ->> F(r))
extern
fun Yoneda_psi : {F:ftype}functor(F) ->>
  {a:type}({r:type}(a ->> r) ->> F(r)) ->> F(a)
//
(* ****** ****** *)
//
implement
Yoneda_phi
  (ftor) = lam(fx) => lam (m) => ftor(m)(fx)
//
implement
Yoneda_psi (ftor) = lam(mf) => mf(lam x => x)
//
(* ****** ****** *)
//
// HX-2014-01-05:
// Another version based on Natural Transformation
//
(* ****** ****** *)

typedef
natrans(F:ftype, G:ftype) = {x:type} (F(x) ->> G(x))

(* ****** ****** *)
//
extern
fun Yoneda_phi_nat : {F:ftype}functor(F) ->>
  {a:type} F(a) ->> natrans(lam (r:type) => (a ->> r), F)
extern
fun Yoneda_psi_nat : {F:ftype}functor(F) ->>
  {a:type} natrans(lam (r:type) => (a ->> r), F) ->> F(a)
//
(* ****** ****** *)
//
implement
Yoneda_phi_nat
  (ftor) = lam(fx) => lam (m) => ftor(m)(fx)
//
implement
Yoneda_psi_nat (ftor) = lam(mf) => mf(lam x => x)
//
(* ****** ****** *)

(* end of [YonedaLemma.dats] *)
