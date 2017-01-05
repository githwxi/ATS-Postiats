(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Somewhere in January, 2017
//
(* ****** ****** *)
(*
Task

Shuffle the characters of a string in such a way that as many of the
character values are in a different position as possible.

A shuffle that produces a randomized result among the best choices is
to be preferred. A deterministic approach that produces the same
sequence every time is acceptable as an alternative.

Display the result as follows:

original string, shuffled string, (score) 

The score gives the number of positions whose character value did not
change.
*)
(* ****** ****** *)
(*
Output:
abracadabra, caarbdabaar, (0)
seesaw, wasese, (0)
elk, lke, (0)
grrrrrr, rrrrgrr, (5)
up, pu, (0)
a, a, (1)
*)
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
//
#staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
extern
fun
shuffling_score{n:int}
  (cs1: string(n), cs2: string(n)): intBtwe(0, n)

//
(* ****** ****** *)

implement
shuffling_score
  {n}(cs1, cs2) = let
//
val n = sz2i(length(cs1))
//
fun
loop
{ i:nat
| i <= n
} .<n-i>.
  (i: int(i), res: intBtwe(0, i)): intBtwe(0, n) =
  if i < n then loop(i+1, if cs1[i] != cs2[i] then res else res+1) else res
//
in
  loop(0, 0)
end // end of [shuffling_score]

(* ****** ****** *)
//
extern
fun
string_shuffle_best
  {n:int}
  (cs1: string(n)): string(n)
//
implement
string_shuffle_best
  {n}(cs1) = let
//
prval() =
  lemma_string_param(cs1)
//
val n0 = length(cs1)
//
val cs2 = string1_copy(cs1)
val (pf, fpf | p0) =
  $UN.ptr_vtake{array(char,n)}(strnptr2ptr(cs2))
//
local
//
implement
array_permute$randint<>
  (n) = i2sz(randint(sz2i(n)))
//
in
val ((*void*)) = array_permute(!p0, n0)
end // end of [local]
//
prval ((*returned*)) = fpf(pf)
//
val n0 = sz2i(n0)
val () =
int2_foreach_cloref
( n0, n0
, lam(i, j) =>
  if i != j then let
    val i = $UN.cast{natLt(n)}(i)
    val j = $UN.cast{natLt(n)}(j)
    val ci = $UN.ptr0_get_at<char>(p0, i)
    val cj = $UN.ptr0_get_at<char>(p0, j)
  in
    if (cs1[i] != cj && cs1[j] != ci) then ($UN.ptr0_set_at<char>(p0, i, cj); $UN.ptr0_set_at<char>(p0, j, ci))
  end // end of [let]
) (* int2_foreach_cloref *)
//
in
  strnptr2string(cs2)
end // end of [string_shuffle_best]

(* ****** ****** *)

#staload TIME = "libats/libc/SATS/time.sats"
#staload STDLIB = "libats/libc/SATS/stdlib.sats"

(* ****** ****** *)

implement
main0 () =
{
//
fun
test
{n:int}
(
  cs1: string(n)
) : void =
{
val cs2 = string_shuffle_best(cs1)
val score = shuffling_score(cs1, cs2)
val ((*void*)) = println! (cs1, ", ", cs2, ", ", "(", score, ")")
} (* end of [test] *)
//
val () = $STDLIB.srandom($UN.cast($TIME.time_get()))
//
val () = test("abracadabra")
val () = test("seesaw")
val () = test("elk")
val () = test("grrrrrr")
val () = test("up")
val () = test("a")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Best_shuffle.dats] *)
