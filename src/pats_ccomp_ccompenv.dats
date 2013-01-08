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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload FIL = "./pats_filename.sats"

(* ****** ****** *)
//
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
//
(* ****** ****** *)
//
staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"
//
(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

viewtypedef funlablst_vt = List_vt (funlab)

val the_funlablst = ref_make_elt<funlablst_vt> (list_vt_nil ())

in // in of [local]

implement
the_funlablst_add (fl) = let
  val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
in
  !p := list_vt_cons (fl, !p)
end // end of [the_funlablst_add]

implement
the_funlablst_get () = let
  val xs = xs where {
    val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
    val xs = !p
    val () = !p := list_vt_nil ()
  } // end of [val]
  val xs = list_vt_reverse (xs)
in
  list_of_list_vt (xs)
end // end of [the_funlablst_get]

end // end of [local]

implement
the_funlablst_addlst
  (fls) = list_app_fun (fls, the_funlablst_add)
// end of [the_funlablst_addlst]

(* ****** ****** *)

dataviewtype
markenvlst_vt =
  | MARKENVLSTnil of ()
  | MARKENVLSTmark of (markenvlst_vt)
  | MARKENVLSTcons_var of (d2var, markenvlst_vt)
  | MARKENVLSTcons_fundec of (hifundec, markenvlst_vt)
  | MARKENVLSTcons_impdec of (hiimpdec, markenvlst_vt)
  | MARKENVLSTcons_staload of (filenv, markenvlst_vt)
  | MARKENVLSTcons_tmpsub of (tmpsub, markenvlst_vt)
  | MARKENVLSTcons_impdec2 of (hiimpdec2, markenvlst_vt)
  | MARKENVLSTcons_tmpcstmat of (tmpcstmat, markenvlst_vt) 
// end of [markenvlst]

(* ****** ****** *)
//
extern
fun markenvlst_vt_free (xs: markenvlst_vt): void
//
implement
markenvlst_vt_free (xs) = let
in
  case+ xs of
  | ~MARKENVLSTnil () => ()
  | ~MARKENVLSTmark (xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_var (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_fundec (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_impdec (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_staload (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpsub (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_impdec2 (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpcstmat (_, xs) => markenvlst_vt_free (xs)
end // end of [markenvlst_vt_free]

(* ****** ****** *)
//
extern
fun fprint_markenvlst
  (out: FILEref, xs: !markenvlst_vt): void
//
implement
fprint_markenvlst (out, xs) = let
//
fun loop (
  out: FILEref, xs: !markenvlst_vt, i: int
) : void = let
in
//
case+ xs of
| MARKENVLSTnil () => fold@ (xs)
| MARKENVLSTmark (!p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_string (out, "||")
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTmark]
| MARKENVLSTcons_var
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_d2var (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_var]
//
| MARKENVLSTcons_fundec
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val hfd = !p_x
    val () = fprint_d2var (out, hfd.hifundec_var)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val imp = !p_x
    val () = fprint_d2cst (out, imp.hiimpdec_cst)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec]
//
| MARKENVLSTcons_staload
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val fname = filenv_get_name (!p_x)
    val () = $FIL.fprint_filename (out, fname)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_staload]
//
| MARKENVLSTcons_tmpsub
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_tmpsub (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_impdec2
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_hiimpdec2 (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_tmpcstmat
    (!p_x, !p_xs) => let
    val () =
      if i > 0 then
        fprint_string (out, ", ")
      // end of [if]
    val () = fprint_tmpcstmat (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpcstmat]
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_markenvlst]

(* ****** ****** *)

viewtypedef
ccompenv_struct = @{
  ccompenv_tmplevel = int
, ccompenv_tmprecdepth = int
, ccompenv_markenvlst = markenvlst_vt
, ccompenv_varbindmap= d2varmap_vt (primval)
} // end of [ccompenv_struct]

(* ****** ****** *)

extern
fun ccompenv_struct_uninitize
  (x: &ccompenv_struct >> ccompenv_struct?): void
// end of [ccompenv_struct_uninitize]

implement
ccompenv_struct_uninitize (x) = let
  val () =
    markenvlst_vt_free (x.ccompenv_markenvlst)
  // end of [val]
  val () = d2varmap_vt_free (x.ccompenv_varbindmap)
in
  // end of [ccompenv_struct_uninitize]
end // end of [ccompenv_struct_uninitize]

(* ****** ****** *)

dataviewtype
ccompenv = CCOMPENV of ccompenv_struct

(* ****** ****** *)

assume ccompenv_vtype = ccompenv

(* ****** ****** *)

implement
ccompenv_make
  () = env where {
  val env = CCOMPENV (?)
  val CCOMPENV (!p) = env
//
  val () = p->ccompenv_tmplevel := 0
  val () = p->ccompenv_tmprecdepth := 0
  val () = p->ccompenv_markenvlst := MARKENVLSTnil ()
  val () = p->ccompenv_varbindmap := d2varmap_vt_nil ()
//
  val () = fold@ (env)
} // end of [ccompenv_make]

(* ****** ****** *)

implement
ccompenv_free (env) = let
in
//
case+ env of
| CCOMPENV (!p_env) => let
    val () = ccompenv_struct_uninitize (!p_env)
  in
    free@ (env)
  end // end of [CCOMPENV]
//
end // end of [ccompenv_free]

(* ****** ****** *)

implement
fprint_ccompenv
  (out, env) = let
in
//
case+ env of
| CCOMPENV (!p_env) => let
    val () = fprint_string (out, "ccompenv_markenvlst: ")
    val () = fprint_markenvlst (out, p_env->ccompenv_markenvlst)
    val () = fprint_newline (out)
  in
    fold@ (env)
  end // end of [CCOMPENV]
//
end // end of [fprint_ccompenv]

(* ****** ****** *)

implement
ccompenv_get_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val level = p->ccompenv_tmplevel
  prval () = fold@ (env)
in
  level
end // end of [ccompenv_get_tmplevel]

implement
ccompenv_inc_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmplevel := p->ccompenv_tmplevel + 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_tmplevel]

implement
ccompenv_dec_tmplevel
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmplevel := p->ccompenv_tmplevel - 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_tmplevel]

(* ****** ****** *)

implement
ccompenv_get_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val depth = p->ccompenv_tmprecdepth
  prval () = fold@ (env)
in
  depth
end // end of [ccompenv_get_tmprecdepth]

implement
ccompenv_inc_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmprecdepth := p->ccompenv_tmprecdepth + 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_tmprecdepth]

implement
ccompenv_dec_tmprecdepth
  (env) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_tmprecdepth := p->ccompenv_tmprecdepth - 1)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_tmprecdepth]

(* ****** ****** *)

local

assume ccompenv_push_v = unit_v

fun auxpop (
  map: &d2varmap_vt (primval), xs: markenvlst_vt
) : markenvlst_vt = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in xs
  end // end of [MENVLSTnil]
| ~MARKENVLSTmark (xs) => xs
| ~MARKENVLSTcons_var (d2v, xs) => let
    val _(*removed*) = d2varmap_vt_remove (map, d2v)
  in
    auxpop (map, xs)
  end // end of [MENVLSTcons]
| ~MARKENVLSTcons_fundec (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_impdec (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_staload (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpsub (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_impdec2 (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpcstmat (_, xs) => auxpop (map, xs)
//
end // end of [auxpop]

fun auxjoin (
  map: &d2varmap_vt (primval), xs: &markenvlst_vt
) : void = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTnil]
| ~MARKENVLSTmark (xs1) => let
    val () = xs := auxpop (map, xs1) in (*nothing*)
  end // end of [MARKENVLSTmark]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_var]
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_fundec]
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec]
| MARKENVLSTcons_staload (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_staload]
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpsub]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec2]
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpcstmat]
//
end // end of [auxjoin]

in // in of [local]

implement
ccompenv_push (env) = let
//
  val CCOMPENV (!p) = env
//
  val () = p->ccompenv_markenvlst := MARKENVLSTmark (p->ccompenv_markenvlst)
//
  prval () = fold@ (env)
//
in
  (unit_v | ())
end // end of [ccompenv_push]

implement
ccompenv_pop
  (pfpush | env) = let
//
  prval unit_v () = pfpush
//
  val CCOMPENV (!p) = env
//
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := auxpop (p->ccompenv_varbindmap, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_pop]

implement
ccompenv_localjoin
  (pfpush, pfpush2 | env) = let
//
  prval unit_v () = pfpush
  prval unit_v () = pfpush2
//
  val CCOMPENV (!p) = env
//
  val () = auxjoin (p->ccompenv_varbindmap, p->ccompenv_markenvlst)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_localjoin]

end // end of [local]

(* ****** ****** *)

implement
ccompenv_add_varbind
  (env, d2v, pmv) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_var (d2v, xs)
  val _(*inserted*) = d2varmap_vt_insert (p->ccompenv_varbindmap, d2v, pmv)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_varbind]

implement
ccompenv_find_varbind
  (env, d2v) = opt where {
//
  val CCOMPENV (!p) = env
  val opt = d2varmap_vt_search (p->ccompenv_varbindmap, d2v)
  prval () = fold@ (env)
} // end of [ccompenv_add_varbind]

(* ****** ****** *)

implement
ccompenv_add_fundec
  (env, hfd) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_fundec (hfd, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_fundec]

(* ****** ****** *)

implement
ccompenv_add_impdec
  (env, imp) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_impdec (imp, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec]

(* ****** ****** *)

implement
ccompenv_add_staload
  (env, fenv) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_staload (fenv, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_staload]

(* ****** ****** *)

implement
ccompenv_add_tmpsub
  (env, tsub) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpsub (tsub, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpsub]

extern
fun ccompenv_find_tmpsub
  (env: !ccompenv): tmpsubopt_vt
implement
ccompenv_find_tmpsub (env) = let
//
fun loop (
  xs: !markenvlst_vt
) : tmpsubopt_vt = let
in
//
case+ xs of
//
| MARKENVLSTcons_tmpsub
    (tsub, !p_xs) => let
    prval () = fold@ (xs) in Some_vt (tsub)
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_var]
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_fundec]
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_staload (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_staload]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec2]
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_tmpcstmat]
//
| MARKENVLSTmark (!p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_mark]
//
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in None_vt ()
  end // end of [MARKENVLSTnil]
//
end // end of [loop]
//
val CCOMPENV (!p) = env
val res = loop (p->ccompenv_markenvlst)
prval () = fold@ (env)
in
  res
end // end of [ccompenv_find_tmpsub]

(* ****** ****** *)

extern
fun ccompenv_add_impdec2 (env: !ccompenv, imp2: hiimpdec2): void
implement
ccompenv_add_impdec2
  (env, imp2) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_impdec2 (imp2, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_impdec2]

implement
ccompenv_add_impdecloc
  (env, imp) = let
  val- ~Some_vt (tsub) = ccompenv_find_tmpsub (env)
  val sub = tmpsub2stasub (tsub)
  val tmparg = s2explstlst_subst (sub, imp.hiimpdec_tmparg)
  val () = stasub_free (sub)
  val imp2 = HIIMPDEC2 (imp, tsub, tmparg)
in
  ccompenv_add_impdec2 (env, imp2)
end // end of [ccompenv_add_impdecloc]

(* ****** ****** *)

implement
ccompenv_add_tmpcstmat
  (env, tmpmat) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpcstmat (tmpmat, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpcstmat]

(* ****** ****** *)

implement
ccompenv_tmpcst_match
  (env, d2c0, t2mas) = let
//
fun auxlst (
  xs: !markenvlst_vt
, d2c0: d2cst
, t2mas: t2mpmarglst
) : tmpcstmat = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in TMPCSTMATnone ()
  end // end of [MARKENVLSTnil]
//
| MARKENVLSTmark
    (!p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    opt
  end // end of [MARKENVLSTmark]
//
| MARKENVLSTcons_var
    (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    opt
  end // end of [MARKENVLSTcons_var]
//
| MARKENVLSTcons_fundec
    (fdc, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    opt
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec
    (imp, !p_xs) => let
    val opt =
      hiimpdec_tmpcst_match (imp, d2c0, t2mas)
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_impdec]
//
| MARKENVLSTcons_staload
    (fenv, !p_xs) => let
    val- Some (map) =
      filenv_get_tmpcstdecmapopt (fenv)
    // end of [val]
    val imps = tmpcstdecmap_find (map, d2c0)
    val opt = hiimpdeclst_tmpcst_match (imps, d2c0, t2mas)
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_tmpsub
    (tsub, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    opt
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_impdec2
    (imp2, !p_xs) => let
    val opt =
      hiimpdec2_tmpcst_match (imp2, d2c0, t2mas)
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_impdec]
//
| MARKENVLSTcons_tmpcstmat
    (tmpmat, !p_xs) => let
    val opt =
      tmpcstmat_tmpcst_match (tmpmat, d2c0, t2mas)
    // end of [val]
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_tmpcstmat]
//
end // end of [auxlst]
//
and auxcont (
  opt: tmpcstmat
, xs: !markenvlst_vt
, d2c0: d2cst
, t2mas: t2mpmarglst
) : tmpcstmat = let
in
//
case+ opt of
| TMPCSTMATsome _ => opt
| TMPCSTMATsome2 _ => opt
| TMPCSTMATnone _ => auxlst (xs, d2c0, t2mas)
//
end // end of [auxcont]
//
val CCOMPENV (!p) = env
val opt = auxlst (p->ccompenv_markenvlst, d2c0, t2mas)
prval () = fold@ (env)
//
in
  opt
end // end of [ccompenv_tmpcst_match]

(* ****** ****** *)

(* end of [pats_ccomp_ccompenv.dats] *)
