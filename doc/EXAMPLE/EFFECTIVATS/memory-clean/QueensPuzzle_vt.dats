(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)
//
extern
fun
qsolve{n:nat}(n: int(n)): stream_vt(list_vt(int, n))
//
(* ****** ****** *)

implement
qsolve{n}(n) =
(
if
n = 0
then
$ldelay
(
  stream_vt_cons(list_vt_nil, stream_vt_make_nil())
) (* end of [then] *)
else let
//
fun
test
{ i:int
| 0 < i; i <= n
} .<n-i>.
(
  x: int
, i: int(i), xs: !list_vt(int, n-i)
) :<> bool =
(
case+ xs of
| list_vt_nil() => true
| list_vt_cons(x1, xs) =>
    if (x != x1 && abs(x-x1) != i) then test(x, i+1, xs) else false
  // end of [list_cons]
)
//
fun
extend
(
  x: int, xs: list_vt(int, n-1)
) :<!laz> stream_vt(list_vt(int, n)) = $ldelay
(
//
(
if x < N then (
  if test(x, 1, xs)
    then stream_vt_cons(list_vt_cons(x, list_vt_copy(xs)), extend(x+1, xs)) else !(extend(x+1, xs))
  // end of [if]
) else (list_vt_free(xs); stream_vt_nil(*void*))
) : stream_vt_con(list_vt(int, n))
//
,
//
list_vt_free(xs)
//
)  (* end of [extend] *)
//
in
//
stream_vt_concat<list_vt(int, n)>
(
  stream_vt_map_fun<list_vt(int,n-1)><stream_vt(list_vt(int,n))>(qsolve(n-1), lam(xs) =<0> $effmask_all(extend(0, xs)))
) (* end of [stream_vt_concat] *)
//
end // end of [else]
//
) (* end of [qsolve] *)

(* ****** ****** *)
//
implement
main0() =
{
  val xss = stream2list_vt(qsolve(N))
  val ((*void*)) =
    println! ("The number of solutions equals ", length(xss))
  // end of [val]
  val ((*void*)) = list_vt_freelin_fun(xss, lam(xs) =<1> list_vt_free(xs))
}
//
(* ****** ****** *)

(* end of [QueensPuzzle.dats] *)
