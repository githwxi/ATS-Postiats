(*
** for testing [prelude/memory]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
fun malloc_gc
  {n:int}
(
  n: size_t (n)
) :<!wrt>
  [l:agz]
(
  b0ytes n @ l, mfree_gc_v (l) | ptr l
) = "mac#%" // endfun

fun mfree_gc
  {l:addr}{n:int}
(
  pfat: b0ytes n @ l, pfgc: mfree_gc_v (l) | ptr l
) :<!wrt> void = "mac#%" // endfun
*)

(* ****** ****** *)

val () =
{
//
val
(
  pfat, pfgc | p
) = malloc_gc ((i2sz)1000000)
//
val () = assertloc (p > 0)
//
val () = mfree_gc (pfat, pfgc | p)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_memory.dats] *)
