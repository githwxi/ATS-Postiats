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
//
extern
fun
qsolve
{n:nat}(int(n)): stream(list(int, n))
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

implement
qsolve{n}(n) =
(
if
n = 0
then
(
  stream_make_sing(list_nil)
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
, i: int(i), xs: list(int, n-i)
) :<> bool =
(
case+ xs of
| list_nil() => true
| list_cons(x1, xs) =>
    if (x != x1 && abs(x-x1) != i)
      then test(x, i+1, xs) else false
  // end of [list_cons]
)
//
fun
extend
{x:nat | x <= N} .<N-x>.
(
  x: int(x), xs: list(int, n-1)
) :<> stream(list(int, n)) = $delay
(
//
if x < N then (
  if test(x, 1, xs)
    then stream_cons(list_cons(x, xs), extend(x+1, xs))
    else !(extend(x+1, xs))
  // end of [if]
) else stream_nil(*void*)
//
) (* end of [extend] *)
//
in
//
stream_concat
(
  stream_map_fun(qsolve(n-1), lam(xs) => extend(0, xs))
) (* end of [stream_concat] *)
//
end // end of [else]
//
) (* end of [qsolve] *)

(* ****** ****** *)
//
implement
main0() =
{
  val xss = qsolve(N)
  val ((*void*)) = println! ("The number of solutions equals ", length(xss))
}
//
(* ****** ****** *)

(* end of [QueensPuzzle.dats] *)
