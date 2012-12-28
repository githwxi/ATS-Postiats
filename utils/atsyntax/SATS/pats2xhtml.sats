(*
** for highlighting/xreferencing ATS2 code
*)

(* ****** ****** *)

staload
LSYN = "libatsyntax/SATS/libatsyntax.sats"
typedef putc_type = $LSYN.putc_type

(* ****** ****** *)

macdef fstring_putc = $LSYN.fstring_putc

(* ****** ****** *)

fun fileref2charlst (fil: FILEref): List_vt (char)

(* ****** ****** *)

fun pats2xhtml_level1_charlst (
  stadyn: int, cs: List_vt (char), putc: putc_type
) : void // end of [pats2xhtml_level1_charlst]

fun pats2xhtml_level1_fileref
  (stadyn: int, inp: FILEref, putc: putc_type): void
// end of [pats2xhtml_level1_fileref]

(* ****** ****** *)

(* end of [pats2xhtml.sats] *)
