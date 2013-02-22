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

fun fcopy (
  filr: FILEref
, filr2: FILEref
) : void = let
  val c = fileref_getc (filr)
in
  if c >= 0 then let
    val () = fileref_putc (filr2, c) in fcopy (filr, filr2)
  end // end of [if]
end (* end of [fcopy] *)

(* ****** ****** *)

implement
main (
  argc, argv
) = 0 where {
  val filr = (
    if argc >= 2 then
      fileref_open_exn (argv[1], $UN.cast{fmode}("r"))
    else stdin_ref
  ) : FILEref // end of [filr]
  val filr2 = (
    if argc >= 3 then
      fileref_open_exn (argv[2], $UN.cast{fmode}("w"))
    else stdout_ref
  ) : FILEref // end of [val]
  val () = fcopy (filr, filr2)
  val () = if argc >= 2 then fileref_close (filr)
  val () = if argc >= 3 then fileref_close (filr2)
} // end of [main]

(* ****** ****** *)

(* end of [fcopy.dats] *)
