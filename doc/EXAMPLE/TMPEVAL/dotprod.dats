(*
** An example of
** static template evaluation
*)

(* ****** ****** *)

abstype Z
abstype S(type)

(* ****** ****** *)
//
#define Sf(n)
  if n > 0 then S(Sf(n-1)) else Z
//
(* ****** ****** *)
//
dataprop
tieq (type, int) =
| TIEQZ(Z, 0)
| {t:type}{n:nat}
  TIEQS(S(t), n+1) of tieq(t, n)
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun
{a:t0p}
{t:type}
dotprod
{n:nat}
(pf: tieq(t, n) | A1: &(@[a][n]), A2: &(@[a][n])): a

(* ****** ****** *)
//
implement
(a)
dotprod<a><Z>
(
  pf | A1, A2
) = gnumber_int<a> (0)
//
implement
(a,t)
dotprod<a><S(t)>
  {n}
(
  pf | A1, A2
) = res where
{
//
prval TIEQS(pf) = pf
//
overload + with gadd_val of 10
overload * with gmul_val of 10
//
val p1 = addr@A1 and p2 = addr@A2
//
val (pf1, fpf1 | p1_1) =
  $UN.ptr0_vtake{array(a,n-1)}(ptr_succ<a>(p1))
val (pf2, fpf2 | p2_1) =
  $UN.ptr0_vtake{array(a,n-1)}(ptr_succ<a>(p2))
//
val res = A1[0]*A2[0]+dotprod<a><t>(pf | !p1_1, !p2_1)
//
prval ((*ret*)) = fpf1(pf1) and ((*ret*)) = fpf2(pf2)
//
} (* end of [dotprod<a><S(t)>] *)

(* ****** ****** *)
//
extern
fun
{a:t0p}
dotprod3
(A1: &(@[a][3]), A2: &(@[a][3])): a
//
(* ****** ****** *)

extern praxi tieq3(): tieq(Sf(3), 3)

(* ****** ****** *)

implement
{a}(*tmp*)
dotprod3(A1, A2) = dotprod<a><Sf(3)>(tieq3() | A1, A2)

(* ****** ****** *)

(* end of [dotprod.dats] *)
