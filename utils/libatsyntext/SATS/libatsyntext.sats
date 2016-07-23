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

typedef d0ecl = $SYN.d0ecl
typedef d0eclist = $SYN.d0eclist

(* ****** ****** *)
//
staload
S2EXP = "src/pats_staexp2.sats"
staload
D2EXP = "src/pats_dynexp2.sats"
//
typedef s2exp = $S2EXP.s2exp
typedef d2exp = $D2EXP.d2exp
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
//
(* ****** ****** *)
//
(*
fun
parse_from_filename_toplevel
  (stadyn: int, fil: fil_t): d0eclist
fun
parse_from_filename_toplevel2
  (stadyn: int, fil: fil_t): d0eclist
*)
//
fun{}
parse_from_givename_toplevel
(
  stadyn: int, given: string, filref: &fil_t? >> fil_t
) : d0eclist // end of [parse_from_givename_toplevel]
//
(* ****** ****** *)

(* end of [libatsyntext.sats] *)
