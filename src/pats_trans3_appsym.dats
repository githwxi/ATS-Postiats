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
// Start Time: November, 2011
//
(* ****** ****** *)
//
staload
ATSPRE =
"./pats_atspre.dats"
//
(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_appsym"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern
fun aritest_d2exparglst_s2exp
  (d2as: d2exparglst, s2e: s2exp): bool
(*
** HX: for handling dynamic overloading
*)
local
//
fun loop
(
  d2as: d2exparglst
, s2e: s2exp, npf: int, d2es: d2explst
) : bool = let
  val s2e = s2exp_hnfize (s2e)
in
  case+ s2e.s2exp_node of
  | S2Efun
    (
      _(*fc*), _(*lin*), _(*eff*), npf1, s2es_arg, s2e_res
    ) =>
      if (npf = npf1) then let
        val sgn =
          list_length_compare (d2es, s2es_arg) in
        // end of [val]
        if sgn = 0
          then aritest_d2exparglst_s2exp (d2as, s2e_res) else false
        // end of [if]
      end else false // end of [if]
    // end of [S2Efun]
  | S2Eexi (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Euni (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Emetfun (_(*opt*), _(*met*), s2e) => loop (d2as, s2e, npf, d2es)
  | _ => false // end of [_]
end // end of [loop]
//
in // in of [local]

implement
aritest_d2exparglst_s2exp
  (d2as, s2e) = let
in
  case+ d2as of
  | list_cons
      (d2a, d2as) => (
    case+ d2a of
    | D2EXPARGdyn (
        npf, _(*loc*), d2es
      ) => loop (d2as, s2e, npf, d2es)
    | D2EXPARGsta _ =>
        aritest_d2exparglst_s2exp (d2as, s2e)
    ) // end of [list_cons]
  | list_nil ((*void*)) => true
end // end of [aritest_d2exparglst_s2exp]

end // end of [local]

(* ****** ****** *)

fun
d2exp_trup_item
(
  loc0: loc_t, d2i: d2itm, t2mas: t2mpmarglst
) : d3exp = let
(*
  val () = (
    print "d2exp_trup_item: d2i = ";
    fprint_d2itm (stdout_ref, d2i); print_newline ()
  ) // end [val]
*)
in
//
case+ d2i of
| D2ITMcst d2c => let
    val s2qs =
      d2cst_get_decarg (d2c)
    // end of [val]
    val s2e = d2cst_get_type (d2c)
    val s2e = s2exp_unis (s2qs, s2e)
  in
    d3exp_item (loc0, s2e, d2i, t2mas)
  end
| D2ITMvar d2v => let
    val s2qs = d2var_get_decarg (d2v)
    val-Some (s2e) = d2var_get_type (d2v)
    val s2e = s2exp_unis (s2qs, s2e)
  in
    d3exp_item (loc0, s2e, d2i, t2mas)
  end
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "d2exp_trup_item"
    val () = prerr ": a dynamic constant or variable is expected."
    val () = prerr_newline ()
    val () =  the_trans3errlst_add (T3E_d2exp_trup_item (loc0, d2i))
  in
    d3exp_errexp (loc0)
  end // end of [_]
//
end // end of [d2exp_trup_item]

(* ****** ****** *)

fun d3exp_trup_item
  (d3e0: d3exp): d3exp = let
//
val loc0 = d3e0.d3exp_loc
val-D3Eitem (d2i, t2mas) = d3e0.d3exp_node
val isnil = list_is_nil (t2mas)
//
in
//
case+ d2i of
| D2ITMcst d2c => (
    if isnil then
      d2exp_trup_cst (loc0, d2c)
    else
      d2exp_trup_tmpcst (loc0, d2c, t2mas)
    // end of [if]
  ) // end of [D2ITMcst]
| D2ITMvar d2v => (
    if isnil then
      d2exp_trup_var (loc0, d2v)
    else
      d2exp_trup_tmpvar (loc0, d2v, t2mas)
    // end of [if]
  ) // end of [D2ITMvar]
| _ => let
    val () = assertloc (false) in d3exp_errexp (loc0)
  end // end of [_]
//
end // end of [d3exp_trup_item]

(* ****** ****** *)

datatype
d3pitm = D3PITM of (int, d3exp)
typedef d3pitmlst = List (d3pitm)
viewtypedef d3pitmlst_vt = List_vt (d3pitm)

fun d3pitm_get_dexp
  (d3pi: d3pitm): d3exp = let
  val D3PITM (pval, d3e) = d3pi in d3e
end // end of [d3pitm_get_dexp]

fun d3pitm_get_type
  (d3pi: d3pitm): s2exp = let
  val D3PITM (pval, d3e) = d3pi in d3e.d3exp_type
end // end of [d3pitm_get_type]

fun d3pitm_get_pval
  (d3pi: d3pitm): int = let
  val D3PITM (pval, d3e) = d3pi in pval
end // end of [d3pitm_get_pval]

fun d3pitm_make
  (pval: int, d3e: d3exp): d3pitm = D3PITM (pval, d3e)
// end of [d3pitm_make]

fun fprint_d3pitm (
  out: FILEref, x: d3pitm
) : void = let
  val D3PITM (pval, d3e) = x
  val-D3Eitem
    (d2i, t2mas) = d3e.d3exp_node
  val () = fprint_d2itm (out, d2i)
  val () = fprint_string (out, " of ")
  val () = fprint_int (out, pval)
in
  // nothing
end // end of [fprint_d3pitm]

(* ****** ****** *)

datatype
d3exparg = 
  | D3EXPARGsta of (loc_t(*arg*), s2exparglst)
  | D3EXPARGdyn of // HX: notice the argument list [d3es]
      (int(*npf*), loc_t(*arg*), d3explst) // are not opened
    // end of [D3EXPARGdyn]
typedef d3exparglst = List d3exparg
viewtypedef d3exparglst_vt = List_vt d3exparg

(* ****** ****** *)

extern
fun
d3exp_trup_applst
(
  d2e0: d2exp, d3e_fun: d3exp, d3as: d3exparglst
) : d3exp // end of [d3exp_trup_applst]
implement
d3exp_trup_applst
  (d2e0, d3e_fun, d3as) = let
(*
  val () = (
    print "d3exp_trup_applst: ..."; print_newline ()
  ) // end of [val]
*)
  val loc0 = d2e0.d2exp_loc
in
//
case+ d3as of
//
| list_cons (d3a, d3as) => (
  case+ d3a of
  | D3EXPARGsta
      (locarg, s2as) => let
      val loc_fun = d3e_fun.d3exp_loc
      val s2e_fun = d3e_fun.d3exp_type
      var err: int = 0
      val (s2e_fun, s2ps) =
        s2exp_uni_instantiate_sexparglst (s2e_fun, s2as, err)
      // end of [val]
      val () = trans3_env_add_proplst_vt (loc_fun, s2ps)
      val d3e_fun = d3exp_app_sta (loc0, s2e_fun, d3e_fun)
    in
      d3exp_trup_applst (d2e0, d3e_fun, d3as)
    end // end of [D3EXPARGsta]
  | D3EXPARGdyn
      (npf, locarg, d3es_arg) => let
      val loc_fun = d3e_fun.d3exp_loc
      val s2e_fun = d3e_fun.d3exp_type
      val () = d3explst_open_and_add (d3es_arg)
      var err: int = 0
      val (s2e_fun, s2ps) =
        s2exp_unimet_instantiate_all (s2e_fun, locarg, err)
      // HX: [err] is not used
      val () = trans3_env_add_proplst_vt (loc_fun, s2ps)
      val d3e_fun = d3exp_app_unista (loc0, s2e_fun, d3e_fun)
      val-S2Efun (
        fc, _(*lin*), s2fe_fun, _(*npf*), s2es_fun_arg, s2e_fun_res
      ) = s2e_fun.s2exp_node // end of[val]
//
      val loc_app = $LOC.location_combine (loc_fun, locarg)
      val s2es_fun_arg = 
        s2fun_opninv_and_add (locarg, s2es_fun_arg, s2e_fun_res)
      val d3es_arg = d3explst_trdn_arg (d3es_arg, s2es_fun_arg)
//
      val (
        iswth, s2e_res, wths2es
      ) = un_s2exp_wthtype (loc_app, s2e_fun_res)
//
      val d3e_fun = d3exp_fun_restore (fc, d3e_fun)
      val d3es_arg =
      (
        if iswth
          then d3explst_arg_restore (d3es_arg, s2es_fun_arg, wths2es)
          else d3es_arg
        // end of [if]
      ) : d3explst // end of [val]
//
      val err = the_effenv_check_s2eff (loc_app, s2fe_fun)
      val (
      ) = if (err > 0) then (
        the_trans3errlst_add (T3E_d3exp_trup_applst_eff (loc_app, s2fe_fun))
      ) // end of [if] // end of [val]
//
      val d3e_fun = d3exp_app_dyn (loc0, s2e_res, d3e_fun, npf, d3es_arg)
    in
      d3exp_trup_applst (d2e0, d3e_fun, d3as)
    end // end of [D3EXPARGdyn]
  ) (* end of [list_cons] *)
//
| list_nil ((*void*)) => d3e_fun // end of [list_nil]
//
end // end of [d3exp_trup_applst]

(* ****** ****** *)

local

fun auxsel_arity
(
  locsym: loc_t
, d2pis: d2pitmlst
, d2piss: List_vt (d2pitmlst)
, t2mas: t2mpmarglst
, d2args: d2exparglst
) : d3pitmlst_vt = let
in
//
case+ d2pis of
| list_cons
    (d2pi, d2pis) => let
    val D2PITM (pval, d2i) = d2pi
  in
    case+ d2i of
    | D2ITMsymdef
        (_(*sym*), d2pis_new) => let
        val d2piss = list_vt_cons (d2pis, d2piss)
      in
        auxsel_arity (locsym, d2pis_new, d2piss, t2mas, d2args)
      end // end of [D2ITMsymdef]
    | _ => let
        val d3e = d2exp_trup_item (locsym, d2i, t2mas)
        val test = aritest_d2exparglst_s2exp (d2args, d3e.d3exp_type)
        val d3pis = auxsel_arity (locsym, d2pis, d2piss, t2mas, d2args)
      in
        if test then let
          val d3pi = d3pitm_make (pval, d3e) in list_vt_cons (d3pi, d3pis)
        end else d3pis // end of [if]
      end // end of [_]
  end // end of [list_cons]
| list_nil () => (
  case+ d2piss of
  | ~list_vt_cons (d2pis, d2piss) =>
      auxsel_arity (locsym, d2pis, d2piss, t2mas, d2args)
  | ~list_vt_nil () => list_vt_nil ()
  ) // end of [list_nil]
//
end // end of [auxsel_arity]

fun auxsel_skexplst
(
  xs: List_vt @(d3pitm, s2kexp), s2kes: s2kexplst
) : List_vt @(d3pitm, s2kexp) = let
(*
val () =
(
  print "auxsel_skexplst: s2kes = ";
  fprint_s2kexplst (stdout_ref, s2kes); print_newline ()
) // end of [val]
*)
in
//
case+ xs of
| ~list_vt_nil() =>
    list_vt_nil((*void*))
  // list_vt_nil
| ~list_vt_cons(x, xs) =>
  (
  case+ x.1 of
  | S2KEfun
    (
      s2kes_arg, s2ke_res
    ) => let
(*
//
      val
      out = stdout_ref
//
      val () =
      (
        print "auxsel_skexplst: s2kes_arg = ";
        fprint_s2kexplst(out, s2kes_arg); print_newline()
      ) (* end of [val] *)
*)
      val ismat =
        s2kexplst_ismat (s2kes, s2kes_arg)
      // end of [val]
(*
      val () = println! ("auxsel_skexplst: ismat = ", ismat)
*)
      val y = (x.0, s2ke_res)
      val ys = auxsel_skexplst (xs, s2kes)
    in
      if ismat then list_vt_cons (y, ys) else ys
    end // end of [list_vt_cons]
  | _ (*non-S2KEfun*) => auxsel_skexplst (xs, s2kes)
  ) (* end of [list_vt_cons] *)
//
end // end of [auxsel_skexplst]

fun
auxsel_arglst
(
  xs: List_vt @(d3pitm, s2kexp)
, d2as: d2exparglst, d3as: d3exparglst_vt
) :
( d3pitmlst
, d3exparglst
, d2exparglst ) = let
//
typedef T = (d3pitm, s2kexp)
//
fun
auxmap
(
xs: List_vt(T)
) : d3pitmlst =
(
  case+ xs of
  | ~list_vt_nil() => list_nil()
  | ~list_vt_cons(x, xs) => list_cons(x.0, auxmap(xs))
) (* end of [auxmap] *)
//
in
//
case+ d2as of
| list_cons _ => (
  case+ xs of
  | list_vt_cons
      (x, !p_xs1) => (
    case+ !p_xs1 of
    | ~list_vt_nil () => let
        val () = free@ {T}{0} (xs)
        val d3as = list_vt_reverse (d3as)
      in
        (list_sing (x.0), (l2l)d3as, d2as)
      end
    | _ => let
        val () = fold@ (xs)
        val+list_cons (d2a, d2as) = d2as
      in
        case+ d2a of
        | D2EXPARGsta
            (locarg, s2as) => let
            val d3a = D3EXPARGsta (locarg, s2as)
          in
            auxsel_arglst (xs, d2as, list_vt_cons (d3a, d3as))
          end (* D2EXPARGsta *)
        | D2EXPARGdyn
            (npf, locarg, d2es) => let
            val d3es = d2explst_trup (d2es)
            val s2kes = list_map_fun<d3exp><s2kexp>
              (d3es, lam d3e =<1> s2kexp_make_s2exp (d3e.d3exp_type))
            val xs = auxsel_skexplst (xs, $UN.castvwtp1 {s2kexplst} (s2kes))
            val () = list_vt_free (s2kes)
            val d3a = D3EXPARGdyn (npf, locarg, d3es)
          in
            auxsel_arglst (xs, d2as, list_vt_cons (d3a, d3as))
          end (* D2EXPARGdyn *)
      end // end of [_]
    ) // end of [list_vt_cons]
  | ~list_vt_nil () => let
      val d3as =
        list_vt_reverse (d3as)
      // end of [val]
    in
      (list_nil (), (l2l)d3as, d2as)
    end // end of [list_vt_nil]
  ) // end of [list_cons]
| list_nil () => let
    val d3as = list_vt_reverse (d3as) in (auxmap (xs), (l2l)d3as, d2as)
  end // end of [list_nil]
//
end // end of [auxsel_arglst]

#define ITMPVALMIN ~1000000

fun auxselmax
  (xs: d3pitmlst): d3pitmlst = let
  fun loop
    (xs: d3pitmlst, mpval: int): int =
    case+ xs of
    | list_cons (x, xs) => let
        val pval = d3pitm_get_pval (x)
      in
        loop (xs, max_int_int (mpval, pval))
      end
    | list_nil () => mpval
  // end of [loop]
  val mpval = loop (xs, ITMPVALMIN)
  val xs = list_filter_cloptr<d3pitm>
    (xs, lam (x) =<1> d3pitm_get_pval (x) = mpval)
  // end of [val]
in
  (l2l)xs
end // end of [auxselmax]

in (* in of [local] *)

implement
d2exp_trup_applst_sym
  (d2e0, d2s, d2as) = let
//
val t2mas = list_nil(*void*)
//
in
  d2exp_trup_applst_tmpsym(d2e0, d2s, t2mas, d2as)
end // end of [d2exp_trup_applst_sym]

implement
d2exp_trup_applst_tmpsym
  (d2e0, d2s, t2mas, d2as) = let
(*
val () =
(
  print "d2exp_trup_applst_sym: d2s = ";
  fprint_d2sym (stdout_ref, d2s); print_newline ();
  print "d2exp_trup_applst_sym: d2as = ";
  fprint_d2exparglst (stdout_ref, d2as); print_newline ();
) (* end of [val] *)
*)
val loc0 = d2e0.d2exp_loc
val locsym = d2s.d2sym_loc
val d2pis = d2s.d2sym_pitmlst
val d3pis =
  auxsel_arity (locsym, d2pis, list_vt_nil, t2mas, d2as)
val xs = let
  fun f (d3pi: d3pitm): (d3pitm, s2kexp) = let
    val s2e = d3pitm_get_type (d3pi) in (d3pi, s2kexp_make_s2exp s2e)
  end // end of [f]
in
  list_map_fun ($UN.castvwtp1 {d3pitmlst} (d3pis), f)
end // end of [val]
val () = list_vt_free (d3pis)
val xyz = auxsel_arglst (xs, d2as, list_vt_nil)
val d3pis = xyz.0
val d3pis = auxselmax (d3pis)
//
in
//
case+ d3pis of
//
| list_cons
  (
    d3pi, list_nil()
  ) => let
    val d3e_fun = d3pitm_get_dexp (d3pi)
    val d3e_fun = d3exp_trup_item (d3e_fun)
    val d3e_fun = d3exp_trup_applst (d2e0, d3e_fun, xyz.1)
  in
    d23exp_trup_applst (d2e0, d3e_fun, xyz.2)
  end // end of [list_sing]
//
| list_cons
  (
    d3pi1, list_cons(d3pi2, _)
  ) => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the symbol [";
    val () = fprint_d2sym (stderr_ref, d2s)
    val () = prerr "] cannot be resolved due to too many matches:\n"
    val () = fprint_d3pitm (stderr_ref, d3pi1)
    val () = prerr_newline ()
    val () = fprint_d3pitm (stderr_ref, d3pi2)
    val () = prerr_newline ()
    val () =
      the_trans3errlst_add (T3E_d2exp_trup_applst_sym_cons2 (d2e0, d2s))
    // end of [val]
  in
    d3exp_errexp (loc0)
  end // end of [list_cons2]
//
| list_nil((*void*)) => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the symbol [";
    val () = fprint_d2sym (stderr_ref, d2s)
    val () = prerr "] cannot be resolved as no match is found."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_d2exp_trup_applst_sym_nil (d2e0, d2s))
  in
    d3exp_errexp (loc0)
  end // end of [list_nil]
//
end // end of [d2exp_trup_applst_tmpsym]
//
end // end of [local]

(* ****** ****** *)

local

fun
auxins
(
  npf: int
, d2e_rt: d2exp, d2es: d2explst
) : d2explst =
(
if npf > 0
  then let
    val-list_cons (d2e, d2es) = d2es
  in
    list_cons (d2e, auxins (npf-1, d2e_rt, d2es))
  end // end of [then]
  else list_cons (d2e_rt, d2es)
// end of [if]
)

fun
auxins2
(
  d2e0: d2exp
, d2e_rt: d2exp, d2as: d2exparglst
) : d2exparglst =
(
case+ d2as of
//
| list_nil () => let
    val d2a =
      D2EXPARGdyn (~1(*npf*), d2e0.d2exp_loc, list_sing(d2e_rt))
    // end of [val]
  in
    list_sing (d2a)
  end // end of [list_nil]
//
| list_cons (d2a, d2as) =>
  (
    case+ d2a of
    | D2EXPARGsta _ =>
        list_cons (d2a, auxins2 (d2e0, d2e_rt, d2as))
    | D2EXPARGdyn (npf, loc_arg, d2es) => let
        val d2a =
          D2EXPARGdyn (npf, loc_arg, auxins (npf, d2e_rt, d2es))
        // end of [val]
      in
        list_cons (d2a, d2as)
      end // end of [D2EXPARGdyn]
  ) (* end of [list_cons] *)  
//
) (* end of [auxins2] *)

in (* in-of-local *)

implement
d2exp_trup_applst_seloverld
  (d2e0, _fun, d2s, _arg) = let
//
val d2e_rt =
  d2exp_get_seloverld_root (_fun)
val d2as_arg = auxins2 (d2e0, d2e_rt, _arg)
//
in
  d2exp_trup_applst_sym (d2e0, d2s, d2as_arg)
end // end of [d2exp_trup_applst_seloverld]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_funsel.dats] *)
