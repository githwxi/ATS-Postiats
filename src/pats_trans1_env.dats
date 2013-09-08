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
// Start Time: April, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans1_staexp"

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
staload FIX = "./pats_fixity.sats"
staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_symmap.sats"
staload "./pats_symenv.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"
staload "./pats_trans1_env.sats"

(* ****** ****** *)

local
//
vtypedef e1xpenv = symenv (e1xp)
//
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr{e1xpenv}(pf | p0)
//
assume e1xpenv_push_v = unit_v // HX: it is just a dummy
//
in (* in of [local] *)

implement
the_e1xpenv_add
  (k, i) = () where
{
  prval vbox (pf) = pf0
  val () = symenv_insert (!p0, k, i)
} // end of [the_e1xpenv_add]

implement
the_e1xpenv_addperv
  (k, i) = () where
{
  prval vbox (pf) = pf0
  val () = symenv_pervasive_insert (!p0, k, i)
} // end of [the_e1xpenv_addperv]

implement
the_e1xpenv_find (k) = let
//
  prval vbox (pf) = pf0
//
  val ans = symenv_search (!p0, k)
//
in
  case+ ans of
  | Some_vt _ => (fold@ ans; ans)
  | ~None_vt () => symenv_pervasive_search (!p0, k)
end // end of [the_e1xpenv_find]

implement
the_e1xpenv_pop
(
  pfenv | (*none*)
) = map where {
  prval vbox (pf) = pf0
  prval unit_v () = pfenv
  val map = symenv_pop (!p0)
} // end of [the_e1xpenv_pop_free]

implement
the_e1xpenv_push_nil
  () = (pfenv | ()) where
{
  prval vbox (pf) = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_e1xpenv_push_nil]

fun
the_e1xpenv_localjoin
(
  pfenv1: e1xpenv_push_v
, pfenv2: e1xpenv_push_v
| (*none*)
) = () where {
  prval vbox (pf) = pf0
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  val () = symenv_localjoin (!p0)
} // end of [the_e1xpenv_localjoin]

viewdef
e1xpenv_save_v = unit_v
fun
the_e1xpenv_save () = let
  prval vbox (pf) = pf0
  prval pfsave = unit_v ()
  val () = symenv_savecur (!p0)
in
  (pfsave | ())
end // end of [the_e1xpenv_save]

fun
the_e1xpenv_restore
(
  pfsave: e1xpenv_save_v | (*none*)
) : void = () where
{
  prval vbox (pf) = pf0
  prval unit_v () = pfsave
  val map = symenv_restore (!p0)
  val () = symmap_free (map)
} // end of [the_e1xpenv_restore]

end // end of [local]

(* ****** ****** *)

implement
the_EXTERN_PREFIX_get () = let
//
macdef
EXTPRFX =
  $SYM.symbol_ATS_EXTERN_PREFIX
//
val opt = the_e1xpenv_find (EXTPRFX)
//
in
//
case+ opt of
| ~Some_vt (e) => (
  case+ e.e1xp_node of
  | E1XPnone () => stropt_none
  | E1XPstring (x) => stropt_some (x)
  | _ => let
      val () = prerr_warning1_loc (e.e1xp_loc)
      val () = prerr ": a string definition is required for [ATS_EXTERN_PREFIX]."
      val () = prerr_newline ()
    in
      stropt_none
    end // end of [_]
  ) // end of [Some_vt]
| ~None_vt () =>
    stropt_none // HX: [%] is kept to indicate a likely error
  // end of [None_vt]
//
end // end of [the_EXTERN_PREFIX_get]

implement
the_EXTERN_PREFIX_set (prfx) = let
  val e1xp = e1xp_string ($LOC.location_dummy, prfx)
  val () = the_e1xpenv_add ($SYM.symbol_ATS_EXTERN_PREFIX, e1xp)
in
  // nothing
end // end of [the_EXTERN_PREFIX_set]

implement
the_EXTERN_PREFIX_set_none () = let
  val e1xp = e1xp_none ($LOC.location_dummy)
  val () = the_e1xpenv_add ($SYM.symbol_ATS_EXTERN_PREFIX, e1xp)
in
  // nothing
end // end of [the_EXTERN_PREFIX_set_none]

(* ****** ****** *)

local

vtypedef fxtyenv = symenv (fxty)
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr{fxtyenv} (pf | p0)

assume fxtyenv_push_v = unit_v // HX: it is just a dummy

in (* in of [local] *)

implement
the_fxtyenv_add
  (k, i) = () where {
  prval vbox (pf) = pf0
  val () = symenv_insert (!p0, k, i)
} // end of [the_fxtyenv_add]

implement
the_fxtyenv_find (k) = let
  prval vbox (pf) = pf0
  val ans = symenv_search (!p0, k)
in
  case+ ans of
  | Some_vt _ => (fold@ ans; ans)
  | ~None_vt () => symenv_pervasive_search (!p0, k)
end // end of [the_fxtyenv_find]

(* ****** ****** *)

implement
fprint_the_fxtyenv (out) = let
  prval vbox (pf) = pf0 in // HX: ref-effect is not allowed
  $effmask_ref (fprint_symenv_map (out, !p0, $FIX.fprint_fxty))
end // end of [fprint_the_fxtyenv]

(* ****** ****** *)

implement
the_fxtyenv_pop
(
  pfenv | (*none*)
) = map where {
  prval vbox (pf) = pf0
  prval unit_v () = pfenv
  val map = symenv_pop (!p0)
} // end of [the_fxtyenv_pop_free]

implement
the_fxtyenv_push_nil
  () = (pfenv | ()) where
{
  prval vbox (pf) = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_fxtyenv_push_nil]

fun
the_fxtyenv_localjoin
(
  pfenv1: fxtyenv_push_v
, pfenv2: fxtyenv_push_v
| (*none*)
) = () where {
  prval vbox (pf) = pf0
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  val () = symenv_localjoin (!p0)
} // end of [the_fxtyenv_localjoin]

(* ****** ****** *)

implement
the_fxtyenv_pervasive_joinwth (map) = let
  prval vbox (pf) = pf0 in symenv_pervasive_joinwth (!p0, map)
end // end of [fun]

(* ****** ****** *)

viewdef
fxtyenv_save_v = unit_v
fun
the_fxtyenv_save () = let
  prval vbox (pf) = pf0
  prval pfsave = unit_v ()
  val ((*void*)) = symenv_savecur (!p0)
in
  (pfsave | ())
end // end of [the_fxtyenv_save]

fun the_fxtyenv_restore
(
  pfsave: fxtyenv_save_v | (*none*)
) : void = {
  prval vbox (pf) = pf0
  prval unit_v () = pfsave
  val map = symenv_restore (!p0)
  val ((*void*)) = symmap_free (map)
} // end of [the_fxtyenv_restore]

end // end of [local]

(* ****** ****** *)

local

var the_level: int = 0
val p_the_level = &the_level
val (
  pf_the_level | ((*void*))
) = vbox_make_view_ptr{int} (view@the_level | p_the_level)

assume trans1_level_v = unit_v // HX: it is just a dummy

in (* in of [local] *)

implement
the_trans1_level_get () = let
  prval vbox (pf) = pf_the_level in !p_the_level
end // end of [the_trans1_level_get]

implement
the_trans1_level_inc () = let
  prval pflev = unit_v ()
  prval vbox (pf) = pf_the_level
  val () = !p_the_level := !p_the_level + 1
in
  (pflev | ())
end // end of [the_trans1_level_inc]

implement
the_trans1_level_dec
  (pflev | (*none*)) =
{
  prval unit_v () = pflev
  prval vbox (pf) = pf_the_level
  val () = !p_the_level := !p_the_level - 1
} // end of [the_trans1_level_dec]

end // end of [local]

(* ****** ****** *)

local

assume
trans1_env_push_v = (e1xpenv_push_v, fxtyenv_push_v)

in (* in of [local] *)

implement
the_trans1_env_pop
  (pfenv | (*none*)) = () where {
  prval (pf1env, pf2env) = pfenv
  val map = the_e1xpenv_pop (pf1env | (*none*))
  val () = symmap_free (map)
  val map = the_fxtyenv_pop (pf2env | (*none*))
  val () = symmap_free (map)
} // end of [the_trans1_env_pop]

implement
the_trans1_env_push
  () = (pfenv | ()) where {
  val (pf1env | ()) = the_e1xpenv_push_nil ()
  val (pf2env | ()) = the_fxtyenv_push_nil ()
  prval pfenv = (pf1env, pf2env)
} // end of [the_trans1_env_pop]

implement
the_trans1_env_localjoin
  (pfenv1, pfenv2 | (*none*)) = () where {
  prval (pf1env1, pf2env1) = pfenv1
  prval (pf1env2, pf2env2) = pfenv2
  val () = the_e1xpenv_localjoin (pf1env1, pf1env2 | (*none*))
  val () = the_fxtyenv_localjoin (pf2env1, pf2env2 | (*none*))
} // end of [the_trans1_env_localjoin]

end // end of [local]

(* ****** ****** *)

local

assume
trans1_env_save_v = (e1xpenv_save_v, fxtyenv_save_v)

in (* in of [local] *)

implement
the_trans1_env_save () = let
  val (pf1save | ()) = the_e1xpenv_save ()
  val (pf2save | ()) = the_fxtyenv_save ()
  prval pfsave = (pf1save, pf2save)
in
  (pfsave | ())
end // end of [the_trans1_env_save]

implement
the_trans1_env_restore
  (pfsave | (*none*)) = {
  val () = the_e1xpenv_restore (pfsave.0 | (*none*))
  val () = the_fxtyenv_restore (pfsave.1 | (*none*))  
} // end of [the_trans1_env_restore]

end // end of [local]

(* ****** ****** *)

local
//
staload UN = "prelude/SATS/unsafe.sats"
staload LM = "libats/SATS/linmap_avltree.sats"
staload _(*anon*) = "libats/DATS/linmap_avltree.dats"
//
typedef key = uint
typedef itm = @(int, d1eclist)
vtypedef map = $LM.map (key, itm)
//
val theStaloadMap = ref<map> ($LM.linmap_make_nil ())
//
val cmp0 = $UN.cast {$LM.cmp(key)} (null)
implement $LM.compare_key_key<key> (x1, x2, _) = compare (x1, x2)

in (* in of [local] *)

implement
staload_file_search
  (fil) = let
//
val fname =
  $FIL.filename_get_fullname (fil)
//
val k0 = $SYM.symbol_get_stamp (fname)
//
val (vbox(pf) | p) = ref_get_view_ptr{map}(theStaloadMap)
//
var res: itm?  
val found = $LM.linmap_search<key,itm> (!p, k0, cmp0, res)
//
in
//
if found then let
  prval () = opt_unsome {itm} (res) in Some_vt (res)
end else let
  prval () = opt_unnone {itm} (res) in None_vt ()
end (* end of [if] *)
//
end // end of [staload_file_search]

(* ****** ****** *)

implement
staload_file_insert
  (fil, flag, d1cs) = {
//
val fname =
  $FIL.filename_get_fullname (fil)
//
val k0 = $SYM.symbol_get_stamp (fname)
//
var x0: itm = (flag, d1cs) // HX: local var
//
val (vbox(pf) | p) = ref_get_view_ptr{map}(theStaloadMap)
//
var res: itm?
val _(*isexi*) = $LM.linmap_insert<key,itm> (!p, k0, x0, cmp0, res)
prval () = opt_clear {itm} (res)
//
} // end of [staload_file_insert]

end // end of [local]

(* ****** ****** *)

local

%{^
extern ats_ptr_type patsopt_PATSHOMERELOC_get () ;
%} // end of [%{^]

in (* in of [local] *)

implement
the_trans1_env_initialize () =
{
//
val opt = get () where
{
  extern fun get (): Stropt = "mac#patsopt_PATSHOMERELOC_get"
} (* end of [val] *)
val issome = stropt_is_some (opt)
val () =
if issome then let
  val k = $SYM.symbol_PATSHOMERELOC
  val x = e1xp_string ($LOC.location_dummy, stropt_unsome(opt))
in
  the_e1xpenv_addperv (k, x)
end // end of [if] // end of [val]
//
} (* end of [the_trans1_env_initialize] *)

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans1_env.dats] *)
