(* ****** ****** *)
//
// HX-2017-03-29:
//
// For template-based
// implementation of functors
//
(* ****** ****** *)
//
sortdef ftype = t@ype -> type
//
(* ****** ****** *)
//
abstype List0_name
//
abstype FUNCTOR(fname: type, ftype)
//
(* ****** ****** *)
//
dataprop
eqfun_t0ype_type
  (ftype, ftype) =
  {f:ftype}
  EQFUN_t0ype_type(f, f) of ()
//
(* ****** ****** *)

extern
fun
{
fname:type
}{a,b:t@ype}
functor_map
{f: t@ype -> type}
(
pf: FUNCTOR(fname, f) | fopr: a -<cloref1> b
) : f(a) -<cloref1> f(b)

(* ****** ****** *)

extern
praxi
FUNCTOR_List0_elim
  {f:ftype}
(
pf: FUNCTOR(List0_name, f)
) : eqfun_t0ype_type(f, List0)

implement
(a,b:t@ype)
functor_map<List0_name><a,b>
  (pf | fopr) = let
//
prval
EQFUN_t0ype_type() = FUNCTOR_List0_elim(pf)
//
in
  lam(xs) => list_vt2t(list_map_cloref<a><b>(xs, fopr))
end // end of [functor_map<List0_name>]

(* ****** ****** *)

(* end of [tempfunctor.dats] *)
