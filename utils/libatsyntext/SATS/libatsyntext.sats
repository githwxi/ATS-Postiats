(*
**
** Some utility functions for
** manipulating the syntax of ATS2
**
** Contributed by
** Hongwei Xi (gmhwxiATgmailDOTcom)
**
** Start Time: July, 2016
**
*)

(* ****** ****** *)
//
vtypedef
charlst_vt = List0_vt(char)
//
(* ****** ****** *)
//
staload
ERR = "src/pats_error.sats"
//
(* ****** ****** *)
//
staload
SYM = "src/pats_symbol.sats"
//
typedef sym_t = $SYM.symbol
typedef symbol = $SYM.symbol
//
(* ****** ****** *)
//
staload
LOC = "src/pats_location.sats"
//
typedef pos_t = $LOC.position
typedef loc_t = $LOC.location
//
(* ****** ****** *)
//
staload
FIL = "src/pats_filename.sats"
//
typedef fil_t = $FIL.filename
//
(* ****** ****** *)
//
staload LEX = "src/pats_lexing.sats"
//
staload SYN = "src/pats_syntax.sats"
//
staload PAR = "src/pats_parsing.sats"
//
(* ****** ****** *)
//
staload S1EXP = "src/pats_staexp1.sats"
staload D1EXP = "src/pats_dynexp1.sats"
//
(* ****** ****** *)
//
staload S2EXP = "src/pats_staexp2.sats"
staload D2EXP = "src/pats_dynexp2.sats"
//
(* ****** ****** *)
//
typedef d0ecl = $SYN.d0ecl
typedef d0eclist = $SYN.d0eclist
//
typedef s1exp = $S1EXP.s1exp
typedef d1exp = $D1EXP.d1exp
//
typedef s1exp = $S1EXP.s1exp
typedef d1exp = $D1EXP.d1exp
//
typedef s2exp = $S2EXP.s2exp
typedef d2exp = $D2EXP.d2exp
typedef d2ecl = $D2EXP.d2ecl
typedef d2eclist = $D2EXP.d2eclist
//
(* ****** ****** *)
//
fun{}
parse_from_stdin_toplevel
  (stadyn: int): d0eclist
//
fun{}
parse_from_fileref_toplevel
  (stadyn: int, inp: FILEref): d0eclist
// end of [parse_from_fileref_toplevel]
//
(* ****** ****** *)
//
fun{}
parse_from_filename_toplevel
  (stadyn: int, fil: fil_t): d0eclist
fun{}
parse_from_filename_toplevel2
  (stadyn: int, fil: fil_t): d0eclist
//
fun{}
parse_from_givename_toplevel
(
  stadyn: int, given: string, filref: &fil_t? >> fil_t
) : d0eclist // end of [parse_from_givename_toplevel]
//
(* ****** ****** *)

fun syntext_d2ecl(out: FILEref, d2c: d2ecl): void
fun syntext_d2eclist(out: FILEref, d2cs: d2eclist): void

(* ****** ****** *)

(* end of [libatsyntext.sats] *)
