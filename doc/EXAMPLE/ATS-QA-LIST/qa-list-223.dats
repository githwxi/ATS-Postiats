(* ****** ****** *)
//
// HX-2014-03-13
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun{
a:t@ype
} some_fun{n:nat}
  (!arrayptr (a, n), !arrayptr (a, n)): void
//
(* ****** ****** *)

implement
main0 ((*void*)) =
{
//
val A =
(arrayptr)$arrpsz{int}(0, 1)
//
val (fpf | A2) =
  decode ($vcopyenv_vt(A))
val () = some_fun<int> (A, A2)
prval ((*void*)) = fpf (A2)
//
val () = arrayptr_free (A)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-223.dats] *)
