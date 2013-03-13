(*
** for testing [libc/unistd]
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UNI = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/SATS/unistd.sats"

(* ****** ****** *)

val () = {
  val out = stdout_ref
  val cwd = getcwd_gc ()
  val () = fprint_strptr (out, cwd)
  val () = fprint_newline (out)
  val () = strptr_free (cwd)
} // end of [val]

(* ****** ****** *)

val () = {
//
  val left = sleep (1)
  val () = println! ("left = ", left)
  val left = sleep (1U)
  val () = println! ("left = ", left)
  val err = usleep (1000000)
//
  val () = assertloc (usleep (500000) = 0)
  val () = println! ("one-half second passed.")
  val () = assertloc (usleep (500000U) = 0)
  val () = println! ("one-half second passed.")
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_unistd.dats] *)
