(* ****** ****** *)
//
// HX-2017-03-29:
//
// For template-based
// implementation of functors
//
(* ****** ****** *)
//
(*
##myatsccdef=\
patsopt --constraint-ignore --dynamic $1 | \
tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -
*)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
abstype List0$name
//
(* ****** ****** *)
//
sortdef ftype = t@ype -> type
//
(* ****** ****** *)
//
absprop FUNCTOR(fnm: type, ftype)
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
fnm:type
}{a,b:t@ype}
functor_map
{f: t@ype -> type}
(
pf: FUNCTOR(fnm, f) | fopr: a -<cloref1> b
) : f(a) -<cloref1> f(b) // end-of [functor_map]

(* ****** ****** *)

extern
praxi
FUNCTOR_List0
(
// argless
) : FUNCTOR(List0$name, List0)
extern
praxi
FUNCTOR_List0_elim
  {f:ftype}
(
pf: FUNCTOR(List0$name, f)
) : eqfun_t0ype_type(f, List0)

(* ****** ****** *)

implement
(a,b:t@ype)
functor_map<List0$name><a,b>
  (pf | fopr) = let
//
prval
EQFUN_t0ype_type() = FUNCTOR_List0_elim(pf)
//
in
  lam(xs) => list_vt2t(list_map_cloref<a><b>(xs, fopr))
end // end of [functor_map<List0$name>]

(* ****** ****** *)

implement
main0((*void*)) =
{
//
val xs =
$list{int}
(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
//
val ys =
functor_map<List0$name><int,int>(FUNCTOR_List0() | lam(x) => x * x)(xs)
//
val () = println! ("xs = ", xs)
val () = println! ("ys = ", ys)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [tempfunctor.dats] *)
