(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxi AT gmail DOT com
// Start Time: March, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location
overload fprint with $LOC.fprint_location

(* ****** ****** *)

staload "./pats_lexing.sats"

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

implement
parerr_make (loc, node) = '{
  parerr_loc= loc, parerr_node= node
} // end of [parerr_make]

(* ****** ****** *)

vtypedef parerrlst_vt = List_vt (parerr)

(* ****** ****** *)
//
// HX-2011-03-12:
// [n] stores the total number of errors, some of
// which may not be recorded
//
extern
fun the_parerrlst_get (n: &int? >> int): parerrlst_vt
//
(* ****** ****** *)

local
//
// HX-2011-03-22:
// MAXLEN is the max number of errors to be reported
//
#define MAXLEN 100
#assert (MAXLEN > 0)
//
val the_length = ref<int> (0)
val the_parerrlst = ref<parerrlst_vt> (list_vt_nil)
//
in (* in-of-local *)

implement
the_parerrlst_clear
  () = () where {
  val () = !the_length := 0
  val () = () where {
    val (vbox pf | p) = ref_get_view_ptr (the_parerrlst)
    val () = list_vt_free (!p)
    val () = !p := list_vt_nil ()
  } // end of [val]
} (* end of [the_parerrlst_clear] *)

implement
the_parerrlst_add
  (err) = () where {
  val n = let
    val (vbox pf | p) = ref_get_view_ptr (the_length)
    val n = !p
    val () = !p := n + 1
  in n end // end of [val]
  val () = if n < MAXLEN then let
    val (vbox pf | p) = ref_get_view_ptr (the_parerrlst)
  in
    !p := list_vt_cons (err, !p)
  end // end of [val]
} (* end of [the_parerrlst_add] *)

implement
the_parerrlst_get
  (n) = xs where {
  val () = n := !the_length
  val () = !the_length := 0
  val (vbox pf | p) = ref_get_view_ptr (the_parerrlst)
  val xs = !p
  val xs = list_vt_reverse (xs)
  val () = !p := list_vt_nil ()
} (* end of [the_parerrlst_get] *)

end // end of [local]

(* ****** ****** *)

implement
the_parerrlst_add_ifnbt
  (bt, loc, node) = let
in
//
if (bt = 0)
  then the_parerrlst_add (parerr_make (loc, node)) else ()
//
end // end of [the_parerrlst_add_if0]

(* ****** ****** *)

implement
the_parerrlst_add_ifunclosed
  (loc, name) = let
  val newline = '\n'
in
//
if string_contains (name, newline)
  then the_parerrlst_add (parerr_make (loc, PE_fname_unclosed)) else ()
//
end // end of [the_parerrlst_add_ifunclosed]

(* ****** ****** *)

fun
synent_needed
(
  out: FILEref
, x: parerr, name: string
) : void = () where {
//
val () = fprint (out, x.parerr_loc)
val () =
  fprintf (out, ": error(parsing): the syntactic entity [%s] is needed.", @(name))
val () = fprint_newline (out)
//
} (* end of [synent_needed] *)

(* ****** ****** *)

fun
keyword_needed
(
  out: FILEref
, x: parerr, name: string
) : void = () where {
  val () = fprint (out, x.parerr_loc)
  val () = fprintf (out, ": error(parsing): the keyword [%s] is needed.", @(name))
  val () = fprint_newline (out)
} (* end of [keyword_needed] *)

(* ****** ****** *)

fun
parenth_needed
(
  out: FILEref
, x: parerr, name: string
) : void = () where {
  val () = fprint (out, x.parerr_loc)
  val () = fprintf (out, ": error(parsing): the keyword '%s' is needed.", @(name))
  val () = fprint_newline (out)
} (* end of [parenth_needed] *)

(* ****** ****** *)

fun
fname_unclosed
(
  out: FILEref, x: parerr
) : void = () where {
  val () = fprint (out, x.parerr_loc)
  val () = fprintf (out, ": error(parsing): the filename is unclosed.", @())
  val () = fprint_newline (out)
} (* end of [fname_unclosed] *)

(* ****** ****** *)

fun
token_discarded
(
  out: FILEref, x: parerr
) : void = () where {
  val () = fprint (out, x.parerr_loc)
  val () = fprintf (out, ": error(parsing): the token is discarded.", @())
  val () = fprint_newline (out)
} // end of [token_discarded]

(* ****** ****** *)

(*
fun
file_unavailable
(
  out: FILEref, x: parerr
) : void = let
//
val-PE_FILENONE(fname) = x.parerr_node
val ((*void*)) = fprint (out, x.parerr_loc)
val ((*void*)) = fprintf (out, ": error(parsing): the file [%s] is unavailable.", @(fname))
//
in
  // nothing
end // end of [file_unavailable]
*)

(* ****** ****** *)

implement
fprint_parerr
  (out, x) = let
//
val loc = x.parerr_loc and node = x.parerr_node
//
macdef SN (x, name) = synent_needed (out, ,(x), ,(name))
macdef KN (x, name) = keyword_needed (out, ,(x), ,(name))
macdef PN (x, name) = parenth_needed (out, ,(x), ,(name))
//
in
//
case+ node of
//
| PE_AS() => KN (x, "as")
//
| PE_AND() => KN (x, "and")
//
| PE_END() => KN (x, "end")
//
| PE_OF() => KN (x, "of")
| PE_IN() => KN (x, "in")
//
| PE_IF() => KN (x, "if")
| PE_SIF() => KN (x, "sif")
//
| PE_CASE() => KN (x, "case")
| PE_SCASE() => KN (x, "scase")
//
| PE_IFCASE() => KN (x, "ifcase")
//
| PE_THEN () => KN (x, "then")
| PE_ELSE () => KN (x, "else")
//
| PE_REC () => KN (x, "rec")
| PE_WHEN () => KN (x, "when")
| PE_WITH () => KN (x, "with")
//
| PE_TRY () => KN (x, "try")
//
| PE_FOR () => KN (x, "for")
| PE_WHILE () => KN (x, "while")
//
| PE_BAR () => KN (x, "|")
| PE_COLON () => KN (x, ":")
| PE_COMMA () => KN (x, ",")
| PE_SEMICOLON () => KN (x, ";")
| PE_BANG () => KN (x, "!")
| PE_DOT () => KN (x, ",")
| PE_EQ () => KN (x, "=")
| PE_EQGT () => KN (x, "=>")
| PE_GT () => KN (x, ">")
| PE_GTDOT () => KN (x, ">.")
| PE_GTLT () => KN (x, "><")
| PE_SRPTHEN () => KN (x, "#then")
| PE_SRPENDIF () => KN (x, "#endif")
//
| PE_LPAREN () => PN (x, "(")
| PE_RPAREN () => PN (x, ")")
| PE_LBRACKET () => PN (x, "[")
| PE_RBRACKET () => PN (x, "]")
| PE_LBRACE () => PN (x, "{")
| PE_RBRACE () => PN (x, "}")
//
| PE_EOF () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [EOF] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_i0nt () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [i0nt] is needed", @())
    val () = fprint_newline (out)
  }
| PE_c0har () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [c0har] is needed", @())
    val () = fprint_newline (out)
  }
| PE_f0loat () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [f0loat] is needed", @())
    val () = fprint_newline (out)
  }
| PE_s0tring () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0tring] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_i0de () => SN (x, "i0de")
| PE_i0dext () => SN (x, "i0dext")
//
| PE_i0de_dlr () => SN (x, "i0de_dlr")
//
| PE_l0ab () => SN (x, "l0ab")
| PE_p0rec () => SN (x, "p0rec")
//
| PE_funarrow () => SN (x, "funarrow")
| PE_colonwith () => SN (x, "colonwith")
//
| PE_e0xp () => SN (x, "e0xp")
| PE_atme0xp () => SN (x, "atme0xp")
//
| PE_s0rt () => SN (x, "s0rt")
| PE_s0rtid () => SN (x, "s0rtid")
| PE_atms0rt () => SN (x, "atms0rt")
| PE_s0marg () => SN (x, "s0marg")
| PE_a0msrt () => SN (x, "a0msrt")
//
| PE_s0exp () => SN (x, "s0exp")
| PE_si0de () => SN (x, "si0de")
| PE_s0taq () => SN (x, "s0taq")
| PE_atms0exp () => SN (x, "atms0exp")
| PE_labs0exp () => SN (x, "labs0exp")
| PE_s0rtext () => SN (x, "s0rtext")
| PE_s0qua () => SN (x, "s0qua")
| PE_q0marg () => SN (x, "q0marg")
//
| PE_p0at () => SN (x, "p0at")
| PE_pi0de () => SN (x, "pi0de")
| PE_atmp0at () => SN (x, "atmp0at")
| PE_labp0at () => SN (x, "labp0at")
| PE_p0at_as () => SN (x, "p0at_as")
//
| PE_i0fcl () => SN (x, "i0fcl")
//
| PE_gm0at () => SN (x, "gm0at")
| PE_guap0at () => SN (x, "guap0at")
| PE_c0lau () => SN (x, "c0lau")
| PE_sc0lau () => SN (x, "sc0lau")
//
| PE_di0de () => SN (x, "di0de")
| PE_d0ynq () => SN (x, "d0ynq")
| PE_dqi0de () => SN (x, "dqi0de")
//
| PE_arrqi0de () => SN (x, "arrqi0de")
| PE_tmpqi0de () => SN (x, "tmpqi0de")
| PE_impqi0de () => SN (x, "impqi0de")
//
| PE_d0exp () => SN (x, "d0exp")
| PE_d0exp0 () => SN (x, "d0exp0")
| PE_d0exp1 () => SN (x, "d0exp1")
| PE_atmd0exp () => SN (x, "atmd0exp")
| PE_labd0exp () => SN (x, "labd0exp")
//
| PE_d0ecl () => SN (x, "d0ecl")
| PE_stai0de () => SN (x, "stai0de")
| PE_d0ecl_sta () => SN (x, "d0ecl_sta")
| PE_d0ecl_dyn () => SN (x, "d0ecl_dyn")
| PE_guad0ecl () => SN (x, "guad0ecl")
| PE_staloadarg () => SN (x, "staloadarg")
//
| PE_fname_unclosed () => fname_unclosed (out, x)
//
| PE_DISCARD () => token_discarded (out, x)
(*
| PE_FILENONE (fname) => file_unavailable (out, x)
*)
//
(*
| _ => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): unspecified", @())
    val () = fprint_newline (out)
  } (* end of [_] *)
*)
//
end // end of [fprint_parerr]

(* ****** ****** *)

implement
fprint_the_parerrlst
  (out) = let
//
var nerr: int?
val xs = the_parerrlst_get (nerr)
//
fun loop
(
  out: FILEref
, xs: parerrlst_vt
, nerr: int
, bchar_max: lint // local max
, bchar_lst: lint // last char count
) : int = let
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val loc = x.parerr_loc
      val bchar = $LOC.location_get_bchar (loc)
    in
      case+ 0 of
      | _ when
          bchar > bchar_max => let
          val () = fprint_parerr (out, x) in
          loop (out, xs, nerr-1, bchar, bchar)
        end
      | _ when
          bchar <= bchar_lst => let
          val () = fprint_parerr (out, x) in
          loop (out, xs, nerr-1, bchar_max, bchar)
        end
      | _ => loop (out, xs, nerr-1, bchar_max, bchar_lst)
    end // end of [list_vt_cons]
  | ~list_vt_nil ((*void*)) => nerr
end // end of [loop]
//
in
//
case+ xs of
| list_vt_cons _ => let
    prval () = fold@ (xs)
    val nerr = loop (out, xs, nerr, ~1l, ~1l)
    val () =
    if nerr > 0 then {
      val () = fprint_string
        (out, "There are possibly some additional errors.")
      val () = fprint_newline (out)
    } // end of [if]
  in
    1 (* containing errors *)
  end // end of [list_vt_cons]
| ~list_vt_nil () => 0 (* free of errors *)
//
end // end of [fprint_the_parerrlst]

(* ****** ****** *)

(* end of [pats_parsing_error.dats] *)
