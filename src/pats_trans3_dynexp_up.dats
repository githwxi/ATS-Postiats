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
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_dynexp_up"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
staload LOC = "./pats_location.sats"
overload + with $LOC.location_combine
overload print with $LOC.print_location

staload SYN = "./pats_syntax.sats"
overload print with $SYN.print_macsynkind

(* ****** ****** *)

(*
** for T_* constructors
*)
staload "./pats_lexing.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_error.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp2_util.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload MAC = "./pats_dmacro2.sats"
staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

extern fun d2exp_trup_extval (d2e0: d2exp): d3exp
extern fun d2exp_trup_extfcall (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_con (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_tmpid (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_lst (d2e0: d2exp): d3exp
extern fun d2exp_trup_tup (d2e0: d2exp): d3exp
extern fun d2exp_trup_rec (d2e0: d2exp): d3exp
extern fun d2exp_trup_seq (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_effmask (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_vcopyenv (d2e0: d2exp): d3exp

(* ****** ****** *)

extern
fun d2exp_trup_arg_body (
  loc0: location
, fc0: funclo, lin: int, npf: int, p2ts: p2atlst, d2e: d2exp
) : (s2exp, p3atlst, d3exp)

(* ****** ****** *)

extern
fun d2exp_trup_letwhere
  (d2e0: d2exp, d2cs: d2eclist, d2e: d2exp): d3exp
// end of [d2exp_trup_letwhere]

(* ****** ****** *)

extern fun d2exp_trup_lam_dyn (d2e0: d2exp): d3exp
extern fun d2exp_trup_laminit_dyn (d2e0: d2exp): d3exp
extern fun d2exp_trup_lam_sta (d2e0: d2exp): d3exp
extern fun d2exp_trup_lam_met (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_delay (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_for (d2e0: d2exp): d3exp
extern fun d2exp_trup_while (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_trywith (d2e0: d2exp): d3exp

(* ****** ****** *)

extern fun d2exp_trup_mac (d2e0: d2exp): d3exp
extern fun d2exp_trup_macsyn (d2e0: d2exp): d3exp

(* ****** ****** *)

fun d2exp_is_sym
  (d2e: d2exp): bool = let
in
//
case+ d2e.d2exp_node of D2Esym _ => true | _ => false
//
end // end of [d2exp_is_sym]

(* ****** ****** *)

implement
d2exp_trup
  (d2e0) = let
val loc0 = d2e0.d2exp_loc
(*
val () =
(
  println! ("d2exp_trup: loc0 = ", loc0);
  println! ("d2exp_trup: d2e0 = ", d2e0);
) (* end of [val] *)
*)
val d3e0 = (
case+ d2e0.d2exp_node of
//
| D2Evar (d2v) => d2exp_trup_var (loc0, d2v)
| D2Ecst (d2c) => d2exp_trup_cst (loc0, d2c)
//
| D2Eint (int) => d2exp_trup_int (d2e0, int)
| D2Eintrep (rep) => d2exp_trup_intrep (d2e0, rep)
| D2Ebool (b(*bool*)) => d2exp_trup_bool (d2e0, b)
| D2Echar (c(*char*)) => d2exp_trup_char (d2e0, c)
| D2Efloat (rep) => d2exp_trup_float (d2e0, rep)
| D2Estring (str) => d2exp_trup_string (d2e0, str)
//
| D2Ei0nt (tok) => d2exp_trup_i0nt (d2e0, tok)
| D2Ec0har (tok) => let
    val-T_CHAR (c) = tok.token_node
  in
    d2exp_trup_char (d2e0, c) // by default: char1 (c)
  end // end of [D2Ec0har]
| D2Ef0loat (tok) => d2exp_trup_f0loat (d2e0, tok)
| D2Es0tring (tok) => let
    val-T_STRING (str) = tok.token_node
  in
    d2exp_trup_string (d2e0, str) // by default: string1(len)
  end // end of [D2Es0tring]
//
| D2Ecstsp (csp) => d2exp_trup_cstsp (d2e0, csp)
//
(*
| D2Etop () => // case for analysis
*)
| D2Etop2 (s2e) => d3exp_top (loc0, s2e)
//
| D2Eempty () => let
    val s2e = s2exp_void_t0ype () in d3exp_empty (loc0, s2e)
  end // end of [D2Eempty]
//
| D2Eextval _ => d2exp_trup_extval (d2e0)
| D2Eextfcall _ => d2exp_trup_extfcall (d2e0)
//
| D2Econ _ => d2exp_trup_con (d2e0)
//
| D2Efoldat _ => d2exp_trup_foldat (d2e0)
| D2Efreeat _ => d2exp_trup_freeat (d2e0)
//
| D2Etmpid _ => d2exp_trup_tmpid (d2e0)
//
| D2Elet (d2cs, d2e) => d2exp_trup_letwhere (d2e0, d2cs, d2e)
| D2Ewhere (d2e, d2cs) => d2exp_trup_letwhere (d2e0, d2cs, d2e)
//
| D2Eapplst (_fun, _arg) => let
(*
    val () = (
      fprintln! (stdout_ref, "d2exp_trup: D2Eapplst: _fun = ", _fun);
      fprintln! (stdout_ref, "d2exp_trup: D2Eapplst: _arg = ", _arg);
    ) // end of [val]
*)
  in
    case+ _fun.d2exp_node of    
//
    | D2Esym (d2s) =>
        d2exp_trup_applst_sym (d2e0, d2s, _arg)
      // end of [D2Esym]
    | D2Etmpid (
        d2e, t2mas
      ) when
        d2exp_is_sym (d2e) => let
        val-D2Esym (d2s) = d2e.d2exp_node
      in
        d2exp_trup_applst_tmpsym (d2e0, d2s, t2mas, _arg)
      end // end of [D2Etmpid when ...]
//
    | D2Emac (d2m) => let
(*
        val () = (
          println! ("d2exp_trup: D2Eapplst: D2Emac(bef): d2e0 = ", d2e0)
        ) // end of [val]
*)
        val d2e0 =
          $MAC.dmacro_eval_app_short (loc0, d2m, _arg)
        // end of [val]
(*
        val () = (
          println! ("d2exp_trup: D2Eapplst: D2Emac(aft): loc0 = ", loc0);
          println! ("d2exp_trup: D2Eapplst: D2Emac(aft): d2e0 = ", d2e0);
        ) // end of [val]
*)
      in
        d2exp_trup (d2e0)
      end // end of [D2Emac]
//
    | _ => d2exp_trup_applst (d2e0, _fun, _arg)
  end // end of [D2Eapplst]
//
| D2Eifhead
    (_, _, _, opt(*else*)) => let
    val s2e_if = (
      case+ opt of
      | Some _ => s2exp_Var_make_srt (loc0, s2rt_t0ype)
      | None _ => s2exp_void_t0ype () // HX: missing else-branch
    ) : s2exp // end of [val]
    val s2f_if = s2exp2hnf_cast (s2e_if)
  in
    d2exp_trdn_ifhead (d2e0, s2f_if)
  end // end of [D2Eifhead]
| D2Esifhead _ => let
    val s2e_sif =
    s2exp_Var_make_srt (loc0, s2rt_t0ype)
    val s2f_sif = s2exp2hnf_cast (s2e_sif)
  in
    d2exp_trdn_sifhead (d2e0, s2f_sif)
  end // end of [D2Esifhead]
//
| D2Ecasehead _ => let
    val s2e_case =
    s2exp_Var_make_srt (loc0, s2rt_t0ype)
    val s2f_case = s2exp2hnf_cast (s2e_case)
  in
    d2exp_trdn_casehead (d2e0, s2f_case)
  end // end of [D2Ecasehead]
//
| D2Elist (npf, d2es) => let
    val d2e0 =
      d2exp_tup_flt (loc0, npf,d2es) in d2exp_trup (d2e0)
    // end of [val]
  end // end of [D2Elist]
//
| D2Elst _ => d2exp_trup_lst (d2e0)
| D2Etup _ => d2exp_trup_tup (d2e0)
| D2Erec _ => d2exp_trup_rec (d2e0)
| D2Eseq _ => d2exp_trup_seq (d2e0)
//
| D2Eselab (d2e, d2ls) => d2exp_trup_selab (d2e0, d2e, d2ls)
//
| D2Eptrof _ => d2exp_trup_ptrof (d2e0)
| D2Eviewat _ => d2exp_trup_viewat (d2e0)
//
| D2Ederef (d2e) => d2exp_trup_deref (loc0, d2e, list_nil)
//
| D2Eassgn _ => d2exp_trup_assgn (d2e0)
| D2Exchng _ => d2exp_trup_xchng (d2e0)
//
| D2Earrsub (
    d2s, arr, loc_ind, ind // d2s = lrbrackets
  ) => let
    val loc_arr = arr.d2exp_loc
    val loc_arg = loc_arr + loc_ind
    val d2es_arg = list_cons (arr, ind)
    val d2a = D2EXPARGdyn (~1(*npf*), loc_arg, d2es_arg)
    val d2as = list_sing (d2a)
  in
    d2exp_trup_applst_sym (d2e0, d2s, d2as)
  end // end of [D2Earrsub]
| D2Earrpsz (opt, d2es) => let
    val s2e = (
      case+ opt of
      | Some s2e => s2e | None () => let
          val s2t = s2rt_t0ype in s2exp_Var_make_srt (loc0, s2t)
        end // end of [None]
    ) : s2exp // end of [val]
    val d3es = d2explst_trdn_elt (d2es, s2e)
    val n = list_length (d2es)
    val s2e_arrpsz =
      s2exp_arrpsz_vt0ype_int_vt0ype (s2e, n)
    // end of [val]
  in
    d3exp_arrpsz (loc0, s2e_arrpsz, s2e, d3es, n)
  end // end of [D2Earrpsz]
| D2Earrinit
    (s2e_elt, opt, d2es) => let
    var s2i_asz : s2exp
    val d3e_asz : d3exp = (
      case+ opt of
      | Some (d2e_asz) => let
          val d3e_asz = d2exp_trup (d2e_asz)
          val s2e_asz = d3exp_get_type (d3e_asz)
          val s2f_asz = s2exp2hnf (s2e_asz)
          val () = let
            val opt = un_s2exp_g1size_index_t0ype (s2f_asz)
          in
            case+ opt of
            | ~Some_vt (s2i) => s2i_asz := s2i
            | ~None_vt () => let
                val s2i = s2exp_err (s2rt_int) in s2i_asz := s2i
              end // end of [None_vt]
          end // end of [let] // end of [val]
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
//
| D2Eraise (d2e_exn) => let
    val err = the_effenv_check_exn (loc0)
    val () =
      if (err > 0) then the_trans3errlst_add (T3E_d2exp_trup_exn (loc0))
    // end of [val]
    val s2e_exn = s2exp_exception_vtype ()
    val d3e_exn = d2exp_trdn (d2e_exn, s2e_exn)
    val s2e_raise = s2exp_bottom_vt0ype_uni ()
  in
    d3exp_raise (loc0, s2e_raise, d3e_exn)
  end // end of [D2Eraise]
//
| D2Eeffmask _ => d2exp_trup_effmask (d2e0)
//
| D2Eshowtype
    (d2e) => d3e where
  {
    val d3e = d2exp_trup (d2e)
    val () = fshowtype_d3exp (d3e)
  } (* end of [D2Eshowtype] *)
//
| D2Evcopyenv _ => d2exp_trup_vcopyenv (d2e0)
//
| D2Elam_dyn _ => d2exp_trup_lam_dyn (d2e0)
| D2Elaminit_dyn _ => d2exp_trup_laminit_dyn (d2e0)
| D2Elam_sta _ => d2exp_trup_lam_sta (d2e0)
| D2Elam_met _ => d2exp_trup_lam_met (d2e0)
//
| D2Edelay _ => d2exp_trup_delay (d2e0)
//
| D2Efor _ => d2exp_trup_for (d2e0)
| D2Ewhile _ => d2exp_trup_while (d2e0)
| D2Eloopexn (knd) => d2exp_trup_loopexn (loc0, knd)
//
| D2Etrywith _ => d2exp_trup_trywith (d2e0)
//
| D2Emac _ => d2exp_trup_mac (d2e0)
| D2Emacsyn _ => d2exp_trup_macsyn (d2e0)
//
| D2Eann_type
    (d2e, s2e_ann) => let
    val d3e = d2exp_trdn (d2e, s2e_ann)
  in
    d3exp_ann_type (loc0, d3e, s2e_ann)
  end // end of [D2Eann_type]
//
| D2Eann_seff
    (d2e, _(*s2fe*)) => let
  in
    d2exp_trup (d2e) // HX: [d2e] should be a value
  end // end of [D2Eann_seff]
//
| D2Esym _ => let
    val () =
      the_trans3errlst_add (T3E_d2exp_trup_sym (d2e0))
    // end of [val]
  in
    d3exp_err (loc0) // : [s2exp_t0ype_err]
  end // end of [D2Esym]
//
| D2Eerr () => d3exp_err (loc0) // : [s2exp_t0ype_err]
//
| _ => let
    val () = println! ("d2exp_trup: loc0 = ", loc0)
    val () = println! ("d2exp_trup: d2e0 = ", d2e0)
  in
    exitloc (1)
  end // end of [_]
//
) : d3exp // end of [val]
(*
val s2e0 = d3e0.d3exp_type
val (
) = (
  print "d2exp_trup: d3e0.d3exp_type = "; pprint_s2exp (s2e0); print_newline ()
) (* end of [val] *)
*)
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
  val () = if serr < 0 then prerr ": more arguments are expected."
  val () = if serr > 0 then prerr ": fewer arguments are expected."
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

implement
d2var_get_type_some
  (loc0, d2v) = let
//
fun auxerr (
  loc0: location, d2v: d2var
) : void = let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is no longer available."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_typeless (loc0, d2v))
end // end of [auxerr]
//
val opt = d2var_get_type (d2v)
//
in
//
case+ opt of
| Some s2e => s2e
| None () => let
    val () = auxerr (loc0, d2v) in s2exp_t0ype_err ()
  end // end of [None]
//
end // end of [d2var_get_type_some]

(* ****** ****** *)

implement
d2exp_trup_var_mutabl
  (loc0, d2v) = let
  val-Some (s2l) = d2var_get_addr (d2v)
  var s2rt: s2exp
  val s2e_sel = s2addr_deref (loc0, s2l, list_nil, s2rt)
in
  d3exp_var (loc0, s2e_sel, d2v)
end // end of [d2exp_trup_var_mut]

implement
d2exp_trup_var_nonmut
  (loc0, d2v) = let
//
// HX: lin >= 0; nonlin = ~1
//
val lin = d2var_get_linval (d2v)
(*
val () = (
  print "d2exp_trup_var_nonmut: d2v = ";
  print_d2var (d2v);
  print_newline ();
  print ("d2exp_trup_var_nonmut: lin = ");
  print (lin);
  print_newline ();
) (* end of [val] *)
*)
val s2qs = d2var_get_decarg (d2v)
val s2e0 = d2var_get_type_some (loc0, d2v)
//
val () = if lin >= 0 then let
  val isllamlocal =
    the_d2varenv_d2var_is_llamlocal (d2v)
  // end of [val]
in
//
if isllamlocal then let
  val () = d2var_inc_linval (d2v)
in
  d2var_set_type (d2v, None) // HX: [d2v] is consumed
end else let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": the linear dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is expected to be local but it is not."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_trup_llamlocal (d2v))
end // end of [if]
//
end // end of [if] // end of [val]
//
in
//
case+ s2qs of
| list_nil () => d3exp_var (loc0, s2e0, d2v)
| list_cons _ => let
    val locsarg = $LOC.location_rightmost (loc0)
    var err: int = 0
    val (
      s2e_tmp, s2ess
    ) = s2exp_tmp_instantiate_rest (s2e0, locsarg, s2qs, err)
  in
    d3exp_tmpvar (loc0, s2e_tmp, d2v, s2ess)
  end // end of [list_cons]
//
end // end of [d2exp_trup_var_nonmut]

implement
d2exp_trup_var
  (loc0, d2v) = let
in
  if d2var_is_mutabl (d2v) then
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
d2exp_trup_extval
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Eextval (s2e, name) = d2e0.d2exp_node
in
  d3exp_extval (loc0, s2e, name)
end // end of [d2exp_trup_extval]

(* ****** ****** *)

local

fun auxerr
(
  loc0: location, d3e: d3exp
) : void = let
  val loc = d3e.d3exp_loc
  val () = prerr_error3_loc (loc)
  val () = filprerr_ifdebug "d2exp_trup_extfcall"
  val () = prerr ": no linear argument is allowed for the extfcall."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_extfcall_arg (loc0, d3e))
end // end of [auxerr]

fun auxcheck
(
  loc0: location, d3es: d3explst
) : void = let
in
//
case+ d3es of
| list_cons
    (d3e, d3es) => let
    val s2e = d3exp_get_type (d3e)
    val islin = s2exp_is_lin (s2e)
    val () = if islin then auxerr (loc0, d3e)
  in
    auxcheck (loc0, d3es)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxcheck]

in (* in of [local] *)

implement
d2exp_trup_extfcall
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Eextfcall (s2e, _fun, _arg) = d2e0.d2exp_node
  val d3es_arg = d2explst_trup (_arg)
  val ((*void*)) = auxcheck (loc0, d3es_arg)
in
  d3exp_extfcall (loc0, s2e, _fun, d3es_arg)
end // end of [d2exp_trup_extval]

end // end of [local]

(* ****** ****** *)

implement
d2exp_trup_con (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Econ (
    d2c, locfun, s2as, npf, locarg, d2es_arg
  ) = d2e0.d2exp_node
  val s2e_con = d2con_get_type (d2c)
//
  var err: int = 0
  val (s2e, s2ps) =
    s2exp_uni_instantiate_sexparglst (s2e_con, s2as, err)
  // HX: [err] is not used
  val () = trans3_env_add_proplst_vt (locfun, s2ps)
//
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
d2exp_trup_tmpcst
  (loc0, d2c, t2mas) = let
//
val locarg =
  $LOC.location_rightmost (loc0)
val s2qs = d2cst_get_decarg (d2c)
val s2e_d2c = d2cst_get_type (d2c)
var err: int = 0
val (s2e_tmp, t2mas) =
  s2exp_tmp_instantiate_tmpmarglst (s2e_d2c, locarg, s2qs, t2mas, err)
// end of [val]
in
  d3exp_tmpcst (loc0, s2e_tmp, d2c, t2mas)
end // end of [d2exp_trup_tmpcst]

implement
d2exp_trup_tmpvar
  (loc0, d2v, t2mas) = let
//
val locarg =
  $LOC.location_rightmost (loc0)
val s2qs = d2var_get_decarg (d2v)
val s2e_d2v = d2var_get_type_some (loc0, d2v)
var err: int = 0
val (s2e_tmp, t2mas) =
  s2exp_tmp_instantiate_tmpmarglst (s2e_d2v, locarg, s2qs, t2mas, err)
// end of [val]
in
  d3exp_tmpvar (loc0, s2e_tmp, d2v, t2mas)
end // end of [d2exp_trup_tmpvar]

implement
d2exp_trup_tmpid
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Etmpid (d2e_id, t2mas) = d2e0.d2exp_node
//
in
//
case+
  d2e_id.d2exp_node of
| D2Ecst (d2c) =>
    d2exp_trup_tmpcst (loc0, d2c, t2mas)
| D2Evar (d2v) =>
    d2exp_trup_tmpvar (loc0, d2v, t2mas)
| _ => let
    val () = (
      println! ("d2exp_trup_tmpid: d2e_id = ", d2e_id)
    ) // end of [val]
  in
    exitloc (1)
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
//
  val loc_fun = d3e_fun.d3exp_loc
  val s2e_fun = d3e_fun.d3exp_type
//
(*
  val () = (
    print "d23exp_trup_app23: s2e_fun = ";
    pprint_s2exp s2e_fun; print_newline ()
  ) // end of [val]
*)
  var err: int = 0
  val locsarg = $LOC.location_rightmost (loc_fun)
  val (s2e_fun, s2ps) = s2exp_unimet_instantiate_all (s2e_fun, locsarg, err)
  val () = trans3_env_add_proplst_vt (locsarg, s2ps)
(*
  val () = begin
    print "d23exp_trup_app23: s2e_fun = "; pprint_s2exp s2e_fun; print_newline ()
  end // end of [val]
*)
  val d3e_fun =
    d3exp_app_unista (loc_fun, s2e_fun, d3e_fun)
  // end of [d3e_fun]
in
//
case+ s2e_fun.s2exp_node of
| S2Efun (
    fc, _(*lin*), s2fe_fun, npf_fun, s2es_fun_arg, s2e_fun_res
  ) => let
(*
    val () = begin
      print "d23exp_trup_app: s2e_fun = "; pprint_s2exp s2e_fun; print_newline ();
      print "d23exp_trup_app: s2fe_fun = "; pprint_s2eff s2fe_fun; print_newline ();
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
    val loc_app = $LOC.location_combine (loc_fun, locarg)
    val s2es_fun_arg = 
      s2fun_opninv_and_add (locarg, s2es_fun_arg, s2e_fun_res)
    val d3es_arg = d23explst_trdn (locarg, d23es_arg, s2es_fun_arg)
//
    val (
      iswth
    , s2e_res
    , wths2es
    ) =
      un_s2exp_wthtype (loc_app, s2e_fun_res)
    // end of [val]
//
    val d3e_fun = d3exp_fun_restore (fc, d3e_fun)
    val d3es_arg = (
      if iswth then
        d3explst_arg_restore (d3es_arg, s2es_fun_arg, wths2es)
      else d3es_arg
    ) : d3explst // end of [val]
//
    val err =
      the_effenv_check_s2eff (loc_app, s2fe_fun)
    // end of [val]
    val () = if (err > 0) then (
      the_trans3errlst_add (T3E_d23exp_trup_app23_eff (loc_app, s2fe_fun))
    ) // end of [if] // end of [val]
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
case+
  s2e_fun.s2exp_node of
| _ => let
    val d3e_fun =
      d23exp_trup_app23 (
      d2e0, d3e_fun, npf, locarg, d23es_arg
    ) // end of [val]
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
(*
  val () = (
    fprintln!
      (stdout_ref, "d23exp_trup_applst: d3e_fun = ", d3e_fun);
    fprintln! (stdout_ref, "d23exp_trup_applst: d2as = ", d2as);
  ) // end of [val]
*)
in
//
case+ d2as of
| list_cons (d2a, d2as) => (
  case+ d2a of
  | D2EXPARGsta (locarg, s2as) => begin
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
d2exp_trup_lst
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Elst (lin, opt, d2es) = d2e0.d2exp_node
(*
val () = println! ("d2exp_trup_lst: lin = ", lin)
*)
val islin = (
  if lin >= 0 then test_linkind (lin) else false
) : bool // end of [val]
val isnonlin = ~(islin)
val s2e_elt = (
  case+ opt of
  | Some s2e => s2e | None () => let
      val s2t = (
        if isnonlin then s2rt_t0ype else s2rt_vt0ype
      ) : s2rt // end of [val]
    in
      s2exp_Var_make_srt (loc0, s2t)
    end // end of [None]
) : s2exp // end of [val]
val n = list_length (d2es)
val d3es = d2explst_trdn_elt (d2es, s2e_elt)
val isnonlin = (
  if lin >= 0 then isnonlin else s2exp_is_nonlin (s2e_elt)
) : bool // end of [val]
val s2e_lst = (
  if isnonlin then
    s2exp_list_t0ype_int_type (s2e_elt, n)
  else
    s2exp_list_vt0ype_int_vtype (s2e_elt, n)
) : s2exp // end of [val]
//
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
val-D2Etup (knd, npf, d2es) = d2e0.d2exp_node
(*
val () =
(
  fprintln! (stdout_ref, "d2exp_trup_tup: knd = ", knd);
  fprintln! (stdout_ref, "d2exp_trup_tup: d2es = ", d2es);
)
*)
//
val d3es = d2explst_trup (d2es)
//
val ls2es = d3explst_get_type (d3es)
val s2e_tup = s2exp_tyrec (knd, npf, ls2es)
//
(*
val () =
(
  fprintln! (stdout_ref, "d2exp_trup_tup: s2e_tup = ", s2e_tup);
)
*)
//
in
  d3exp_tup (loc0, s2e_tup, knd, npf, d3es)
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
  val-D2Erec (recknd, npf, ld2es) = d2e0.d2exp_node
//
(*
  val () = (
    print "d2exp_trup_rec: ld2es = ";
    print_labd2explst ld2es; print_newline ()
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
val-D2Eseq (d2es) = d2e0.d2exp_node
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
  val (pfpush_eff | ()) = the_effenv_push ()
  val (pfpush_s2cst | ()) = the_s2cstbindlst_push ()
  val (pfpush_d2var | ()) = the_d2varenv_push_let ()
//
  val d3cs = d2eclist_tr (d2cs)
  val d3e_scope = d2exp_trup (d2e_scope)
//
  val () = the_d2varenv_check (loc0)
//
  val () = the_effenv_pop (pfpush_eff | (*none*))
  val () = the_s2cstbindlst_pop_and_unbind (pfpush_s2cst | (*none*))
  val () = the_d2varenv_pop (pfpush_d2var | (*none*))
in
  d3exp_let (loc0, d3cs, d3e_scope)
end // end of [d2exp_trup_letwhere]

(* ****** ****** *)

implement
d2exp_trup_effmask
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Eeffmask (s2fe, d2e) = d2e0.d2exp_node
val (pfpush | ()) = the_effenv_push_effmask (s2fe)
val d3e = d2exp_trup (d2e)
val () = the_effenv_pop (pfpush | (*none*))
//
in
  d3exp_effmask (loc0, s2fe, d3e)
end // end of [d2exp_trup_effmask]

(* ****** ****** *)

implement
d2exp_trup_vcopyenv
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Evcopyenv (knd, d2e) = d2e0.d2exp_node
//
in
//
case+
  d2e.d2exp_node of
| D2Evar (d2v) => let
    val opt = d2var_get_type (d2v)
    val s2f = (
      case+ opt of
      | Some s2e => let
          val isprf = test_prfkind (knd)
        in
          if isprf then s2exp_vcopyenv_v (s2e) else s2exp_vcopyenv_vt (s2e)
        end // end of [Some]
      | None () => s2exp_void_t0ype ()
    ) : s2exp // end of [val]
  in
    d3exp_vcopyenv (loc0, s2f, knd, d2v)
  end // end of [D2Evar]
| _(*non-var*) => d2exp_trup (d2e) // HX: ignoring [$vcopyenv]
//
end // end of [d2exp_trup_vcopyenv]

(* ****** ****** *)

implement
d2exp_trup_arg_body (
  loc0
, fc0, lin, npf
, p2ts_arg, d2e_body
) = let
(*
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
*)
val (pfenv | ()) = trans3_env_push ()
//
var fc: funclo = fc0
val d2e_body = d2exp_funclo_of_d2exp (d2e_body, fc)
var s2fe: s2eff = s2eff_nil
val d2e_body = d2exp_s2eff_of_d2exp (d2e_body, s2fe)
//
val (pfeff | ()) = the_effenv_push_lam (s2fe)
//
val s2es_arg = p2atlst_syn_type (p2ts_arg)
val p3ts_arg = p2atlst_trup_arg (npf, p2ts_arg)
//
val (pfd2v | ()) = the_d2varenv_push_lam (lin)
val () = the_d2varenv_add_p3atlst (p3ts_arg)
val (pfman | ()) = the_pfmanenv_push_lam (lin) // lin:0/1:stopping/continuing search
val () = the_pfmanenv_add_p3atlst (p3ts_arg)
//
val (pflamlp | ()) = the_lamlpenv_push_lam (p3ts_arg)
//
val d3e_body = d2exp_trup (d2e_body)
//
val () = the_d2varenv_check (loc0)
val () = if lin > 0 then the_d2varenv_check_llam (loc0)
//
val () = the_effenv_pop (pfeff | (*none*))
val () = the_d2varenv_pop (pfd2v | (*none*))
val () = the_pfmanenv_pop (pfman | (*none*))
val () = the_lamlpenv_pop (pflamlp | (*none*))
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
  val-D2Elam_dyn (lin, npf, p2ts_arg, d2e_body) = d2e0.d2exp_node
  val fc0 = FUNCLOfun () // default
  val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
  val s2e_fun = s2ep3tsd3e.0
  val p3ts_arg = s2ep3tsd3e.1
  val d3e_body = s2ep3tsd3e.2
in
  d3exp_lam_dyn (loc0, s2e_fun, lin, npf, p3ts_arg, d3e_body)
end // end of [d2exp_trup_lam_dyn]

implement
d2exp_trup_laminit_dyn (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Elaminit_dyn (lin, npf, p2ts_arg, d2e_body) = d2e0.d2exp_node
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
end // end of [d2exp_trup_laminit_dyn]

(* ****** ****** *)

implement
d2exp_trup_lam_sta (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Elam_sta (s2vs, s2ps, d2e_body) = d2e0.d2exp_node
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
d2exp_trup_lam_met
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Elam_met
    (d2vs_ref, s2es_met, d2e_body) = d2e0.d2exp_node
  // end of [val]
  val () = s2explst_check_termet (loc0, s2es_met)
  val (pfmet | ()) = termetenv_push_dvarlst (!d2vs_ref, s2es_met)
  val d3e_body = d2exp_trup (d2e_body)
  val () = termetenv_pop (pfmet | (*none*))
in
  d3exp_lam_met (loc0, s2es_met, d3e_body)
end // end of [d2exp_trup_lam_met]

(* ****** ****** *)

implement
d2exp_trup_delay (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Edelay (d2e_body) = d2e0.d2exp_node
val fc0 = FUNCLOfun () // default
val lin = 0
val npf = ~1
val p2ts_arg = list_nil {p2at} ()
val s2ep3tsd3e = d2exp_trup_arg_body (loc0, fc0, lin, npf, p2ts_arg, d2e_body)
val s2e_fun = s2ep3tsd3e.0
val p3ts_arg = s2ep3tsd3e.1
val d3e_body = s2ep3tsd3e.2
//
val s2e_body = d3exp_get_type (d3e_body)
val s2e_lazy = s2exp_lazy_t0ype_type (s2e_body)
//
val islin =
  s2exp_is_lin (s2e_body)
val () = if islin then let
  val () = prerr_error3_loc (loc0)
  val () = prerr ": it is not allowed to apply $delay to a linear value."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d3exp_delay (loc0, d3e_body))
end // end of [val]
//
in
  d3exp_delay (loc0, s2e_lazy, d3e_body)
end // end of [d2exp_delay_trup]

(* ****** ****** *)

implement
d2exp_trup_for (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Efor (i2nv, init, test, post, body) = d2e0.d2exp_node
//
in
  d2exp_trup_loop (loc0, i2nv, Some(init), test, Some(post), body)
end // end of [d2exp_trup_for]

implement
d2exp_trup_while (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Ewhile (i2nv, test, body) = d2e0.d2exp_node
//
in
  d2exp_trup_loop (loc0, i2nv, None(*init*), test, None(*post*), body)
end // end of [d2exp_trup_while]

(* ****** ****** *)

implement
d2exp_trup_trywith
  (d2e0) = let
  val loc0 = d2e0.d2exp_loc
  val-D2Etrywith
    (r2es, d2e, c2ls) = d2e0.d2exp_node
  val d3e = d2exp_trup (d2e)
  val s2e_res = d3exp_get_type (d3e)
//
  val (pfpush | ()) = the_d2varenv_push_try ()
//
  val s2e_pat =
    s2exp_exception_vtype ()
  // end of [val]
//
  val loc = d3e.d3exp_loc
  val d3e_dummy = d3exp_top (loc, s2e_pat)
  val d3es = list_sing (d3e_dummy)
//
  val s2es_pat = list_sing (s2e_pat)
//
  val c3ls = c2laulst_trdn (
    loc0, CK_case_neg, r2es, c2ls, d3es, s2es_pat, s2e_res
  ) // end of [val]
//
  val () = the_d2varenv_pop (pfpush | (*none*))
//
in
  d3exp_trywith (loc0, d3e, c3ls)
end // end of [d2exp_trup_trywith]

(* ****** ****** *)

implement
d2exp_trup_mac (d2e0) = let
  val-D2Emac (d2m) = d2e0.d2exp_node
(*
  val () = println! ("d2exp_trup: D2Emac: loc0 = ", d2e0.d2exp_loc)
*)
  val d2e_mac =
    $MAC.dmacro_eval_app_short (d2e0.d2exp_loc, d2m, list_nil(*d2as*))
  // end of [val]
(*
  val () = println! ("d2exp_trup: D2Emac: loc_mac = ", d2e_mac.d2exp_loc)
*)
in
  d2exp_trup (d2e_mac)
end // end of [D2Emac]

implement
d2exp_trup_macsyn
  (d2e0) = let
//
val loc0 = d2e0.d2exp_loc
val-D2Emacsyn (knd, d2e) = d2e0.d2exp_node
//
val () = (
  println! ("d2exp_trup: D2Emacsyn: knd = ", knd);
  println! ("d2exp_trup: D2Emacsyn: d2e = ", d2e);
) (* end of [val] *)
//
val d2e_mac = (
  case+ knd of
  | $SYN.MSKdecode () => $MAC.dmacro_eval_decode (d2e)
  | $SYN.MSKxstage () => $MAC.dmacro_eval_xstage (d2e)
  | $SYN.MSKencode () => let
      val () = prerr_errmac_loc (loc0)
      val () = prerr ": the macro syntax `(...) is used incorrectly.";
      val () = prerr_newline ()
    in
      d2exp_err (loc0)
    end // end of [MSKINDencode]
) : d2exp // end of [val]
(*
val () = println! ("d2exp_trup: D2Emacsyn: d2e_mac = ", d2e_mac)
*)
in
  d2exp_trup (d2e_mac)
end // end of [d2exp_trup_macsyn]

(* ****** ****** *)

(* end of [pats_trans3_dynexp_up.dats] *)
