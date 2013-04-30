(*
** for testing [libc/unistd]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload
STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "libc/SATS/unistd.sats"

(* ****** ****** *)

val () =
{
//
val out = stdout_ref
val cwd = getcwd_gc ()
val () = fprint_strptr (out, cwd)
val () = fprint_newline (out)
val () = strptr_free (cwd)
//
} // end of [val]

(* ****** ****** *)

val () =
{
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

val () =
{
//
val err = $STDLIB.system ("touch /tmp/deadbeef")
val ( ) = assertloc (err = 0)
val ( ) = symlink_exn ("/tmp/deadbeef", "/tmp/deadbeef2")
val ( ) = unlink_exn ("/tmp/deadbeef")
val ( ) = unlink_exn ("/tmp/deadbeef2")
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_unistd.dats] *)
