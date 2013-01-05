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

staload _(*anon*) = "prelude/DATS/pointer.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_funlab"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"
typedef stamp = $STMP.stamp

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
funlab_struct = @{
  funlab_name= string
//
, funlab_level= int
//
, funlab_type= hisexp (* function type *)
//
, funlab_qopt= d2cstopt (* local or global *)
//
, funlab_ncopy= int
, funlab_suffix= int
//
, funlab_tmparg= t2mpmarglst (* tmplate arguments *)
//
, funlab_funent= funentopt // function entry
, funlab_tailjoin= tmpvarlst // tail-call optimization
//
, funlab_stamp= stamp
} // end of [funlab_struct]

(* ****** ****** *)

local

assume ccomp_funlab_type = ref (funlab_struct)

in // in of [local]

implement
funlab_make (
  name, level, hse, qopt, t2mas, stamp
) = let
//
val (
  pfgc, pfat | p
) = ptr_alloc<funlab_struct> ()
prval () = free_gc_elim {funlab_struct?} (pfgc)
//
val () = p->funlab_name := name
val () = p->funlab_level := level
val () = p->funlab_type := hse
//
val () = p->funlab_qopt := qopt
//
val () = p->funlab_ncopy := 0
val () = p->funlab_suffix := 0
//
val () = p->funlab_tmparg := t2mas
//
val () = p->funlab_funent := None(*funent*)
val () = p->funlab_tailjoin := list_nil(*tmpvarlst*)
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
funlab_get_qopt (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_qopt
end // end of [funlab_get_qopt]

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
funlab_get_ncopy (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_ncopy
end // end of [funlab_get_ncopy]
implement
funlab_set_ncopy (flab, cnt) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_ncopy := cnt
end // end of [funlab_set_ncopy]

implement
funlab_get_suffix (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_suffix
end // end of [funlab_get_suffix]
implement
funlab_set_suffix (flab, sfx) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_suffix := sfx
end // end of [funlab_set_suffix]

implement
funlab_get_stamp (flab) = let
  val (vbox pf | p) = ref_get_view_ptr (flab) in p->funlab_stamp
end // end of [funlab_get_stamp]

end // end of [local]

(* ****** ****** *)

implement
funlab_get_funclo
  (flab) = fc where {
  val hse = funlab_get_type (flab)
  val- HSEfun (fc, _(*arg*), _(*res*)) = hse.hisexp_node
} // end of [funlab_get_funclo]

(* ****** ****** *)

implement
funlab_get_type_arg
  (flab) = let
  val hse = funlab_get_type (flab)
in
//
case+ hse.hisexp_node of
| HSEfun (_(*fc*), _arg, _(*res*)) => _arg
| _ => let
    val () = prerr_interror ()
    val () = (
      prerr ": funlab_get_type_arg: hse = "; prerr hse; prerr_newline ()
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
| HSEfun (_(*fc*), _(*arg*), _res) => _res
| _ => let
    val () = prerr_interror ()
    val () = (
      prerr ": funlab_get_type_res: hse = "; prerr hse; prerr_newline ()
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
  val lev0 = the_d2varlev_get ()
  val stamp = $STMP.funlab_stamp_make ()
  val flname = $STMP.tostring_prefix_stamp ("__patsfun_", stamp)
  val qopt = None ()
  val t2mas = list_nil ()
in
  funlab_make (flname, lev0, hse, qopt, t2mas, stamp)
end // end of [funlab_make_type]

(* ****** ****** *)

local

fun d2cst_get_gname
  (d2c: d2cst): string = let
  val extdef = d2cst_get_extdef (d2c)
in
  case+ extdef of
//
  | $SYN.DCSTEXTDEFnone () => let
      val sym = d2cst_get_sym (d2c) in $SYM.symbol_get_name (sym)
    end // end of [DCSTEXTDEFnone]
//
  | $SYN.DCSTEXTDEFsome_ext (name) => name
  | $SYN.DCSTEXTDEFsome_mac (name) => name
  | $SYN.DCSTEXTDEFsome_sta (name) => name
//
end // end of [global_cst_name_make]

in // in of [local]

implement
funlab_make_dcst_type
  (d2c, hse) = let
  val lev0 = the_d2varlev_get ()
  val d2c2 = d2cst_get_gname (d2c)
  val qopt = Some (d2c)
  val t2mas = list_nil ()
  val stamp = $STMP.funlab_stamp_make ()
  val stamp2 = $STMP.tostring_stamp (stamp)
  val flname = sprintf ("%s_%s", @(d2c2, stamp2))
  val flname = string_of_strptr (flname)
in
  funlab_make (flname, lev0, hse, qopt, t2mas, stamp)
end // end of [funlab_make_dcst_type]

implement
funlab_make_tmpcst_type
  (d2c, t2mas, hse) = let
  val lev0 = the_d2varlev_get ()
  val d2c2 = d2cst_get_gname (d2c)
  val qopt = Some (d2c)
  val stamp = $STMP.funlab_stamp_make ()
  val stamp2 = $STMP.tostring_stamp (stamp)
  val flname = sprintf ("%s_%s", @(d2c2, stamp2))
  val flname = string_of_strptr (flname)
in
  funlab_make (flname, lev0, hse, qopt, t2mas, stamp)
end // end of [funlab_make_tmpcst_type]

end // end of [local]

(* ****** ****** *)

implement
funlab_make_dvar_type
  (d2v, hse) = let
  val lev0 = the_d2varlev_get ()
  val d2v2 =
    $SYM.symbol_get_name (d2var_get_sym (d2v))
  val qopt = None ()
  val t2mas = list_nil ()
  val stamp = $STMP.funlab_stamp_make ()
  val stamp2 = $STMP.tostring_stamp (stamp)
  val flname = sprintf ("%s_%s", @(d2v2, stamp2))
  val flname = string_of_strptr (flname)
in
  funlab_make (flname, lev0, hse, qopt, t2mas, stamp)
end // end of [funlab_make_dvar_type]

(* ****** ****** *)

implement
fprint_funlab
  (out, flab) = let
  val name = funlab_get_name (flab)
in
  fprint_string (out, name)
end // end of [fprint_funlab]

implement
print_funlab (flab) = fprint_funlab (stdout_ref, flab)
implement
prerr_funlab (flab) = fprint_funlab (stderr_ref, flab)

(* ****** ****** *)

(* end of [pats_ccomp_funlab.dats] *)
