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

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_funsel"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

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
fun loop (
  d2as: d2exparglst, s2e: s2exp, npf: int, d2es: d2explst
) : bool = let
  val s2e = s2exp_hnfize (s2e)
in
  case+ s2e.s2exp_node of
  | S2Efun (
      _(*fc*), _(*lin*), _(*eff*), npf1, s2es_arg, s2e_res
    ) =>
      if (npf = npf1) then let
        val sgn = list_length_compare (d2es, s2es_arg) in
        if sgn = 0 then aritest_d2exparglst_s2exp (d2as, s2e_res) else false
      end else false
    // end of [S2Efun]
  | S2Eexi (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Euni (_(*s2vs*), _(*s2ps*), s2e) => loop (d2as, s2e, npf, d2es)
  | S2Emetfn (_(*stamp*), _(*met*), s2e) => loop (d2as, s2e, npf, d2es)
  | _ => false // end of [_]
end // end of [loop]
//
in // in of [local]

implement
aritest_d2exparglst_s2exp
  (d2as, s2e) = case+ d2as of
  | list_cons (d2a, d2as) => (
    case+ d2a of
    | D2EXPARGdyn (
        npf, _(*loc*), d2es
      ) => loop (d2as, s2e, npf, d2es)
    | D2EXPARGsta _ =>
        aritest_d2exparglst_s2exp (d2as, s2e)
    ) // end of [list_cons]
  | list_nil () => true
// end of [aritest_d2exparglst_s2exp]

end // end of [local]

(* ****** ****** *)

fun d2exp_trup_item (
  loc0: location, d2i: d2itm
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
| D2ITMcst d2c => d2exp_trup_cst (loc0, d2c)
| D2ITMvar d2v => d2exp_trup_var (loc0, d2v)
| _ => let
    val () = prerr_error3_loc (loc0)
    val () = filprerr_ifdebug "d2exp_trup_item"
    val () = prerr ": a dynamic constant or variable is expected."
    val () = prerr_newline ()
    val () =  the_trans3errlst_add (T3E_d2exp_trup_item (loc0, d2i))
  in
    d3exp_err (loc0)
  end // end of [_]
//
end // end of [d2exp_trup_item]

(* ****** ****** *)

datatype
d3itm = D3ITM of (int, d3exp)
typedef d3itmlst = List (d3itm)
viewtypedef d3itmlst_vt = List_vt (d3itm)

fun d3itm_get_dexp
  (d3i: d3itm): d3exp = let
  val D3ITM (pval, d3e) = d3i in d3e
end // end of [d3itm_get_dexp]

fun d3itm_get_type
  (d3i: d3itm): s2exp = let
  val D3ITM (pval, d3e) = d3i in d3e.d3exp_type
end // end of [d3itm_get_type]

fun d3itm_get_pval
  (d3i: d3itm): int = let
  val D3ITM (pval, d3e) = d3i in pval
end // end of [d3itm_get_pval]

fun d3itm_make
  (pval: int, d3e: d3exp): d3itm = D3ITM (pval, d3e)
// end of [d3itm_make]

(* ****** ****** *)

datatype
d3exparg = 
  | D3EXPARGdyn of
      (int(*npf*), location(*arg*), d3explst)
  | D3EXPARGsta of s2exparglst
typedef d3exparglst = List d3exparg
viewtypedef d3exparglst_vt = List_vt d3exparg

(* ****** ****** *)

extern
fun d3exp_trup_applst (
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
| list_cons (d3a, d3as) => (
  case+ d3a of
  | D3EXPARGsta s2as => let
      var err: int = 0
      val s2e_fun = d3e_fun.d3exp_type
      val s2e_fun =
        s2exp_uni_instantiate_sexparglst (s2e_fun, s2as, err)
      // end of [val]
      val d3e_fun = d3exp_app_sta (loc0, s2e_fun, d3e_fun)
    in
      d3exp_trup_applst (d2e0, d3e_fun, d3as)
    end // end of [D3EXPARGsta]
  | D3EXPARGdyn
      (npf, locarg, d3es_arg) => let
(*
      val () = d3explst_open_and_add d3es_arg
*)
      val s2e_fun = d3e_fun.d3exp_type
      var err: int = 0
      val s2e_fun = s2exp_uni_instantiate_all (s2e_fun, locarg, err)
      // HX: [err] is not used
      val d3e_fun = d3exp_app_sta (loc0, s2e_fun, d3e_fun)
    in
      case+ s2e_fun.s2exp_node of
      | S2Efun (
          fc, _(*lin*), s2fe_fun, _(*npf*), s2es_arg, s2e_res
        ) => let
          val d3es_arg =
            d3explst_trdn_arg (d3es_arg, s2es_arg)
          // end of [val]
          val d3e_fun =
            d3exp_app_dyn (loc0, s2e_res, s2fe_fun, d3e_fun, npf, d3es_arg)
          // end of [val]
        in
          d3exp_trup_applst (d2e0, d3e_fun, d3as)
        end // end of [S2Efun]
      | _ => let
          val () = prerr_interror_loc (loc0)
          val () = prerr ": d3exp_trup_applst"
          val () = prerr ": a function type is expected: s2e_fun = "
          val () = prerr_s2exp (s2e_fun)
          val () = prerr_newline ()
          val () = assertloc (false)
        in
          exit {d3exp} (1)
        end // end of [_]
    end // end of [D3EXPARGdyn]
  ) // end of [list_cons]
| list_nil () => d3e_fun // end of [list_nil]
//
end // end of [d3exp_trup_applst]

(* ****** ****** *)

local

fun auxsel_arity (
  locsym: location
, d2is: d2itmlst, d2iss: List_vt (d2itmlst)
, d2as: d2exparglst
) : d3itmlst_vt = let
in
//
case+ d2is of
| list_cons (d2i, d2is) => (
  case+ d2i of
  | D2ITMsymdef
      (_(*sym*), d2is_new) => let
      val d2iss = list_vt_cons (d2is, d2iss)
    in
      auxsel_arity (locsym, d2is_new, d2iss, d2as)
    end // end of [D2ITMsymdef]
  | _ => let
      val d3e = d2exp_trup_item (locsym, d2i)
      val test = aritest_d2exparglst_s2exp (d2as, d3e.d3exp_type)
      val d3is = auxsel_arity (locsym, d2is, d2iss, d2as)
    in
      if test then let
        val pval = 0
        val d3i = d3itm_make (pval, d3e)
      in
        list_vt_cons (d3i, d3is)
      end else d3is // end of [if]
    end // end of [_]
  ) // end of [list_cons]
| list_nil () => (
  case+ d2iss of
  | ~list_vt_cons (d2is, d2iss) => auxsel_arity (locsym, d2is, d2iss, d2as)
  | ~list_vt_nil () => list_vt_nil ()
  ) // end of [list_nil]
//
end // end of [auxsel_arity]

fun auxsel_skexplst (
  xs: List_vt @(d3itm, s2kexp), s2kes: s2kexplst
) : List_vt @(d3itm, s2kexp) = let
  val () = (
    print "auxsel_skexplst: s2kes = ";
    fprint_s2kexplst (stdout_ref, s2kes); print_newline ()
  ) // end of [val]
in
//
case+ xs of
| ~list_vt_cons (x, xs) => (
  case+ x.1 of
  | S2KEfun
      (s2kes_arg, s2ke_res) => let
//
      val () = (
        print "auxsel_skexplst: s2kes_arg = ";
        fprint_s2kexplst (stdout_ref, s2kes_arg); print_newline ()
      ) // end of [val]
//
      val ismat =
        s2kexplst_ismat (s2kes, s2kes_arg)
      // end of [val]
//
      val () = (
        print "auxsel_skexplst: ismat = "; print ismat; print_newline ()
      )  // end of [val]
//
      val y = (x.0, s2ke_res)
      val ys = auxsel_skexplst (xs, s2kes)
    in
      if ismat then list_vt_cons (y, ys) else ys
    end // end of [list_vt_cons]
  | _ => auxsel_skexplst (xs, s2kes)
  ) // end of [list_vt_cons]
| ~list_vt_nil () => list_vt_nil ()
//
end // end of [auxsel_skexplst]

fun auxsel_arglst (
  xs: List_vt @(d3itm, s2kexp)
, d2as: d2exparglst, d3as: d3exparglst_vt
) : (
  d3itmlst, d3exparglst, d2exparglst
) = let
//
typedef T = (d3itm, s2kexp)
//
fun auxmap
  (xs: List_vt (T)) : d3itmlst =
  case+ xs of
  | ~list_vt_cons (x, xs) => list_cons (x.0, auxmap xs)
  | ~list_vt_nil () => list_nil ()
// end of [auxmap]
in
//
case+ d2as of
| list_cons _ => (
  case+ xs of
  | list_vt_cons (x, !p_xs1) => (
    case+ !p_xs1 of
    | ~list_vt_nil () => let
        val () = free@ {T}{0} (xs)
        val d3as = list_vt_reverse (d3as)
      in
        (list_sing (x.0), (l2l)d3as, d2as)
      end
    | _ => let
        val () = fold@ (xs)
        val+ list_cons (d2a, d2as) = d2as
      in
        case+ d2a of
        | D2EXPARGdyn
            (npf, locarg, d2es) => let
            val d3es = d2explst_trup (d2es)
            val s2kes = list_map_fun<d3exp><s2kexp>
              (d3es, lam d3e =<1> s2kexp_make_s2exp (d3e.d3exp_type))
            val xs = auxsel_skexplst (xs, $UN.castvwtp1 {s2kexplst} (s2kes))
            val () = list_vt_free (s2kes)
            val d3as = list_vt_cons (D3EXPARGdyn (npf, locarg, d3es), d3as)
          in
            auxsel_arglst (xs, d2as, d3as)
          end
        | D2EXPARGsta (s2as) => let
            val d3as = list_vt_cons (D3EXPARGsta (s2as), d3as)
          in
            auxsel_arglst (xs, d2as, d3as)
          end
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
  (xs: d3itmlst): d3itmlst = let
  fun loop
    (xs: d3itmlst, mpval: int): int =
    case+ xs of
    | list_cons (x, xs) => let
        val pval = d3itm_get_pval (x)
      in
        loop (xs, max_int_int (mpval, pval))
      end
    | list_nil () => mpval
  // end of [loop]
  val mpval = loop (xs, ITMPVALMIN)
  val xs = list_filter_cloptr<d3itm>
    (xs, lam (x) =<1> d3itm_get_pval (x) = mpval)
  // end of [val]
in
  (l2l)xs
end // end of [auxselmax]

in // in of [local]

implement
d2exp_trup_applst_sym
  (d2e0, d2s, d2as) = let
  val loc0 = d2e0.d2exp_loc
  val locsym = d2s.d2sym_loc
  val d2is = d2s.d2sym_itmlst
  val d3is = auxsel_arity (locsym, d2is, list_vt_nil, d2as)
  val xs = let
    fun f (d3i: d3itm): (d3itm, s2kexp) = let
      val s2e = d3itm_get_type (d3i) in (d3i, s2kexp_make_s2exp s2e)
    end // end of [f]
  in
    list_map_fun ($UN.castvwtp1 {d3itmlst} (d3is), f)
  end
  val () = list_vt_free (d3is)
  val xyz = auxsel_arglst (xs, d2as, list_vt_nil)
  val d3is = xyz.0
  val d3is = auxselmax (d3is)
in
//
case+ d3is of
| list_cons (
    d3i, list_nil ()
  ) => let
    val d3e_fun = d3itm_get_dexp (d3i)
    val d3e_fun = d3exp_trup_applst (d2e0, d3e_fun, xyz.1)
  in
    d23exp_trup_applst (d2e0, d3e_fun, xyz.2)
  end // end of [list_sing]
| list_cons (
    d3i, list_cons _
  ) => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the symbol [";
    val () = fprint_d2sym (stderr_ref, d2s)
    val () = prerr "] cannot be resolved due to too many matches."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (
      T3E_d2exp_trup_applst_sym_cons2 (d2e0, d2s)
    ) // end of [val]
  in
    d3exp_err (loc0)
  end // end of [list_cons2]
| list_nil () => let
    val () = prerr_error3_loc (loc0)
    val () = prerr ": the symbol [";
    val () = fprint_d2sym (stderr_ref, d2s)
    val () = prerr "] cannot be resolved as no match is found."
    val () = prerr_newline ()
    val () = the_trans3errlst_add
      (T3E_d2exp_trup_applst_sym_nil (d2e0, d2s))
    // end of [val]
  in
    d3exp_err (loc0)
  end // end of [list_nil]
//
end // end of [d2exp_trup_applst_sym]
//
end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_funsel.dats] *)
