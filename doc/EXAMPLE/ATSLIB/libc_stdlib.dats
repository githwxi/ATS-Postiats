(*
** for testing [libc/stdlib]
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

staload UNI = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/SATS/stdlib.sats"
staload _ = "libc/DATS/stdlib.dats"

(* ****** ****** *)

val () =
{
  val u = getenv_gc ("USER")
  val () = println! ("$USER = ", u)
  val () = strptr_free (u)
} // end of [val]

(* ****** ****** *)

val () = {
  val seed = 31415926U
  val () = srand (seed)
  val r1 = rand ()
  val r2 = rand ()
  val () = srand (seed)
  val () = assertloc (r1 = rand ())
  val () = assertloc (r2 = rand ())
  var seed_r: uint = seed
  val r1 = rand_r (seed_r)
  val r2 = rand_r (seed_r)
  var seed_r: uint = seed
  val () = assertloc (r1 = rand_r (seed_r))
  val () = assertloc (r2 = rand_r (seed_r))
} // end of [val]

(* ****** ****** *)

val () = {
  val seed = 31415926U
  val () = srandom (seed)
  val l1 = random ()
  val l2 = random ()
  val () = srandom (seed)
  val () = assertloc (l1 = random ())
  val () = assertloc (l2 = random ())
} // end of [val]

(* ****** ****** *)

val () = {
//
val () = srand48 (27182828L)
val d1 = drand48 ()
val d2 = drand48 ()
val () = srand48 (27182828L)
val () = assertloc (d1 = drand48 ())
val () = assertloc (d2 = drand48 ())
//
val () = srand48 (27182828L)
val l1 = lrand48 ()
val l2 = lrand48 ()
val () = srand48 (27182828L)
val () = assertloc (l1 = lrand48 ())
val () = assertloc (l2 = lrand48 ())
//
val () = srand48 (27182828L)
val m1 = mrand48 ()
val m2 = mrand48 ()
val () = srand48 (27182828L)
val () = assertloc (m1 = mrand48 ())
val () = assertloc (m2 = mrand48 ())
//
} // end of [val]

(* ****** ****** *)

val () = {
//
val str = "scratch-XXXXXX"
val str2 = string1_copy (str)
val fdes = mkstemp (str2)
val () = assertloc (fdes >= 0)
val () = assertloc ($UNI.close (fdes) = 0)
val () = assertloc ($UNI.unlink ($UNSAFE.strnptr2string(str2)) = 0)
val () = strnptr_free (str2)
//
} // end of [val]

(* ****** ****** *)

val () = {
  val () = assertloc (system ("ls -l > /dev/null") = 0)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_stdlib.dats] *)
