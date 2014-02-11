(* ****** ****** *)
//
// HX-2014-02-11
//
(* ****** ****** *)
//
// arrpsz/arrayptrsize
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun tally{n:nat}(psz: arrpsz(int, n)): int
  
(* ****** ****** *)

implement
tally{n} (psz) = let
//
var n0: size_t
val A0 = arrpsz_get_ptrsize (psz, n0)
val n0 = n0
//
fun loop
  {i:nat | i <= n}
(
  A: !arrayptr (int, n), i: int(i), res: int
) : int =
  if n0 > i then loop (A, succ(i), res+A[i]) else res
//
val res = loop (A0, 0, 0)
val () = arrayptr_free (A0)
//
in
  res
end // end of [tally]

(* ****** ****** *)

implement
main0 () =
{
//
val () = println! ("tally($arrpsz(1, 2, 3)) = ", tally($arrpsz{int}(1, 2, 3)))
val () = println! ("tally($arrpsz(1, 2, 3, 4, 5)) = ", tally($arrpsz{int}(1, 2, 3, 4, 5)))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-190.dats] *)
