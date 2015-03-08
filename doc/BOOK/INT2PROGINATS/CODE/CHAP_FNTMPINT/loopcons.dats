(* ****** ****** *)
//
// For use in INT2PROGINATS
//
(* ****** ****** *)
//
// Templates for loop construction
//
(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

fun
tally
(
  n: int
) : int = loop (0, 0) where
{
  fun loop (i: int, res: int): int =
    if i < n then loop (i + 1, res + i) else res
}

(* ****** ****** *)

fun
for_loop
(
  count: int, limit: int, fwork: (int) -<cloref1> void
) : void = (
if count < limit
  then (fwork(count); for_loop(count+1, limit, fwork)) else ()
// end of [if]
) (* end of [for_loop] *)

(* ****** ****** *)

fun
tally2
(
  n: int
) : int = let
  val res = ref<int> (0)
in
  for_loop (0, n, lam (i) => !res := !res + i); !res
end // end of [tally2]

(* ****** ****** *)

fun{
env:t@ype
} for_loop2
(
  count: int, limit: int
, env: &env >> _, fwork: (int, &env >> _) -<cloref1> void
) : void = (
if
count < limit
then (
  fwork(count, env); for_loop2<env>(count+1, limit, env, fwork)
) else ()
// end of [if]
) (* end of [for_loop2] *)

(* ****** ****** *)

fun
tally3
(
  n: int
) : int = let
  var res: int = 0
in
  for_loop2<int> (0, n, res, lam (i, res) => res := res + i); res
end // end of [tally3]

(* ****** ****** *)

extern
fun{
env:t@ype
} for_loop3$fwork(count: int, env: &env >> _): void

fun{
env:t@ype
} for_loop3
(
  count: int, limit: int, env: &env >> _
) : void = (
if
count < limit
then (
  for_loop3$fwork<env>(count, env); for_loop3<env>(count+1, limit, env)
) else ()
// end of [if]
) (* end of [for_loop3] *)

(* ****** ****** *)

fun
tally4
(
  n: int
) : int = let
//
var res: int = 0
//
implement
for_loop3$fwork<int> (i, res) = res := res + i
//
in
  for_loop3<int> (0, n, res); res
end // end of [tally4]

(* ****** ****** *)

val N = 100
val () = println! ("tally(", N, ") = ", tally(N))
val () = println! ("tally2(", N, ") = ", tally2(N))
val () = println! ("tally3(", N, ") = ", tally3(N))
val () = println! ("tally4(", N, ") = ", tally4(N))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [loopcons.dats] *)
