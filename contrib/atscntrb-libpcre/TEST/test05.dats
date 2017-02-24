//
// Some code for testing the API in ATS for pcre
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/pcre.sats"
staload "./../SATS/pcre_ML.sats"

(* ****** ****** *)

staload _ = "./../DATS/pcre.dats"
staload _ = "./../DATS/pcre_ML.dats"

(* ****** ****** *)

extern
fun mygrep
  (inp: FILEref, out: FILEref, regstr: string): void
// end of [mygrep]

(* ****** ****** *)

implement
mygrep (inp, out, regstr) = let
//
fun loop
(
  regexp: !pcreptr1, nline: int
) : void = let
//
val isnot = fileref_isnot_eof (inp)
//
in
  if isnot then let
    val line = fileref_get_line_string (inp)
    val nret = pcre_match_string (regexp, $UN.strptr2string(line))
    val () = if nret >= 0 then fprintln! (out, "line(", nline, "): ", line)
    val () = strptr_free (line)
  in
    loop (regexp, nline+1)
  end else () // end of [if]
end // end of [loop]
//
var errptr: ptr
var erroffset: int
val tableptr = the_null_ptr
val regexp = pcre_compile (regstr, 0u, errptr, erroffset, tableptr)
//
val p0 = ptrcast (regexp)
//
in
//
if p0 > 0 then let
  val () =
    loop (regexp, 1(*nline*))
  val () = pcre_free (regexp)
in
  // nothing
end else let
  prval () = pcre_free_null (regexp)
in
  // nothing
end // end of [if]
//
end // end of [mygrep]

(* ****** ****** *)

implement
main0
  (argc, argv) =
{
//
val inp = stdin_ref
val out = stdout_ref
//
val regstr =
  (if argc >= 2 then argv[1] else ""): string
val () = mygrep (inp, out, regstr)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test05.dats] *)
