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
// Start Time: November, 2011
//
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
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_up"

(* ****** ****** *)

staload LAB = "pats_label.sats"
staload LOC = "pats_location.sats"
macdef print_location = $LOC.print_location
macdef prerr_location = $LOC.prerr_location

staload SYN = "pats_syntax.sats"

(* ****** ****** *)

(*
** for T_* constructors
*)
staload "pats_lexing.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_error.sats"
staload "pats_staexp2_util.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload "pats_dynexp2_util.sats"
staload "pats_dynexp3.sats"

(* ****** ****** *)

staload SOL = "pats_staexp2_solve.sats"

(* ****** ****** *)

staload "pats_trans3.sats"
staload "pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern fun d2exp_trup_con (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_tmpid (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_arg_body (
  loc0: location
, fc0: funclo, lin: int, npf: int, p2ts: p2atlst, d2e: d2exp
) : (s2exp, p3atlst, d3exp)

(* ****** ****** *)

extern fun d2exp_trup_lam_dyn (d2e0: d2exp): d3exp
extern fun d2exp_trup_laminit_dyn (d2e0: d2exp): d3exp
extern fun d2exp_trup_lam_sta (d2e0: d2exp): d3exp
extern fun d2exp_trup_lam_met (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_lst (d2e0: d2exp): d3exp
extern fun d2exp_trup_tup (d2e0: d2exp): d3exp
extern fun d2exp_trup_rec (d2e0: d2exp): d3exp
extern fun d2exp_trup_seq (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_letwhere
  (d2e0: d2exp, d2cs: d2eclist, d2e: d2exp): d3exp
// end of [d2exp_trup_letwhere]

(* ****** ****** *)

implement
d2exp_trup
  (d2e0) = let
// (*
val () = (
  print "d2exp_trup: d2e0 = "; print_d2exp d2e0; print_newline ()
) // end of [val]
// *)
val loc0 = d2e0.d2exp_loc
val d3e0 = (
case+ d2e0.d2exp_node of
//
| D2Evar (d2v) => d2exp_trup_var (loc0, d2v)
| D2Ecst (d2c) => d2exp_trup_cst (loc0, d2c)
//
| D2Eint (i(*int*)) => d2exp_trup_int (d2e0, i)
| D2Ebool (b(*bool*)) => d2exp_trup_bool (d2e0, b)
| D2Echar (c(*char*)) => d2exp_trup_char (d2e0, c)
//
| D2Ei0nt (tok) => d2exp_trup_i0nt (d2e0, tok)
| D2Ec0har (tok) => let
    val- T_CHAR (c) = tok.token_node
  in
    d2exp_trup_char (d2e0, c) // by default: char1 (c)
  end // end of [D2Ec0har]
| D2Es0tring (tok) => let
    val- T_STRING (str) = tok.token_node
  in
    d2exp_trup_string (d2e0, str) // by default: string1 (len)
  end // end of [D2Es0tring]
| D2Ef0loat (tok) => d2exp_trup_f0loat (d2e0, tok)
//
| D2Ecstsp (csp) => d2exp_trup_cstsp (d2e0, csp)
//
| D2Eempty () => let
    val s2e = s2exp_void_t0ype () in d3exp_empty (loc0, s2e)
  end // end of [D2Eempty]
| D2Eextval (s2e, rep) => d3exp_extval (loc0, s2e, rep)
//
| D2Econ _ => d2exp_trup_con (d2e0)
//
| D2Etmpid _ => d2exp_trup_tmpid (d2e0)
//
| D2Elet (d2cs, d2e) => d2exp_trup_letwhere (d2e0, d2cs, d2e)
| D2Ewhere (d2e, d2cs) => d2exp_trup_letwhere (d2e0, d2cs, d2e)
//
| D2Eapplst (_fun, _arg) => let
(*
    val () = (
      print "d2exp_trup: D2Eapplst"; print_newline ()
    ) // end of [val]
*)
  in
    case+ _fun.d2exp_node of
    | D2Esym d2s =>
        d2exp_trup_applst_sym (d2e0, d2s, _arg)
      // end of [D2Esym]
    | _ => d2exp_trup_applst (d2e0, _fun, _arg)
  end // end of [D2Eapplst]
//
| D2Eifhead (_, _, _, _else) => let
    val s2e_if = (
      case+ _else of
      | Some _ => s2exp_Var_make_srt (loc0, s2rt_t0ype)
      | None _ => s2exp_void_t0ype () // HX: missing else-branch
    ) : s2exp // end of [val]
    val s2f_if = s2exp2hnf_cast (s2e_if)
  in
    d2exp_trdn_ifhead (d2e0, s2f_if)
  end // end of [D2Eifhead]
| D2Esifhead _ => let
    val s2e_sif = s2exp_Var_make_srt (loc0, s2rt_t0ype)
    val s2f_sif = s2exp2hnf_cast (s2e_sif)
  in
    d2exp_trdn_sifhead (d2e0, s2f_sif)
  end // end of [D2Esifhead]
//
| D2Ecasehead _ => let
    val s2e_case = s2exp_Var_make_srt (loc0, s2rt_t0ype)
    val s2f_case = s2exp2hnf_cast (s2e_case)
  in
    d2exp_trdn_casehead (d2e0, s2f_case)
  end // end of [D2Ecasehead]
//
| D2Elst _ => d2exp_trup_lst (d2e0)
| D2Etup _ => d2exp_trup_tup (d2e0)
| D2Erec _ => d2exp_trup_rec (d2e0)
| D2Eseq _ => d2exp_trup_seq (d2e0)
//
| D2Earrinit
    (s2e_elt, opt, d2es) => let
    var s2i_asz : s2exp
    val d3e_asz : d3exp = (
      case+ opt of
      | Some (d2e_asz) => let
          val () =
            s2i_asz := s2exp_err (s2rt_int)
          // end of [val]
        in
          d2exp_trup (d2e_asz)
        end // end of [Some]
      | None () => let
          val n = list_length (d2es)
          val () = s2i_asz := s2exp_int (n)
          val s2e_asz = s2exp_int_index_t0ype (s2i_asz)
        in
          d3exp_int (loc0, s2e_asz, n)
        end // end of [None]
    ) // end of [val]
    val d3es = d2explst_trdn_elt (d2es, s2e_elt)
    val s2es_dim = list_sing (s2i_asz)
    val s2e_arr = s2exp_tyarr (s2e_elt, s2es_dim)
  in
    d3exp_arrinit (loc0, s2e_arr, s2e_elt, d3e_asz, d3es)
  end // end of [D2Earrinit]
| D2Earrsize (opt, d2es) => let
    val s2e = (
      case+ opt of
      | Some s2e => s2e | None () => let
          val s2t = s2rt_t0ype in s2exp_Var_make_srt (loc0, s2t)
        end // end of [None]
    ) : s2exp // end of [val]
    val d3es = d2explst_trdn_elt (d2es, s2e)
    val n = list_length (d2es)
    val s2e_arrsz =
      s2exp_arrsz_viewt0ype_int_viewt0ype (s2e, n)
    // end of [val]
  in
    d3exp_arrsize (loc0, s2e_arrsz, d3es, n)
  end // end of [D2Earrsize]
//
| D2Elam_dyn _ => d2exp_trup_lam_dyn (d2e0)
| D2Elaminit_dyn _ => d2exp_trup_laminit_dyn (d2e0)
| D2Elam_sta _ => d2exp_trup_lam_sta (d2e0)
| D2Elam_met _ => d2exp_trup_lam_met (d2e0)
//
| D2Eloopexn (knd) => d2exp_trup_loopexn (d2e0, knd)
//
| D2Eann_type (d2e, s2e_ann) => let
    val d3e = d2exp_trdn (d2e, s2e_ann)
  in
    d3exp_ann_type (loc0, d3e, s2e_ann)
  end // end of [D2Eann_type]
//
| _ => let
    val () = (
      print "d2exp_trup: loc0 = ";
      print_location (loc0); print_newline ();
      print "d2exp_trup: d2e0 = "; print_d2exp d2e0; print_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1)
  end // end of [_]
//
) : d3exp // end of [val]
// (*
val s2e0 = d3e0.d3exp_type
val () = (
  print "d2exp_trup: d3e0.d3exp_type = "; pprint_s2exp (s2e0); print_newline ()
) // end of [val]
// *)
in
//
d3e0 // the return value
//
end // end of [d2exp_trup]

(* ****** ****** *)

implement
d2explst_trup
  (d2es) = l2l (list_map_fun (d2es, d2exp_trup))
// end of [d2explst_trup]

implement
d2explstlst_trup
  (d2ess) = l2l (list_map_fun (d2ess, d2explst_trup))
// end of [d2explstlst_trup]

(* ****** ****** *)

fun d2explst_trup_arg
  (d2es: d2explst): d23explst = let
(*
  val () = (
    print "d2explst_trup_arg"; print_newline ()
  ) // end of [val]
*)
in
  case+ d2es of
  | list_cons (d2e, d2es) => let
      val d23e = let
        val isval = d2exp_is_varlamcst (d2e)
(*
        val () = println! ("d2explst_trup_arg: isval = ", isval)
        val () = (
          print "d2explst_trup_arg: d2e = "; print_d2exp (d2e); print_newline ()
        ) // end of [val]
*)
      in
        if isval then D23Ed2exp d2e else let
          val d3e = d2exp_trup (d2e) in D23Ed3exp d3e
        end // end of [if]
      end : d23exp // end of [val]
      val d23es = d2explst_trup_arg (d2es)
    in
      list_vt_cons (d23e, d23es)
    end // end of [cons]
  | list_nil () => list_vt_nil ()
end // end of [d2explst_trup_arg]

fun
d23explst_open_and_add
  {n:nat} .<n>. (
  d23es: !list_vt (d23exp, n)
) : void = let
//
fn f (d23e: !d23exp): void =
  case+ d23e of
  | D23Ed2exp d2e => let
      prval () = fold@ (d23e) in (*nothing*)
    end // end of [D23Ed2exp]
  | D23Ed3exp d3e => let
      val () = d3exp_open_and_add (d3e) in fold@ (d23e)
    end // end of [D23Ed3exp]
(* end of [f] *)
//
in
  case+ d23es of
  | list_vt_cons
      (!p_d23e, !p_d23es) => let
      val () = f (!p_d23e)
      val () = d23explst_open_and_add (!p_d23es)
      prval () = fold@ (d23es)
    in
      // nothing
    end // end of [cons]
  | list_vt_nil () => let
      prval () = fold@ (d23es) in (*nothing*)
    end // end of [list_nil]
end // end of [d23explst_open_and_add]

(* ****** ****** *)

fun d23explst_trup
  (d23es: d23explst): d3explst =
  case+ d23es of
  | ~list_vt_cons (d23e, d23es) => let
      val d3e = (case+ d23e of
        | ~D23Ed2exp d2e => d2exp_trup (d2e) | ~D23Ed3exp d3e => d3e
      ) : d3exp // end of [val]
    in
      list_cons (d3e, d23explst_trup (d23es))
    end // end of [cons]
  | ~list_vt_nil () => list_nil ()
// end of [d23explst_trup]

(* ****** ****** *)

fn d23explst_trdn (
  locarg: location
, d23es: d23explst, s2es: s2explst
) : d3explst = let
//
fun aux (
  d23es: d23explst, s2es: s2explst, err: &int
) : d3explst = begin
  case+ d23es of
  | ~list_vt_cons (d23e, d23es) => (
    case+ s2es of
    | list_cons (s2e, s2es) => let
        val d3e = (case+ d23e of
          | ~D23Ed2exp (d2e) => d2exp_trdn (d2e, s2e)
          | ~D23Ed3exp (d3e) => d3exp_trdn (d3e, s2e)
        ) : d3exp // end of [val]
        val d3es = aux (d23es, s2es, err)
      in
        list_cons (d3e, d3es)
      end // end of [list_cons]
    | list_nil () => let
        val () = err := err + 1
        val () = d23exp_free (d23e)
        val () = d23explst_free (d23es)
      in
        list_nil ()
      end // end of [list_nil]
    ) // end of [list_vt_cons]
  | ~list_vt_nil () => (case+ s2es of
    | list_cons _ => let
        val () = err := err - 1 in list_nil ()
      end // end of [list_cons]
    | list_nil () => list_nil ()
    ) // end of [list_vt_nil]
end // end of [aux]
//
var serr: int = 0
val d3es = aux (d23es, s2es, serr)
val () = if (serr != 0) then let
  val () = prerr_error3_loc (locarg)
  val () = filprerr_ifdebug "d23explst_trdn"
  val () = prerr ": arity mismatch"
  val () = if serr > 0 then prerr ": less arguments are expected."
  val () = if serr < 0 then prerr ": more arguments are expected."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d23explst_trdn_arity (locarg, serr))
end // end of [val]
in
//
d3es (* return value *)
//
end // end of [d23explst_trdn]

(* ****** ****** *)

fn d2exp_trup_var_mutabl
  (loc0: location, d2v: d2var): d3exp = let
(*
  val () = {
    val () = print "d2exp_trup_var_mutabl: d2v = "
    val () = print_d2var (d2v)
    val () = print_newline ()
    val () = print "d2exp_trup_var_mutabl: d2varset = "
    val () = print_newline ()
  } // end of [val]
*)
  val () = assertloc (false)
in
  exit (1)
end // end of [d2exp_trup_var_mut]

fn d2exp_trup_var_nonmut
  (loc0: location, d2v: d2var): d3exp = let
//
val lin = d2var_get_linval (d2v)
(*
val () = (
  print "d2exp_trup_var_nonmut: d2v = "; print_d2var (d2v); print_newline ()
) // end of [val]
val () = println! ("d2exp_trup_var_nonmut: lin = ", lin)
*)
val s2qs = d2var_get_decarg (d2v)
val- Some (s2e) = d2var_get_type (d2v)
//
in
//
case+ s2qs of
| list_nil () => d3exp_var (loc0, s2e, d2v)
| list_cons _ => let
    val locsarg = $LOC.location_rightmost (loc0)
    var err: int = 0
    val (
      s2e_tmp, s2ess
    ) = s2exp_tmp_instantiate_rest (s2e, locsarg, s2qs, err)
  in
    d3exp_tmpvar (loc0, s2e_tmp, d2v, s2ess)
  end // end of [list_cons]
//
end // end of [d2exp_trup_var_nonmut]

implement
d2exp_trup_var
  (loc0, d2v) = let
in
  if d2var_is_mutable (d2v) then
    d2exp_trup_var_mutabl (loc0, d2v)
  else
    d2exp_trup_var_nonmut (loc0, d2v)
  // end of [if]
end // end of [d2exp_trup_var]

(* ****** ****** *)

implement
d2exp_trup_cst
  (loc0, d2c) = let
  val s2e = d2cst_get_type (d2c)
  val s2qs = d2cst_get_decarg (d2c)
in
//
case+ s2qs of
| list_cons _ => let
    val locsarg = $LOC.location_rightmost (loc0)
    var err: int = 0
    val (
      s2e_tmp, s2ess
    ) = s2exp_tmp_instantiate_rest (s2e, locsarg, s2qs, err)
  in
    d3exp_tmpcst (loc0, s2e_tmp, d2c, s2ess)
  end // end of [list_cons]
| list_nil () => d3exp_cst (loc0, s2e, d2c)
//
end // end of [d2cst_trup_cst]

(* ****** ****** *)

implement
d2exp_trup_con (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Econ (
    d2c, locfun, s2as, npf, locarg, d2es_arg
  ) = d2e0.d2exp_node
  val s2e_con = d2con_get_type (d2c)
//
  var err: int = 0
  val (s2e, s2ps) =
    s2exp_uni_instantiate_sexparglst (s2e_con, s2as, err)
  // HX: [err] is not used
  val () = trans3_env_add_proplst_vt (locfun, s2ps)
  val () = if (err > 0) then let
    val () = prerr_error3_loc (locfun)
    val () = filprerr_ifdebug "d2exp_trup_con"
    val () = prerr ": static application cannot be properly typechecked."
    val () = prerr_newline ()
  in
    the_trans3errlst_add (
      T3E_s2exp_uni_instantiate_sexparglst (locfun, s2e_con, s2as)
    ) // end of [the_trans3errlst_add]
  end // end of [val]
//
  val d23es_arg =
    d2explst_trup_arg (d2es_arg)
  // end of [val]
  val () = d23explst_open_and_add (d23es_arg)
//
  var err: int = 0
  val locsarg = $LOC.location_rightmost (locfun)
  val (s2e, s2ps) = s2exp_uni_instantiate_all (s2e, locsarg, err)
  // HX: [err] is not used
  val () = trans3_env_add_proplst_vt (locsarg, s2ps)
//
in
//
case+ s2e.s2exp_node of
| S2Efun (
    _fc, _lin, _s2fe, npf_con, s2es_arg, s2e_res
  ) => let
    val err = $SOL.pfarity_equal_solve (loc0, npf_con, npf)
    val () = if (err > 0) then let
      val () = prerr_error3_loc (loc0)
      val () = filprerr_ifdebug "d2exp_trup_con"
      val () = prerr ": proof arity mismatch: the constructor ["
      val () = prerr_d2con (d2c)
      val () = prerrf ("] requires [%i] arguments.", @(npf_con))
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_d2exp_trup_con_npf (d2e0, npf)) // nothing
    end // end of [val]
    val d3es_arg = d23explst_trdn (locarg, d23es_arg, s2es_arg)
  in
    d3exp_con (loc0, s2e_res, d2c, npf, d3es_arg)
  end // end of [S2Efun]
| _ => let
    val () = d23explst_free (d23es_arg) in d3exp_err (loc0)
  end // end of [_]
//
end // end [d2exp_trup_con]

(* ****** ****** *)

implement
d2exp_trup_tmpid (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val locarg = $LOC.location_rightmost (loc0)
  val- D2Etmpid (d2e_id, t2mas) = d2e0.d2exp_node
in
//
case+ d2e_id.d2exp_node of
| D2Ecst d2c => let
    val s2qs = d2cst_get_decarg (d2c)
    val s2e_d2c = d2cst_get_type (d2c)
    var err: int = 0
    val (s2e_tmp, t2mas) =
      s2exp_tmp_instantiate_tmpmarglst (s2e_d2c, locarg, s2qs, t2mas, err)
    // end of [val]
  in
    d3exp_tmpcst (loc0, s2e_tmp, d2c, t2mas)
  end // end of [D2Ecst]
| _ => let
    val () = (
      print "d2exp_trup_tmpid: d2e_id = "; print_d2exp d2e_id; print_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    exit (1)
  end // end of [_]
//
end // end of [d2exp_trup_tmpid]

(* ****** ****** *)

implement
d2exp_trup_applst
  (d2e0, d2e_fun, d2as_arg) = let
  val d3e_fun = d2exp_trup (d2e_fun)
  val () = d3exp_open_and_add (d3e_fun)
in
  d23exp_trup_applst (d2e0, d3e_fun, d2as_arg)
end // end of [d2exp_trup_applst]

(* ****** ****** *)

fun
d23exp_trup_applst_sta (
  d2e0: d2exp
, d3e_fun: d3exp, s2as: s2exparglst, d2as: d2exparglst
) : d3exp = let
(*
  val () = (
    print "d23exp_trup_applst_sta: d2e0 = "; print_d2exp d2e0; print_newline ()
  ) // end of [val]
*)
  val loc_fun = d3e_fun.d3exp_loc
  val s2e_fun = d3e_fun.d3exp_type
  val loc_app =
    aux (loc_fun, s2as) where {
    fun aux (
      loc: location, s2as: s2exparglst
    ) : location = case+ s2as of
      | list_cons _ => let
          val s2a = list_last<s2exparg> (s2as)
        in
          $LOC.location_combine (loc, s2a.s2exparg_loc)
        end // end of [list_cons]
      | list_nil () => loc
  } // end of [where] // end of [val]
//
  var err: int = 0
  val (s2e_fun, s2ps) =
    s2exp_uni_instantiate_sexparglst (s2e_fun, s2as, err)
  // end of [val]
  val () = trans3_env_add_proplst_vt (loc_app, s2ps)
  val () = if (err > 0) then let
    val () = prerr_error3_loc (loc_app)
    val () = filprerr_ifdebug "d2exp_trup_applst_sta"
    val () = prerr ": static application cannot be properly typechecked."
    val () = prerr_newline ()    
  in
    the_trans3errlst_add (
      T3E_s2exp_uni_instantiate_sexparglst (loc_app, s2e_fun, s2as)
    ) // end of [the_trans3errlst_add]
  end // end of [val]
//
  val d3e_fun = d3exp_app_sta (loc_app, s2e_fun, d3e_fun)
in
  d23exp_trup_applst (d2e0, d3e_fun, d2as)
end // end of [d2exp_trup_applst_sta]

(* ****** ****** *)

fun d23exp_trup_app23 (
  d2e0: d2exp
, d3e_fun: d3exp
, npf: int, locarg: location, d23es_arg: d23explst
) : d3exp = let
  val loc_fun = d3e_fun.d3exp_loc
  val s2e_fun = d3e_fun.d3exp_type
// (*
  val () = begin
    print "d23exp_trup_app23: s2e_fun = "; pprint_s2exp s2e_fun; print_newline ()
  end // end of [val]
// *)
//
  var err: int = 0
  val locsarg = $LOC.location_rightmost (loc_fun)
  val (s2e_fun, s2ps) = s2exp_unimet_instantiate_all (s2e_fun, locsarg, err)
  val () = trans3_env_add_proplst_vt (locarg, s2ps)
// (*
  val () = begin
    print "d23exp_trup_app23: s2e_fun = "; pprint_s2exp s2e_fun; print_newline ()
  end // end of [val]
// *)
  val d3e_fun = d3exp_app_sta (loc_fun, s2e_fun, d3e_fun)
  val loc_app = $LOC.location_combine (loc_fun, locarg)
in
//
case+ s2e_fun.s2exp_node of
| S2Efun (
    fc, _(*lin*), s2fe_fun, npf_fun, s2es_fun_arg, s2e_fun_res
  ) => let
(*
    val () = begin
      print "d23exp_trup_app: s2e_fun = "; print_s2exp s2e_fun; print_newline ();
      print "d23exp_trup_app: s2fe_fun = "; print_s2eff s2fe_fun; print_newline ();
      printf ("d23exp_trup_app23: npf = %i and npf_fun = %i", @(npf, npf_fun));
      print_newline ()
    end // end of [val]
*)
//
    val err =
      $SOL.pfarity_equal_solve (loc_fun, npf_fun, npf)
    // end of [val]
    val () = if (err > 0) then let
      val () = prerr_error3_loc (loc_fun)
      val () = filprerr_ifdebug "d23exp_trup_app23"
      val () = prerr ": proof arity mismatch"
      val () = prerrf (": the function requires %i proof arguments.", @(npf_fun))
      val () = prerr_newline ()
      val () = prerr_the_staerrlst ()
    in
      the_trans3errlst_add (T3E_d23exp_trup_app23_npf (loc_fun, npf))
    end // end of [val]
//
    val d3es_arg = d23explst_trdn (locarg, d23es_arg, s2es_fun_arg)
    var s2e_res: s2exp = s2e_fun_res
(*
    var wths2es
      : wths2explst = WTHS2EXPLSTnil ()
    // end of [var]
    val iswth = s2exp_is_wth (s2e_fun_res)
    val () = if iswth then let
      val s2e_fun_res =
        s2exp_opnexi_and_add (loc_app, s2e_fun_res)
      val- S2Ewth (s2e, wths2es1) = s2e_fun_res.s2exp_node
    in
      s2e_res := s2e; wths2es := wths2es1
    end : void // end of [val]
    val d3e_fun = d3exp_funclo_restore (fc, d3e_fun)
    val d3es_arg = (
      if iswth then d3explst_arg_restore (d3es_arg, wths2es) else d3es_arg
    ) : d3explst
*)
    val err =
      the_effenv_check_s2eff (loc_app, s2fe_fun)
    // end of [val]
    val () = if (err > 0) then let
(*
      val () = prerr_error3_loc (loc_app)
      val () = filprerr_ifdebug "d23exp_trup_app23"
      val () = prerr ": the application may incur disallowed effects."
      val () = prerr_newline ()
*)
    in
      the_trans3errlst_add (T3E_d23exp_trup_app23_eff (loc_app, s2fe_fun))
    end // end of [val]
  in
    d3exp_app_dyn (loc_app, s2e_res, s2fe_fun, d3e_fun, npf, d3es_arg)
  end // end of [S2Efun]
| _ => let
    val () = d23explst_free (d23es_arg)
    val () = prerr_error3_loc (loc_fun)
    val () = filprerr_ifdebug "d23exp_trup_app23"
    val () = prerr ": the applied dynamic expression is not of a function type."
    val () = prerr_newline ()
    val () = the_trans3errlst_add (T3E_d23exp_trup_app23_fun (loc_fun, s2e_fun))
  in
    d3exp_err (loc_fun)
  end // end of [_]
//
end // end of [d23exp_trup_app23]

fun d23exp_trup_applst_dyn (
  d2e0: d2exp
, d3e_fun: d3exp
, npf: int, locarg: location, d2es_arg: d2explst
, d2as: d2exparglst
) : d3exp = let
  val loc_fun = d3e_fun.d3exp_loc
  val loc_app = $LOC.location_combine (loc_fun, locarg)
  val s2e_fun = d3e_fun.d3exp_type
  val d23es_arg =
    d2explst_trup_arg (d2es_arg)
  // end of [val]
  val () = d23explst_open_and_add (d23es_arg)
in
//
case+ s2e_fun.s2exp_node of
| _ => let
    val d3e_fun = d23exp_trup_app23 (d2e0, d3e_fun, npf, locarg, d23es_arg)
  in
    d23exp_trup_applst (d2e0, d3e_fun, d2as)
  end // end of [_]
//
end // end of [d2exp_trup_applst_dyn]

implement
d23exp_trup_applst (
  d2e0: d2exp
, d3e_fun: d3exp, d2as: d2exparglst
) : d3exp = let
in
//
case+ d2as of
| list_cons (d2a, d2as) => (
  case+ d2a of
  | D2EXPARGsta (s2as) => begin
      d23exp_trup_applst_sta (d2e0, d3e_fun, s2as, d2as)
    end // end of [D2EXPARGsta]
  | D2EXPARGdyn (npf, locarg, d2es_arg) => begin
      d23exp_trup_applst_dyn (d2e0, d3e_fun, npf, locarg, d2es_arg, d2as)
    end // end of [D2EXPARGdyn]
  ) // end of [cons]
| list_nil () => d3e_fun
//
end // end of [d2exp_trup_applst]

(* ****** ****** *)

implement
d2exp_trup_arg_body (
  loc0
, fc0, lin, npf
, p2ts_arg, d2e_body
) = let
// (*
val FNAME = "d2exp_trup_arg_body"
val () = (
  printf ("%s: npf = ", @(FNAME));
  print_int (npf); print_newline ()
) // end of [val]
val () = (
  printf ("%s: arg = ", @(FNAME));
  print_p2atlst (p2ts_arg); print_newline ()
) // end of [val]
val () = (
  printf ("%s: body = ", @(FNAME));
  print_d2exp (d2e_body); print_newline ()
) // end of [val]
// *)
val (pfenv | ()) = trans3_env_push ()
//
var fc: funclo = fc0
val d2e_body = d2exp_funclo_of_d2exp (d2e_body, fc)
var s2fe: s2eff = s2eff_nil
val d2e_body = d2exp_s2eff_of_d2exp (d2e_body, s2fe)
//
val (pfeff | ()) =
  the_effenv_push_lam (s2fe)
// end of [val]
val s2es_arg = p2atlst_syn_type (p2ts_arg)
val p3ts_arg = p2atlst_trup_arg (npf, p2ts_arg)
val d3e_body = d2exp_trup (d2e_body)
//
val () = the_effenv_pop (pfeff | (*none*))
//
val () = trans3_env_pop_and_add_main (pfenv | loc0)
//
val s2e_res = d3e_body.d3exp_type
val isprf = s2exp_is_prf (s2e_res)
val islin = lin > 0
val s2t_fun = s2rt_prf_lin_fc (loc0, isprf, islin, fc)
val s2e_fun = s2exp_fun_srt (
  s2t_fun, fc, lin, s2fe, npf, s2es_arg, s2e_res
) // end of [val]
//
in
//
(s2e_fun, p3ts_arg, d3e_body)
//
end // end of [d2exp_trup_arg_body]

(* ****** ****** *)

implement
d2exp_trup_lam_dyn (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Elam_dyn (lin, npf, p2ts_arg, d2e_body) = d2e0.d2exp_node
  val fc0 = FUNCLOfun () // default
  val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
  val s2e_fun = s2ep3tsd3e.0
  val p3ts_arg = s2ep3tsd3e.1
  val d3e_body = s2ep3tsd3e.2
in
  d3exp_lam_dyn (loc0, s2e_fun, lin, npf, p3ts_arg, d3e_body)
end // end of [D2Elam_dyn]

implement
d2exp_trup_laminit_dyn (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Elaminit_dyn (lin, npf, p2ts_arg, d2e_body) = d2e0.d2exp_node
  val fc0 = FUNCLOclo (0) // default
  val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
  val s2e_fun = s2ep3tsd3e.0
  val p3ts_arg = s2ep3tsd3e.1
  val d3e_body = s2ep3tsd3e.2
  val () = (
    case+ s2e_fun.s2exp_node of
    | S2Efun (fc, _, _, _, _, _) => (case+ fc of
      | FUNCLOclo 0 => () // [CLO]
      | _ => let
         val () = prerr_error3_loc (loc0)
         val () = filprerr_ifdebug "d2exp_trup_laminit_dyn"
         val () = prerr ": the initializing value is expected to be a flat closure but it is not."
         val () = prerr_newline ()
       in
         the_trans3errlst_add (T3E_d2exp_trup_laminit_funclo (d2e0, fc))
       end // end of [_]
      ) // end of [S2Efun]
    | _ => () // HX: deadcode
  ) : void // end of [val]
in
  d3exp_laminit_dyn (loc0, s2e_fun, lin, npf, p3ts_arg, d3e_body)
end // end of [D2Elam_dyn]

(* ****** ****** *)

implement
d2exp_trup_lam_sta (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Elam_sta (s2vs, s2ps, d2e_body) = d2e0.d2exp_node
//
  val (pfenv | ()) = trans3_env_push ()
  val () = trans3_env_add_svarlst (s2vs)
  val () = trans3_env_hypadd_proplst (loc0, s2ps)
//
  val d3e_body = d2exp_trup (d2e_body)
//
  val () = trans3_env_pop_and_add_main (pfenv | loc0)
//
  val s2e = d3e_body.d3exp_type
  val s2e_uni = s2exp_uni (s2vs, s2ps, s2e)
in
  d3exp_lam_sta (loc0, s2e_uni, s2vs, s2ps, d3e_body)
end // end of [d2exp_trup_lam_sta]

(* ****** ****** *)

implement
d2exp_trup_lam_met (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Elam_met
    (d2vs_ref, s2es_met, d2e_body) = d2e0.d2exp_node
  // end of [val]
  val () = s2explst_check_termet (loc0, s2es_met)
  val (pfmet | ()) = termetenv_push_dvarlst (!d2vs_ref, s2es_met)
  val d3e_body = d2exp_trup (d2e_body)
  val () = termetenv_pop (pfmet | (*none*))
in
  d3exp_lam_met (loc0, s2es_met, d3e_body)
end // end of [D2Elam_met]

(* ****** ****** *)

implement
d2exp_trup_lst
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Elst (lin, opt, d2es) = d2e0.d2exp_node
// (*
val () = (print "d2exp_trup_lst: lin = "; print lin; print_newline ())
// *)
  val s2e_elt = (case+ opt of
    | Some s2e => s2e | None () => let
        val s2t = (
          if lin > 0 then s2rt_viewt0ype else s2rt_t0ype
        ) : s2rt // end of [val]
      in
        s2exp_Var_make_srt (loc0, s2t)
      end // end of [None]
  ) : s2exp // end of [val]
  val n = list_length d2es
  val d3es = d2explst_trdn_elt (d2es, s2e_elt)
  val isnonlin = s2exp_is_nonlin (s2e_elt)
  val s2e_lst = (
    if isnonlin then
      s2exp_list_t0ype_int_type (s2e_elt, n)
    else
      s2exp_list_viewt0ype_int_viewtype (s2e_elt, n)
  ) : s2exp // end of [val]
in
  d3exp_lst (loc0, s2e_lst, lin, s2e_elt, d3es)
end // end of [d2exp_trup_lst]

(* ****** ****** *)

extern
fun d3explst_get_type (d3es: d3explst): labs2explst

implement
d3explst_get_type (d3es) = let
  fun aux (
    d3es: d3explst, i: int
  ) : labs2explst =
    case+ d3es of
    | list_cons (d3e, d3es) => let
        val l = $LAB.label_make_int (i)
        val s2e = d3e.d3exp_type
        val ls2e = SLABELED (l, None, s2e)
      in
        list_cons (ls2e, aux (d3es, i+1))
      end
    | list_nil () => list_nil ()
  // end of [aux]
in
  aux (d3es, 0)
end // end of [d3explst_get_type]

implement
d2exp_trup_tup
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Etup (tupknd, npf, d2es) = d2e0.d2exp_node
(*
  val () = (
    print "d2exp_trup_tup: d2es = "; print_d2explst d2es; print_newline ()
  ) // end of [val]
*)
//
  val d3es = d2explst_trup (d2es)
//
  val ls2es = d3explst_get_type (d3es)
  val s2e_tup = s2exp_tyrec (tupknd, npf, ls2es)
//
in
  d3exp_tup (loc0, s2e_tup, tupknd, npf, d3es)
end // end of [d2exp_trup_tup]

(* ****** ****** *)

extern
fun labd3explst_get_type (ld3es: labd3explst): labs2explst

implement
labd3explst_get_type (ld3es) = let
  fn f (
    ld3e: labd3exp
  ) : labs2exp = let
    val $SYN.DL0ABELED (l, d3e) = ld3e in
    SLABELED (l.l0ab_lab, None, d3e.d3exp_type)
  end // end of [f]
in
  l2l (list_map_fun (ld3es, f))
end // end of [labd3explst_get_type]

implement
d2exp_trup_rec
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val- D2Erec (recknd, npf, ld2es) = d2e0.d2exp_node
//
(*
  val () = (
    print "d2exp_trup_rec: ld2es = "; print_labd2explst ld2es; print_newline ()
  ) // end of [val]
*)
//
  fun aux (
    ld2es: labd2explst
  ) : labd3explst =
    case+ ld2es of
    | list_cons (ld2e, ld2es) => let
        val $SYN.DL0ABELED (l, d2e) = ld2e
        val ld3e = $SYN.DL0ABELED (l, d2exp_trup (d2e))
        val ld3es = aux (ld2es)
      in
        list_cons (ld3e, ld3es)
      end // end of [list_cons]
    | list_nil () => list_nil ()
  val ld3es = aux ld2es
//
  val ls2es = labd3explst_get_type (ld3es)
  val s2e_rec = s2exp_tyrec (recknd, npf, ls2es)
//
in
  d3exp_rec (loc0, s2e_rec, recknd, npf, ld3es)
end // end of [d2exp_trup_rec]

(* ****** ****** *)

implement
d2exp_trup_seq (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val- D2Eseq (d2es) = d2e0.d2exp_node
//
fun aux (
  d2e: d2exp
, d2es: d2explst
, s2e_res: &(s2exp?) >> s2exp
, s2e_void: s2exp
) : d3explst =
  case+ :(
    s2e_res: s2exp
  ) => d2es of
  | list_cons (d2e1, d2es1) => let
      val d3e = d2exp_trdn (d2e, s2e_void)
      val d3es = aux (d2e1, d2es1, s2e_res, s2e_void)
    in
      list_cons (d3e, d3es)
    end // end of [cons]
  | list_nil () => let
      val d3e = d2exp_trup (d2e)
      val () = s2e_res := s2exp_hnfize (d3e.d3exp_type)
    in
      list_sing (d3e)
    end // end of [nil]
// end of [aux]
//
val s2e_void = s2exp_void_t0ype ()
//
in
//
case+ d2es of
| list_cons (d2e, d2es) => let
    var s2e_res: s2exp // uninitialized
    val d3es = aux (d2e, d2es, s2e_res, s2e_void)
  in
    d3exp_seq (loc0, s2e_res, d3es)
  end // end of [cons]
| list_nil () => d3exp_empty (loc0, s2e_void)
//
end // end of [d2exp_trup_seq]

(* ****** ****** *)

implement
d2exp_trup_letwhere
  (d2e0, d2cs, d2e_scope) = let
  val loc0 = d2e0.d2exp_loc
(*
  val (pf_effect | ()) = the_effect_env_push ()
  val (pf_s2cstlst | ()) = the_s2cstlst_env_push ()
  val (pf_d2varset | ()) = the_d2varset_env_push_let ()
*)
  val d3cs = d2eclist_tr (d2cs)
  val d3e_scope = d2exp_trup (d2e_scope)
(*
  val () = the_d2varset_env_check loc0
  val () = the_d2varset_env_pop_let (pf_d2varset | (*none*))
  val () = the_s2cstlst_env_pop_and_unbind (pf_s2cstlst | (*none*))
  val () = the_effect_env_pop (pf_effect | (*none*))
*)
in
  d3exp_let (loc0, d3cs, d3e_scope)
end // end of [d2exp_trup_letwhere]

(* ****** ****** *)

(* end of [pats_trans3_dynexp_up.dats] *)
