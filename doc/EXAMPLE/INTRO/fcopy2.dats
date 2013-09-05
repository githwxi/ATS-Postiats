//
// A naive implementation of file copying
//
(* ****** ****** *)
//
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
//
// Start time: April 2013
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/integer.dats"

(* ****** ****** *)
//
staload "libc/SATS/stdio.sats"
//
(* ****** ****** *)

#define N 1024

(* ****** ****** *)

fun fcopy2
(
  filr: FILEref, filr2: FILEref
) : void = let
//
fun loop {n:pos}
(
  buf: &b0ytes(n) >> bytes(n)
, n: int n, filr: FILEref, filr2: FILEref
) : void = let
  val p = fgets (buf, n, filr)
in
//
if p > 0 then let
  val () = fputs_exn ($UN.cast{string}(p), filr2)
in
  loop (buf, n, filr, filr2)
end else () // end of [if]
//
end // end of [loop]
//
val
(
  pfat, pfgc | p
) = malloc_gc ((i2sz)N)
val () = loop (!p, N, filr, filr2)
val () = mfree_gc (pfat, pfgc | p)
//
in
  // nothing
end (* end of [fcopy2] *)

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
  val () = fcopy2 (filr, filr2)
  val () = if argc >= 2 then fileref_close (filr)
  val () = if argc >= 3 then fileref_close (filr2)
} // end of [main]

(* ****** ****** *)

(* end of [fcopy2.dats] *)
