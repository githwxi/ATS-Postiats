(*
** for testing [libc/stdio]
*)

(* ****** ****** *)

#include "share/atspre_staload.hats"

(* ****** ****** *)

#define EOF ~1

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
  val () = assertloc (ret = 0)
  val ret = ferror (fp)
  val () = assertloc (ret = 0)
//
  val c = fgetc (pfr | fp)
  val () = assertloc (c = EOF)
//
  val ret = feof (fp)
  val () = assertloc (ret != 0)
  val ret = ferror (fp)
  val () = assertloc (ret = 0)
//
  val c0 = '0'
  val c0 = fputc (pfw | c0, fp)
  val () = assertloc (c0 = char2int0 '0')
//
  val c1 = '1'
  val c1 = fputc (pfw | c1, fp)
  val () = assertloc (c1 = char2int0 '1')
//
  val ret = fseek (fp, 0L, SEEK_SET)
  val () = assertloc (ret = 0)
//
  val ret = ftell (fp)
  val () = assertloc (ret = 0L)
//
  val c0 = fgetc (pfr | fp)
  val () = assertloc (c0 = char2int0 '0')
  val ret = ftell (fp)
  val () = assertloc (ret = 1L)
//
  val c1 = fgetc (pfr | fp)
  val () = assertloc (c1 = char2int0 '1')
  val ret = ftell (fp)
  val () = assertloc (ret = 2L)
//
  val ret = fputs (pfw | "23456789", fp)
  val () = assertloc (ret != 0)
  val ret = ftell (fp)
  val () = assertloc (ret = 10L)
//
  val () = rewind (fp)
  val ret = ftell (fp)
  val () = assertloc (ret = 0L)
//
  val () = fclose_exn (fp)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_stdio.dats] *)
