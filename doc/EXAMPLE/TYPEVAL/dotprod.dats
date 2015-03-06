(*
** An example of
** static template evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload "libats/SATS/typeval.sats"
//
staload _ = "libats/DATS/typeval.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
extern
fun
{a:t0p}
dotprod3
(A0: &(@[a][3]), A1: &(@[a][3])): a
//
(* ****** ****** *)

extern praxi tieq3(): tieq(fS(3), 3)

(* ****** ****** *)

implement
{a}(*tmp*)
dotprod3
  (A0, A1) = res where
{
//
var res
  : a = gnumber_int<a>(0)
//
val p_res = addr@res
//
implement
sarray_foreach2$fwork<a>
  (x0, x1) =
{
  val r0 = $UN.ptr0_get<a>(p_res)
  val () = $UN.ptr0_set<a>(p_res, gadd_val<a> (r0, gmul_val<a> (x0, x1)))
} (* end of [sarray_foreach2$fwork] *)
//
val ((*void*)) = sarray_foreach2<a><fS(3)>(tieq3() | A0, A1)
//
} (* end of [dotprod3] *)

(* ****** ****** *)

implement
main0 () =
{
//
var A1 = @[int](1, 2, 3)
var A2 = @[int](1, 2, 3)
//
val () = fprintln! (stdout_ref, "1*1+2*2+3*3=", dotprod3<int> (A1, A2))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [dotprod.dats] *)
