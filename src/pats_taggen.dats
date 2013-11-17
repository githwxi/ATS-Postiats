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
// Start Time: July, 2013
//
(* ****** ****** *)

staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_taggen.sats"

(* ****** ****** *)

typedef
tagent = '{
  tagent_sym= symbol
, tagent_loc= location
} // end of [tagent]

(* ****** ****** *)
//
fun TAGENT
(
  sym: symbol, loc: location
) : tagent = '{
  tagent_sym= sym, tagent_loc= loc
} (* end of [TAGENT] *)
//
(* ****** ****** *)

assume tagent_type = tagent

(* ****** ****** *)

typedef
taggen_type
  (a: type) = (a, &tagentlst_vt) -> void
// end of [depgen_type]

(* ****** ****** *)

extern fun taggen_d0ecl : taggen_type (d0ecl)

(* ****** ****** *)

implement
taggen_d0ecl
  (d0c0, res) = let
in
end // end of [taggen_d0ecl]

(* ****** ****** *)

implement
taggen_proc (d0cs) = list_vt_nil(*void*)

(* ****** ****** *)

implement
fprint_entlst
  (out, given, xs) = let
  val-~list_vt_nil () = xs
in
  // nothing
end // end of [fprint_entlst]

(* ****** ****** *)

(* end of [pats_taggen.dats] *)
