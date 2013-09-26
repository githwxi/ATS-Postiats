(*
** for testing [libc/unistd]
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

staload
FCNTL = "libc/SATS/fcntl.sats"
staload
STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "libc/SATS/unistd.sats"

(* ****** ****** *)

val () =
{
val STDIN2 = dup (STDIN_FILENO)
val () = println! ("STDIN2 = ", STDIN2)
val () = close0_exn (STDIN2)
val STDOUT2 = dup (STDOUT_FILENO)
val STDERR2 = dup (STDERR_FILENO)
val () = println! ("STDOUT2 = ", STDOUT2)
val () = println! ("STDERR2 = ", STDERR2)
//
val (fpf | fildes) = $FCNTL.fildes_iget_int (STDOUT2)
val fd = $FCNTL.fildes_get_int (fildes)
prval () = fpf (fildes)
val () = println! ("fd = ", fd)
//
val () = close0_exn (STDOUT2)
//
val (fpf | fildes) = $FCNTL.fildes_iget_int (STDOUT2)
val fd = $FCNTL.fildes_get_int (fildes)
prval () = fpf (fildes)
val () = println! ("fd(-1) = ", fd)
} (* end of [libc_unistd] *)

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
val out = stdout_ref
val uid = getlogin_r_gc ()
val () = fprintln! (out, "userid = ", uid)
val () = strptr_free (uid)
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
val ( ) = unlink_exn ("/tmp/deadbeef")
val ( ) = symlink_exn ("Hello, world!", "/tmp/deadbeef2")
val str = readlink_gc ("/tmp/deadbeef2")
val ( ) = unlink_exn ("/tmp/deadbeef2")
val ( ) = println! ("readlink(/tmp/deadbeef2) = ", str)
val ( ) = strptr_free (str)
val str = readlink_gc ("/tmp/deadbeef3")
val ( ) = println! ("readlink(/tmp/deadbeef3) = ", str)
val ( ) = strptr_free (str)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_unistd.dats] *)
