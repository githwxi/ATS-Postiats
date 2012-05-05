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
// Start Time: March, 2012
//
(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"
staload _(*anon*) = "prelude/DATS/reference.dats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env_dvar"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

local

dataviewtype
ld2vsetlst = // local dynamic variables
  | LD2VSset of
      (d2varset_vt, ld2vsetlst) // local dynamic variable set
  | LD2VSlam of
      (int(*lin*), d2varlst_vt, ld2vsetlst) // marker for lambdas
  | LD2VSnil of ()
// end of [ld2vsetlst]

extern
fun the_d2varenv_push (): (d2varenv_push_v | void)

assume d2varenv_push_v = unit_v

val the_ld2vs =
  ref<d2varset_vt> (d2varset_vt_nil ())
// end of [val]

val the_ld2vss = ref<ld2vsetlst> (LD2VSnil ())

in // in of [local]

implement
the_d2varenv_get_top () = let
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  d2varset_vt_listize (!p)
end // end of [the_d2varenv_get_top]

implement
the_d2varenv_get_llamd2vs () = let
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
  case+ !pp of
  | LD2VSlam (lin, !p_d2vs, _) => let
      val d2vs = !p_d2vs; val () = !p_d2vs := list_vt_nil
    in
      fold@ (!pp); d2vs
    end // end of [LD2VSlam]
  | LD2VSset _ => (fold@ (!pp); list_vt_nil)
  | LD2VSnil _ => (fold@ (!pp); list_vt_nil)
end // end of [the_d2varenv_get_llamd2vs]

implement
the_d2varenv_add
  (d2v) = let
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  !p := d2varset_vt_add (!p, d2v)
end // end of [the_d2varenv_add]

implement
the_d2varenv_addlst
  (d2vs) = let
  fun loop {n:nat} .<n>. (
    set: d2varset_vt, d2vs: list (d2var, n)
  ) :<> d2varset_vt =
    case+ d2vs of
    | list_cons (d2v, d2vs) => let
        val set = d2varset_vt_add (set, d2v) in loop (set, d2vs)
      end // end of [list_cons]
    | list_nil () => set
  // end of [loop]
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  !p := loop (!p, d2vs)
end // end of [the_d2varenv_addlst]

(* ****** ****** *)

implement
the_d2varenv_pop
   (pfpush | (*none*)) = let
   fun loop (
     ld2vss: ld2vsetlst
   ) : ld2vsetlst =
     case+ ld2vss of
     | ~LD2VSset (d2vs, ld2vss) => let
         val () = d2varset_vt_free (d2vs) in ld2vss
       end // end of [LD2VSset]
     | ~LD2VSlam (lin, d2vs, ld2vss) => let
         val () = list_vt_free (d2vs) in loop (ld2vss)
       end // end of [LD2VSlam]
     | ~LD2VSnil () => LD2VSnil ()
   // end of [loop]
   prval unit_v () = pfpush
   val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
   !pp := $effmask_ref (loop (!pp))
end // end of [the_d2varenv_pop]

(* ****** ****** *)

implement
the_d2varenv_push () = let
  val d2vs = d2vs where {
    val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
    val d2vs = !p
    val () = !p := d2varset_vt_nil ()
  } // end of [val]
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
  val () = !pp := LD2VSset (d2vs, !pp)
in
  (unit_v () | ())
end // end of [the_d2varenv_push]

implement
the_d2varenv_push_lam (lin) = let
  val (pfpush | ()) = the_d2varenv_push ()
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
  val () = !pp := LD2VSlam (lin, list_vt_nil, !pp)
in
  (pfpush | ())
end // end of [the_d2varenv_push_lam]

implement
the_d2varenv_push_let () = the_d2varenv_push ()

(* ****** ****** *)

implement
the_d2varenv_d2var_is_llamlocal
  (d2v0) = let // [d2v0] is linear
//
fun loop (
  ld2vss: !ld2vsetlst, d2v0: d2var
) : bool = (
  case+ ld2vss of
  | LD2VSlam (
      lin, !p_d2vs, !p_ld2vss
    ) => (
    case+ 0 of
    | _ when lin > 0 => let
        val () = !p_d2vs :=
          list_vt_cons (d2v0, !p_d2vs)
        // end of [val]
        val ans = loop (!p_ld2vss, d2v0)
      in
        fold@ (ld2vss); ans
      end // end of [llam]
    | _ => (fold@ (ld2vss); false)
    ) // end of [LD2VSlam]
  | LD2VSset (!p_d2vs, !p_ld2vss) => let
      val ans =
        d2varset_vt_is_member (!p_d2vs, d2v0)
      val ans = (
        if ans then true else loop (!p_ld2vss, d2v0)
      ) // end of [val]
    in
      fold@ (ld2vss); ans
    end // end of [LD2VSset]
  | LD2VSnil () => (fold@ (ld2vss); false)
) (* end of [loop] *)
//
val ans = let
  val (vbox pf | p) = ref_get_view_ptr (the_ld2vs)
in
  d2varset_vt_is_member (!p, d2v0)
end // end of [val]
//
in
//
if ans then true else let
  val (vbox pf | pp) = ref_get_view_ptr (the_ld2vss)
in
  $effmask_ref (loop (!pp, d2v0))
end // end of [if]
//
end // end of [the_d2varenv_d2var_is_llamlocal]

end // end of [local]

(* ****** ****** *)

fun // for mutable vars
the_d2varenv_add_d2vw_if
  (p2t: p2at): void = let
//
val () = (
  print "the_d2varenv_add_d2vw_if: p2t = "; print_p2at (p2t); print_newline ()
) (* end of [val] *)
//
in
  case+ p2t.p2at_node of
  | P2Tvar (
      knd, d2v
    ) when d2var_is_mutable (d2v) => let
      val- Some (d2vw) = d2var_get_view (d2v)
    in
      the_d2varenv_add (d2vw)
    end // end of [P2Tvar]
  | P2Tann (p2t, _) => the_d2varenv_add_d2vw_if (p2t)
  | _ => () // end of [val]
end // end of [the_d2varenv_add_d2var_view]

implement
the_d2varenv_add_p2at
  (p2t) = let
  val () = the_d2varenv_add_d2vw_if (p2t)
in
  the_d2varenv_addlst ($UT.lstord2list (p2t.p2at_dvs))
end // end of [the_d2varenv_add_p2at]

implement
the_d2varenv_add_p2atlst
  (p2ts) = list_app_fun (p2ts, the_d2varenv_add_p2at)
// end of [the_d2varenv_add_p2atlst]

(* ****** ****** *)

extern fun d2vfin_check
  (loc0: location, d2v: d2var): void
// end of [d2vfin_check]

local

fun d2vfin_check_some (
  loc0: location
, d2v: d2var, s2e: s2exp
) : void = let
//
fun auxerr1 (
  loc0: location
, d2v: d2var, s2e1: s2exp, s2e2: s2exp
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is preserved but with an incompatible type."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
  val () =  the_trans3errlst_add (T3E_d2var_fin_some_some (loc0, d2v))
} (* end of [auxerr1] *)
fun auxerr2 (
  loc0: location, d2v: d2var, s2e: s2exp
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] needs to be consumed but it is preserved with the type ["
  val () = prerr_s2exp (s2e)
  val () = prerr "] instead."
  val () = prerr_newline ()
  val () = the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
} (* end of [auxerr2] *)
//
val d2vfin = d2var_get_finknd (d2v)
//
val () = (
  print "d2vfin_check_some: d2vfin = "; print_d2vfin (d2vfin); print_newline ()
) (* end of [val] *)
//
in
//
case+ d2vfin of
| D2VFINsome (s2e_fin) => let
    val (pfpush | ()) = trans3_env_push ()
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e, s2e_fin)
    val () = if err > 0 then auxerr1 (loc0, d2v, s2e, s2e_fin)
    val knd = C3NSTRKINDsome_fin (d2v, s2e_fin, s2e)
    val () = trans3_env_pop_and_add (pfpush | loc0, knd)
  in
    d2var_set_type (d2v, Some s2e_fin)
  end // end of [D2VFINsome]
| D2VFINvbox (s2e_box) => let
    val (pfpush | ()) = trans3_env_push ()
    val err = $SOL.s2exp_tyleq_solve (loc0, s2e, s2e_box)
    val () = if err > 0 then auxerr1 (loc0, d2v, s2e, s2e_box)
    val knd = C3NSTRKINDsome_box (d2v, s2e_box, s2e)
    val () = trans3_env_pop_and_add (pfpush | loc0, knd)
  in
    d2var_set_type (d2v, Some s2e_box)
  end // end of [D2VFINvbox]
| D2VFINdone () => () // HX: handled by [funarg_d2vfin_check]
| D2VFINnone () => let
    val islin = s2exp_is_lin (s2e)
    val () = if islin then auxerr2 (loc0, d2v, s2e)
    val linval = d2var_get_linval (d2v)
  in
    if linval >= 0 then d2var_set_type (d2v, None ())
  end // end of [D2VFINnone]
// end of [case]
//
end // end of [d2vfin_check_some]

fun d2vfin_check_none (
  loc0: location, d2v: d2var
) : void = let
//
fun auxerr (
  loc0: location, d2v: d2var
) : void = {
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] needs to be preserved but it is consumed instead."
  val () = prerr_newline ()
} (* end of [auxerr] *)
//
val d2vfin = d2var_get_finknd (d2v)
//
in
//
case+ d2vfin of
| D2VFINnone () => ()
| D2VFINdone () => () // HX: handled by [funarg_d2vfin_check]
| D2VFINsome _ => let
    val () = auxerr (loc0, d2v)
  in
    the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
  end // end of [D2VFINsome]
| D2VFINvbox _ => let
    val () = auxerr (loc0, d2v)
  in
    the_trans3errlst_add (T3E_d2var_fin_none_some (loc0, d2v))
  end // end of [D2VFINvbox]
//
end // end of [d2vfin_check_none]

in // in of [local]

implement
d2vfin_check (loc0, d2v) = let
//
val () = (
  print "d2vfin_check: d2v = "; print_d2var (d2v); print_newline ()
) // end of [val]
//
val opt = d2var_get_type (d2v)
//
in
//
case+ opt of
| Some (s2e) => let
    val () = (
      print "d2vfin_check: s2e = "; print_s2exp (s2e); print_newline ()
    ) // end of [val]
  in
    d2vfin_check_some (loc0, d2v, s2e)
  end // end of [Some]
| None () => d2vfin_check_none (loc0, d2v)
//
end // end of [d2vfin_check]

implement
the_d2varenv_check (loc0) = let
(*
val () = (
  print "the_d2varenv_check"; print_newline ()
) // end of [val]
*)
fun loop (
  loc0: location, d2vs: d2varlst_vt
) : void =
  case+ d2vs of
  | ~list_vt_cons (d2v, d2vs) => let
      val () = d2vfin_check (loc0, d2v) in loop (loc0, d2vs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
(* end of [loop] *)
//
in
  loop (loc0, the_d2varenv_get_top ())
end // end of [the_d2varenv_check]

implement
the_d2varenv_check_llam
  (loc0) = let
//
fun aux (
  loc0: location, d2v: d2var
) : void = let
  val opt = d2var_get_type (d2v)
in
  case+ opt of
  | Some (s2e) => let
      val islin = s2exp_is_lin (s2e)
    in
      if islin then let
        val () = prerr_error3_loc (loc0)
        val () = prerr ": the linear dynamic variable ["
        val () = prerr_d2var (d2v)
        val () = prerr "] needs to be consumed but it is preserved with the type ["
        val () = prerr_s2exp (s2e)
        val () = prerr "] instead."
        val () = prerr_newline ()
        val () = assertloc (false)
      in
        exit (1)
      end else
        d2var_set_type (d2v, None ())
      // end of [if]
    end // end of [Some]
  | None () => ()
end // end of [aux]
fun auxlst (
  loc0: location, d2vs: d2varlst_vt
) : void =
  case+ d2vs of
  | ~list_vt_cons
      (d2v, d2vs) => let
      val () = aux (loc0, d2v)
      val () = auxlst (loc0, d2vs)
    in
      // nothing
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
// end of [auxlst]
in
  auxlst (loc0, the_d2varenv_get_llamd2vs ())
end // end of [the_d2varenv_check_llam]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
funarg_d2vfin_check (loc0) = let
//
val () = (
  print "funarg_d2vfin_check: enter"; print_newline ()
) // end of [val]
//
fun auxvar
  (loc0: location, d2v: d2var): void = let
(*
  val () = begin
    print "funarg_varfin_check: auxvar: d2v (bef) = "; print_d2var d2v; print_newline ()
  end // end of [val]
*)
  val d2v = let
    val opt = d2var_get_view (d2v) in
    case+ opt of Some (d2v) => d2v | None () => d2v
  end : d2var // end of [val]
(*
  val () = begin
    print "funarg_varfin_check: auxvar: d2v (aft) = "; print_d2var d2v; print_newline ()
  end // end of [val]
*)
  val () = d2vfin_check (loc0, d2v)
in
  d2var_set_finknd (d2v, D2VFINdone ()) // HX: indicating that [d2vfin_check] should skip it
end // end of [auxvar]
//
fun auxpatlst (
  loc0: location, p3ts: p3atlst
) : void = let
in
//
case+ p3ts of
| list_cons
    (p3t, p3ts) => let
    val () = (
      case+ p3t.p3at_node of
      | P3Tvar (_(*knd*), d2v) => auxvar (loc0, d2v)
      | _ => ()
    ) : void // end of [val]
  in
    auxpatlst (loc0, p3ts)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxpatlst]
//
val opt = the_lamlpenv_get_funarg ()
//
in
//
case+ opt of
| ~Some_vt p3ts => auxpatlst (loc0, p3ts)
| ~None_vt () => let
    val () = prerr_interror_loc (loc0)
    val () = prerr ": funarg_varfin_check: there is no funarg."
    val () = prerr_newline ()
  in
    assertloc (false)
  end // end of [None_vt]
end (* end of [funarg_varfin_check] *)

(* ****** ****** *)

implement
s2exp_wth_instantiate (loc0, s2e0) = let
// (*
val () = begin
  print "s2exp_wth_instantiate: s2e0 = "; print_s2exp s2e0; print_newline ()
end // end of [val]
// *)
fun aux .<>. (
  loc0: location
, refknd: int, p3t: p3at, s2e: s2exp
) : void = let
  val d2v = (
    case+ p3t.p3at_node of
    | P3Tvar
        (_(*refknd*), d2v) => d2v
    | P3Tas
        (_(*refknd*), d2v, _) => d2v
    | _ => let
        val () = prerr_interror_loc (loc0)
        val () = prerr ": s2exp_wth_instantiate"
        val () = prerr ": aux: the pattern is expected to be a variable."
        val () = prerr_newline ()
        val () = assertloc (false)
      in
        $ERR.abort {d2var} ()
      end // end of [_]
  ) : d2var // end of [val]
//
in
//
case+ 0 of
| _ when refknd = 0 =>
    d2var_set_finknd (d2v, D2VFINsome s2e)
| _ (* refknd = 1 *) => let
    val- Some (d2v_view) = d2var_get_view (d2v)
    val- Some (s2e_addr) = d2var_get_addr (d2v)
    val s2e_at = s2exp_at (s2e, s2e_addr)
  in
    d2var_set_finknd (d2v_view, D2VFINsome (s2e_at))
  end // end of [_]
//
end // end of [aux]
//
fun auxlst (
  loc0: location
, p3ts: p3atlst, wths2es: wths2explst
) : void = let
in
//
case+ wths2es of
| WTHS2EXPLSTcons_trans
    (refknd, s2e, wths2es) => let
    val- list_cons (p3t, p3ts) = p3ts
    val () = aux (loc0, refknd, p3t, s2e)
  in
    auxlst (loc0, p3ts, wths2es)     
  end // end of [WTHS2EXPLSTcons_some]
| WTHS2EXPLSTcons_invar
    (wths2es) => let // HX: already handled
    val- list_cons (p3t, p3ts) = p3ts
  in
    auxlst (loc0, p3ts, wths2es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTcons_none
    (wths2es) => let
    val- list_cons (p3t, p3ts) = p3ts
  in
    auxlst (loc0, p3ts, wths2es)
  end // end of [WTHS2EXPLSTcons_none]
| WTHS2EXPLSTnil () => ()
end // end of [auxlst]
//
var err: int = 0
val (s2e, s2ps) =
  s2exp_exi_instantiate_all (s2e0, loc0, err)
val () = trans3_env_add_proplst_vt (loc0, s2ps)
//
in
//
case+ s2e0.s2exp_node of
| S2Ewth
    (s2e, wths2es) => s2e where {
    val- ~Some_vt (p3ts) = opt where {
      val opt = the_lamlpenv_get_funarg ()
    } // end of [val]
    val () = auxlst (loc0, p3ts, wths2es)
  } // end of [S2Ewth]
| _ => s2e0 // end of [_]
//
end // end of [s2exp_wth_instantiate]

(* ****** ****** *)

(* end of [pats_trans3_env_dvar.dats] *)
