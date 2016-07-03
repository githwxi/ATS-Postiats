(*
//
// HX-2016-07-02
// A program to solve the 8-queens problem
// based on lazy evaluation
//
// Please note that
// this is a memeory-clean implementation!!!
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)
//
extern
fun
qsolve(n: int): stream_vt(List0_vt(int))
//
(* ****** ****** *)

implement
qsolve(n) = let
//
(*
val () =
  println! ("qsolve: n = ", n)
*)
//
vtypedef
stream0_vt = List0_vt(int)
vtypedef
stream1_vt = stream_vt(stream0_vt)
vtypedef
stream2_vt = stream_vt(stream1_vt)
//
fun
test
(
  x0: int, xs: !List0_vt(int)
) : bool = let
//
var
pred =
lam@
(
  i: intGte(0), x: int
) : bool =<clo> x0 != x && abs(x0-x) != i+1
//
in
//
list0_iforall
(
  $UNSAFE.castvwtp1{list0(int)}(xs), $UNSAFE.cast(addr@pred)
) (* list0_iforall *)
//
end // end of [test]
//
fun
extend
(
  x0: int
, xs: List0_vt(int)
) : stream_vt(List0_vt(int)) = $ldelay
(
(
if
x0 < N
then (
  if test(x0, xs)
    then
    stream_vt_cons(
      cons_vt(x0, list_vt_copy(xs)), extend(x0+1, xs)
    ) (* stream_vt_cons *)
    else !(extend(x0+1, xs))
  // end of [if]
) else
(
  list_vt_free(xs); stream_vt_nil((*void*))
)
) : stream_vt_con(List0_vt(int))
,
list_vt_free(xs)
) (* end of [extend] *)
//
in
//
if
(n > 0)
then (
//
stream_vt_concat(
  stream_vt_map_fun<stream0_vt><stream1_vt>
    (qsolve(n-1), lam(xs) => $effmask_all(extend(0, xs)))
) (* stream_vt_concat *)
//
) (* end of [then] *)
else (
$ldelay(
  stream_vt_cons(nil_vt(), stream_vt_make_nil())
) (* $ldelay *)
) (* end of [else] *)
//
end // end of [qsolve]

(* ****** ****** *)

fun
process_sol
(
  xss: stream_vt(List0_vt(int)), i: int
) : int =
(
case+ !xss of
| ~stream_vt_nil() => i
| ~stream_vt_cons(xs, xss) => (list_vt_free(xs); process_sol(xss, i+1))
)

(* ****** ****** *)

implement
main0((*void*)) =
{
  val () = println! ("|qsolve(", N, ")| = ", process_sol(qsolve(N), 0))
}
(* ****** ****** *)

(* end of [queens_lincomb] *)
