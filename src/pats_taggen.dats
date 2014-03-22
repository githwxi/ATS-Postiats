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
taggen_ftype
  (a: type) = (a, &tagentlst_vt) -> void
// end of [depgen_type]

(* ****** ****** *)

extern fun taggen_d0ecl : taggen_ftype (d0ecl)
extern fun taggen_d0eclist : taggen_ftype (d0eclist)

(* ****** ****** *)

extern
fun taggen_guad0ecl : taggen_ftype (guad0ecl)

(* ****** ****** *)
//
extern
fun taggen_s0expdeflst : taggen_ftype (s0expdeflst)
//
extern fun taggen_e0xndeclst : taggen_ftype (e0xndeclst)
extern fun taggen_d0atdeclst : taggen_ftype (d0atdeclst)
//
extern fun taggen_d0cstdeclst : taggen_ftype (d0cstdeclst)
//
extern fun taggen_m0acdeflst : taggen_ftype (m0acdeflst)
//
extern fun taggen_f0undeclst : taggen_ftype (f0undeclst)
extern fun taggen_v0aldeclst : taggen_ftype (v0aldeclst)
extern fun taggen_v0ardeclst : taggen_ftype (v0ardeclst)
//
(* ****** ****** *)

fun
tagentlst_add_symloc
(
  res: &tagentlst_vt
, sym: symbol, loc: location
) : void =
  tagentlst_add (res, TAGENT (sym, loc))
// end of [tagentlst_add_symloc]

(* ****** ****** *)

fun
tagentlst_add_i0de
(
  res: &tagentlst_vt, id: i0de
) : void = (
  tagentlst_add_symloc (res, id.i0de_sym, id.i0de_loc)
) (* end of [tagentlst_add_i0de] *)

(* ****** ****** *)

fun
tagentlst_add_i0delst
(
  res: &tagentlst_vt, ids: i0delst
) : void = (
case+ ids of
| list_cons
    (id, ids) => let
    val () =
      tagentlst_add_i0de (res, id)
    // end of [val]
  in
    tagentlst_add_i0delst (res, ids)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
) (* end of [tagentlst_add_i0delst] *)

(* ****** ****** *)

fun
tagentlst_add_p0at
(
  res: &tagentlst_vt, p0t0: p0at
) : void = let
//
val loc0 = p0t0.p0at_loc
//
in
//
case+
p0t0.p0at_node of
//
| P0Tide (sym) =>
    tagentlst_add_symloc (res, sym, loc0)
| P0Tdqid (d0q, sym) =>
    tagentlst_add_symloc (res, sym, loc0)
| P0Topid (sym) =>
    tagentlst_add_symloc (res, sym, loc0)
//
| P0Tann (p0t, _) => tagentlst_add_p0at (res, p0t)
//
| _ => ((*void*)) // HX-2013-11-17: ignored
//
end // end of [tagentlst_add_symloc]

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
//
| D0Cfixity _ => ()
| D0Cnonfix _ => ()
//
| D0Csymintr (ids) => tagentlst_add_i0delst (res, ids)
| D0Csymelim (ids) => tagentlst_add_i0delst (res, ids)
| D0Coverload (id, _, _) => tagentlst_add_i0de (res, id)
//
| D0Ce0xpdef (sym, _) =>
    tagentlst_add_symloc (res, sym, loc0)
| D0Ce0xpundef (sym) =>
    tagentlst_add_symloc (res, sym, loc0)
//
| D0Ctkindef (tkd) => let
    val sym = tkd.t0kindef_sym
    val loc = tkd.t0kindef_loc_id
  in
    tagentlst_add_symloc (res, sym, loc)
  end // end of [D0Ctkindef]
| D0Csexpdefs (_, sdfs) => taggen_s0expdeflst (sdfs, res)
| D0Csaspdec (sasp) => let
    val qid = sasp.s0aspdec_qid
  in
    tagentlst_add_symloc (res, qid.sqi0de_sym, qid.sqi0de_loc)
  end // end of [D0Csaspdec]
//
| D0Cexndecs
    (d0cs) => taggen_e0xndeclst (d0cs, res)
| D0Cdatdecs (_, d0cs, sdfs) =>
  {
    val () = taggen_d0atdeclst (d0cs, res)
    val () = taggen_s0expdeflst (sdfs, res)
  } (* end of [D0Cdatdecs] *)
//
| D0Cdcstdecs
    (_, _, _, d0cs) => taggen_d0cstdeclst (d0cs, res)
//
| D0Cimpdec (_, _, impdec) => let
    val qid = impdec.i0mpdec_qid
  in
    tagentlst_add_symloc (res, qid.impqi0de_sym, qid.impqi0de_loc)
  end // end of [D0Cimpdec]
//
| D0Cmacdefs (_, _, mds) => taggen_m0acdeflst (mds, res)
//
| D0Cfundecs (_, _, fds) => taggen_f0undeclst (fds, res)
| D0Cvaldecs (_, _, vds) => taggen_v0aldeclst (vds, res)
| D0Cvardecs (_(*knd*), vds) => taggen_v0ardeclst (vds, res)
//
| D0Cinclude _ => ()
//
| D0Cstaload (pfil, idopt, fname) => ()
| D0Cstaloadnm (pfil, idopt, nspace) => ()
//
| D0Cstaloadloc
    (pfil, idsym, d0cs) => taggen_d0eclist (d0cs, res)
//
| D0Cdynload _ => ()
//
| D0Clocal
    (d0cs_head, d0cs_body) =>
  {
    val () = taggen_d0eclist (d0cs_head, res)
    val () = taggen_d0eclist (d0cs_head, res)
  } (* end of [D0Clocal] *)
//
| D0Cguadecl (knd, gd0c) => taggen_guad0ecl (gd0c, res)
//
| _ (*rest*) => (
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

local

fun
taggen_guad0ecl_node
(
  gd0cn: guad0ecl_node, res: &tagentlst_vt
) : void = let
in
//
case+ gd0cn of
//
| GD0Cone (_, d0cs) =>
  {
    val () = taggen_d0eclist (d0cs, res)
  }
| GD0Ctwo (_, d0cs1, d0cs2) =>
  {
    val () = taggen_d0eclist (d0cs1, res)
    val () = taggen_d0eclist (d0cs2, res)
  }
| GD0Ccons (_, d0cs, knd, gd0cn) =>
  {
    val () = taggen_guad0ecl_node (gd0cn, res)
  }
//
end (* end of [taggen_guad0ecl_node] *)

in (* in of [local] *)

implement
taggen_guad0ecl (gd0c, res) =
  taggen_guad0ecl_node (gd0c.guad0ecl_node, res)
// end of [taggen_guad0ecl]

end // end of [local]

(* ****** ****** *)

implement
taggen_s0expdeflst
  (sdfs, res) = let
in
//
case+ sdfs of
| list_cons
    (sdf, sdfs) => let
    val sym = sdf.s0expdef_sym
    val loc = sdf.s0expdef_loc_id
    val () =
      tagentlst_add_symloc (res, sym, loc)
    // end of [val]
  in
    taggen_s0expdeflst (sdfs, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_s0expdeflst]

(* ****** ****** *)

implement
taggen_e0xndeclst
  (d0cs, res) = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
    val sym = d0c.e0xndec_sym
    val loc = d0c.e0xndec_loc
    val () =
      tagentlst_add_symloc (res, sym, loc)
    // end of [val]
  in
    taggen_e0xndeclst (d0cs, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_e0xndeclst]

(* ****** ****** *)

implement
taggen_d0atdeclst
  (d0cs, res) = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
    val sym = d0c.d0atdec_sym
    val loc = d0c.d0atdec_loc
    val () =
      tagentlst_add_symloc (res, sym, loc)
    // end of [val]
  in
    taggen_d0atdeclst (d0cs, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_d0atdeclst]

(* ****** ****** *)

implement
taggen_d0cstdeclst
  (d0cs, res) = let
in
//
case+ d0cs of
| list_cons
    (d0c, d0cs) => let
    val sym = d0c.d0cstdec_sym
    val loc = d0c.d0cstdec_loc
    val () =
      tagentlst_add_symloc (res, sym, loc)
    // end of [val]
  in
    taggen_d0cstdeclst (d0cs, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_d0cstdeclst]

(* ****** ****** *)

implement
taggen_m0acdeflst
  (mds, res) = let
in
//
case+ mds of
| list_cons
    (md, mds) => let
    val sym = md.m0acdef_sym
    val loc = md.m0acdef_loc
    val () = tagentlst_add_symloc (res, sym, loc)
  in
    taggen_m0acdeflst (mds, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_m0acdeflst]

(* ****** ****** *)

implement
taggen_f0undeclst
  (fds, res) = let
in
//
case+ fds of
| list_cons
    (fd, fds) => let
    val sym = fd.f0undec_sym
    val loc = fd.f0undec_sym_loc
    val () = tagentlst_add_symloc (res, sym, loc)
  in
    taggen_f0undeclst (fds, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_f0undeclst]

(* ****** ****** *)

implement
taggen_v0aldeclst
  (vds, res) = let
in
//
case+ vds of
| list_cons
    (vd, vds) => let
    val p0t = vd.v0aldec_pat
    val () = tagentlst_add_p0at (res, p0t)
  in
    taggen_v0aldeclst (vds, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_v0aldeclst]

(* ****** ****** *)

implement
taggen_v0ardeclst
  (vds, res) = let
in
//
case+ vds of
| list_cons
    (vd, vds) => let
    val sym = vd.v0ardec_sym
    val loc = vd.v0ardec_sym_loc
    val () = tagentlst_add_symloc (res, sym, loc)
  in
    taggen_v0ardeclst (vds, res)
  end // end of [list_cons]
| list_nil ((*void*)) => ()
//
end // end of [taggen_v0ardeclst]

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
  val () = fprint (out, "\"name\": ")
  val () = fprint_name (out, ent.tagent_sym)
  val () = fprint (out, ", \"nline\": ")
  val () = fprint_int (out, location_beg_nrow(loc)+1)
  val () = fprint (out, ", \"nchar\": ")
  val () = fprint_lint (out, location_beg_ntot(loc)+1L)
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
