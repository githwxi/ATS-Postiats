//
// A naive implementation of file copying
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: January 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)

fun fcopy
(
  inp: FILEref, out: FILEref
) : void = let
  val c = fileref_getc (inp)
in
  if c >= 0 then let
    val () = fileref_putc (out, c) in fcopy (inp, out)
  end // end of [if]
end (* end of [fcopy] *)

(* ****** ****** *)

implement
main (
  argc, argv
) = 0 where {
  val inp =
  (
    if argc >= 2 then
      fileref_open_exn (argv[1], file_mode_r)
    else stdin_ref
  ) : FILEref // end of [inp]
  val out =
  (
    if argc >= 3 then
      fileref_open_exn (argv[2], file_mode_w)
    else stdout_ref
  ) : FILEref // end of [val]
  val () = fcopy (inp, out)
  val () = if argc >= 2 then fileref_close (inp)
  val () = if argc >= 3 then fileref_close (out)
} // end of [main]

(* ****** ****** *)

(* end of [fcopy.dats] *)
