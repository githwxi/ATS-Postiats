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

staload UN = "prelude/SATS/unsafe.sats"

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
//
val the_dyncstset =
  ref_make_elt<d2cstset> (d2cstset_nil ())
val the_dyncstlst =
  ref_make_elt<d2cstlst_vt> (list_vt_nil ())
//
in (* in of [local] *)

implement
the_dyncstlst_add
  (d2c) = let
  val d2cs = !the_dyncstset
  val found = d2cstset_is_member (d2cs, d2c)
in
//
if ~(found) then let
  val () = let
    val (
      vbox pf | p
    ) = ref_get_view_ptr (the_dyncstlst)
  in
    !p := list_vt_cons (d2c, !p)
  end // end of [val]
in
  !the_dyncstset := d2cstset_add (d2cs, d2c)
end (* end of [if] *)
//
end // end of [the_dyncstlst_add]

implement
the_dyncstlst_get () = let
//
val d2cs = let
  val (
    vbox pf | p
  ) = ref_get_view_ptr (the_dyncstlst)
  val d2cs = !p
  val () = !p := list_vt_nil ()
in
  list_vt_reverse (d2cs)
end // end of [val]
//
in
  list_of_list_vt (d2cs)
end // end of [the_dyncstlst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef
saspdeclst_vt = List_vt (hidecl)

val the_saspdeclst =
  ref_make_elt<saspdeclst_vt> (list_vt_nil ())
// end of [val]

in (* in of [local] *)

implement
the_saspdeclst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_saspdeclst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_saspdeclst_add]

implement
the_saspdeclst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_saspdeclst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_saspdeclst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef
extcodelst_vt = List_vt (hidecl)

val the_extcodelst =
  ref_make_elt<extcodelst_vt> (list_vt_nil ())
// end of [val]

in (* in of [local] *)

implement
the_extcodelst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_extcodelst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_extcodelst_add]

implement
the_extcodelst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_extcodelst)
//
val xs = !p
val () = !p := list_vt_nil ()
//
var !p_cmp = @lam
(
  x1: &hidecl, x2: &hidecl
) : int =<clo>
  (pos1 - pos2) where
{
  val-HIDextcode (knd1, pos1, _) = x1.hidecl_node
  val-HIDextcode (knd2, pos2, _) = x2.hidecl_node
} (* end of [where] // end of [@lam] *)
//
val xs = list_vt_mergesort<hidecl> (xs, !p_cmp)
//
in
  list_of_list_vt (xs)
end // end of [the_extcodelst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef
staloadlst_vt = List_vt (hidecl)

val
the_staloadlst =
  ref_make_elt<staloadlst_vt> (list_vt_nil ())
// end of [val]

in (* in of [local] *)

implement
the_staloadlst_add (x) = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_staloadlst)
//
in
  !p := list_vt_cons (x, !p)
end // end of [the_staloadlst_add]

implement
the_staloadlst_get () = let
//
val (
  vbox pf | p
) = ref_get_view_ptr (the_staloadlst)
val xs = !p
val () = !p := list_vt_nil ()
val xs = list_vt_reverse<hidecl> (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_staloadlst_get]

end // end of [local]

(* ****** ****** *)

local

vtypedef funlablst_vt = List_vt (funlab)

val the_funlablst = ref_make_elt<funlablst_vt> (list_vt_nil ())

in (* in of [local] *)

implement
the_funlablst_add (fl) = let
//
val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
//
in
  !p := list_vt_cons (fl, !p)
end // end of [the_funlablst_add]

implement
the_funlablst_addlst
  (fls) = list_app_fun (fls, the_funlablst_add)
// end of [the_funlablst_addlst]

(* ****** ****** *)

implement
the_funlablst_get () = let
//
val xs = xs where {
  val (vbox pf | p) = ref_get_view_ptr (the_funlablst)
  val xs = !p
  val () = !p := list_vt_nil ()
} (* end of [val] *)
//
val xs = list_vt_reverse (xs)
//
in
  list_of_list_vt (xs)
end // end of [the_funlablst_get]

end // end of [local]

(* ****** ****** *)

datavtype
markenvlst_vt =
  | MARKENVLSTnil of ()
  | MARKENVLSTmark of (markenvlst_vt)
  | MARKENVLSTcons_var of (d2var, markenvlst_vt)
  | MARKENVLSTcons_fundec of (hifundec, markenvlst_vt)
  | MARKENVLSTcons_impdec of (hiimpdec, markenvlst_vt)
  | MARKENVLSTcons_impdec2 of (hiimpdec2, markenvlst_vt)
  | MARKENVLSTcons_staload of (filenv, markenvlst_vt)
  | MARKENVLSTcons_tmpsub of (tmpsub, markenvlst_vt)
  | MARKENVLSTcons_tmpcstmat of (tmpcstmat, markenvlst_vt) 
  | MARKENVLSTcons_tmpvarmat of (tmpvarmat, markenvlst_vt) 
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
  | ~MARKENVLSTcons_impdec2 (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_staload (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpsub (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpcstmat (_, xs) => markenvlst_vt_free (xs)
  | ~MARKENVLSTcons_tmpvarmat (_, xs) => markenvlst_vt_free (xs)
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
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_string (out, "||")
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTmark]
| MARKENVLSTcons_var
    (!p_x, !p_xs) => let
    val () =
    (
       if i > 0 then fprint_string (out, ", ")
    )
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
    (
      if i > 0 then fprint_string (out, ", ")
    )
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
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val imp = !p_x
    val () = fprint_d2cst (out, imp.hiimpdec_cst)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_impdec2
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_hiimpdec2 (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
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
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpsub (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpsub]
//
| MARKENVLSTcons_tmpcstmat
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpcstmat (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat
    (!p_x, !p_xs) => let
    val () =
    (
      if i > 0 then fprint_string (out, ", ")
    )
    val () = fprint_tmpvarmat (out, !p_x)
    val () = loop (out, !p_xs, i+1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [MARKENVLSTcons_tmpvarmat]
//
end // end of [loop]
//
in
  loop (out, xs, 0)
end // end of [fprint_markenvlst]

(* ****** ****** *)

datavtype
looptmplab3 =
LOOPTMPLAB3 of
(
  tmplab(*init*), tmplab(*fini*), tmplab(*cont*)
) // end of [looptmplab3]

vtypedef loopexnenv = List_vt (looptmplab3)

extern
fun loopexnenv_free (xs: loopexnenv): void

implement
loopexnenv_free (xs) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val+~LOOPTMPLAB3 (_, _, _) = x in loopexnenv_free (xs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loopexnenv_free]

(* ****** ****** *)

vtypedef flabsetenv = List_vt (funlabset)

extern
fun flabsetenv_free (xs: flabsetenv): void
implement
flabsetenv_free (xs) = list_vt_free (xs)

(* ****** ****** *)

vtypedef d2varsetenv = List_vt (d2varset)

extern
fun d2varsetenv_free (xs: d2varsetenv): void
implement
d2varsetenv_free (xs) = list_vt_free (xs)

(* ****** ****** *)
//
vtypedef vbindlstenv = List_vt (vbindlst_vt)
//
extern
fun vbindlstenv_free (xs: vbindlstenv): void
implement
vbindlstenv_free (vbss) = let
in
//
case+ vbss of
| ~list_vt_cons
    (vbs, vbss) =>
  (
    list_vt_free (vbs); vbindlstenv_free (vbss)
  )
| ~list_vt_nil () => ()
//
end // end of [vbindlstenv_free]
//
(* ****** ****** *)

viewtypedef
ccompenv_struct =
@{
  ccompenv_tmplevel= int
, ccompenv_tmprecdepth= int
, ccompenv_loopexnenv= loopexnenv
//
, ccompenv_flabsetenv= flabsetenv
, ccompenv_d2varsetenv= d2varsetenv
, ccompenv_vbindlstenv= vbindlstenv
//
, ccompenv_markenvlst= markenvlst_vt
, ccompenv_varbindmap= d2varmap_vt (primval)
} // end of [ccompenv_struct]

(* ****** ****** *)

extern
fun ccompenv_struct_uninitize
  (x: &ccompenv_struct >> ccompenv_struct?): void
// end of [ccompenv_struct_uninitize]

implement
ccompenv_struct_uninitize (x) = let
//
  val () =
    markenvlst_vt_free (x.ccompenv_markenvlst)
//
  val () = loopexnenv_free (x.ccompenv_loopexnenv)
//
  val () = flabsetenv_free (x.ccompenv_flabsetenv)
  val () = d2varsetenv_free (x.ccompenv_d2varsetenv)
  val () = vbindlstenv_free (x.ccompenv_vbindlstenv)
//
  val () = d2varmap_vt_free (x.ccompenv_varbindmap)
//
in
  // end of [ccompenv_struct_uninitize]
end // end of [ccompenv_struct_uninitize]

(* ****** ****** *)

datavtype
ccompenv_vt = CCOMPENV of ccompenv_struct

(* ****** ****** *)

assume ccompenv_vtype = ccompenv_vt

(* ****** ****** *)

implement
ccompenv_make
  () = env where
{
val env = CCOMPENV (?)
val CCOMPENV (!p) = env
//
val () = p->ccompenv_tmplevel := 0
val () = p->ccompenv_tmprecdepth := 0
val () = p->ccompenv_loopexnenv := list_vt_nil ()
//
val () = p->ccompenv_flabsetenv := list_vt_nil ()
val () = p->ccompenv_d2varsetenv := list_vt_nil ()
val () = p->ccompenv_vbindlstenv := list_vt_nil ()
//
val () = p->ccompenv_markenvlst := MARKENVLSTnil ()
val () = p->ccompenv_varbindmap := d2varmap_vt_nil ()
//
val () = fold@ (env)
//
val () = ccompenv_inc_flabsetenv (env) // toplevel flabs
val () = ccompenv_inc_d2varsetenv (env) // toplevel d2vars
//
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

implement
ccompenv_inc_loopexnenv
  (env, tl1, tl2, tl3) = let
  val tlll = LOOPTMPLAB3 (tl1, tl2, tl3)
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_loopexnenv := list_vt_cons (tlll, p->ccompenv_loopexnenv))
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_loopexnenv]

implement
ccompenv_dec_loopexnenv
  (env) = let
  val CCOMPENV (!p) = env
  val-~list_vt_cons (x, xs) = p->ccompenv_loopexnenv
  val+~LOOPTMPLAB3 (_, _, _) = x
  val () = (p->ccompenv_loopexnenv := xs)
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_dec_loopexnenv]

implement
ccompenv_get_loopfini
  (env) = let
  val CCOMPENV (!p) = env
  val-list_vt_cons (!px, _) = p->ccompenv_loopexnenv
  val+LOOPTMPLAB3 (_, tl_fini, _) = !px
  prval () = fold@ (!px)
  prval () = fold@ (p->ccompenv_loopexnenv)
  prval () = fold@ (env)
in
  tl_fini
end // end of [ccompenv_get_loopfini]

implement
ccompenv_get_loopcont
  (env) = let
  val CCOMPENV (!p) = env
  val-list_vt_cons (!px, _) = p->ccompenv_loopexnenv
  val+LOOPTMPLAB3 (_, _, tl_cont) = !px
  prval () = fold@ (!px)
  prval () = fold@ (p->ccompenv_loopexnenv)
  prval () = fold@ (env)
in
  tl_cont
end // end of [ccompenv_get_loopcont]

(* ****** ****** *)

implement
ccompenv_inc_flabsetenv (env) =
(
  ccompenv_incwth_flabsetenv (env, funlabset_nil ())
) // end of [ccompenv_inc_flabsetenv]

implement
ccompenv_incwth_flabsetenv
  (env, fls) = let
  val CCOMPENV (!p) = env
  val () = (p->ccompenv_flabsetenv := list_vt_cons (fls, p->ccompenv_flabsetenv))
  prval () = fold@ (env)
in
  // nothing
end // end of [ccompenv_inc_flabsetenv]

implement
ccompenv_getdec_flabsetenv
  (env) = (fls) where
{
//
val CCOMPENV (!p) = env
val-~list_vt_cons (fls, flss) = p->ccompenv_flabsetenv
val () = p->ccompenv_flabsetenv := flss
prval () = fold@ (env)
//
} // end of [ccompenv_getdec_flabsetenv]

implement
ccompenv_add_flabsetenv
  (env, fl) = ((*void*)) where
{
//
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_fls, _) = p->ccompenv_flabsetenv
val () = !p_fls := funlabset_add (!p_fls, fl)
prval () = fold@ (p->ccompenv_flabsetenv)
prval () = fold@ (env)
//
} // end of [ccompenv_add_flabsetenv]

implement
ccompenv_addset_flabsetenv
  (env, lev0, flset) = let
//
fun addlst_if
(
  env: !ccompenv, lev0: int, fls: List_vt (funlab)
) : void = let
in
//
case+ fls of
| ~list_vt_cons
    (fl, fls) => let
    val lev = funlab_get_level (fl)
    val () = 
    ( // HX: no need for handling siblings (=lev0)
      if lev < lev0 then ccompenv_add_flabsetenv (env, fl)
    ) : void // end of [val]
  in
    addlst_if (env, lev0, fls)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [addlst_if]
//
in
//
addlst_if (env, lev0, funlabset_listize (flset))
//
end // end of [ccompenv_addset_flabsetenv]

(* ****** ****** *)

implement
ccompenv_inc_d2varsetenv
  (env) = let
//
val d2vs = d2varset_nil ()
val CCOMPENV (!p) = env
val d2vss = p->ccompenv_d2varsetenv
val () = (p->ccompenv_d2varsetenv := list_vt_cons (d2vs, d2vss))
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_inc_d2varsetenv]

implement
ccompenv_getdec_d2varsetenv
  (env) = (d2vs) where
{
//
val CCOMPENV (!p) = env
val-~list_vt_cons (d2vs, d2vss) = p->ccompenv_d2varsetenv
val () = p->ccompenv_d2varsetenv := d2vss
prval () = fold@ (env)
//
} // end of [ccompenv_getdec_d2varsetenv]

implement
ccompenv_add_d2varsetenv
  (env, d2v) = ((*void*)) where
{
//
val lev = d2var_get_level (d2v)
//
val () =
if (lev > 0) then
{
val CCOMPENV (!p) = env
val-list_vt_cons
  (!p_d2vs, _) = p->ccompenv_d2varsetenv
val () = !p_d2vs := d2varset_add (!p_d2vs, d2v)
prval () = fold@ (p->ccompenv_d2varsetenv)
prval () = fold@ (env)
} (* end of [if] *)
//
} // end of [ccompenv_add_d2varsetenv]

implement
ccompenv_addset_d2varsetenv
  (env, lev0, d2vset) = let
//
fun addlst_if
(
  env: !ccompenv, lev0: int, d2vs: List_vt (d2var)
) : void = let
in
//
case+ d2vs of
| ~list_vt_cons
    (d2v, d2vs) => let
    val lev = d2var_get_level (d2v)
    val () = 
    ( // HX: no need for handling siblings (=lev0)
      if lev < lev0 then ccompenv_add_d2varsetenv (env, d2v)
    ) : void // end of [val]
  in
    addlst_if (env, lev0, d2vs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [addlst_if]
//
in
//
addlst_if (env, lev0, d2varset_listize (d2vset))
//
end // end of [ccompenv_addset_d2varsetenv]

(* ****** ****** *)

implement
ccompenv_inc_vbindlstenv
  (env) = let
//
val vbs = list_vt_nil ()
val CCOMPENV (!p) = env
val vbss = p->ccompenv_vbindlstenv
val () = (p->ccompenv_vbindlstenv := list_vt_cons (vbs, vbss))
prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_inc_vbindlstenv]

implement
ccompenv_getdec_vbindlstenv
  (env) = let
//
val CCOMPENV (!p) = env
val-~list_vt_cons
  (vbs, vbss) = p->ccompenv_vbindlstenv
val () = p->ccompenv_vbindlstenv := vbss
prval () = fold@ (env)
//
val vbs = list_vt_reverse (vbs)
//
in
  list_of_list_vt (vbs)
end // end of [ccompenv_getdec_vbindlstenv]

(* ****** ****** *)

local

assume ccompenv_push_v = unit_v

fun auxpop
(
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
| ~MARKENVLSTcons_impdec2 (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_staload (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpsub (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpcstmat (_, xs) => auxpop (map, xs)
| ~MARKENVLSTcons_tmpvarmat (_, xs) => auxpop (map, xs)
//
end // end of [auxpop]

fun auxjoin
(
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
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_staload]
//
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpsub]
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val () = auxjoin (map, !p_xs); prval () = fold@ (xs) in (*nothing*)
  end // end of [MENVLSTcons_tmpvarmat]
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
//
val lev = d2var_get_level (d2v)
val () =
if (lev > 0) then
{
val-list_vt_cons
  (!p_vbs, _) = p->ccompenv_vbindlstenv
val () = !p_vbs := list_vt_cons ( @(d2v, pmv), !p_vbs )
prval () = fold@ (p->ccompenv_vbindlstenv)
} (* end of [val] *)
//
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
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec]
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_staload (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_staload]
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_tmpcstmat]
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val res = loop (!p_xs); prval () = fold@ (xs) in res
  end // end of [MARKENVLSTcons_tmpvarmat]
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

implement
ccompenv_add_impdec2 (env, imp2) = let
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
  val-~Some_vt (tsub) = ccompenv_find_tmpsub (env)
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

implement
ccompenv_add_tmpvarmat
  (env, tmpmat) = let
//
  val CCOMPENV (!p) = env
  val xs = p->ccompenv_markenvlst
  val () = p->ccompenv_markenvlst := MARKENVLSTcons_tmpvarmat (tmpmat, xs)
//
  prval () = fold@ (env)
//
in
  // nothing
end // end of [ccompenv_add_tmpvarmat]

(* ****** ****** *)

local

fun auxlst
(
  env: !ccompenv, hfds: hifundeclst
) : void = let
in
//
case+ hfds of
| list_cons
    (hfd, hfds) => let
    val () =
      ccompenv_add_fundec (env, hfd) in auxlst (env, hfds)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

in (* in of [local] *)

implement
ccompenv_add_fundecsloc
  (env, knd, decarg, hfds) = let
in
//
case+ decarg of
| list_cons _ => auxlst (env, hfds) | list_nil _ => ()
//
end // end of [ccompenv_add_fundecsloc]

end // end of [local]

(* ****** ****** *)

local

fun auxlst
(
  xs: !markenvlst_vt
, d2c0: d2cst
, t2mas: t2mpmarglst
) : tmpcstmat = let
in
//
case+ xs of
//
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in TMPCSTMATnone ()
  end // end of [MARKENVLSTnil]
//
| MARKENVLSTmark (!p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTmark] *)
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_var] *)
//
| MARKENVLSTcons_fundec (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_fundec] *)
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
    val-Some (map) =
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
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_tmpsub] *)
//
| MARKENVLSTcons_impdec2
    (imp2, !p_xs) => let
    val opt = hiimpdec2_tmpcst_match (imp2, d2c0, t2mas)
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_impdec2]
//
| MARKENVLSTcons_tmpcstmat
    (tmpmat, !p_xs) => let
    val opt = tmpcstmat_tmpcst_match (tmpmat, d2c0, t2mas)
    val res = auxcont (opt, !p_xs, d2c0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_tmpcstmat]
//
| MARKENVLSTcons_tmpvarmat (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2c0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_tmpvarmat] *)
//
end (* end of [auxlst] *)

and auxcont
(
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

in (* in of [local] *)

implement
ccompenv_tmpcst_match
  (env, d2c0, t2mas) = let
//
val CCOMPENV (!p) = env
val opt = auxlst (p->ccompenv_markenvlst, d2c0, t2mas)
prval () = fold@ (env)
//
in
  opt
end // end of [ccompenv_tmpcst_match]

end // end of [local]

(* ****** ****** *)

local

fun auxlst
(
  xs: !markenvlst_vt
, d2v0: d2var
, t2mas: t2mpmarglst
) : tmpvarmat = let
in
//
case+ xs of
| MARKENVLSTnil () => let
    prval () = fold@ (xs) in TMPVARMATnone ()
  end // end of [MARKENVLSTnil]
//
| MARKENVLSTmark (!p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end // end of [MARKENVLSTmark]
//
| MARKENVLSTcons_var (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_var] *)
//
| MARKENVLSTcons_fundec
    (hfd, !p_xs) => let
    val opt =
      hifundec_tmpvar_match (hfd, d2v0, t2mas)
    val res = auxcont (opt, !p_xs, d2v0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_fundec]
//
| MARKENVLSTcons_impdec (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_impdec] *)
//
| MARKENVLSTcons_staload (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_staload] *)
//
| MARKENVLSTcons_tmpsub (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_tmpsub] *)
//
| MARKENVLSTcons_impdec2 (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_impdec2] *)
//
| MARKENVLSTcons_tmpcstmat (_, !p_xs) => let
    val opt = auxlst (!p_xs, d2v0, t2mas) in fold@ (xs); opt
  end (* end of [MARKENVLSTcons_tmpcstmat] *)
//
| MARKENVLSTcons_tmpvarmat
    (tmpmat, !p_xs) => let
    val opt = tmpvarmat_tmpvar_match (tmpmat, d2v0, t2mas)
    val res = auxcont (opt, !p_xs, d2v0, t2mas)
    prval () = fold@ (xs)
  in
    res
  end // end of [MARKENVLSTcons_tmpvarmat]
//
end // end of [auxlst]

and auxcont
(
  opt: tmpvarmat
, xs: !markenvlst_vt
, d2v0: d2var
, t2mas: t2mpmarglst
) : tmpvarmat = let
in
//
case+ opt of
| TMPVARMATsome _ => opt
| TMPVARMATsome2 _ => opt
| TMPVARMATnone _ => auxlst (xs, d2v0, t2mas)
//
end // end of [auxcont]

in (* in of [local] *)

implement
ccompenv_tmpvar_match
  (env, d2v0, t2mas) = let
//
val CCOMPENV (!p) = env
val opt = auxlst (p->ccompenv_markenvlst, d2v0, t2mas)
prval () = fold@ (env)
//
in
  opt
end // end of [ccompenv_tmpvar_match]

end // end of [local]

(* ****** ****** *)

local

val the_tmplst = ref<tmpvarlst> (list_nil)
val the_pmdlst = ref<primdeclst> (list_nil)

in (* in of [local] *)

implement
the_toplevel_getref_tmpvarlst () = $UN.cast2Ptr1 (the_tmplst)
implement
the_toplevel_getref_primdeclst () = $UN.cast2Ptr1 (the_pmdlst)

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_ccompenv.dats] *)
