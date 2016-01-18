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
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

staload "./pats_location.sats"

(* ****** ****** *)

assume
position_t0ype =
$extype_struct
"pats_position_struct" of
{
  ntot= lint, nrow= int, ncol= int
} // end of [position_t0ype]

(* ****** ****** *)
//
implement
print_position
  (pos) = fprint_position (stdout_ref, pos)
//
(* ****** ****** *)

implement
fprint_position
  (out, pos) = let
//
val ntot = pos.ntot
val nrow = pos.nrow
val ncol = pos.ncol
//
in
//
fprintf
(
  out, "%li(line=%i, offs=%i)", @(ntot+1L, nrow+1, ncol+1)
) (* end of [val] *)
//
end // end of [fprint_position]

(* ****** ****** *)

implement position_get_ntot (pos) = pos.ntot
implement position_get_nrow (pos) = pos.nrow
implement position_get_ncol (pos) = pos.ncol

(* ****** ****** *)

implement
position_init
(
  pos0, ntot, nrow, ncol
) = () where {
  val () = pos0.ntot := ntot
  val () = pos0.nrow := nrow
  val () = pos0.ncol := ncol
} (* end of [position_init] *)

implement
position_copy
(
  pos0, pos1
) = () where {
  val () = pos0.ntot := pos1.ntot
  val () = pos0.nrow := pos1.nrow
  val () = pos0.ncol := pos1.ncol  
} (* end of [position_copy] *)

(* ****** ****** *)

implement
position_incby_char
  (pos, i) =
if i >= 0 then let
//
  #define c2i int_of_char
//
  val () =
    pos.ntot := pos.ntot + 1L
  // end of [val]
  val () = if i = (c2i)'\n' then let
    val () = pos.nrow := pos.nrow + 1
    val () = pos.ncol := 0
  in
    // nothing
  end else let
    val () = pos.ncol := pos.ncol + 1
  in
    // nothing
  end // end of [if]
in
  // nothing
end // end of [position_incby_char]

(* ****** ****** *)

implement
position_decby_count
  (pos, n) = () where {
//
  #define u2i int_of_uint
  #define u2l lint_of_uint
//
  val () = pos.ntot := pos.ntot - (u2l)n
  val () = pos.ncol := pos.ncol - (u2i)n
} // end of [position_decby_count]

implement
position_incby_count
  (pos, n) = () where {
//
  #define u2i int_of_uint
  #define u2l lint_of_uint
//
  val () = pos.ntot := pos.ntot + (u2l)n
  val () = pos.ncol := pos.ncol + (u2i)n
} // end of [position_incby_count]

(* ****** ****** *)

assume
location_type =
'{
//
  filename=
  filename // file name
//
, beg_ntot= lint // beginning char position
, beg_nrow= int
, beg_ncol= int
, end_ntot= lint // finishing char position
, end_nrow= int
, end_ncol= int
//
, locpragma= locpragma
//
} (* end of [location_type] *)

(* ****** ****** *)

implement
location_get_bchar (loc) = loc.beg_ntot

(* ****** ****** *)

implement
location_beg_nrow (loc) = loc.beg_nrow

(* ****** ****** *)

implement
location_beg_ntot (loc) = loc.beg_ntot
implement
location_end_ntot (loc) = loc.end_ntot

(* ****** ****** *)

implement
location_get_filename(loc) = loc.filename

(* ****** ****** *)
//
implement
print_location
  (loc) = fprint_location(stdout_ref, loc)
//
implement
prerr_location
  (loc) = fprint_location(stderr_ref, loc)
//
(* ****** ****** *)

implement
fprint_locrange
  (out, loc) = () where {
//
val () =
  fprint_lint (out, loc.beg_ntot+1L)
val () = fprint_string (out, "(line=")
val () = fprint_int (out, loc.beg_nrow+1)
val () = fprint_string (out, ", offs=")
val () = fprint_int (out, loc.beg_ncol+1)
val () = fprint_string (out, ")")
//
val () = fprint_string (out, " -- ")
//
val () =
  fprint_lint (out, loc.end_ntot+1L)
val () = fprint_string (out, "(line=")
val () = fprint_int (out, loc.end_nrow+1)
val () = fprint_string (out, ", offs=")
val () = fprint_int (out, loc.end_ncol+1)
val () = fprint_string (out, ")")
//
} (* end of [fprint_locrange] *)

(* ****** ****** *)

implement
fprint_location
  (out, loc) = let
(*
val () = println! ("fprint_location")
*)
in
//
fprint_locpragma(out, loc.locpragma);
$FIL.fprint_filename_full (out, loc.filename);
fprint_string (out, ": "); fprint_locrange (out, loc)
//
end (* end of [fprint_location] *)

(* ****** ****** *)

implement
fprint2_location
  (out, loc) = let
(*
val () = println! ("fprint2_location")
*)
in
//
fprint_locpragma(out, loc.locpragma);
$FIL.fprint2_filename_full (out, loc.filename); 
fprint_string (out, ": "); fprint_locrange (out, loc)
//
end (* end of [fprint2_location] *)

(* ****** ****** *)

implement
location_dummy =
'{
  filename= $FIL.filename_dummy
, beg_ntot= ~1L
, beg_nrow= ~1
, beg_ncol= ~1
, end_ntot= ~1L
, end_nrow= ~1
, end_ncol= ~1
, locpragma= locpragma0_make()
} (* end of [location_dummy] *)

(* ****** ****** *)

implement
location_make_pos_pos
  (pos1, pos2) = let
  val fil = $FIL.filename_get_current ()
in
  location_make_fil_pos_pos (fil, pos1, pos2)
end // end of [location_make_pos_pos]

(* ****** ****** *)

implement
location_make_fil_pos_pos
  (fil, pos1, pos2) = '{
  filename= fil
, beg_ntot= pos1.ntot
, beg_nrow= pos1.nrow
, beg_ncol= pos1.ncol
, end_ntot= pos2.ntot
, end_nrow= pos2.nrow
, end_ncol= pos2.ncol
, locpragma= the_location_pragma_get()
} // end of [location_make_pos_pos]

(* ****** ****** *)

implement
location_leftmost
  (loc) = '{
  filename= loc.filename
, beg_ntot= loc.beg_ntot
, beg_nrow= loc.beg_nrow
, beg_ncol= loc.beg_ncol
, end_ntot= loc.beg_ntot
, end_nrow= loc.beg_nrow
, end_ncol= loc.beg_ncol
, locpragma= loc.locpragma
} // end of [location_leftmost]

implement
location_rightmost
  (loc) = '{
  filename= loc.filename
, beg_ntot= loc.end_ntot
, beg_nrow= loc.end_nrow
, beg_ncol= loc.end_ncol
, end_ntot= loc.end_ntot
, end_nrow= loc.end_nrow
, end_ncol= loc.end_ncol
, locpragma= loc.locpragma
} // end of [location_rightmost]

(* ****** ****** *)

local

fn
location_is_none
(
  loc: location
) :<> bool = (loc.beg_ntot < 0L)

fn
location_combine_main
(
  loc1: location, loc2: location
) :<> location = let
//
  var beg_ntot: lint
  var beg_nrow: int and beg_ncol: int
  var end_ntot: lint
  var end_nrow: int and end_ncol: int
//
  val () =
  if loc1.beg_ntot <= loc2.beg_ntot
    then begin
      beg_nrow := loc1.beg_nrow;
      beg_ncol := loc1.beg_ncol;
      beg_ntot := loc1.beg_ntot;
    end // end of [then]
    else begin
      beg_nrow := loc2.beg_nrow;
      beg_ncol := loc2.beg_ncol;
      beg_ntot := loc2.beg_ntot;
    end // end of [else]
  // end of [if] // end of [val]
//
  val () =
  if loc1.end_ntot >= loc2.end_ntot
    then begin
      end_nrow := loc1.end_nrow;
      end_ncol := loc1.end_ncol;
      end_ntot := loc1.end_ntot; 
    end // end of [then]
    else begin
      end_nrow := loc2.end_nrow;
      end_ncol := loc2.end_ncol;
      end_ntot := loc2.end_ntot; 
    end // end of [else]
  // end of [if] // end of [val]
//
in '{
  filename= loc1.filename
, beg_ntot= beg_ntot, beg_nrow= beg_nrow, beg_ncol= beg_ncol
, end_ntot= end_ntot, end_nrow= end_nrow, end_ncol= end_ncol
, locpragma= loc1.locpragma
} end // end of [location_combine_main]

in // in of [local]

implement
location_combine
  (loc1, loc2) = case+ 0 of
  | _ when location_is_none loc1 => loc2
  | _ when location_is_none loc2 => loc1
  | _ (*rest*) => location_combine_main (loc1, loc2)
// end of [location_combine]

end // end of [local]

(* ****** ****** *)

implement
fprint_line_pragma
  (out, loc) = let
//
val
line = loc.beg_nrow
//
val () =
if
line >= 0
then let
  val () = fprint_string (out, "#line ")
  val () = fprint_int (out, line+1) // counting from 1
  val () = fprint_string (out, " \"")
  val () = $FIL.fprint_filename_full (out, loc.filename)
  val () = fprint_string (out, "\"\n")
in
  // nothing
end // end of [then]
else let
(*
//
// HX-2010-11-02: this is another possibility:
//
  val () = fprint1_string (out, "#line 1 \"<built-in>\"\n")
*)
in
  // nothing
end // end of [else]
//
in
  // nothing
end // end of [fprint_line_pragma]

(* ****** ****** *)

local
//
datatype
locpragma =
  | LOCPRAGMA0 of ()
  | LOCPRAGMA1 of (string(*...*))
  | LOCPRAGMA2 of (string(*file*), string(*...*))
//
assume locpragma_type = locpragma
//
typedef locpragmalst = List0(locpragma)
//
val
the_locpragma = ref<locpragma>(LOCPRAGMA0())
val
the_locpragmalst = ref<locpragmalst>(list_nil())
//
in (* in-of-local *)
//
implement
locpragma0_make()= LOCPRAGMA0()
implement
locpragma1_make(x)= LOCPRAGMA1(x)
implement
locpragma2_make(x1, x2)= LOCPRAGMA2(x1, x2)
//
implement
the_location_pragma_get
  ((*void*)) = !the_locpragma
implement
the_location_pragma_set
  (x0) = !the_locpragma := x0
//
implement
the_location_pragma_pop
  ((*void*)) = () where
{
//
  val x0 = !the_locpragma
  val xs = !the_locpragmalst
  val-list_cons(x, xs) = xs
  val () = !the_locpragma := x
  val () = !the_locpragmalst := xs
//
} (* end of [the_location_pragma_pop] *)
//
implement
the_location_pragma_push
  ((*void*)) = () where
{
//
  val x0 = !the_locpragma
  val xs = !the_locpragmalst
  val () = !the_locpragma := LOCPRAGMA0()
  val () = !the_locpragmalst := list_cons(x0, xs)
//
} (* end of [the_location_pragma_push] *)

(* ****** ****** *)

implement
fprint_locpragma(out, x) =
(
//
case+ x of
| LOCPRAGMA0() => ()
| LOCPRAGMA1(loc) =>
  fprint! (out, "#locpragma(", loc, "): ")
| LOCPRAGMA2(fil, loc) =>
  fprint! (out, "#locpragma(", fil, ": ", loc, "): ")
//
) (* end of [fprint_locpragma] *)

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_location.dats] *)
