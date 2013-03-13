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

val () =
{
  val out = stdout_ref
  val cwd = getcwd_gc ()
  val () = fprint_strptr (out, cwd)
  val () = fprint_newline (out)
  val () = strptr_free (cwd)
}

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_unistd.dats] *)
