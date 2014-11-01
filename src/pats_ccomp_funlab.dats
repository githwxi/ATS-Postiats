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
// Start Time: July, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_funlab"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

(* ****** ****** *)

staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

typedef
funlab_struct =
@{
  funlab_name= string
//
, funlab_level= int // top/inner level
//
, funlab_funclo= funclo (* funclo option *)
//
, funlab_type= hisexp (* function type *)
//
, funlab_tmpknd= int (* 0/1 : template use/def *)
//
, funlab_d2copt= d2cstopt (* global *)
, funlab_d2vopt= d2varopt (* local/static *)
//
, funlab_ncopy= int
, funlab_origin= Option (ptr)
, funlab_suffix= int
//
, funlab_tmparg= t2mpmarglst (* tmplt use *)
//
, funlab_funent= funentopt // function entry
//
, funlab_stamp= stamp (* stamp for unicity *)
} (* end of [funlab_struct] *)

(* ****** ****** *)

local

assume ccomp_funlab_type = ref (funlab_struct)

in (* in of [local] *)

implement
funlab_make
(
  name, level, hse, fcopt, qopt, sopt, t2mas, stamp
) = let
//
val
(
  pfgc, pfat | p
) = ptr_alloc<funlab_struct> ()
//
prval () = free_gc_elim {funlab_struct?} (pfgc)
//
val fc =
(
case+ fcopt of
| ~Some_vt (fc) => fc
| ~None_vt () => (
  case+ hse.hisexp_node of
  | HSEfun (fc, _, _) => fc | _ => FUNCLOfun ()
  ) // end of [None_vt]
) : funclo // end of [val]
//
val () = p->funlab_name := name
val () = p->funlab_level := level
//
val () = p->funlab_type := hse
val () = p->funlab_funclo := fc
//
val () = p->funlab_tmpknd := ~1
val () = p->funlab_d2copt := qopt // global
val () = p->funlab_d2vopt := sopt // static
//
val () = p->funlab_ncopy := 0
//
val () = p->funlab_origin := None ()
val () = p->funlab_suffix := 0
//
val () = p->funlab_tmparg := t2mas
//
val () = p->funlab_funent := None(*funent*)
//
val () = p->funlab_stamp := stamp
//
in
  ref_make_view_ptr (pfat | p)
end // end of [funlab_make]

(* ****** ****** *)

implement
funlab_get_name (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_name
end // end of [funlab_get_name]

implement
funlab_get_level (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_level
end // end of [funlab_get_level]

implement
funlab_get_type (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_type
end // end of [funlab_get_type]

implement
funlab_get_funclo (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_funclo
end // end of [funlab_get_funclo]

implement
funlab_get_tmpknd (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_tmpknd
end // end of [funlab_get_tmpknd]
implement
funlab_set_tmpknd (flab, knd) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_tmpknd := knd
end // end of [funlab_set_tmpknd]

implement
funlab_get_d2copt (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_d2copt
end // end of [funlab_get_d2copt]
implement
funlab_get_d2vopt (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_d2vopt
end // end of [funlab_get_d2vopt]

implement
funlab_get_ncopy (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_ncopy
end // end of [funlab_get_ncopy]
implement
funlab_set_ncopy (flab, cnt) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_ncopy := cnt
end // end of [funlab_set_ncopy]

implement
funlab_get_origin
  (flab) = let
  val (vbox pf | p) =
    ref_get_view_ptr (flab) in $UN.cast{funlabopt}(p->funlab_origin)
  // end of [val]
end // end of [funlab_get_origin]

implement
funlab_set_origin
  (flab, opt) = let
  val opt = $UN.cast{Option(ptr)}(opt)
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_origin := opt
end // end of [funlab_set_origin]

implement
funlab_get_suffix (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_suffix
end // end of [funlab_get_suffix]
implement
funlab_set_suffix (flab, sfx) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_suffix := sfx
end // end of [funlab_set_suffix]

implement
funlab_get_tmparg (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_tmparg
end // end of [funlab_get_tmparg]

implement
funlab_get_funent (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_funent
end // end of [funlab_get_funent]
implement
funlab_set_funent (flab, opt) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_funent := opt
end // end of [funlab_set_funent]

implement
funlab_get_stamp
  (flab) = $effmask_ref
(
let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_stamp
end // end of [funlab_get_stamp]
) (* end of [funlab_get_stamp] *)

end // end of [local]

(* ****** ****** *)

implement
funlab_get_type_arg
  (flab) = let
  val hse = funlab_get_type (flab)
in
//
case+ hse.hisexp_node of
| HSEfun (
    _(*fc*), _arg, _(*res*)
  ) => _arg
| _ => let
    val () = prerr_interror ()
    val () = (
      prerrln! (": funlab_get_type_arg: hse = ", hse)
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1) // HX: this is deadcode
  end (* end of [_] *)
//
end // end of [funlab_get_type_arg]

implement
funlab_get_type_res
  (flab) = let
  val hse = funlab_get_type (flab)
in
//
case+ hse.hisexp_node of
| HSEfun (
    _(*fc*), _(*arg*), _res
  ) => _res
| _ => let
    val () = prerr_interror ()
    val () = (
      prerrln! (": funlab_get_type_arg: hse = ", hse)
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1) // HX: this is deadcode
  end (* end of [_] *)
//
end // end of [funlab_get_type_res]

(* ****** ****** *)

implement
funlab_incget_ncopy
  (flab) = cnt1 where {
  val cnt = funlab_get_ncopy (flab)
  val cnt1 = cnt + 1
  val () = funlab_set_ncopy (flab, cnt1)
} // end of [funlab_incget_ncopy]

(* ****** ****** *)

implement
funlab_make_type
  (hse) = let
  val lvl0 = the_d2varlev_get ()
  val fcopt = None_vt() // HX: by [hse]
  val stamp = $STMP.funlab_stamp_make ()
  val flname = let
    val opt = $GLOB.the_STATIC_PREFIX_get ()
  in
    if stropt_is_none(opt) then "__patsfun_"
      else $UN.castvwtp0{string}(stropt_unsome(opt)+"patsfun_")
  end // end of [val]
  val flname2 = $STMP.tostring_prefix_stamp (flname, stamp)
in
//
funlab_make
(
  flname2, lvl0, hse, fcopt, None(*qopt*), None(*sopt*), list_nil(*t2mas*), stamp
)
//
end // end of [funlab_make_type]

(* ****** ****** *)

local

fun
d2cst_get_gname
  (d2c: d2cst): string = let
  val extdef = d2cst_get_extdef (d2c)
in
  case+ extdef of
//
  | $SYN.DCSTEXTDEFnone (knd) => let
      val sym = d2cst_get_sym (d2c) in $SYM.symbol_get_name (sym)
    end // end of [DCSTEXTDEFnone]
//
  | $SYN.DCSTEXTDEFsome_ext (name) => name
  | $SYN.DCSTEXTDEFsome_mac (name) => name
  | $SYN.DCSTEXTDEFsome_sta (name) => name
//
end // end of [d2cst_get_gname]

fun flname_make
(
  d2c: d2cst, stamp: stamp
) : string = let
  val d2c2 = d2cst_get_gname (d2c)
  val stamp2 = $STMP.tostring_stamp (stamp)
  val flname = sprintf ("%s$%s", @(d2c2, stamp2))
in
  string_of_strptr (flname)
end // end of [flname_make]

in (* in of [local] *)

implement
funlab_make_dcst_type
  (d2c, hse, fcopt) = let
  val lvl0 = the_d2varlev_get ()
  val qopt = Some (d2c)
  val t2mas = list_nil ()
  val stamp = $STMP.funlab_stamp_make ()
  val flname = flname_make (d2c, stamp)
in
//
funlab_make
(
  flname, lvl0, hse, fcopt, qopt, None (*sopt*), t2mas, stamp
)
//
end // end of [funlab_make_dcst_type]

implement
funlab_make_tmpcst_type
(
  d2c, t2mas, hse, fcopt
) = let
  val lvl0 = the_d2varlev_get ()
  val qopt = Some (d2c)
  val stamp = $STMP.funlab_stamp_make ()
  val flname = flname_make (d2c, stamp)
in
//
funlab_make
(
  flname, lvl0, hse, fcopt, qopt, None (*sopt*), t2mas, stamp
) (* end of [funlab_make] *)
//
end // end of [funlab_make_tmpcst_type]

end // end of [local]

(* ****** ****** *)

local

fun
flname_make
(
  d2v: d2var, stamp: stamp
) : string = let
//
  val opt =
    $GLOB.the_STATIC_PREFIX_get ()
  val isnone = stropt_is_none (opt)
//
  val d2v2 =
    $SYM.symbol_get_name (d2var_get_sym (d2v))
  // end of [val]
  val stamp2 = $STMP.tostring_stamp (stamp)
in
//
if
isnone
then
  string_of_strptr (sprintf ("%s_%s", @(d2v2, stamp2)))
else let
  val prfx = stropt_unsome(opt) in
  string_of_strptr (sprintf ("%s%s_%s", @(prfx, d2v2, stamp2)))
end // end of [else]
//
end // end of [flname_make]

in (* in of [local] *)

implement
funlab_make_dvar_type
  (d2v, hse, fcopt) = let
  val lvl0 = the_d2varlev_get ()
  val sopt = Some (d2v)
  val t2mas = list_nil ()
  val stamp = $STMP.funlab_stamp_make ()
  val flname = flname_make (d2v, stamp)
in
//
funlab_make
(
  flname, lvl0, hse, fcopt, None(*qopt*), sopt, t2mas, stamp
) (* end of [funlab] *)
//
end // end of [funlab_make_dvar_type]

(*
//
// HX-2014-11-01:
// where is this needed?
//
implement
funlab_make_tmpvar_type
(
  d2v, t2mas, hse, fcopt
) = let
  val lvl0 = the_d2varlev_get ()
  val sopt = Some (d2v)
  val stamp = $STMP.funlab_stamp_make ()
  val flname = flname_make (d2v, stamp)
in
//
funlab_make
(
  flname, lvl0, hse, fcopt, None(*qopt*), sopt, t2mas, stamp
) (* end of [funlab_make] *)
//
end // end of [funlab_make_tmpvar_type]
*)

end // end of [local]

(* ****** ****** *)

implement
fprint_funlab
  (out, flab) = let
  val name = funlab_get_name (flab)
  val () = fprint_string (out, name)
  val sfx = funlab_get_suffix (flab)
  val () = fprintf (out, "$%i", @(sfx))
  val flev = funlab_get_level (flab)
  val () = fprintf (out, "(level=%i)", @(flev))
in
  // nothing
end // end of [fprint_funlab]

implement
print_funlab (flab) = fprint_funlab (stdout_ref, flab)
implement
prerr_funlab (flab) = fprint_funlab (stderr_ref, flab)

(* ****** ****** *)

implement
fprint_funlablst
  (out, fls) = let
//
val () = $UT.fprintlst (out, fls, ", ", fprint_funlab)
//
in
  // nothing
end // end of [fprint_funlablst]

(* ****** ****** *)

implement
fprint_funlablstopt
  (out, opt) = let
in
//
case+ opt of
| Some (fls) =>
    fprint! (out, "Some(", fls, ")")
  // end of [Some]
| None ((*void*)) => fprint! (out, "None()")
//
end // end of [fprint_funlablstopt]

(* ****** ****** *)

local

staload
LS = "libats/SATS/linset_listord.sats"
staload
_(*anon*) = "libats/DATS/linset_listord.dats"

assume funlabset_vtype = $LS.set (funlab)

val cmp =
lam (x: funlab, y: funlab) =<cloref>
  $STMP.compare_stamp_stamp (funlab_get_stamp (x), funlab_get_stamp (y))
// end of [val]

in (* in of [local] *)

implement
funlabset_vt_nil () = $LS.linset_make_nil ()

implement
funlabset_vt_free (fls) = $LS.linset_free (fls)

implement
funlabset_vt_ismem
  (fls, fl) = $LS.linset_is_member (fls, fl, cmp)
// end of [funlabset_vt_ismem]

implement
funlabset_vt_add
  (fls, fl) = fls where
{
  var fls = fls
  val _(*exists*) = $LS.linset_insert (fls, fl, cmp)
} // end of [funlabset_vt_add]

implement
funlabset_vt_listize (fls) = $LS.linset_listize (fls)
implement
funlabset_vt_listize_free (fls) = $LS.linset_listize_free (fls)

end // end of [local]

implement
funlablst2set (fls) = let
//
fun loop
(
  fls: funlablst, res: funlabset_vt
) : funlabset_vt = let
in
//
case+ fls of
| list_cons
    (fl, fls) => let
    val res = funlabset_vt_add (res, fl) in loop (fls, res)
  end (* end of [list_cons] *)
| list_nil () => res
//
end (* end of [loop] *)
//
in
  loop (fls, funlabset_vt_nil ())
end // end of [funlablst2set]

(* ****** ****** *)

implement
fprint_funlabset_vt
  (out, fls) = let
  val fls = funlabset_vt_listize (fls)
  val ((*void*)) = fprint_funlablst (out, $UN.linlst2lst(fls))
  val ((*void*)) = list_vt_free (fls)
in
  // nothing
end // end of [fprint_funlabset_vt]

(* ****** ****** *)

(* end of [pats_ccomp_funlab.dats] *)
