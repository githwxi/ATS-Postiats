(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
// Start Time: July, 2012
//
(* ****** ****** *)

staload
STAMP = "pats_stamp.sats"
typedef stamp = $STAMP.stamp

(* ****** ****** *)

staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_histaexp.sats"

(* ****** ****** *)

typedef
funlab_struct = @{
  funlab_name= string
, funlab_level= int
, funlab_type= hitype (* function type *)
, funlab_qopt= d2cstopt (* local or global *)
, funlab_stamp= stamp
} // end of [funlab_struct]

(* ****** ****** *)

local

assume funlab_type = ref (funlab_struct)

in // in of [local]

implement
funlab_get_name (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (fl) in p->funlab_name
end // end of [funlab_get_name]

implement
funlab_get_level (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (fl) in p->funlab_level
end // end of [funlab_get_level]

implement
funlab_get_type (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (fl) in p->funlab_type
end // end of [funlab_get_type]

implement
funlab_get_stamp (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (fl) in p->funlab_stamp
end // end of [funlab_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
fprint_funlab
  (out, fl) = let
  val name = funlab_get_name (fl)
in
  fprint_string (out, name)
end // end of [fprint_funlab]

implement
print_funlab (fl) = fprint_funlab (stdout_ref, fl)
implement
prerr_funlab (fl) = fprint_funlab (stderr_ref, fl)

(* ****** ****** *)

(* end of [pats_histaexp_funlab.dats] *)
