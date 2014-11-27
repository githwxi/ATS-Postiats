(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
absvtype lock(a:vt@ype)
//
extern
fun{a:vt0p}
lock_acquire(!lock(a)): a
extern
fun{a:vt0p}
lock_release(!lock(a), a): void
//
overload [] with lock_acquire
overload [] with lock_release
//
(* ****** ****** *)
//
val
mylock = $extval(lock(int), "mylock")
//
val x0 = mylock[]
val () = mylock[] := x0
//
(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [chap_brktoverld.dats] *)
