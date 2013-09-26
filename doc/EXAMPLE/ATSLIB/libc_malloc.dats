(*
** for testing [libc/malloc]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libc/SATS/malloc.sats"
staload "libc/SATS/stdlib.sats"

(* ****** ****** *)

val () = {
//
val N = g1i2u (1024)
val (pfopt | p) = malloc_libc (N)
val ((*void*)) = assertloc (p > 0)
prval malloc_libc_v_succ (pfat, pfgc) = pfopt
val () = malloc_stats ()
//
val nuse = malloc_usable_size (pfgc | p)
val () = println! ("malloc_usable_size (", p ,") = ", nuse)
//
val () = mfree_libc (pfat, pfgc | p)
//
val () = println! ("malloc_trim() = ", malloc_trim ((i2sz)0))
val () = println! ("malloc_trim() = ", malloc_trim ((i2sz)0))
//
val () = malloc_stats ()
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_malloc.dats] *)
