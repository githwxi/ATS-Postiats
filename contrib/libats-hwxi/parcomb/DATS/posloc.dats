(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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
// Authoremail: hwxiATcsDOTbuDOTedu
// Start Time: December 2008
//
(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-10
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/posloc.sats"

(* ****** ****** *)

local

typedef
filename = @{ fname= string }

assume filename_type = filename

in (* in of [local] *)

implement
fprint_filename (out, fil) = fprint_string (out, fil.fname)

implement print_filename (fil) = fprint_filename (stdout_ref, fil)
implement prerr_filename (fil) = fprint_filename (stderr_ref, fil)

(* ****** ****** *)

implement
filename_make_string (name) = @{ fname= name }

implement filename_none = @{ fname= "" }
implement filename_stdin = @{ fname= "<STDIN>" }

end // end of [local]

(* ****** ****** *)

local

vtypedef
filenamelst_vt = List0_vt (filename)

val the_filenamelst = ref_make_elt<filenamelst_vt> (list_vt_nil)

in (* in of [local] *)

implement
filename_pop () = let
  val (vbox pf | p_xs) = ref_get_viewptr (the_filenamelst)
  val-~list_vt_cons (x, xs) = !p_xs
in
  !p_xs := (xs: filenamelst_vt)
end (* end of [filename_pop] *)

implement
filename_push (x) = let
  val (vbox pf | p_xs) = ref_get_viewptr (the_filenamelst)
in
  !p_xs := list_vt_cons{filename}(x, !p_xs)
end // end of [filename_push]

implement
filename_get_current () = let
  val (vbox pf | p_xs) = ref_get_viewptr (the_filenamelst)
in
//
case+ !p_xs of
| list_vt_cons (x, _) => (x) | list_vt_nil () => filename_none
//
end // end of [filename_get_current]

end // end of [local]

(* ****** ****** *)

typedef
position = '{ line= int, loff= int, toff= lint }

assume position_type = position

implement
position_origin = '{ line = 0, loff= 0, toff= 0L }

implement
position_next
  (pos, c) =
(
  if (c = '\n') then '{
    line= pos.line + 1, loff= 0, toff= pos.toff + 1L
  } else '{
    line= pos.line, loff= pos.loff + 1, toff= pos.toff + 1L
  } // end of [if]
) // end of [position_next]

implement position_line (p) = p.line
implement position_loff (p) = p.loff
implement position_toff (p) = p.toff

implement
fprint_position (out, pos) = fprint!
  (out, pos.toff+1L, "(line=", pos.line+1, ", offs=", pos.loff+1, ")")
implement print_position (pos) = fprint_position (stdout_ref, pos)
implement prerr_position (pos) = fprint_position (stderr_ref, pos)

implement lt_position_position (p1, p2) = p1.toff < p2.toff
implement lte_position_position (p1, p2) = p1.toff <= p2.toff
implement eq_position_position (p1, p2) = p1.toff = p2.toff
implement neq_position_position (p1, p2) = p1.toff <> p2.toff

(* ****** ****** *)

typedef
location = '{
  fname= filename // file name
, begpos_line= int
, begpos_loff= int  // beginning char position in a line
, begpos_toff= lint // beginning char position
, endpos_line= int
, endpos_loff= int  // finishing char position in a line
, endpos_toff= lint // finishing char position
} (* end of [location] *)

assume location_type = location

(* ****** ****** *)

implement
location_none = '{
  fname= filename_none
, begpos_line= ~1
, begpos_loff= ~1
, begpos_toff= ~1L
, endpos_line= ~1
, endpos_loff= ~1
, endpos_toff= ~1L
} // end of [location_none]

(* ****** ****** *)

implement
location_make
  (begpos, endpos) = '{
  fname= filename_get_current ()
, begpos_line= position_line begpos
, begpos_loff= position_loff begpos
, begpos_toff= position_toff begpos
, endpos_line= position_line endpos
, endpos_loff= position_loff endpos
, endpos_toff= position_toff endpos
} // end of [location_make]

(* ****** ****** *)

fun
location_combine_main
(
  loc1: location, loc2: location
) : location = let
//
var begpos_line: int
var begpos_loff: int
and begpos_toff: lint
var endpos_line: int
var endpos_loff: int
and endpos_toff: lint
//
val () =
  if loc1.begpos_toff <= loc2.begpos_toff
    then (
      begpos_line := loc1.begpos_line;
      begpos_loff := loc1.begpos_loff; begpos_toff := loc1.begpos_toff;
    ) (* end of [then] *)
    else (
      begpos_line := loc2.begpos_line;
      begpos_loff := loc2.begpos_loff; begpos_toff := loc2.begpos_toff;
    ) (* end of [else] *)
  // end of [if]
//
val () =
  if loc1.endpos_toff >= loc2.endpos_toff
    then (
      endpos_line := loc1.endpos_line;
      endpos_loff := loc1.endpos_loff; endpos_toff := loc1.endpos_toff;
    ) (* end of [then] *)
    else (
      endpos_line := loc2.endpos_line;
      endpos_loff := loc2.endpos_loff; endpos_toff := loc2.endpos_toff;
    ) (* end of [else] *)
  // end of [if]
//
in '{
  fname= loc1.fname
, begpos_line= begpos_line
, begpos_loff= begpos_loff
, begpos_toff= begpos_toff
, endpos_line= endpos_line
, endpos_loff= endpos_loff
, endpos_toff= endpos_toff
} end // end of [location_combine_main]

(* ****** ****** *)

local

fn location_is_none
  (loc: location):<> bool = (loc.begpos_toff < 0L)

in (* in of [local] *)

implement
location_combine
  (loc1, loc2) = (
  case+ 0 of
  | _ when location_is_none loc1 => loc2
  | _ when location_is_none loc2 => loc1
  | _ => location_combine_main (loc1, loc2)
) // end of [location_combine]

end // end of [local]

(* ****** ****** *)

implement
fprint_location
  (out, loc) = (
  fprint_filename (out, loc.fname);
  fprint_string (out, ": ");
  fprint_lint (out, loc.begpos_toff+1L);
  fprint_string (out, "(line=");
  fprint_int (out, loc.begpos_line+1);
  fprint_string (out, ", offs=");
  fprint_int (out, loc.begpos_loff+1);
  fprint_string (out, ") -- ");
  fprint_lint (out, loc.endpos_toff+1L);
  fprint_string (out, "(line=");
  fprint_int (out, loc.endpos_line+1);
  fprint_string (out, ", offs=");
  fprint_int (out, loc.endpos_loff+1);
  fprint_string (out, ")");
) (* end of [fprint_location] *)

implement print_location (loc) = fprint_location (stdout_ref, loc)
implement prerr_location (loc) = fprint_location (stderr_ref, loc)

(* ****** ****** *)

(* end of [posloc.dats] *)
