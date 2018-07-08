(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)

implement
position_byrow(pos) =
{
//
val () = pos.pos_ntot := pos.pos_ntot + 1
val () = pos.pos_ncol := 0 (* beginning *)
val () = pos.pos_nrow := pos.pos_nrow + 1
//
} (* end of [position_byrow] *)

(* ****** ****** *)
//
implement
position_incby_1
  (pos) = pos.incby(1)
//
implement
position_incby_n
  (pos, n) = () where
{
//
val () = pos.pos_ntot := pos.pos_ntot + n
val () = pos.pos_ncol := pos.pos_ncol + n
//
} (* end of [position_incby_n] *)

(* ****** ****** *)

implement
position_decby_n(pos, n) =
{
//
val () = pos.pos_ntot := pos.pos_ntot - n
val () = pos.pos_ncol := pos.pos_ncol - n
//
} (* end of [position_decby_n] *)

(* ****** ****** *)

implement
position_incby_char
  (pos, c) = (
//
if
c >= 0
then
(
  if c = '\n'
    then position_byrow(pos)
    else position_incby_1(pos)
  // end of [if]
) (* then *)
else ((*void*))
//
) (* position_incby_char *)
  
(* ****** ****** *)

assume
location_type =
$rec{
  fil= fil_t
, beg_ntot= int // beginning char position
, beg_nrow= int
, beg_ncol= int
, end_ntot= int // finishing char position
, end_nrow= int
, end_ncol= int
} (* end of [location_type] *)

(* ****** ****** *)

implement
location_dummy =
'{
  fil= filename_dummy
, beg_ntot= ~1, beg_nrow= ~1
, beg_ncol= ~1, end_ntot= ~1
, end_nrow= ~1, end_ncol= ~1
} (* end of [location_dummy] *)

(* ****** ****** *)

implement
fprint_location
  (out, loc) = let
//
val fil = loc.fil
val ((*void*)) = fprint_filename(out, fil)
//
in
  fprint_string(out, ": "); fprint_locrange(out, loc)
end (* end of [fprint_location] *)

(* ****** ****** *)

implement
fprint_locrange
  (out, loc) = () where
{
//
val () =
fprint!
( out
, loc.beg_ntot+1
, "(line=", loc.beg_nrow+1, ", offs=", loc.beg_ncol+1, ")"
)
//
val () = fprint_string (out, " -- ")
//
val () =
fprint!
( out
, loc.end_ntot+1
, "(line=", loc.end_nrow+1, ", offs=", loc.end_ncol+1, ")"
)
//
} (* end of [fprint_locrange] *)

(* ****** ****** *)
//
implement
location_is_atlnbeg
  (loc) = (loc.beg_ncol = 0)
//  
(* ****** ****** *)

implement
location_make_pos_pos
  (pos1, pos2) = (
//
location_make_fil_pos_pos
  (the_filename_get(), pos1, pos2)
//
) (* end of [location_make_pos_pos] *)

(* ****** ****** *)

implement
location_make_fil_pos_pos
(
  fil, pos1, pos2
) = $rec{
//
  fil= fil
, beg_ntot= pos1.pos_ntot
, beg_nrow= pos1.pos_nrow
, beg_ncol= pos1.pos_ncol
, end_ntot= pos2.pos_ntot
, end_nrow= pos2.pos_nrow
, end_ncol= pos2.pos_ncol
//
} (* end of [location_make_fil_pos_pos] *)

(* ****** ****** *)

implement
location_leftmost
  (loc) = '{
  fil= loc.fil
, beg_ntot= loc.beg_ntot
, beg_nrow= loc.beg_nrow
, beg_ncol= loc.beg_ncol
, end_ntot= loc.beg_ntot
, end_nrow= loc.beg_nrow
, end_ncol= loc.beg_ncol
} // end of [location_leftmost]

implement
location_rightmost
  (loc) = '{
  fil= loc.fil
, beg_ntot= loc.end_ntot
, beg_nrow= loc.end_nrow
, beg_ncol= loc.end_ncol
, end_ntot= loc.end_ntot
, end_nrow= loc.end_nrow
, end_ncol= loc.end_ncol
} // end of [location_rightmost]

(* ****** ****** *)

local

fun
is_none
(
  loc: loc_t
) : bool = (loc.beg_ntot < 0)

fun
auxmain
(
  loc1: loc_t, loc2: loc_t
) : loc_t = let
//
  var beg_ntot: int
  var beg_nrow: int and beg_ncol: int
  var end_ntot: int
  var end_nrow: int and end_ncol: int
//
  val () =
  if loc1.beg_ntot <= loc2.beg_ntot
    then begin
      beg_ntot := loc1.beg_ntot;
      beg_nrow := loc1.beg_nrow; beg_ncol := loc1.beg_ncol
    end // end of [then]
    else begin
      beg_ntot := loc2.beg_ntot;
      beg_nrow := loc2.beg_nrow; beg_ncol := loc2.beg_ncol
    end // end of [else]
  // end of [if]
//
  val () =
  if loc1.end_ntot >= loc2.end_ntot
    then begin
      end_ntot := loc1.end_ntot; 
      end_nrow := loc1.end_nrow; end_ncol := loc1.end_ncol
    end // end of [then]
    else begin
      end_ntot := loc2.end_ntot; 
      end_nrow := loc2.end_nrow; end_ncol := loc2.end_ncol
    end // end of [else]
  // end of [if]
//
in
//
$rec{
  fil= loc1.fil
, beg_ntot= beg_ntot, beg_nrow= beg_nrow, beg_ncol= beg_ncol
, end_ntot= end_ntot, end_nrow= end_nrow, end_ncol= end_ncol
} (* $rec *)
//
end // end of [auxmain]

in (* in of [local] *)

implement
location_combine
  (loc1, loc2) =
(
  case+ 0 of
  | _ when
      is_none (loc1) => loc2
  | _ when
      is_none (loc2) => loc1
  | _ => auxmain (loc1, loc2)
) (* end of [location_combine] *)

end // end of [local]

(* ****** ****** *)

(* end of [atexting_posloc.dats] *)
