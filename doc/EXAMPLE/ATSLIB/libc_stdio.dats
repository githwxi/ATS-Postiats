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
//
  prval pfr = file_mode_lte_rw_r ()
  prval pfw = file_mode_lte_rw_w ()
//
  val ret = fileno (fp)
  val () = println! ("fileno (...) = ", ret)
//
  val ret = feof (fp)
  val () = println! ("feof (...) = ", ret)
//
  val c = fgetc_err (pfr | fp)
  val () = println! ("fgetc (...) = ", c)
//
  val ret = feof (fp)
  val () = println! ("feof (...) = ", ret)
//
  val c = '0'
  val c = fputc_err (pfw | c, fp)
  val () = println! ("fputc (...) = ", c)
//
  val () = fclose_exn (fp)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_stdio.dats] *)
