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
//
staload _(*anon*) =
  "prelude/DATS/list.dats"
staload _(*anon*) =
  "prelude/DATS/list_vt.dats"
//
(* ****** ****** *)

staload "./pats_symbol.sats"
staload "./pats_location.sats"

(* ****** ****** *)

staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_taggen.sats"

(* ****** ****** *)

fun tagentlst_add
(
  res: &tagentlst_vt, ent: tagent
) : void = let
in
  res := list_vt_cons{tagent}(ent, res)
end // end of [tagentlst_add]

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
extern fun taggen_d0eclist : taggen_type (d0eclist)

(* ****** ****** *)

implement
taggen_d0ecl
  (d0c0, res) = let
//
val loc0 = d0c0.d0ecl_loc
//
in
//
case+ d0c0.d0ecl_node of
| _ =>
  (
    tagentlst_add (res, TAGENT (symbol_empty, loc0))
  ) (* end of [_] *)
//
end // end of [taggen_d0ecl]

(* ****** ****** *)

implement
taggen_d0eclist
  (d0cs, res) = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
    val () =
      taggen_d0ecl (d0c, res)
    // end of [val]
  in
    taggen_d0eclist (d0cs, res)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [taggen_d0eclist]

(* ****** ****** *)

implement
taggen_proc (d0cs) = let
//
var res: tagentlst_vt = list_vt_nil()
//
val ((*void*)) = taggen_d0eclist (d0cs, res)
//
in
  list_vt_reverse (res)
end // end of [taggen_proc]

(* ****** ****** *)

implement
fprint_entlst
  (out, given, xs) = let
//
fun fprint_name
(
  out: FILEref, sym: symbol
) : void =
{
  val () = fprint_char (out, '"')
  val () = fprint_symbol (out, sym)
  val () = fprint_char (out, '"')
}
//
fun fprint_ent
(
  out: FILEref, ent: tagent
) : void = let
//
  val loc = ent.tagent_loc
//
  val () = fprint_string (out, "{\n")
//
  val () = fprint (out, "name: ")
  val () = fprint_name (out, ent.tagent_sym)
  val () = fprint (out, ", nrow: ")
  val () = fprint_int (out, location_beg_nrow(loc))
  val () = fprint (out, ", nchar: ")
  val () = fprint_lint (out, location_beg_ntot(loc))
//
  val () = fprint_string (out, "\n}\n")
//
in
end // end of [fprint_ent]
//
fun auxlst
(
  out: FILEref
, i: int, xs: tagentlst_vt
) : void = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () =
    if i > 0 then
      fprint_string (out, ",\n")
    // end of [if]
    val () = fprint_ent (out, x)
  in
    auxlst (out, i+1, xs)
  end // end of [list_vt_cons]
| ~list_vt_nil ((*void*)) => ()
//
end // end of [auxlst]
//
val () = fprint_string (out, "{\n")
val () = fprint_string (out, "\"tagfile\": ")
val () = fprint_string (out, "\"")
val () = fprint_string (out, given)
val () = fprint_string (out, "\"")
val () = fprint_string (out, ",\n")
val () = fprint_string (out, "\"tagentarr\": [\n")
val () = auxlst (out, 0(*i*), xs)
val () = fprint_string (out, "]\n")
val () = fprint_string (out, "}\n")
//
in
  // nothing
end // end of [fprint_entlst]

(* ****** ****** *)

(* end of [pats_taggen.dats] *)
