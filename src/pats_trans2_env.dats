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
// Start Time: May, 2011
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

staload "./pats_basics.sats"

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
typedef filename = $FIL.filename

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_env"

(* ****** ****** *)

staload "./pats_symmap.sats"
staload "./pats_symenv.sats"
staload "./pats_staexp2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_namespace.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

local

vtypedef
filenv_struct =
@{
  name= filename
, sort= s2temap
, sexp= s2itmmap
, dexp= d2itmmap
, decl2= d2eclist
, decl3= Option (dynexp2_d3eclist_type)
(*
, hidecl= Option (dynexp2_hideclist_type)
*)
, tcimap= Option (dynexp2_tmpcstimpmap_type)
, tvdmap= Option (dynexp2_tmpvardecmap_type)
} // end of [filenv_struct]

assume filenv_type = ref (filenv_struct)

in (* in of [local] *)

implement
filenv_make
(
  fil, s2tm, s2im, d2im, d2cs
) = let
//
val (
  pfgc, pfat | p
) = ptr_alloc<filenv_struct> ()
prval () = free_gc_elim {filenv_struct?} (pfgc)
//
val () = p->name := fil
val () = p->sort := s2tm
val () = p->sexp := s2im
val () = p->dexp := d2im
val () = p->decl2 := d2cs
val () = p->decl3 := None ()
(*
val () = p->hidecl := None ()
*)
val () = p->tcimap := None ()
val () = p->tvdmap := None ()
in
//
ref_make_view_ptr (pfat | p)
//
end // end of [filenv_make]

implement
filenv_get_name (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv) in p->name  
end // end of [filenv_get_name]

implement
filenv_get_s2temap (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv)
  prval (pf1, fpf1) = __assert (view@ (p->sort)) where {
    extern prfun __assert {a:vt@ype} {l:addr} (pf: !a @ l): (a @ l, minus (filenv, a @ l))
  } // end of [prval]
in
  (pf1, fpf1 | &p->sort)
end // end of [filenv_get_s2temap]

implement
filenv_get_s2itmmap (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv)
  prval (pf1, fpf1) = __assert (view@ (p->sexp)) where {
    extern prfun __assert {a:vt@ype} {l:addr} (pf: !a @ l): (a @ l, minus (filenv, a @ l))
  } // end of [prval]
in
  (pf1, fpf1 | &p->sexp)
end // end of [filenv_get_s2itmmap]

implement
filenv_get_d2itmmap (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv)
  prval (pf1, fpf1) = __assert (view@ (p->dexp)) where {
    extern prfun __assert {a:vt@ype} {l:addr} (pf: !a @ l): (a @ l, minus (filenv, a @ l))
  } // end of [prval]
in
  (pf1, fpf1 | &p->dexp)
end // end of [filenv_get_d2itmmap]

implement
filenv_get_d2eclist (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv) in p->decl2
end // end of [filenv_get_d2eclist]

(* ****** ****** *)

implement
filenv_getref_d3eclistopt
  (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv) in $UN.cast2Ptr1(&(p->decl3))
end // end of [filenv_getref_d3eclist]

(* ****** ****** *)

implement
filenv_getref_tmpcstimpmap
  (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv) in $UN.cast2Ptr1(&(p->tcimap))
end // end of [filenv_getref_tmpcstimpmap]

implement
filenv_getref_tmpvardecmap
  (fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (fenv) in $UN.cast2Ptr1(&(p->tvdmap))
end // end of [filenv_getref_tmpvardecmap]

end // end of [local]

(* ****** ****** *)

local
//
assume s2rtenv_push_v = unit_v
//
vtypedef s2rtenv = symenv (s2rtext)
//
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {s2rtenv} (pf | p0)
//
(* ****** ****** *)

fun
the_s2rtenv_find_namespace .<>.
  (id: symbol): s2rtextopt_vt = let
  fn f (
    fenv: filenv
  ) :<cloptr1> s2rtextopt_vt = let
    val (pf, fpf | p) = filenv_get_s2temap (fenv)
    val ans = symmap_search (!p, id)
    prval () = minus_addback (fpf, pf | fenv)
  in
    ans
  end // end of [f]
in
  the_namespace_search (f)
end // end of [the_s2rtenv_find_namespace]

(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
the_s2rtenv_add (id, s2te) = let
  prval vbox pf = pf0 in symenv_insert (!p0, id, s2te)
end // end of [the_s2rtenv_add]

(* ****** ****** *)

implement
the_s2rtenv_find (id) = let
  val ans = let
    prval vbox pf = pf0 in symenv_search (!p0, id)
  end // end of [val]
in
//
case+ ans of
| Some_vt _ => (fold@ ans; ans)
| ~None_vt () => let
    val ans = the_s2rtenv_find_namespace (id)
  in
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => let
        prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_s2rtenv_find]

(* ****** ****** *)

implement
the_s2rtenv_top_clear
  () = () where {
  prval vbox pf = pf0
  val () = symenv_top_clear (!p0)
} // end of [the_s2rtenv_top_clear]

(* ****** ****** *)

implement
the_s2rtenv_pop (
  pfenv | (*none*)
) = let
  prval unit_v () = pfenv
  prval vbox pf = pf0
in
 symenv_pop (!p0)
end // end of [the_s2rtenv_pop]

implement
the_s2rtenv_pop_free
  (pfenv | (*none*)) = {
  prval unit_v () = pfenv
  prval vbox pf = pf0
  val () = symenv_pop_free (!p0)
} // end of [the_s2rtenv_pop_free]

implement
the_s2rtenv_push_nil
  () = (pfenv | ()) where {
  prval vbox pf = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_s2rtenv_push_nil]

(* ****** ****** *)

fun
the_s2rtenv_localjoin
(
  pfenv1: s2rtenv_push_v
, pfenv2: s2rtenv_push_v
| (*none*)
) = () where {
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  prval vbox pf = pf0
  val () = symenv_localjoin (!p0)
} // end of [the_s2rtenv_localjoin]

(* ****** ****** *)

viewdef
s2rtenv_save_v = unit_v
fun the_s2rtenv_save () = let
  prval pfsave = unit_v ()
  prval vbox pf = pf0
  val () = symenv_savecur (!p0)
in
  (pfsave | ())
end // end of [the_s2rtenv_save]

fun the_s2rtenv_restore (
  pfsave: s2rtenv_save_v | (*none*)
) : s2temap = let
  prval vbox pf = pf0
  prval unit_v () = pfsave
in
  symenv_restore (!p0)
end // end of [the_s2rtenv_restore]

(* ****** ****** *)

implement
the_s2rtenv_pervasive_joinwth0 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth0 (!p0, map)
end // end of [the_s2rtenv_pervasive_joinwth0]
implement
the_s2rtenv_pervasive_joinwth1 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth1 (!p0, map)
end // end of [the_s2rtenv_pervasive_joinwth1]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
the_s2rtenv_find_qua
  (q, id) = let
(*
val () =
print "the_s2rtenv_find_qua: qid = "
val () = ($SYN.print_s0rtq (q); $SYM.print_symbol (id))
val () = print_newline ((*void*))
*)
in
//
case+ q.s0rtq_node of
| $SYN.S0RTQnone _ =>
    the_s2rtenv_find (id)
| $SYN.S0RTQsymdot (sym) => let
    val ans = the_s2expenv_find (sym)
  in
    case+ ans of
    | ~Some_vt (s2i) => (
      case+ s2i of
      | S2ITMfilenv (fenv) => let
          val (
            pf, fpf | p_map
          ) = filenv_get_s2temap (fenv)
          val ans = symmap_search (!p_map, id)
          prval () = minus_addback (fpf, pf | fenv)
        in
          ans
        end // en dof [S2ITMfil]
      | _ => let
          val loc = q.s0rtq_loc
          val () = prerr_error2_loc (loc)
          val () = prerr ": the qualifier ["
          val () = $SYM.prerr_symbol (sym)
          val () = prerr "] should refer to a filename but it does not."
          val () = prerr_newline ()
        in
          None_vt ()
        end
      ) // end of [Some_vt]
    | ~None_vt () => let
        val loc = q.s0rtq_loc
        val () = prerr_error2_loc (loc)
        val () = prerr ": the qualifier ["
        val () = $SYM.prerr_symbol (sym)
        val () = prerr "] is unrecognized."
        val () = prerr_newline ()
      in
        None_vt ()
      end
    // end of [case]
  end // end of [S2RTsymdot]
//
end // end of [the_s2rtenv_find_qua]

(* ****** ****** *)

local
//
assume s2expenv_push_v = unit_v
//
vtypedef s2expenv = symenv (s2itm)
//
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {s2expenv} (pf | p0)
//
(* ****** ****** *)

fun
the_s2expenv_find_namespace .<>.
  (id: symbol): s2itmopt_vt = let
  fn f (
    fenv: filenv
  ) :<cloptr1> s2itmopt_vt = let
    val (pf, fpf | p) = filenv_get_s2itmmap (fenv)
    val ans = symmap_search (!p, id)
    prval () = minus_addback (fpf, pf | fenv)
  in
    ans
  end // end of [f]
in
  the_namespace_search (f)
end // end of [the_s2expenv_find_namespace]

(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
the_s2expenv_add (id, s2i) = let
  prval vbox pf = pf0 in symenv_insert (!p0, id, s2i)
end // end of [the_s2expenv_add]

(* ****** ****** *)

implement
the_s2expenv_find (id) = let
  val ans = let
    prval vbox pf = pf0 in symenv_search (!p0, id)
  end // end of [val]
in
//
case+ ans of
| Some_vt _ => (fold@ ans; ans)
| ~None_vt () => let
    val ans = the_s2expenv_find_namespace (id)
  in
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => let
        prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_s2expenv_find]

(* ****** ****** *)

implement
the_s2expenv_pervasive_find (id) = let
   prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
end // end of [the_s2expenv_pervasive_find]

(* ****** ****** *)

implement
the_s2expenv_top_clear
  () = () where {
  prval vbox pf = pf0
  val () = symenv_top_clear (!p0)
} // end of [the_s2expenv_top_clear]

(* ****** ****** *)

implement
the_s2expenv_pop (
  pfenv | (*none*)
) = let
  prval unit_v () = pfenv
  prval vbox pf = pf0
in
  symenv_pop (!p0)
end // end of [the_s2expenv_pop]

implement
the_s2expenv_pop_free
  (pfenv | (*none*)) = () where {
  prval unit_v () = pfenv
  prval vbox pf = pf0
  val () = symenv_pop_free (!p0)
} // end of [the_s2expenv_pop_free]

implement
the_s2expenv_push_nil
  () = (pfenv | ()) where {
  prval vbox pf = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_s2expenv_push_nil]

(* ****** ****** *)

fun
the_s2expenv_localjoin
(
  pfenv1: s2expenv_push_v
, pfenv2: s2expenv_push_v
| (*none*)
) = () where {
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  prval vbox pf = pf0
  val () = symenv_localjoin (!p0)
} // end of [the_s2expenv_localjoin]

(* ****** ****** *)

viewdef
s2expenv_save_v = unit_v
fun the_s2expenv_save () = let
  prval pfsave = unit_v ()
  prval vbox pf = pf0
  val () = symenv_savecur (!p0)
in
  (pfsave | ())
end // end of [the_s2expenv_save]

fun the_s2expenv_restore (
  pfsave: s2expenv_save_v | (*none*)
) : s2itmmap = let
  prval vbox pf = pf0
  prval unit_v () = pfsave
in
  symenv_restore (!p0)
end // end of [the_s2expenv_restore]

(* ****** ****** *)

implement
the_s2expenv_pervasive_joinwth0 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth0 (!p0, map)
end // end of [the_s2expenv_pervasive_joinwth0]
implement
the_s2expenv_pervasive_joinwth1 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth1 (!p0, map)
end // end of [the_s2expenv_pervasive_joinwth1]

end // end of [local]

(* ****** ****** *)

implement
the_s2expenv_find_qua
  (q, id) = let
(*
//
val () =
print "the_s2expenv_find_qua: qid = "
val () = ($SYN.print_s0taq (q); $SYM.print_symbol (id))
val () = print_newline ((*void*))
//
*)
in
//
case+ q.s0taq_node of
//
| $SYN.S0TAQnone _ =>
    the_s2expenv_find (id)
//
| $SYN.S0TAQsymdot (sym) => let
    val ans = the_s2expenv_find (sym)
  in
    case+ ans of
    | ~Some_vt (s2i) => (
      case+ s2i of
      | S2ITMfilenv (fenv) => let
          val (
            pf, fpf | p_map
          ) = filenv_get_s2itmmap (fenv)
          val ans = symmap_search (!p_map, id)
          prval () = minus_addback (fpf, pf | fenv)
        in
          ans
        end // en dof [S2ITMfil]
      | _ => let
          val loc = q.s0taq_loc
          val () = prerr_error2_loc (loc)
          val () = prerr ": the qualifier ["
          val () = $SYM.prerr_symbol (sym)
          val () = prerr "] should refer to a filename but it does not."
          val () = prerr_newline ((*void*))
        in
          None_vt ()
        end
      ) // end of [Some_vt]
    | ~None_vt () => let
        val loc = q.s0taq_loc
        val () = prerr_error2_loc (loc)
        val () = prerr ": the qualifier ["
        val () = $SYM.prerr_symbol (sym)
        val () = prerr "] is unrecognized."
        val () = prerr_newline ((*void*))
      in
        None_vt ()
      end
  end // end of [S2RTsymdot]
//
(*
//
// HX-2017-01-24:
// removed as it is never in use
//
| $SYN.S0TAQsymcolon _ => None_vt((*void*))
*)
//
end // end of [the_s2expenv_find_qua]

(* ****** ****** *)

implement
the_s2expenv_add_scst
  (s2c) = let
(*
val () =
(
  println! ("s2expenv_add_scst: s2c = ", s2c);
  println! ("s2expenv_add_scst: s2t = ", s2cst_get_srt(s2c));
) (* end of [val] *)
*)
val id = s2cst_get_sym s2c
//
val s2cs = (
  case+ the_s2expenv_find (id) of
  | ~Some_vt s2i => begin case+ s2i of
    | S2ITMcst s2cs => s2cs | _ => list_nil ()
    end // end of [Some_vt]
  | ~None_vt () => list_nil ()
) : s2cstlst // end of [val]
//
val s2i = S2ITMcst (list_cons (s2c, s2cs))
//
in
  the_s2expenv_add (id, s2i)
end // end of [the_s2expenv_add_scst]

implement
the_s2expenv_add_svar
  (s2v) = let
  val id = s2var_get_sym (s2v)
in
  the_s2expenv_add (id, S2ITMvar s2v)
end // end of [the_s2expenv_add_svar]

implement
the_s2expenv_add_svarlst
  (s2vs) = list_app_fun (s2vs, the_s2expenv_add_svar)
// end of [the_s2expenv_add_svarlst]

implement
the_s2expenv_add_sp2at
  (sp2t) = (
  case+ sp2t.sp2at_node of
  | SP2Tcon (s2c, s2vs) => the_s2expenv_add_svarlst (s2vs)
  | SP2Terr () => () // HX: a placeholder for indicating an error
) // end of [the_s2expenv_add_sp2at]

implement
the_s2expenv_add_datconptr (d2c) = let
  val sym = d2con_get_sym d2c
  val name = $SYM.symbol_get_name (sym)
  val id = $SYM.symbol_make_string (name + "_unfold")
  val () = the_s2expenv_add (id, S2ITMdatconptr (d2c))
in
  // empty
end // end of [the_s2expenv_add_datconptr]

implement
the_s2expenv_add_datcontyp (d2c) = let
  val sym = d2con_get_sym d2c
  val name = $SYM.symbol_get_name (sym)
  val id = $SYM.symbol_make_string (name + "_pstruct")
  val () = the_s2expenv_add (id, S2ITMdatcontyp (d2c))
in
  // empty
end // end of [the_s2expenv_add_datcontyp]

(* ****** ****** *)

local

val the_maclev =
  ref_make_elt<int> (1) // HX: the initial level is 1
// end of [val]

in (* in of [local] *)

implement
the_maclev_get () = !the_maclev

implement
the_maclev_inc
  (loc) = let
  val lev = !the_maclev
  val () = if lev > 0 then {
    val () = prerr_error2_loc (loc)
    val () = prerr ": the syntax `(...) is used incorrectly at this location.";
    val () = prerr_newline ()
  } // end of [if] // end of [val]
in
  !the_maclev := lev + 1
end // end of [the_maclev_inc]

implement
the_maclev_dec
  (loc) = let
  val lev = !the_maclev
  val () = if lev = 0 then {
    val () = prerr_error2_loc (loc)
    val () = prerr ": the syntax ,(...) or %(...) is used incorrectly at this location.";
    val () = prerr_newline ()
  } // end of [if] // end of [val]
in
  !the_maclev := lev - 1
end // end of [the_maclev_dec]

end // end of [local]

(* ****** ****** *)

local

val the_macdeflev =
  ref_make_elt<int> (0)
// end of [val]

in (* in of [local] *)

implement
the_macdeflev_get () = !the_macdeflev

implement
the_macdeflev_inc () =
  !the_macdeflev := !the_macdeflev + 1
// end of [macdeflev_inc]

implement
the_macdeflev_dec () =
  !the_macdeflev := !the_macdeflev - 1
// end of [macdeflev_dec]

end // end of [local]

(* ****** ****** *)

local

val the_tmplev =
  ref_make_elt<int> (0)
// end of [val]

in (* in of [local] *)

implement
the_tmplev_get () = !the_tmplev

implement
the_tmplev_inc () =
  !the_tmplev := !the_tmplev + 1
// end of [tmplev_inc]

implement
the_tmplev_dec () =
  !the_tmplev := !the_tmplev - 1
// end of [tmplev_dec]

end // end of [local]

(* ****** ****** *)

(*
** HX-2012-06-07:
** this function is currently not used
** in the implementation of ATS2
*)
#if (0) #then

implement
s2var_check_tmplev
  (loc, s2v) = let
  val lev = s2var_get_tmplev (s2v)
in
  case+ 0 of
  | _ when lev > 0 => let
      val tmplev = the_tmplev_get ()
    in
      if lev < tmplev then let
        val () = prerr_error2_loc (loc)
        val () = prerr ": the static variable ["
        val () = prerr_s2var (s2v)
        val () = prerr "] is out of scope."
        val () = prerr_newline ()
      in
        the_trans2errlst_add (T2E_s2var_check_tmplev (s2v))
      end // end of [if]
    end // end of [_ when lev > 0]]
  | _ => () // HX: [s2v] is not a template variable
end // end of [s2var_tmplev_check]

#endif // PATS_UNUSED_CODE

(* ****** ****** *)

implement
s2qualstlst_set_tmplev
  (s2qs, tmplev) = () where {
  fun aux (
    pf: !unit_v | s2q: s2qua
  ) :<cloptr1> void =
    list_app_cloptr (s2q.s2qua_svs, lam s2v =<1> s2var_set_tmplev (s2v, tmplev))
  // end of [aux]
  prval pfu = unit_v ()
  val () = list_app_vcloptr {unit_v} (pfu | s2qs, aux)
  prval unit_v () = pfu
} // end of [s2qualstlst_set_tmplev]

(* ****** ****** *)

local
//
val
the_d2varlev = ref<int> (0)
//
assume the_d2varlev_inc_v = unit_v
//
in (* in of [local] *)

implement
the_d2varlev_get () = !the_d2varlev

implement
the_d2varlev_inc
  ((*void*)) = let
  prval pfinc = unit_v ()
  val n = !the_d2varlev
  val () = !the_d2varlev := n + 1
in
  (pfinc | ())
end // end of [the_d2varlev_inc]

implement
the_d2varlev_dec
  (pfinc | (*none*)) = let
  prval unit_v () = pfinc
  val n = !the_d2varlev
  val () = !the_d2varlev := n - 1
in
  // nothing
end // end of [the_d2varlev_dec]

implement
the_d2varlev_save () = let
  val n = !the_d2varlev in !the_d2varlev := 0; n
end (* end of [the_d2varlev_save] *)

implement
the_d2varlev_restore (lvl0) = !the_d2varlev := lvl0

end // end of [local]

(* ****** ****** *)

local
//
assume d2expenv_push_v = unit_v
//
vtypedef d2expenv = symenv (d2itm)
//
val [l0:addr] (pf | p0) = symenv_make_nil ()
val (pf0 | ()) = vbox_make_view_ptr {d2expenv} (pf | p0)
//
(* ****** ****** *)

fn the_d2expenv_find_namespace
  (id: symbol): d2itmopt_vt = let
  fn f (
    fenv: filenv
  ) :<cloptr1> d2itmopt_vt = let
    val (pf, fpf | p) = filenv_get_d2itmmap (fenv)
    val ans = symmap_search (!p, id)
    prval () = minus_addback (fpf, pf | fenv)
  in
    ans
  end // end of [f]
in
  the_namespace_search (f)
end // end of [the_d2expenv_find_namespace]

in (* in of [local] *)

implement
the_d2expenv_add (id, d2i) = let
  prval vbox pf = pf0 in symenv_insert (!p0, id, d2i)
end // end of [the_d2expenv_add]

(* ****** ****** *)

implement
the_d2expenv_find (id) = let
  val ans = let
    prval vbox pf = pf0 in symenv_search (!p0, id)
  end // end of [val]
in
//
case+ ans of
| Some_vt _ => (fold@ ans; ans)
| ~None_vt () => let
    val ans = the_d2expenv_find_namespace (id)
  in
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => let
        prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
      end // end of [None_vt]
  end // end of [None_vt]
//
end // end of [the_d2expenv_find]

(* ****** ****** *)

implement
the_d2expenv_current_find (id) = let
   prval vbox pf = pf0 in symenv_search (!p0, id)
end // end of [the_d2expenv_current_find]

implement
the_d2expenv_pervasive_find (id) = let
   prval vbox pf = pf0 in symenv_pervasive_search (!p0, id)
end // end of [the_d2expenv_pervasive_find]

(* ****** ****** *)

implement
the_d2expenv_top_clear
  () = () where {
  prval vbox pf = pf0
  val () = symenv_top_clear (!p0)
} // end of [the_d2expenv_top_clear]

(* ****** ****** *)

implement
the_d2expenv_pop (
  pfenv | (*none*)
) = let
  prval unit_v () = pfenv
  prval vbox pf = pf0
in
  symenv_pop (!p0)
end // end of [the_d2expenv_pop]

implement
the_d2expenv_pop_free
  (pfenv | (*none*)) = () where {
  prval unit_v () = pfenv
  prval vbox pf = pf0
  val () = symenv_pop_free (!p0)
} // end of [the_d2expenv_pop_free]

implement
the_d2expenv_push_nil
  () = (pfenv | ()) where {
  prval vbox pf = pf0
  val () = symenv_push_nil (!p0)
  prval pfenv = unit_v ()
} // end of [the_d2expenv_push_nil]

(* ****** ****** *)

fun
the_d2expenv_localjoin
(
  pfenv1: d2expenv_push_v
, pfenv2: d2expenv_push_v
| (*none*)
) = () where {
  prval unit_v () = pfenv1
  prval unit_v () = pfenv2
  prval vbox pf = pf0
  val () = symenv_localjoin (!p0)
} // end of [the_d2expenv_localjoin]

(* ****** ****** *)

viewdef
d2expenv_save_v = unit_v
fun the_d2expenv_save () = let
  prval pfsave = unit_v ()
  prval vbox pf = pf0
  val () = symenv_savecur (!p0)
in
  (pfsave | ())
end // end of [the_d2expenv_save]

fun the_d2expenv_restore (
  pfsave: d2expenv_save_v | (*none*)
) : d2itmmap = let
  prval vbox pf = pf0
  prval unit_v () = pfsave
in
  symenv_restore (!p0)
end // end of [the_d2expenv_restore]

(* ****** ****** *)

implement
the_d2expenv_pervasive_joinwth0 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth0 (!p0, map)
end // end of [the_d2expenv_pervasive_joinwth0]
implement
the_d2expenv_pervasive_joinwth1 (map) = let
  prval vbox pf = pf0 in symenv_pervasive_joinwth1 (!p0, map)
end // end of [the_d2expenv_pervasive_joinwth1]

end // end of [local]

(* ****** ****** *)

implement
the_d2expenv_find_qua
  (q, id) = let
(*
val () =
print (
  "the_d2expenv_find_qua: qid = "
) (* val *)
val () =
($SYN.print_s0taq(q); $SYM.print_symbol(id))
val () = print_newline ((*void*))
*)
in
//
case+
q.d0ynq_node
of // case+
| $SYN.D0YNQnone _ =>
    the_d2expenv_find(id)
  // end of [D0YNQnone]
| $SYN.D0YNQsymdot(sym) => let
    val ans =
      the_s2expenv_find(sym)
    // end of [val]
  in
    case+ ans of
    | ~Some_vt(s2i) =>
      (
      case+ s2i of
      | S2ITMfilenv
        (
          fenv
        ) => ans where
        {
          val (
            pf, fpf | p_map
          ) = filenv_get_d2itmmap(fenv)
          val ans = symmap_search(!p_map, id)
          prval () = minus_addback(fpf, pf | fenv)
        } (* end of [S2ITMfil] *)
      | _ (*rest-of-s2itm*) => let
          val () =
            prerr_error2_loc(q.d0ynq_loc)
          // end of [val]
          val () = prerr ": the qualifier ["
          val () = $SYM.prerr_symbol(sym)
          val () = prerr "] should refer to a filename but it does not."
          val () = prerr_newline((*void*))
        in
          None_vt ((*void*))
        end
      ) // end of [Some_vt]
    | ~None_vt((*void*)) => let
        val () =
          prerr_error2_loc(q.d0ynq_loc)
        // end of [val]
        val () = prerr ": the qualifier ["
        val () = $SYM.prerr_symbol(sym)
        val () = prerr "] is unrecognized."
        val () = prerr_newline((*void*))
      in
        None_vt ((*void*))
      end // end of [None_vt]
  end // end of [S2RTsymdot]
(*
//
// HX-2017-01-24:
// removed due to no use
//
| $SYN.D0YNQsymcolon _ => None_vt((*void*))
| $SYN.D0YNQsymdotcolon _ => None_vt((*void*))
*)
//
end // end of [the_s2expenv_find_qua]

(* ****** ****** *)

implement
the_d2expenv_add_dcon
  (d2c) = let
//
val id = d2con_get_sym d2c
val d2cs =
(
case+
  the_d2expenv_find (id) of
| ~Some_vt d2i => (
    case+ d2i of D2ITMcon d2cs => d2cs | _ => list_nil ()
  ) // end of [Some_vt]
| ~None_vt ((*void*)) => list_nil ()
) : d2conlst // end of [val]
val d2i = D2ITMcon (list_cons (d2c, d2cs))
//
in
  the_d2expenv_add (id, d2i)
end // end of [the_d2expenv_add_dcon]

(* ****** ****** *)

implement
the_d2expenv_add_dcst (d2c) = let
  val id = d2cst_get_sym (d2c) in the_d2expenv_add (id, D2ITMcst d2c)
end // end of [the_d2expenv_add_dcst]

(* ****** ****** *)

implement
the_d2expenv_add_dmacdef (d2m) = let
  val id = d2mac_get_sym (d2m) in the_d2expenv_add (id, D2ITMmacdef d2m)
end // end of [the_d2expenv_add_dmacdef]
implement
the_d2expenv_add_dmacvar (d2v) = let
  val id = d2var_get_sym (d2v) in the_d2expenv_add (id, D2ITMmacvar d2v)
end // end of [the_d2expenv_add_dmacvar]
implement
the_d2expenv_add_dmacvarlst
  (d2vs) = list_app_fun (d2vs, the_d2expenv_add_dmacvar)
// end of [the_d2expenv_add_dmacvarlst]

(* ****** ****** *)

implement
the_d2expenv_add_dvar (d2v) = let
  val id = d2var_get_sym (d2v) in the_d2expenv_add (id, D2ITMvar d2v)
end // end of [the_d2expenv_add_dvar]
implement
the_d2expenv_add_dvarlst
  (d2vs) = list_app_fun (d2vs, the_d2expenv_add_dvar)
// end of [the_d2expenv_add_dvarlst]
implement
the_d2expenv_add_dvaropt (opt) = (
  case+ opt of Some (d2v) => the_d2expenv_add_dvar (d2v) | None () => ()
) // end of [the_d2expenv_add_dvaropt]

(* ****** ****** *)

implement
the_d2expenv_add_fundeclst
  (knd, f2ds) = let
//
fun auxlst
(
  f2ds: f2undeclst
) : void = (
case+ f2ds of
| list_cons
    (f2d, f2ds) => let
    val () = the_d2expenv_add_dvar (f2d.f2undec_var)
  in
    auxlst (f2ds)
  end // end of [list_cons]
| list_nil ((*none*)) => ()
) (* end of [auxlist] *)
//
in
//
case+ f2ds of
| list_cons
    (f2d, f2ds) => let
    val () = the_d2expenv_add_dvar (f2d.f2undec_var)
  in
    if not(funkind_is_mutailrec(knd)) then auxlst (f2ds)
  end // end of [list_cons]
| list_nil ((*none*)) => ()
//
end // end of [the_d2expenv_add_fundeclst]

(* ****** ****** *)

local

val the_staload_level = ref<int> (0)

assume staload_level_push_v = unit_v

in (* in of [local] *)

implement
the_staload_level_get () = !the_staload_level

implement
the_staload_level_push
  () = (pf | ()) where {
  prval pf = unit_v ()
  val n = !the_staload_level
  val () = !the_staload_level := n+1
} // end of [the_staload_level_push]

implement
the_staload_level_pop
  (pf | (*none*)) = let
  prval unit_v () = pf
  val n = !the_staload_level
  val () = !the_staload_level := n-1
in
  // nothing
end // end of [the_staload_level_pop]

end // end of [local]

(* ****** ****** *)

local

val the_filenvmap =
  ref<symmap(filenv)> (symmap_make_nil ())
// end of [the_filenvmap]

in (* in of [local] *)

implement
the_filenvmap_add (fid, fenv) = let
  val (vbox pf | p) = ref_get_view_ptr (the_filenvmap)
in
  symmap_insert (!p, fid, fenv)
end // end of [the_filenvmap_add]

implement
the_filenvmap_find (fid) = let
  val (vbox pf | p) = ref_get_view_ptr (the_filenvmap)
in
  symmap_search (!p, fid)
end // end of [the_filenvmap_find]

end // end of [local]

(* ****** ****** *)

local

assume
trans2_env_push_v = @(
  s2rtenv_push_v, s2expenv_push_v, d2expenv_push_v
) (* end of [trans2_env_push_v] *)

in (* in of [local] *)

implement
the_trans2_env_pop
  (pfenv | (*none*)) = {
  val () = the_namespace_pop ()
  val () = the_s2rtenv_pop_free (pfenv.0 | (*none*))
  val () = the_s2expenv_pop_free (pfenv.1 | (*none*))
  val () = the_d2expenv_pop_free (pfenv.2 | (*none*))
} // end of [the_trans2_env_pop]

implement
the_trans2_env_push () = let
  val () = the_namespace_push ()
  val (pf0 | ()) = the_s2rtenv_push_nil ()
  val (pf1 | ()) = the_s2expenv_push_nil ()
  val (pf2 | ()) = the_d2expenv_push_nil ()
in
  ((pf0, pf1, pf2) | ())
end // end of [the_trans2_env_push]

implement
the_trans2_env_localjoin
  (pf1, pf2 | (*none*)) = {
  val () = the_namespace_localjoin ()
  val () = the_s2rtenv_localjoin (pf1.0, pf2.0 | (*none*))
  val () = the_s2expenv_localjoin (pf1.1, pf2.1 | (*none*))
  val () = the_d2expenv_localjoin (pf1.2, pf2.2 | (*none*))
} // end of [trans2_env_localjoin]

implement
the_trans2_env_pervasive_joinwth
  (pfenv | fil, d2cs) = {
  val m0 = the_s2rtenv_pop (pfenv.0 | (*none*))
  val () = the_s2rtenv_pervasive_joinwth1 (m0)
  val m1 = the_s2expenv_pop (pfenv.1 | (*none*))
  val () = the_s2expenv_pervasive_joinwth1 (m1)
  val m2 = the_d2expenv_pop (pfenv.2 | (*none*))
  val () = the_d2expenv_pervasive_joinwth1 (m2)
//
  val fsymb = $FIL.filename_get_fullname (fil)
  val fenv = filenv_make (fil, m0, m1, m2, d2cs)
  val ((*void*)) = the_filenvmap_add (fsymb, fenv)
//
} // end of [the_trans2_env_pervasive_joinwth1]

end // end of [local]

(* ****** ****** *)

local

assume
trans2_env_save_v = @(
  s2rtenv_save_v, s2expenv_save_v, d2expenv_save_v
) // end of [trans2_env_save_v]

in (* in of [local] *)

implement
the_trans2_env_save () = let
  val () = the_namespace_save ()
  val (pf0 | ()) = the_s2rtenv_save ()
  val (pf1 | ()) = the_s2expenv_save ()
  val (pf2 | ()) = the_d2expenv_save ()
  prval pfsave = (pf0, pf1, pf2)
in
  (pfsave | ())
end // end of [the_trans1_env_save]

implement
the_trans2_env_restore
  (pfsave | (*none*)) = let
  val () = the_namespace_restore ()
  val m0 = the_s2rtenv_restore (pfsave.0 | (*none*))
  val m1 = the_s2expenv_restore (pfsave.1 | (*none*))  
  val m2 = the_d2expenv_restore (pfsave.2 | (*none*))
in
  (m0, m1, m2)
end // end of [the_trans2_env_restore]

end // end of [local]

(* ****** ****** *)

local

fun
the_s2rtenv_initialize
(
// argless
) : void = {
//
  val (pfenv | ()) = the_s2rtenv_push_nil ()
//
// HX: pre-defined predicative sorts
//
  val () = the_s2rtenv_add ($SYM.symbol_INT, S2TEsrt s2rt_int)
  val () = the_s2rtenv_add ($SYM.symbol_ADDR, S2TEsrt s2rt_addr)
  val () = the_s2rtenv_add ($SYM.symbol_BOOL, S2TEsrt s2rt_bool)
//
(*
  val () = the_s2rtenv_add ($SYM.symbol_CHAR, S2TEsrt s2rt_char)
*)
//
  val () = the_s2rtenv_add ($SYM.symbol_REAL, S2TEsrt s2rt_real)
//
  val () = the_s2rtenv_add ($SYM.symbol_FLOAT, S2TEsrt s2rt_float)
  val () = the_s2rtenv_add ($SYM.symbol_STRING, S2TEsrt s2rt_string)
//
  val () = the_s2rtenv_add ($SYM.symbol_CLS, S2TEsrt s2rt_cls) // classes
//
  val () = the_s2rtenv_add ($SYM.symbol_EFF, S2TEsrt s2rt_eff) // effects
//
  val () = the_s2rtenv_add ($SYM.symbol_TKIND, S2TEsrt s2rt_tkind)
//
// HX: pre-defined impredicative sorts
//
  val () = the_s2rtenv_add ($SYM.symbol_PROP, S2TEsrt s2rt_prop)
//
  val () = the_s2rtenv_add ($SYM.symbol_TYPE, S2TEsrt s2rt_type)
  val () = the_s2rtenv_add ($SYM.symbol_T0YPE, S2TEsrt s2rt_t0ype)
//
  val () = the_s2rtenv_add ($SYM.symbol_VIEW, S2TEsrt s2rt_view)
//
  val () = the_s2rtenv_add ($SYM.symbol_VTYPE, S2TEsrt s2rt_vtype)
  val () = the_s2rtenv_add ($SYM.symbol_VT0YPE, S2TEsrt s2rt_vt0ype)
//
  val () = the_s2rtenv_add ($SYM.symbol_VIEWTYPE, S2TEsrt s2rt_vtype)
  val () = the_s2rtenv_add ($SYM.symbol_VIEWT0YPE, S2TEsrt s2rt_vt0ype)
//
  val () = the_s2rtenv_add ($SYM.symbol_TYPES, S2TEsrt s2rt_types)
//
  val map = the_s2rtenv_pop (pfenv | (*none*))
  val ((*void*)) = the_s2rtenv_pervasive_joinwth0 (map)
//
} (* end of [trans2_env_initialize] *)

fun
the_s2rtenv_reinitialize(): void = the_s2rtenv_top_clear ()

(* ****** ****** *)
//
fun 
the_s2expenv_initialize (): void = ()
fun
the_s2expenv_reinitialize(): void = the_s2expenv_top_clear()
//
(* ****** ****** *)
//
fun 
the_d2expenv_initialize (): void = {
(*
// HX-2013-02:
// in prelude/basics_pre.sats: symintr []
//
val (pfenv | ()) = the_d2expenv_push_nil ()
//
val () = let
  val sym = $SYM.symbol_LRBRACKETS in
  the_d2expenv_add (sym, D2ITMsymdef (sym, list_nil))
end // end of [val]
//
val map = the_d2expenv_pop (pfenv | (*none*))
//
val () = the_d2expenv_pervasive_joinwth0 (map)
//
*)
//
} (* end of [the_d2expenv_initialize] *)
//
fun
the_d2expenv_reinitialize(): void = the_d2expenv_top_clear()
//
(* ****** ****** *)

val the_trans2_env_flag = ref<int> (0)

(* ****** ****** *)

in (* in of [local] *)

implement
the_trans2_env_initialize
(
// argumentless
) = let
//
val n = !the_trans2_env_flag
val () = !the_trans2_env_flag := n+1
//
in
//
if
n = 0
then {
  val () = the_s2rtenv_initialize ()
  val () = the_s2expenv_initialize ()
  val () = the_d2expenv_initialize ()
} else {
  val () = the_s2rtenv_reinitialize ()
  val () = the_s2expenv_reinitialize ()
  val () = the_d2expenv_reinitialize ()
} (* end of [if] *)
//
end // end of [the_trans2_env_initialize]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans2_env.dats] *)
