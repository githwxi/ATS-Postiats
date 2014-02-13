(* ****** ****** *)
//
// HX-2014-02-11
//
(* ****** ****** *)
//
// $vcopyenv_vt
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun tally{n:int}(!arrayptr(int, n), n: size_t n): int
  
(* ****** ****** *)

implement
tally (A, n) = let
//
fun loop{i:nat}
(
  i: size_t i, res: int
) : int =
  if i < n then let
    val (fpf | A) =
      decode($vcopyenv_vt(A))
    val res = res + A[i]
    prval ((*void*)) = fpf (A)
  in
    loop (succ(i), res)
  end else res // end of [if]
//
in
  loop (i2sz(0), 0)
end // end of [tally]

(* ****** ****** *)

implement
main0 () =
{
//
val A = (arrayptr)$arrpsz{int}(1,2,3,4,5,6,7,8,9)
val () = println! ("tally(A, 9) = ", tally(A, i2sz(9)))
val () = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-191.dats] *)
