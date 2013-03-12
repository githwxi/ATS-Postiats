(*
** for testing [libc/stdio]
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

val () = {
  val fp = tmpfile_exn ()
  val () = fclose_exn (fp)
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_stdio.dats] *)
