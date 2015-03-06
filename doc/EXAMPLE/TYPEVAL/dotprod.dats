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
dotprod3(A0: &(@[a][3]), A1: &(@[a][3])): a
//
extern
fun
{a:t0p}
dotprod4(A0: &(@[a][4]), A1: &(@[a][4])): a
//
(* ****** ****** *)

extern praxi tieq3(): tieq(fS(3), 3)
extern praxi tieq4(): tieq(fS(4), 4)

(* ****** ****** *)

implement
(a:t@ype)
sarray_foreach2$fwork<a>
  (x0, x1, env) =
{
  val r0 =
  $UN.ptr0_get<a>(env)
  val () =
  $UN.ptr0_set<a>
    (env, gadd_val<a> (r0, gmul_val<a> (x0, x1)))
  // end of [val]
} (* end of [sarray_foreach2$fwork] *)

(* ****** ****** *)

implement
{a}(*tmp*)
dotprod3
  (A0, A1) = res where
{
//
var res: a = gnumber_int<a>(0)
//
val ((*void*)) =
  sarray_foreach2<a><fS(3)>(tieq3() | A0, A1, addr@res)
//
} (* end of [dotprod3] *)

implement
{a}(*tmp*)
dotprod4
  (A0, A1) = res where
{
//
var res: a = gnumber_int<a>(0)
//
val ((*void*)) =
  sarray_foreach2<a><fS(4)>(tieq4() | A0, A1, addr@res)
//
} (* end of [dotprod4] *)

(* ****** ****** *)

implement
main0 () =
{
//
var A0 = @[int](1, 2, 3)
var A1 = @[int](1, 2, 3)
val () = fprintln! (stdout_ref, "1*1+2*2+3*3=", dotprod3<int> (A0, A1))
//
var A0 = @[int](1, 2, 3, 4)
var A1 = @[int](1, 2, 3, 4)
val () = fprintln! (stdout_ref, "1*1+2*2+3*3+4*4=", dotprod4<int> (A0, A1))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [dotprod.dats] *)
