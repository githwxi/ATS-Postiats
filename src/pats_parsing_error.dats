(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2011
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

staload LOC = "pats_location.sats"
typedef location = $LOC.location
overload fprint with $LOC.fprint_location

(* ****** ****** *)

implement
parerr_make (loc, node) = '{
  parerr_loc= loc, parerr_node= node
} // end of [parerr_make]

(* ****** ****** *)

viewtypedef
parerrlst_vt = List_vt (parerr)

(* ****** ****** *)
//
// HX-2011-03-12:
// [n] stores the total number of errors, some of
// which may not be recorded
//
extern
fun the_parerrlst_get (n: &int? >> int): parerrlst_vt

(* ****** ****** *)

local
//
// HX-2011-03-22:
// MAXLEN is the max number of errors to be reported
//
#define MAXLEN 100
#assert (MAXLEN > 0)
val the_length = ref<int> (0)
val the_parerrlst = ref<parerrlst_vt> (list_vt_nil)

in // in of [local]

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
} // end of [the_parerrlst_add]

implement
the_parerrlst_get
  (n) = xs where {
  val () = n := !the_length
  val () = !the_length := 0
  val (vbox pf | p) = ref_get_view_ptr (the_parerrlst)
  val xs = !p
  val xs = list_vt_reverse (xs)
  val () = !p := list_vt_nil ()
} // end of [the_parerrlst_get]

end // end of [local]

(* ****** ****** *)

implement
the_parerrlst_add_ifnbt
  (bt, loc, node) =
  if (bt = 0) then
    the_parerrlst_add (parerr_make (loc, node))
  else () // end of [if]
// end of [the_parerrlst_add_if0]

(* ****** ****** *)

implement
fprint_parerr
  (out, x) = let
  val loc = x.parerr_loc
in
//
case+ x.parerr_node of
| PE_BAR () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [BAR] is needed", @())
    val () = fprint_newline (out)
  }
| PE_COMMA () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [COMMA] is needed", @())
    val () = fprint_newline (out)
  }
| PE_SEMICOLON () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [SEMICOLON] is needed", @())
    val () = fprint_newline (out)
  }
| PE_RPAREN () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [RPAREN] is needed", @())
    val () = fprint_newline (out)
  }
| PE_RBRACE () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [RBRACE] is needed", @())
    val () = fprint_newline (out)
  }
| PE_EQ () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [EQ] is needed", @())
    val () = fprint_newline (out)
  }
| PE_EQGT () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [EQGT] is needed", @())
    val () = fprint_newline (out)
  }
| PE_EOF () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [EOF] is needed", @())
    val () = fprint_newline (out)
  }
| PE_i0nt () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [i0nt] is needed", @())
    val () = fprint_newline (out)
  }
| PE_s0tring () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0tring] is needed", @())
    val () = fprint_newline (out)
  }
| PE_i0de () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [i0de] is needed", @())
    val () = fprint_newline (out)
  }
| PE_i0de_dlr () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [i0de_dlr] is needed", @())
    val () = fprint_newline (out)
  }
| PE_l0ab () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [l0ab] is needed", @())
    val () = fprint_newline (out)
  }
| PE_p0rec () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [p0rec] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_e0xp () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [e0xp] is needed", @())
    val () = fprint_newline (out)
  }
| PE_atme0xp () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [atme0xp] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_s0rtid () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0rtid] is needed", @())
    val () = fprint_newline (out)
  }
| PE_s0rt () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0rt] is needed", @())
    val () = fprint_newline (out)
  }
| PE_atms0rt () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [atms0rt] is needed", @())
    val () = fprint_newline (out)
  }
| PE_s0marg () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0marg] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_si0de () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [si0de] is needed", @())
    val () = fprint_newline (out)
  }
| PE_s0exp () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [s0exp] is needed", @())
    val () = fprint_newline (out)
  }
| PE_atms0exp () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [atms0exp] is needed", @())
    val () = fprint_newline (out)
  }
| PE_labs0exp () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [labs0exp] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_di0de () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [di0de] is needed", @())
    val () = fprint_newline (out)
  }
//
| PE_d0ecl () => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): [d0ecl] is needed", @())
    val () = fprint_newline (out)
  }
(*
| _ => {
    val () = fprint (out, loc)
    val () = fprintf (out, ": error(parsing): unspecified", @())
    val () = fprint_newline (out)
  }
*)
//
end // end of [fprint_parerr]

(* ****** ****** *)

implement
fprint_the_parerrlst
  (out) = let
  var n: int?
  val xs = the_parerrlst_get (n)
  fun loop (
    out: FILEref, xs: parerrlst_vt, n: int
  ) : int =
    case+ xs of
    | ~list_vt_cons (x, xs) => (
        fprint_parerr (out, x); loop (out, xs, n-1)
      ) // end of [list_vt_cons]
    | ~list_vt_nil () => n
  // end of [loop]
in
  case+ xs of
  | list_vt_cons _ => let
      prval () = fold@ (xs)
      val n = loop (out, xs, n)
      val () = if n > 0 then {
        val () = fprint_string
          (out, "There are possibly some additional errors.")
        val () = fprint_newline (out)
      } // end of [if]
    in
      // nothing
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
end // end of [fprint_the_parerrlst]

(* ****** ****** *)

(* end of [pats_parsing_error.dats] *)
