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
macdef castvwtp1 = $UN.castvwtp1

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans2_decl"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
macdef EQEQ = $SYM.symbol_EQEQ
overload = with $SYM.eq_symbol_symbol
overload != with $SYM.neq_symbol_symbol

staload SYN = "./pats_syntax.sats"
typedef i0de = $SYN.i0de
typedef i0delst = $SYN.i0delst
typedef s0taq = $SYN.s0taq
typedef d0ynq = $SYN.d0ynq
typedef dqi0de = $SYN.dqi0de
typedef impqi0de = $SYN.impqi0de

macdef
prerr_dqid (dq, id) =
  ($SYN.prerr_d0ynq ,(dq); $SYM.prerr_symbol ,(id))
// end of [prerr_dqid]

(* ****** ****** *)

staload NS = "./pats_namespace.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp2_util.sats"

(* ****** ****** *)

staload "./pats_trans2.sats"
staload "./pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt
macdef list_sing (x) = list_cons (,(x), list_nil)

(* ****** ****** *)

fn symintr_tr
  (ids: i0delst): void = let
//
fun aux
  (ids: i0delst): void = let
in
  case+ ids of
  | list_cons (id, ids) => aux ids where {
      val sym = id.i0de_sym
      val () = the_d2expenv_add (sym, D2ITMsymdef (sym, list_nil))
    } // end of [list_cons]
  | list_nil () => () // end of [list_nil]
end // end of [aux]
//
in
  aux ids
end // end of [symintr_tr]

fn symelim_tr
  (ids: i0delst): void = let
  fn f (id: i0de): void = let
    val sym = id.i0de_sym
    val ans = the_d2expenv_find (sym)
  in
    case+ ans of
    | ~Some_vt (d2i) => (case+ d2i of
      | D2ITMsymdef _ =>
          the_d2expenv_add (sym, D2ITMsymdef (sym, list_nil))
      | _ => () // HX: should a warning be reported?
      ) // end of [Some_vt]
    | ~None_vt () => ()
  end // end of [f]
in
  list_app_fun (ids, f)
end // end of [symelim_tr]

(* ****** ****** *)

extern
fun overload_tr (
  d1c0: d1ecl
, id: i0de, dqid: dqi0de, pval: int
) : d2itmopt // end of [overload_tr]
extern
fun overload_tr_def (
  d1c0:d1ecl, id: i0de, pval: int, def: d2itm
) : void // end of [overload_tr_def]
extern
fun overload_tr_d2eclist (d2cs: d2eclist): void

(* ****** ****** *)

implement
overload_tr
  (d1c0, id, dqid, pval) = let
//
(*
  val () = {
    val () = print "overload_tr: id = "
    val () = $SYN.print_i0de (id)
    val () = print_newline ()
    val () = print "overload_tr: dqid = "
    val () = $SYN.print_dqi0de (dqid)
    val () = print_newline ();
  } // end of [val]
*)
//
fn auxerr (
  d1c0: d1ecl, dqid: $SYN.dqi0de
) : void = let
  val loc = dqid.dqi0de_loc
  val () = prerr_error2_loc (loc)
  val () = filprerr_ifdebug "overload_tr"
  val () = prerr ": the dynamic identifier ["
  val () = $SYN.prerr_dqi0de (dqid)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_overload (d1c0))
end (* end of [auxerr] *)
//
  val ans = 
    the_d2expenv_find_qua (dqid.dqi0de_qua, dqid.dqi0de_sym)
  // end of [val]
  val ans = option_of_option_vt (ans)
  val () = (case+ ans of
    | Some (d2i) => overload_tr_def (d1c0, id, pval, d2i)
    | None () => auxerr (d1c0, dqid)
  ) // end of [val]
in
  ans
end // end of [overload_tr]

implement
overload_tr_def
  (d1c0, id, pval, def) = let
//
  var err: int = 0
//
fn auxerr1 (
  d1c0: d1ecl, id: i0de, err: &int
) : void = let
  val () = err := err + 1
  val () = prerr_error2_loc (id.i0de_loc)
  val () = filprerr_ifdebug ("overload_tr_def")
  val () = prerr ": the overloaded identifier ["
  val () = $SYN.prerr_i0de (id)
  val () = prerr "] should refer to a symbol but it does not."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_overload (d1c0))
end // end of [auxerr1]
//
fn auxerr2 (
  d1c0: d1ecl, id: i0de, err: &int
) : void = let
  val () = err := err + 1
  val () = prerr_error2_loc (id.i0de_loc)
  val () = filprerr_ifdebug "overload_tr_def"
  val () = prerr ": the overloaded identifier ["
  val () = $SYN.prerr_i0de (id)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_d1ecl_tr_overload (d1c0))
end // end of [auxerr2]
//
val sym = id.i0de_sym
val ans = ans where {
  val ans = the_d2expenv_current_find (sym)
  val ans = (
    case+ ans of
    | Some_vt _ => (fold@ ans; ans)
    | ~None_vt () => the_d2expenv_pervasive_find (sym)
  ) : d2itmopt_vt
} // end of [val]
val d2pis = (
  case+ ans of
  | ~Some_vt d2i => (
    case+ d2i of
    | D2ITMsymdef (sym, d2pis) => d2pis
    | _ => let
        val () = auxerr1 (d1c0, id, err) in list_nil ()
      end // end of [_]
    ) // end of [Some_vt]
  | ~None_vt () => let
      val () = auxerr2 (d1c0, id, err) in list_nil ()
    end // end of [None_vt]
) : d2pitmlst // end of [val]
(*
val () = begin
  print "overload_tr_def: def := "; print_d2itm (def); print_newline ();
  print "overload_tr_def: d2is := "; print_d2itmlst (d2is); print_newline ();
end // end of [val]
*)
in
//
if err = 0 then let
  val d2pi = D2PITM (pval, def)
  val d2pis_new = list_cons (d2pi, d2pis)
in
  the_d2expenv_add (sym, D2ITMsymdef (sym, d2pis_new))
end // end of [if]
//
end (* end of [overload_tr_def] *)

(* ****** ****** *)

fn d1atsrtdec_tr
(
  res: s2rt, d1c: d1atsrtdec
) : s2cstlst = let
//
fn aux (
  i: int, res: s2rt, d1c: d1atsrtcon
) : s2cst = let
  val id = d1c.d1atsrtcon_sym
  val loc = d1c.d1atsrtcon_loc
  val arg = s1rtlst_tr (d1c.d1atsrtcon_arg)
  val s2t = s2rt_fun (arg, res)
  val s2c = s2cst_make (
    id // sym
  , loc // location
  , s2t // srt
  , None () // isabs
  , true // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , list_nil () // argvarlst
  , None () // def
  ) // end of [s2cst_make]
  val () = s2cst_set_tag (s2c, i)
  val () = the_s2expenv_add_scst (s2c)
in
  s2c
end // end of [aux]
//
fun auxlst (
  i: int, res: s2rt, d1cs: d1atsrtconlst
) : s2cstlst = let
in
//
case+ d1cs of
| list_cons
    (d1c, d1cs) => (
    list_cons (aux (i, res, d1c), auxlst (i+1, res, d1cs))
  ) // end of [cons]
| list_nil () => list_nil ()
//
end // end of [auxlst]
//
in
  auxlst (0, res, d1c.d1atsrtdec_con)
end // end of [d1atsrtdec_tr]

fn d1atsrtdeclst_tr
  (d1cs: d1atsrtdeclst) = let
//
typedef T = (d1atsrtdec, s2rtdat, s2rt)
//
fun loop1 (
  xs0: List_vt (T)
) : void = let
in
  case+ xs0 of
  | ~list_vt_cons (x, xs) => let
      val s2cs = d1atsrtdec_tr (x.2, x.0)
      val () = s2rtdat_set_sconlst (x.1, s2cs)
    in
      loop1 (xs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
end // end of [loop1]
//
fun loop2 (
  d1cs: d1atsrtdeclst, res: List_vt (T)
) : void = let
in
  case+ d1cs of
  | list_cons
      (d1c, d1cs) => let
      val loc = d1c.d1atsrtdec_loc
      val sym = d1c.d1atsrtdec_sym
      val s2td = s2rtdat_make (sym)
      val s2t = S2RTbas (S2RTBASdef s2td)
//
      val s2ts_arg = '[s2t, s2t]
      val s2t_eqeq = s2rt_fun (s2ts_arg, s2rt_bool)
      val s2c_eqeq = s2cst_make (
        EQEQ // sym
      , loc // location
      , s2t_eqeq // srt
      , None () // isabs
      , false // iscon
      , false // isrec
      , false // isasp
      , None () // islst
      , list_nil () // argvarlst
      , None () // def
      ) // end of [val]
      val () = the_s2expenv_add_scst (s2c_eqeq)
//
      val () = the_s2rtenv_add (sym, S2TEsrt s2t)
    in
      loop2 (d1cs, list_vt_cons ( @(d1c, s2td, s2t), res ))
    end // end of [list_cons]
  | list_nil () => loop1 (res)
end // end of [loop2]
//
in
  loop2 (d1cs, list_vt_nil ())
end // end of [d1atsrtdeclst_tr]

(* ****** ****** *)

fn s1rtdef_tr
  (d: s1rtdef): void = let
  val id = d.s1rtdef_sym
  val s2te = s1rtext_tr (d.s1rtdef_def)
in
  the_s2rtenv_add (id, s2te)
end // end of [s1rtdef_tr]

(* ****** ****** *)

fn s1tacst_tr
  (d: s1tacst): void = let
//
  fun aux (
    xs: a1msrtlst, res: s2rt
  ) : s2rt =
    case+ xs of
    | list_cons (x, xs) =>
        s2rt_fun (a1msrt_tr_srt (x), aux (xs, res))
      // end of [list_cons]
    | list_nil () => res
  // end of [aux]
//
  val id = d.s1tacst_sym
  val loc = d.s1tacst_loc
  val s2t_res = s1rt_tr (d.s1tacst_res)
  val s2t_cst = aux (d.s1tacst_arg, s2t_res)
  val s2c = s2cst_make (
    id // sym
  , loc // location
  , s2t_cst // srt
  , None () // isabs
  , false // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , list_nil () // argvarlst
  , None () // def
  ) // end of [s2cst_make]
in
  the_s2expenv_add_scst (s2c)
end // end of [s1tacst_tr]

(* ****** ****** *)

fn s1tacon_tr
(
  s2t_res: s2rt, d: s1tacon
) : void = let
  val id = d.s1tacon_sym
  val loc = d.s1tacon_loc
//
  val argvars = l2l (
    list_map_fun (d.s1tacon_arg, a1msrt_tr_symsrt)
  ) // end of [val]
//
  val s2t_fun = let
    fun aux (
      s2t_res: s2rt, xss: List (syms2rtlst)
    ) : s2rt =
      case+ xss of
      | list_cons (xs, xss) => let
          val s2ts_arg =
            list_map_fun<syms2rt><s2rt> (xs, lam x =<0> x.1)
          val s2t_res = s2rt_fun ((l2l)s2ts_arg, s2t_res)
        in
          aux (s2t_res, xss)
        end (* end of [list_cons] *)
      | list_nil () => s2t_res
    // end of [aux]
  in
    aux (s2t_res, argvars)
  end : s2rt // end of [val]
(*
  val () = (
    print "s1tacon_tr: sym = "; $SYM.print_symbol (id); print_newline ();
    print "s1tacon_tr: s2t_fun = "; print_s2rt (s2t_fun); print_newline ();
  ) // end of [val]
*)
  val (pfenv | ()) = the_s2expenv_push_nil ()
//
  val s2vss = let
    fun f1 (x: syms2rt): s2var =
      if x.0 = $SYM.symbol_empty then
        s2var_make_srt (x.1) else s2var_make_id_srt (x.0, x.1)
      // end of [if]
    fun f2 (
      xs: syms2rtlst
    ) : s2varlst = let
      val s2vs = l2l (list_map_fun (xs, f1))
      val () = the_s2expenv_add_svarlst (s2vs)
    in
      s2vs
    end // end of [f2]
    val s2vss = list_map_fun (argvars, f2)
  in
    l2l (s2vss)
  end : List (s2varlst) // end of [val]
  val def = let
    fun aux (
      s2t_fun: s2rt, s2vss: List (s2varlst), s2e: s2exp
    ) : s2exp =
      case+ s2vss of
      | list_cons
          (s2vs, s2vss) => let
          val-S2RTfun (_, s2t1_fun) = s2t_fun
          val s2e = aux (s2t1_fun, s2vss, s2e)
          val s2e_lam = s2exp_lam_srt (s2t_fun, s2vs, s2e)
        in
          s2e_lam
        end // end of [list_cons]
      | list_nil () => s2e
     // end of [aux]
     val def = d.s1tacon_def
   in
     case+ def of
     | Some s1e => let
         val s2e =
           s1exp_trdn (s1e, s2t_res)
         // end of [val]
         val s2e_def = aux (s2t_fun, s2vss, s2e)
       in
         Some (s2e_def)
       end // end of [Some]
     | None () => None ()
  end : s2expopt // end of [val]
//
  val () = the_s2expenv_pop_free (pfenv | (*none*))
//
  val s2c = s2cst_make (
    id // sym
  , loc // location
  , s2t_fun // srt
  , Some (def) // isabs
  , true // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , argvars // argvarlst
  , None () // definition
  ) // end of [val]
in
  the_s2expenv_add_scst (s2c)
end // end of [s1tacon_tr]

fn s1taconlst_tr
(
  knd: int, ds: s1taconlst
) : void = let
  fun aux
  (
    s2t: s2rt, ds: s1taconlst
  ): void =
    case+ ds of
    | list_cons (d, ds) => let
        val () = s1tacon_tr (s2t, d) in aux (s2t, ds)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [aux]
  val s2t_res = s2rt_impred (knd)
in
  aux (s2t_res, ds)
end // end of [s1taconlst_tr]

(* ****** ****** *)

(*
//
// HX-2012-05-23: removed
//
fn s1tavar_tr
  (d: s1tavar): s2tavar = let
  val loc = d.s1tavar_loc
  val s2t = s1rt_tr (d.s1tavar_srt)
  val s2v = s2var_make_id_srt (d.s1tavar_sym, s2t)
  val () = the_s2expenv_add_svar (s2v)
in
  s2tavar_make (loc, s2v)
end // end of [s1tavar_tr]

fn s1tavarlst_tr
  (ds: s1tavarlst): s2tavarlst = l2l (list_map_fun (ds, s1tavar_tr))
// end of [s1tavarlst_tr]
*)

(* ****** ****** *)

fn t1kindef_tr
  (d: t1kindef): void = let
//
val sym = d.t1kindef_sym
val loc_id = d.t1kindef_loc_id
val def = s1exp_trup (d.t1kindef_def)
val s2c =
  s2cst_make (
  sym // name
, loc_id // location
, s2rt_tkind // tkind constant
, None () // isabs
, false // iscon
, false // isrec
, false // isasp
, None () // islst
, list_nil () // argvar
, Some (def) // definition
) // end of [val]
in
  the_s2expenv_add_scst (s2c)
end // end of [t1kindef_tr]

(* ****** ****** *)

fun
s1expdef_tr_arg
(
  xs: s1marglst
) : List_vt (s2varlst) = let
//
fn f
(
  x: s1marg
) : s2varlst = s2vs where {
  val s2vs = s1arglst_trup (x.s1marg_arg)
  val () = the_s2expenv_add_svarlst (s2vs)
} // end of [f]
//
in
  list_map_fun (xs, f)
end // end of [s1expdef_tr_arg]

fun
s1expdef_tr_def
(
  xs: s1marglst, res: s2rtopt, def: s1exp
) : s2exp = let 
//
val (
  pfenv | ()
) = the_s2expenv_push_nil ()
//
val s2vss = s1expdef_tr_arg (xs)
//
val s2e_body =
(
case+ res of
| Some s2t => s1exp_trdn (def, s2t)
| None ((*void*)) => s1exp_trup (def)
) : s2exp // end of [val]
//
val (
) = the_s2expenv_pop_free (pfenv | (*none*))
//
val s2e_def = s2exp_lamlst ((castvwtp1)s2vss, s2e_body)
val () = list_vt_free (s2vss)
//
in
  s2e_def  
end // end of [s1expdef_tr_def]

fun
s1expdef_tr (
  res: s2rtopt, d: s1expdef
) : s2cst = let
//
fn auxerr
  (d: s1expdef): void = let
//
val (
) = prerr_error2_loc (d.s1expdef_loc)
val () = filprerr_ifdebug ("s1expdef_tr")
val (
) = prerr "\
: the sort for the static definition does not
match the one assigned to the static constant [\
" // end of [val]
val () = $SYM.prerr_symbol (d.s1expdef_sym)
val () = prerr "]."
val () = prerr_newline ()
//
in
  the_trans2errlst_add (T2E_s1expdef_tr (d))
end // end of [auxerr]
//
val sym = d.s1expdef_sym
and loc_id = d.s1expdef_loc_id
and arg = d.s1expdef_arg
and def = d.s1expdef_def
val res1 = s1rtopt_tr (d.s1expdef_res)
//
val res2 = (
case+ res of
| Some s2t => (
  case+ res1 of
  | Some s2t1 => let
      val test = s2rt_ltmat1 (s2t1, s2t)
    in
      if test then res1 else (auxerr (d); res)
    end // end of [Some]
  | None () => res
  ) // end of [Some]
| None () => res1
) : s2rtopt // end of [val]
//
val def2 = s1expdef_tr_def (arg, res2, def)
//
in
//
s2cst_make (
  sym // name
, loc_id // location
, def2.s2exp_srt // srt
, None () // isabs
, false // iscon
, false // isrec
, false // isasp
, None () // islst
, list_nil () // argvar
, Some (def2) // definition
) (* end of [s2cst_make] *)
//
end // end of [s1expdef_tr]

fn s1expdeflst_tr
  (knd: int, ds: s1expdeflst): void = let
//
val res =
(
  if knd >= 0 then Some (s2rt_impred (knd)) else None ()
) : s2rtopt
//
val s2cs = let
  fun aux (
    ds: s1expdeflst
  ) :<cloref1> List_vt (s2cst) =
  (
    case+ ds of
    | list_cons (d, ds) => let
        val s2c = s1expdef_tr (res, d) in list_vt_cons (s2c, aux ds)
      end // end of [list_cons]
    | list_nil () => list_vt_nil ()
  ) // end of [aux]
in
  aux (ds)
end // end of [val]
//
val () = let
  fun loop
  (
    s2cs: List_vt (s2cst)
  ) : void =
    case+ s2cs of
    | ~list_vt_cons (s2c, s2cs) => let
        val () = the_s2expenv_add_scst (s2c) in loop (s2cs)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [loop]
in
  loop (s2cs)
end // end of [val]
//
in
  // nothing
end // end of [s1expdeflst_tr]

(* ****** ****** *)

fun s1aspdec_tr_arg (
  d: s1aspdec, xs: s1marglst, s2t_fun: &s2rt
) : List_vt (s2varlst) = let
//
fn auxerr (
  d: s1aspdec, x: s1marg
) : void = let
  val () = prerr_error2_loc (x.s1marg_loc)
  val () = filprerr_ifdebug ("s1aspdec_tr_arg")
  val () = prerr ": too many arguments for the assumed static constant."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_s1aspdec_tr_arg (d, x))
end // end of [auxerr]
//
in // in of [let]
//
case+ xs of
| list_cons (x, xs) => (
  case+ s2t_fun of
  | S2RTfun (s2ts_arg, s2t_res) => let
      val () = s2t_fun := s2t_res
      val s2vs = s1marg_trdn (x, s2ts_arg)
      val () = the_s2expenv_add_svarlst (s2vs)
    in
      list_vt_cons (s2vs, s1aspdec_tr_arg (d, xs, s2t_fun))
    end // end of [S2RTfun]
  | _ => let
      val () = auxerr (d, x) in list_vt_nil ()
    end (* end of [_] *)
  ) // end of [list_cons]
| list_nil () => list_vt_nil ()
//
end // end of [s1aspdec_tr_arg]

fun s1aspdec_tr_res (
  d: s1aspdec, s2t_res: s2rt
) : s2rt = let
//
fn auxerr (
  d: s1aspdec, s2t1: s2rt, s2t2: s2rt
) : void = {
  val () = prerr_error2_loc (d.s1aspdec_loc)
  val () = filprerr_ifdebug ("s1aspdec_tr_res")
  val () = prerr ": the static assumption is given the sort ["
  val () = prerr_s2rt (s2t1)
  val () = prerr "] but it is expected to be of the sort ["
  val () = prerr_s2rt (s2t2)
  val () = prerr "]."
  val () = prerr_newline ()
  val () = the_trans2errlst_add (T2E_s1aspdec_tr_res (d, s2t1, s2t2))
} // end of [auxerr]
//
in // in of [let]
//
case+ d.s1aspdec_res of
| Some s1t => let
    val s2t = s1rt_tr (s1t)
    val test = s2rt_ltmat1 (s2t, s2t_res)
  in
    if test then s2t else let
      val () = auxerr (d, s2t, s2t_res) in s2t
    end (* end of [if] *)
  end // end of [Some]
| None () => s2t_res
//
end // end of [s1aspdec_tr_res]

viewtypedef
s2aspdecopt_vt = Option_vt (s2aspdec)

fn s1aspdec_tr
  (d1c: s1aspdec): s2aspdecopt_vt = let
//
fn auxerr1 (
  d: s1aspdec, q: s0taq, id: symbol
) : void = let
  val () = prerr_error2_loc (d.s1aspdec_loc)
  val () = filprerr_ifdebug ("s1aspdec_tr")
  val () = prerr (": the static constant [")
  val () = ($SYN.prerr_s0taq (q); $SYM.prerr_symbol id)
  val () = prerr ("] is not abstract.")
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_s1aspdec_tr (d))
end // end of [auxerr1]
//
fn auxerr2 (
  d: s1aspdec, q: s0taq, id: symbol
) : void = let
  val () =
    prerr_error2_loc (d.s1aspdec_loc)
  // end of [val]
  val () = filprerr_ifdebug ("s1aspdec_tr")
  val () = prerr (": the identifier [")
  val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
  val () = prerr "] does not refer to a static constant."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_s1aspdec_tr (d))
end // end of [auxerr2]
//
fn auxerr3 (
  d: s1aspdec, q: s0taq, id: symbol
) : void = let
  val () = prerr_error2_loc (d.s1aspdec_loc)
  val () = prerr ": the identifier ["
  val () = ($SYN.prerr_s0taq q; $SYM.prerr_symbol id)
  val () = prerr "] is unrecognized."
  val () = prerr_newline ()
in
  the_trans2errlst_add (T2E_s1aspdec_tr (d))
end // end of [auxerr3]
//
  val loc = d1c.s1aspdec_loc
  val qid = d1c.s1aspdec_qid
  val q = qid.sqi0de_qua and id = qid.sqi0de_sym
  val ans = the_s2expenv_find_qua (q, id)
in
//
case+ ans of
| ~Some_vt s2i => begin case+ s2i of
  | S2ITMcst s2cs => let
      val s2cs = list_filter_fun<s2cst> (s2cs, s2cst_is_abstr)
    in
      case+ s2cs of
      | ~list_vt_cons
          (s2c, s2cs) => let
          val () = list_vt_free (s2cs)
          val (pfenv | ()) = the_s2expenv_push_nil ()
          var s2t_fun = s2cst_get_srt (s2c)
          val s2vss = s1aspdec_tr_arg (d1c, d1c.s1aspdec_arg, s2t_fun)
          val s2t_res = s1aspdec_tr_res (d1c, s2t_fun)
          val s2e_body = s1exp_trdn (d1c.s1aspdec_def, s2t_res)
          val () = the_s2expenv_pop_free (pfenv | (*none*))
          val s2e_def = s2exp_lamlst ((castvwtp1)s2vss, s2e_body)
          val () = list_vt_free (s2vss)
(*
          // HX: definition binding is to be done in [pats_trans3_decl.dats]
*)
        in
          Some_vt (s2aspdec_make (loc, s2c, s2e_def))
        end // end of [list_vt_cons]
      | ~list_vt_nil () => let
          val () = auxerr1 (d1c, q, id) in None_vt ()
        end // end of [list_vt_nil]
      end // end of [S2ITEMcst]
    | _ => let
        val () = auxerr2 (d1c, q, id) in None_vt ()
      end (* end of [_] *)
    end // end of [Some_vt]
  | ~None_vt () => let
      val () = auxerr3 (d1c, q, id) in None_vt ()
    end // end of [None_vt]
end // end of [s1aspdec_tr]

(* ****** ****** *)

local

fun
d1atconlst_tr (
  s2c: s2cst
, islin: bool
, isprf: bool
, s2vss0: s2varlstlst
, fil: filename
, d1cs: d1atconlst
) : d2conlst =
  case+ d1cs of
  | list_cons (d1c, d1cs) => let
      val d2c = d1atcon_tr (s2c, islin, isprf, s2vss0, fil, d1c)
    in
      list_cons (d2c, d1atconlst_tr (s2c, islin, isprf, s2vss0, fil, d1cs))
    end // end of [cons]
  | list_nil () => list_nil ()
(* end of [d1atconlst_tr] *)

in (* in of [local] *)

fn d1atdec_tr (
  s2c: s2cst, s2vss0: s2varlstlst, d1c: d1atdec
) : void = let
//
  val () = let
    val n = list_length (s2vss0) in
    if n >= 2 then {
      val () = prerr_error2_loc (d1c.d1atdec_loc)
      val () = filprerr_ifdebug "d1atdec_tr" // for debugging
      val () = prerr ": the declared type constructor is overly applied."
      val () = prerr_newline ()
      val () = the_trans2errlst_add (T2E_d1atdec_tr (d1c))
    } // end of [if]
  end // end of [val]
//
  val s2t_fun = s2cst_get_srt (s2c)
  val s2t_res = (
    case+ s2t_fun of S2RTfun (_, s2t) => s2t | s2t => s2t
  ) // end of [val]
  val islin = s2rt_is_lin s2t_res and isprf = s2rt_is_prf s2t_res
  val d2cs = d1atconlst_tr
    (s2c, islin, isprf, s2vss0, d1c.d1atdec_fil, d1c.d1atdec_con)
  // end of [val]
  val () = let // assigning tags to dynamic constructors
    fun aux (
      i: int, d2cs: d2conlst
    ) : void = case+ d2cs of
      | list_cons (d2c, d2cs) => let
          val () = d2con_set_tag (d2c, i) in aux (i+1, d2cs)
        end // end of [list_cons]
      | list_nil () => () // end of [list_nil]
    // end of [aux]
  in
    aux (0, d2cs)
  end // end of [val]
//
  val islst = (case+ d2cs of
    | list_cons (
        d2c1, list_cons (d2c2, list_nil ())
      ) =>
        if d2con_get_arity_real (d2c1) = 0 then (
          if d2con_get_arity_real (d2c2) > 0 then Some @(d2c1, d2c2)
          else None ()
        ) else (
          if d2con_get_arity_real (d2c2) = 0 then Some @(d2c2, d2c1)
          else None ()
        ) // end of [if]
      // end of [list_cons (_, list_cons (_, list_nil _))
    | _ => None () // end of [_]
  ) : Option @(d2con, d2con)
  val () = s2cst_set_islst (s2c, islst)
  val () = s2cst_set_dconlst (s2c, Some d2cs)
//
in
  // nothing
end // end of [d1atdec_tr]

end // end of [local]

extern
fun d1atdeclst_tr (
  datknd: int, d1cs_dat: d1atdeclst, d1cs_def: s1expdeflst
) : s2cstlst // end of [d1atdeclst_tr]
implement
d1atdeclst_tr (
  datknd, d1cs_dat, d1cs_def
) = let
//
typedef
T = (d1atdec, s2cst, s2varlstlst)
//
val s2t_res = s2rt_impred (datknd)
//
val d1cs2cs2vsslst = let
//
  var res: List (T) = list_nil ()
//
  fun aux .<>. (
    d1c: d1atdec, res: &List (T)
  ) :<cloref1> void = let
    val argvar = l2l (
      list_map_fun (d1c.d1atdec_arg, a1msrt_tr_symsrt)
    ) : List (syms2rtlst)
    val s2vss = let
      fun f (
        xs: syms2rtlst
      ) : s2varlst =
        case+ xs of
        | list_cons (x, xs) => let
            val isnamed = (x.0 != $SYM.symbol_empty)
          in
            if isnamed then let
              val s2v = s2var_make_id_srt (x.0, x.1) in list_cons (s2v, f (xs))
            end else f (xs) // end of [if]
          end // end of [list_cons]
        | list_nil () => list_nil ()
      // end of [f]
      fun ff (
        xss: List (syms2rtlst)
      ) : s2varlstlst =
        case+ xss of
        | list_cons (xs, xss) => let
             val s2vs = f (xs) and s2vss = ff (xss)
           in
             if list_is_cons (s2vs) then list_cons (s2vs, s2vss) else s2vss
           end // end of [list_vt_cons]
        | list_nil () => list_nil ()
      // end of [ff]
    in
      ff (argvar)
    end : s2varlstlst
//
    val s2tss_arg = let
      fun f
        (xs: syms2rtlst): s2rtlst =
        case+ xs of
        | list_cons (x, xs) => list_cons (x.1, f (xs))
        | list_nil () => list_nil ()
      // end of []
    in
      l2l (list_map_fun (argvar, f))
    end : s2rtlstlst
//
    val s2c = s2cst_make_dat (
      d1c.d1atdec_sym, d1c.d1atdec_loc, s2tss_arg, s2t_res, argvar
    ) // end of [val]
    val () = the_s2expenv_add_scst (s2c)
//
  in
    res := list_cons ((d1c, s2c, s2vss), res)
  end // end of [val]
//
  fun auxlst (
    d1cs: d1atdeclst, res: &List(T)
  ) :<cloref1> void = case+ d1cs of
    | list_cons (d1c, d1cs) => let
        val () = aux (d1c, res) in auxlst (d1cs, res)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [auxlst]
//
in
  auxlst (d1cs_dat, res); res
end : List (T) // end of [d1cs2cs2vsslst]
//
val () = aux (d1cs_def) where {
  fun aux (
    d1cs: s1expdeflst
  ) : void = begin case+ d1cs of
    | list_cons (d1c, d1cs) => let
        val s2c = s1expdef_tr (None, d1c)
        val () = the_s2expenv_add_scst (s2c)
      in
        aux (d1cs)
      end // end of [cons]
    | list_nil () => () // end of [list_nil]
  end (* end of [aux] *)
} // end of [val]
//
fun aux (
  xs: List (T)
) : s2cstlst = case+ xs of
  | list_cons (x, xs) => let
      val () = d1atdec_tr (x.1, x.2, x.0) in list_cons (x.1, aux xs)
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux]
in
//
aux (d1cs2cs2vsslst)
//
end // end of [d1atdeclst_tr]

(* ****** ****** *)
//
// HX: [exn] is considered a viewtype constructor
//
fn e1xndec_tr (
  s2c: s2cst, d1c: e1xndec
) : d2con = let
  val loc = d1c.e1xndec_loc
  val fil = d1c.e1xndec_fil and id = d1c.e1xndec_sym
  val (pfenv | ()) = the_s2expenv_push_nil ()
  val s2qs = l2l (list_map_fun (d1c.e1xndec_qua, q1marg_tr))
  val npf = d1c.e1xndec_npf
  val s1es_arg = d1c.e1xndec_arg
  val s2es_arg = s1explst_trdn_vt0ype (s1es_arg)
  val () = the_s2expenv_pop_free (pfenv | (*none*))
  val d2c = d2con_make
    (loc, fil, id, s2c, 1(*vwtp*), s2qs, npf, s2es_arg, None(*ind*))
  val () = d2con_set_tag (d2c, ~1)
  val () = the_d2expenv_add_dcon (d2c)
in
  d2c (* HX: the defined exception constructor *)
end // end of [e1xndec_tr]

extern
fun e1xndeclst_tr (d1cs: e1xndeclst): d2conlst
implement
e1xndeclst_tr (d1cs) = let
  fun aux (
    s2c: s2cst, d1cs: e1xndeclst
  ) : d2conlst =
    case+ d1cs of
    | list_cons (d1c, d1cs) => let
        val d2c = e1xndec_tr (s2c, d1c)
      in
        list_cons (d2c, aux (s2c, d1cs))
      end // end of [list_cons]
    | list_nil () => list_nil ()
  // end of [aux]
  val s2c = s2cstref_get_cst (the_exception_vtype)
  val d2cs = aux (s2c, d1cs)
  val d2cs0 = (
    case+ s2cst_get_dconlst (s2c) of
    | Some d2cs0 => list_append (d2cs, d2cs0) | None () => d2cs
  ) : d2conlst // end of [val]
  val () = s2cst_set_dconlst (s2c, Some d2cs0)
in
  d2cs (*d2conlst*)
end // end of [e1xndeclst_tr]

(* ****** ****** *)

fun
c1lassdec_tr
(
  id: i0de, sup: s1expopt
) : void = () where {
//
val s2c =
s2cst_make
(
  id.i0de_sym // sym
, id.i0de_loc // location
, s2rt_cls // srt
, None(*isabs*)
, false(*iscon*), false(*isrec*), false(*isasp*)
, None (*islst*)
, list_nil () // argvar
, None () // def
) (* end of [s2cst_make] *)
//
val () = (
case+ sup of
| Some s1e => {
    val s2e = s1exp_trdn (s1e, s2rt_cls)
    val ((*void*)) = s2cst_add_supcls (s2c, s2exp_hnfize(s2e))
  } // end of [Some]
| None () => ()
) (* end of [val] *)
//
val () = the_s2expenv_add_scst (s2c)
//
} // end of [c1lassdec_tr]

(* ****** ****** *)

local

fun s2exp_get_arylst
  (s2e: s2exp): List int =
  case+ s2e.s2exp_node of
  | S2Efun (_, _, _, _, s2es, s2e) =>
      list_cons (list_length s2es, s2exp_get_arylst (s2e))
  | S2Eexi (_, _, s2e) => s2exp_get_arylst (s2e)
  | S2Euni (_, _, s2e) => s2exp_get_arylst (s2e)
  | S2Emetfun (_, _, s2e) => s2exp_get_arylst (s2e)
  | _ => list_nil ()
// end of [s2exp_get_arylst]

in (* in of [local] *)

fun d1cstdec_tr
(
  dck: dcstkind
, s2qs: s2qualst
, d1c: d1cstdec
) : d2cst = let
  val loc = d1c.d1cstdec_loc
  val fil = d1c.d1cstdec_fil
  val sym = d1c.d1cstdec_sym
//
// HX-2012:
// it is either prop or t@ype; it cannot be linear
//
  val isprf =
    dcstkind_is_proof (dck)
  val s2t_cst =
    (if isprf then s2rt_prop else s2rt_t0ype): s2rt
//
  val s1e_cst = d1c.d1cstdec_type
  var s2e_cst =
    s1exp_trdn (s1e_cst, s2t_cst)
  val arylst = s2exp_get_arylst (s2e_cst)
  val extdef = d1c.d1cstdec_extdef
  val d2c =
    d2cst_make (sym, loc, fil, dck, s2qs, arylst, s2e_cst, extdef)
  // end of [val]
//
  val () = the_d2expenv_add_dcst (d2c)
//
in
  d2c
end // end of [d1cstdec_tr]

end // end of [local]

fun d1cstdeclst_tr
(
  dck: dcstkind, s2qs: s2qualst, d1cs: d1cstdeclst
) : d2cstlst = let
in
  case+ d1cs of
  | list_cons (d1c, d1cs) => let
      val d2c = d1cstdec_tr (dck, s2qs, d1c)
    in
      list_cons (d2c, d1cstdeclst_tr (dck, s2qs, d1cs))
    end // end of [cons]
  | list_nil () => list_nil ()
end // end of [d1cstdeclst_tr]

(* ****** ****** *)

local

fun trans2_env_add_m2acarg
  (x: m2acarg): void = let
in
  case+ x of
  | M2ACARGsta (s2vs) =>
      the_s2expenv_add_svarlst (s2vs)
    // end of [M2ACARGsta]
  | M2ACARGdyn (d2vs) =>
      the_d2expenv_add_dmacvarlst (d2vs)
    // end of [M2ACARGdyn]
end // end of [trans2_env_add_m2acarg]
fun trans2_env_add_m2acarglst
  (xs: m2acarglst): void = list_app_fun (xs, trans2_env_add_m2acarg)
// end of [trans2_env_add_m2acarglst]

in (* in of [local] *)

fn m1acdef_tr (
  knd: int, d2m: d2mac, d1c: m1acdef
) : void = let
//
val loc = d1c.m1acdef_loc
and sym = d1c.m1acdef_sym
val (pfenv | ()) = the_trans2_env_push ()
val arglst = d2mac_get_arglst (d2m)
//
(*
val out = stdout_ref
val () = fprintf
  (out, "m1acdef_tr: knd = %i\n", @(knd))
val () =
  fprint_string (out, "m1acdef_tr: arglst =\n")
val () = fprint_m2acarglst (out, arglst)
val () = fprint_newline (out)
*)
//
val () = trans2_env_add_m2acarglst (arglst)
val () = the_macdeflev_inc ()
val () = if knd >= 1 then the_maclev_dec (loc)
val def = d1exp_tr (d1c.m1acdef_def)
val () = if knd >= 1 then the_maclev_inc (loc)
val () = the_macdeflev_dec ()
val () = the_trans2_env_pop (pfenv | (*none*))
val () = d2mac_set_def (d2m, def)
//
in
  // empty
end // end of [m1acdef_tr]

end // end of [local]

local

fun m1acarg_tr
  (x: m1acarg): m2acarg = let
in
  case+ x.m1acarg_node of
  | M1ACARGdyn (ids) => let
      fun f (x: i0de): d2var =
        d2var_make (x.i0de_loc, x.i0de_sym)
      val d2vs = list_map_fun (ids, f)
    in
      M2ACARGdyn ((l2l)d2vs)
    end
  | M1ACARGsta (s1as) => let
      fun f (s1a: s1arg): s2var = let
        val s2t = (
          case+ s1a.s1arg_srt of
          | Some (s1t) => s1rt_tr (s1t) | None () => s2rt_t0ype
        ) : s2rt // end of [val]
      in
        s2var_make_id_srt (s1a.s1arg_sym, s2t)
      end // end of [f]
      val s2vs = list_map_fun (s1as, f)
    in
      M2ACARGsta ((l2l)s2vs)
    end
end // end of [m1acarg_tr]

fun m1acarglst_tr
  (m1as: m1acarglst): m2acarglst = let
  val m2as = list_map_fun (m1as, m1acarg_tr) in (l2l)m2as
end // end of [m1acarglst_tr]

in (* in of [local] *)

fun m1acdeflst_tr (
  knd: int, d1cs: m1acdeflst
) : void = let
//
// knd: 0/1/2 => short/long/longrec
//
fun aux1 (
  knd: int, d1cs: m1acdeflst
) : d2maclst = let
in
//
case+ d1cs of
| list_cons
    (d1c, d1cs) => let
    val loc = d1c.m1acdef_loc
    val sym = d1c.m1acdef_sym
    val def = d2exp_empty (loc)
    val args = m1acarglst_tr (d1c.m1acdef_arg)
    val d2m = d2mac_make (loc, sym, knd, args, def)
    val () = if knd >= 2 then the_d2expenv_add_dmacdef (d2m)
    val d2ms = aux1 (knd, d1cs)
  in
    list_cons (d2m, d2ms)
  end // end of [aux1]
| list_nil () => list_nil ()
//
end // end of [aux1]
val d2ms = aux1 (knd, d1cs)
//
fun loop2 (
  d2ms: d2maclst, d1cs: m1acdeflst
) : void = let
in
  case+ d2ms of
  | list_cons (d2m, d2ms) => let
      val-list_cons (d1c, d1cs) = d1cs
      val knd = d2mac_get_kind (d2m)
      val d2c = m1acdef_tr (knd, d2m, d1c)
      val () = if knd <= 1 then the_d2expenv_add_dmacdef (d2m)
    in
      loop2 (d2ms, d1cs)
    end // end of [list_cons]
  | list_nil () => ()
end // end of [loop2]
val () = loop2 (d2ms, d1cs)
//
in
  // nothing
end // end of [m1acdeflst_tr]

end // end of [local]

(* ****** ****** *)

fn f1undec_tr
(
  decarg: s2qualst
, d2v: d2var, f1d: f1undec
) : f2undec = let
  val (
  ) = d2var_set_decarg (d2v, decarg)
  val def = d1exp_tr (f1d.f1undec_def)
(*
  val () = begin
    print "f1undec_tr: d2v = "; print d2v; print_newline ()
    print "f1undec_tr: def = "; print def; print_newline ()
  end // end of [val]
*)
  val ann = witht1ype_tr (f1d.f1undec_ann)
in
  f2undec_make (f1d.f1undec_loc, d2v, def, ann)
end // end of [f1undec_tr]

fn f1undeclst_tr
(
  knd: funkind
, decarg: s2qualst, f1ds: f1undeclst
) : f2undeclst = let
//
  val isprf = funkind_is_proof (knd)
  val isrec = funkind_is_recursive (knd)
//
  val d2vs = let
    fun aux1
      {n:nat} .<n>.
    (
      isprf: bool
    , f1ds: list (f1undec, n)
    ) : list (d2var, n) =
      case+ f1ds of
      | list_cons
          (f1d, f1ds) => let
          val sym = f1d.f1undec_sym
          val loc = f1d.f1undec_sym_loc
          val d2v = d2var_make (loc, sym)
          val () = d2var_set_isfix (d2v, true)
          val () = d2var_set_isprf (d2v, isprf)
        in
          list_cons (d2v, aux1 (isprf, f1ds))
        end // end of [list_cons]
      | list_nil () => list_nil ()
    // end of [aux1]
  in
    aux1 (isprf, f1ds)
  end // end of [val]
//
  val () = (
    if isrec then the_d2expenv_add_dvarlst (d2vs) else ()
  ) : void // end of [val]
//
  val f2ds = let
    fun aux2
      {n:nat} .<n>.
    (
      decarg: s2qualst
    , d2vs: list (d2var, n)
    , f1ds: list (f1undec, n)
    ) : list (f2undec, n) =
      case+ d2vs of
      | list_cons (d2v, d2vs) => let
          val+list_cons (f1d, f1ds) = f1ds
          val f2d = f1undec_tr (decarg, d2v, f1d)
          val f2ds = aux2 (decarg, d2vs, f1ds)
        in
          list_cons (f2d, f2ds)
        end // end of [list_cons]
      | list_nil () => list_nil ()
    // end of [aux2]
  in
    aux2 (decarg, d2vs, f1ds)
  end // end of [val]
//
  val () = (
    if isrec then () else the_d2expenv_add_dvarlst (d2vs)
  ) : void // end of [val]
//
in
  f2ds
end // end of [f1undeclst_tr]

(* ****** ****** *)

fn v1aldec_tr
(
  v1d: v1aldec, p2t: p2at
) : v2aldec = let
  val loc = v1d.v1aldec_loc
  val def = d1exp_tr (v1d.v1aldec_def)
  val ann = witht1ype_tr (v1d.v1aldec_ann)
in
  v2aldec_make (loc, p2t, def, ann)
end // end of [v1aldec_tr]

fn v1aldeclst_tr{n:nat}
(
  isrec: bool, v1ds: list (v1aldec, n)
) : v2aldeclst = let
  val p2ts = list_map_fun<v1aldec>
    (v1ds, lam (v1d) =<1> p1at_tr (v1d.v1aldec_pat))
  val p2ts = (l2l)p2ts: list (p2at, n)
  val s2vs = $UT.lstord2list (p2atlst_svs_union p2ts)
  val d2vs = $UT.lstord2list (p2atlst_dvs_union p2ts)
in
  if not(isrec) then let
    val v2ds = list_map2_fun<v1aldec,p2at> (v1ds, p2ts, v1aldec_tr)
    val () = the_s2expenv_add_svarlst s2vs
    val () = the_d2expenv_add_dvarlst d2vs
  in
    l2l (v2ds)
  end else let
    val () = the_d2expenv_add_dvarlst (d2vs)
    val v2ds = list_map2_fun<v1aldec,p2at> (v1ds, p2ts, v1aldec_tr)
    val () = the_s2expenv_add_svarlst (s2vs)
  in
    l2l (v2ds)
  end // end of [if]
end (* end of [v1aldeclst_tr] *)

(* ****** ****** *)

fn v1ardec_tr
(
  v1d: v1ardec
) : v2ardec = let
(*
// HX: toplevel stack allocation is supported.
*)
  val sym = v1d.v1ardec_sym
  val loc_sym = v1d.v1ardec_sym_loc
  val d2v_ptr = d2var_make (loc_sym, sym)
  // [s2v_addr] is introduced as a static variable of the
  val s2v_addr = s2var_make_id_srt (sym, s2rt_addr) // same name
  val s2e_addr = s2exp_var (s2v_addr)
  val () = d2var_set_addr (d2v_ptr, Some (s2e_addr))
  val s2eopt = (
    case+ v1d.v1ardec_type of
    | Some s1e => let
        val s2e = s1exp_trdn_impred (s1e) in Some (s2e)
      end // end of [Some]
    | None () => None ()
  ) : s2expopt // end of [val]
  val wth = (
    case+ v1d.v1ardec_wth of
    | Some (i0de) => let
        val d2v = d2var_make (i0de.i0de_loc, i0de.i0de_sym)
      in
        Some (d2v)
      end // end of [Some]
    | None () => None ()
  ) : d2varopt // end of [val]
  val ini = d1expopt_tr (v1d.v1ardec_ini)
in
  v2ardec_make (
    v1d.v1ardec_loc, v1d.v1ardec_knd, d2v_ptr, s2v_addr, s2eopt, wth, ini
  ) // end of [v2ardec_make]
end // end of [v1ardec_tr]

fn v1ardeclst_tr
(
  v1ds: v1ardeclst
) : v2ardeclst = v2ds where {
  val v2ds =
    l2l (list_map_fun (v1ds, v1ardec_tr))
  // end of [val]
  val () = list_app_fun (v2ds, f) where {
    fn f (v2d: v2ardec): void = let
      val () = the_s2expenv_add_svar (v2d.v2ardec_svar)
      val () = the_d2expenv_add_dvar (v2d.v2ardec_dvar)
    in
      case+ v2d.v2ardec_wth of
        Some (d2v) => the_d2expenv_add_dvar (d2v) | None () => ()
      // end of [case]
    end // end of [f]
  } (* end of [val] *)
} // end of [v1ardeclst_tr]

(* ****** ****** *)

local

fun
auxkndck
(
  v1d: v1ardec
) : void = let
  val stadyn = v1d.v1ardec_knd
in
//
if stadyn > 0 then let
  val () =
    prerr_warning2_loc (v1d.v1ardec_loc)
  // end of [val]
  val () = filprerr_ifdebug "prv1ardec_tr"
  val () = prerr ": the dynalloc mark (!) is ignored."
  val () = prerr_newline ()
in
(*
  the_trans2errlst_add (T2E_prv1ardec_tr (v1d))
*)
end // end of [if]
//
end // end of [auxkndck]

fun
auxwthck
(
  v1d: v1ardec
) : void = let
  val idopt = v1d.v1ardec_wth
in
  case+ idopt of
  | Some id => let
      val () =
        prerr_warning2_loc (v1d.v1ardec_loc)
      // end of [val]
      val () = filprerr_ifdebug "prv1ardec_tr"
      val () = prerr ": the dynamic identifier ["
      val () = $SYN.prerr_i0de (id)
      val () = prerr "] is ignored."
      val () = prerr_newline ()
    in
(*
      the_trans2errlst_add (T2E_prv1ardec_tr (v1d))
*)
    end // end of [Some]
  | None _ => ()
end // end of [auxwthck]

in (* in of [local] *)

fun
prv1ardec_tr
(
  v1d: v1ardec
) : prv2ardec = let
//
val () = auxkndck (v1d)
val () = auxwthck (v1d)
//
val sym = v1d.v1ardec_sym
val loc_sym = v1d.v1ardec_sym_loc
val d2v = d2var_make (loc_sym, sym)
val s2eopt = (
  case+ v1d.v1ardec_type of
  | Some s1e => let
      val s2e = s1exp_trdn_impred (s1e) in Some (s2e)
    end // end of [Some]
  | None () => None ()
) : s2expopt // end of [val]
//
val d2eopt = d1expopt_tr (v1d.v1ardec_ini)
//
in
  prv2ardec_make (v1d.v1ardec_loc, d2v, s2eopt, d2eopt)
end // end of [prv1ardec_tr]

end // end of [local]

fun
prv1ardeclst_tr
(
  v1ds: v1ardeclst
) : prv2ardeclst = v2ds where {
  val v2ds =
    l2l (list_map_fun (v1ds, prv1ardec_tr))
  // end of [val]
  val () = list_app_fun (v2ds, f) where {
    fn f (v2d: prv2ardec): void = the_d2expenv_add_dvar (v2d.prv2ardec_dvar)
  } (* end of [val] *)
} // end of [prv1ardeclst_tr]

(* ****** ****** *)

(*
//
// HX:
// this one is implemented in [pats_trans2_impdec.dats]
//
extern fun i1mpdec_tr (d1c: d1ecl): Option_vt (i2mpdec)
*)

(* ****** ****** *)

fn s1taload_tr
(
  loc0: location
, idopt: symbolopt
, fil: filename
, loadflag: int
, d1cs: d1eclist
, loaded: &int? >> int
) : filenv = let
(*
val () = print "s1taload_tr: staid = "
val () = (
case+ idopt of
| Some id => $SYM.print_symbol (id) | None () => print "(*none*)"
) : void // end of [val]
val () = print_newline ()
val () = begin
  print "s1taload_tr: filename = "; $FIL.print_filename_full fil; print_newline ()
end // end of [val]
*)
//
val fsymb =
  $FIL.filename_get_fullname (fil)
val (pflev | ()) = the_staload_level_push ()
val ans = the_filenvmap_find (fsymb)
//
val fenv =
(
case+
:(
loaded: int
) => ans of
| ~Some_vt fenv => let
    val () = loaded := 1 in fenv
  end // end of [Some_vt]
| ~None_vt _ => let
    val () = loaded := 0
    val (pfsave | ()) = the_trans2_env_save ()
    val opt = $GLOB.the_PACKNAME_get ()
    val d2cs = d1eclist_tr (d1cs)
    val () = $GLOB.the_PACKNAME_set (opt)
    val (m0, m1, m2) = the_trans2_env_restore (pfsave | (*none*))
    val fenv = filenv_make (fil, m0, m1, m2, d2cs)
    val () = the_filenvmap_add (fsymb, fenv)
  in
    fenv
  end // end of [None_vt]
) : filenv // end of [val]
//
val () = (
case+ idopt of
| Some id =>
    the_s2expenv_add (id, S2ITMfilenv fenv)
| None ((*void*)) =>
    $NS.the_namespace_add (fenv) // opened file
) : void // end of [val]
//
val () = the_staload_level_pop (pflev | (*none*))
//
in
  fenv
end // end of [s1taload_tr]

(* ****** ****** *)

implement
d1ecl_tr (d1c0) = let
  val loc0 = d1c0.d1ecl_loc
(*
  val () = begin
    print "d1ecl_tr: d1c0 = "; print_d1ecl d1c0; print_newline ()
  end // end of [val]
*)
//
fun auxcheck_impdec
(
  d1c0: d1ecl, knd: int, impdec: i2mpdec
) : void = let
  val d2c = impdec.i2mpdec_cst
  val okay = (
    if knd > 0 then d2cst_is_prf (d2c) else d2cst_is_nonprf (d2c)
  ) : bool // end of [val]
  val () = if ~okay then let
    val () = prerr_error2_loc (d1c0.d1ecl_loc)
    val () = filprerr_ifdebug "d1ecl_tr: auxcheck_impdec" // for debugging
    val () = if knd > 0 then
      prerr ": the implemented dynamic constant is required to be proof."
    val () = if knd = 0 then
      prerr ": the implemented dynamic constant is required to be nonproof."
    val () = prerr_newline ()
  in
    the_trans2errlst_add (T2E_d1ecl_tr_impdec (d1c0))
  end // end of [if] // end of [val]
in
  // nothing
end // end of [auxcheck_impdec]
//
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => d2ecl_none (loc0)
| D1Clist (ds) => let
    val ds = l2l (list_map_fun (ds, d1ecl_tr))
  in
    d2ecl_list (loc0, ds)
  end // end of [D1Clist]
//
| D1Cpackname (opt) => let
    val (
    ) = $GLOB.the_PACKNAME_set (opt)
  in
    d2ecl_none (loc0)
  end (* end of [D1Cpackname] *)
//
| D1Csymintr (ids) => let
    val () = symintr_tr (ids) in d2ecl_symintr (loc0, ids)
  end // end of [D1Csymintr]
| D1Csymelim (ids) => let
    val () = symelim_tr (ids) in d2ecl_symelim (loc0, ids)
  end // end of [D1Csymelim]
| D1Coverload
    (id, dqid, pval) => let
    val d2iopt =
      overload_tr (d1c0, id, dqid, pval)
    // end of [val]
  in
    d2ecl_overload (loc0, id, d2iopt)
  end // end of [D1Coverload]
//
| D1Ce1xpdef (id, def) => let
    val () = the_s2expenv_add (id, S2ITMe1xp def)
    val () = the_d2expenv_add (id, D2ITMe1xp def)
  in
    d2ecl_none (loc0)
  end // end of [D1Ce1xpdef]
| D1Ce1xpundef (id, def) => let
    val () = the_s2expenv_add (id, S2ITMe1xp def)
    val () = the_d2expenv_add (id, D2ITMe1xp def)
  in
    d2ecl_none (loc0)
  end // end of [D0Ce0xpundef]
//
| D1Cdatsrts (ds) => let
    val () = d1atsrtdeclst_tr (ds) in d2ecl_none (loc0)
  end // end of [D1Cdatsrts]
| D1Csrtdefs (ds) => let
    val () = list_app_fun (ds, s1rtdef_tr) in d2ecl_none (loc0)
  end // end of [D1Csrtdefs]
| D1Cstacsts (ds) => let
    val () = list_app_fun (ds, s1tacst_tr) in d2ecl_none (loc0)
  end // end of [D1Cstacsts]
| D1Cstacons (knd, ds) => let
    val () = s1taconlst_tr (knd, ds) in d2ecl_none (loc0)
  end // end of [D1Cstacons]
(*
| D1Cstavars (d1s) => let
    val d2s = s1tavarlst_tr (d1s) in d2ecl_stavars (loc0, d2s)
  end // end of [D1Cstavars]
*)
| D1Ctkindef (d) => let
    val () = t1kindef_tr (d) in d2ecl_none (loc0)
  end // end of [D1Ckindef]
| D1Csexpdefs (knd, ds) => let
    val () = s1expdeflst_tr (knd, ds) in d2ecl_none (loc0)
  end // end of [D1Csexpdefs]
| D1Csaspdec (d1c) => let
    val d2copt = s1aspdec_tr (d1c)
  in
    case+ d2copt of
    | ~Some_vt d2c => d2ecl_saspdec (loc0, d2c)
    | ~None_vt () =>
        d2ecl_none (loc0) // HX: error already reported
    // end of [case]
  end // end of [D1Csaspdec]
//
| D1Cdatdecs
  (
    knd, d1cs_dat, d1cs_def
  ) => let
    val s2cs = d1atdeclst_tr (knd, d1cs_dat, d1cs_def)
  in
    d2ecl_datdecs (loc0, knd, s2cs)
  end // end of [D1Cdatdecs]
| D1Cexndecs (d1cs) => let
    val d2cs = e1xndeclst_tr d1cs in d2ecl_exndecs (loc0, d2cs)
  end // end of [D1Cexndecs]
//
| D1Cclassdec (id, sup) => let
    val () = c1lassdec_tr (id, sup) in d2ecl_none (loc0)
  end // end of [D1Cclassdec]
| D1Cextype
  (
    name, s1e_def
  ) => let
    val s2e_def = s1exp_trdn_impred (s1e_def)
  in
    d2ecl_extype (loc0, name, s2e_def)
  end // end of [D1Cextype]
| D1Cextype
  (
    knd, name, s1e_def
  ) => let
    val s2t_def = s2rt_impred (knd)
    val s2e_def = s1exp_trdn (s1e_def, s2t_def)
  in
    d2ecl_extype (loc0, name, s2e_def)
  end // end of [D1Cextype]
| D1Cextval (name, def) => let
    val def = d1exp_tr (def) in d2ecl_extval (loc0, name, def)
  end // end of [D1Cextval]
| D1Cextcode (knd, pos, code) => d2ecl_extcode (loc0, knd, pos, code)
//
| D1Cdcstdecs
  (
    dck, decarg, d1cs
  ) => let
    val (pfenv | ()) = the_s2expenv_push_nil ()
    val s2qs = l2l (list_map_fun (decarg, q1marg_tr_dec))
    val d2cs = d1cstdeclst_tr (dck, s2qs, d1cs)
    val () = the_s2expenv_pop_free (pfenv | (*none*))
  in
    d2ecl_dcstdecs (loc0, dck, d2cs)
  end // end of [D1Cdcstdecs]
//
| D1Cmacdefs
  (
    knd, isrec, d1cs
  ) => let
    val knd = (
      if isrec then (if knd = 0 then 0 else 2) else knd
    ) : int // end of [val]
    val () = m1acdeflst_tr (knd, d1cs) in d2ecl_none (loc0)
  end // end of [D1Cmacdefs]
//
| D1Cimpdec
  (
    knd, _arg, _dec
  ) => let
    val d2copt = i1mpdec_tr (d1c0)
  in
    case+ d2copt of
    | ~Some_vt (impdec) => let
        val () =
          auxcheck_impdec (d1c0, knd, impdec)
        // end of [val]
      in
        d2ecl_impdec (loc0, knd, impdec)
      end // end of [Some_vt]
//
// HX: the error is already reported
//
    | ~None_vt () => d2ecl_none (loc0)
  end // end of [D1Cimpdec]
//
| D1Cfundecs
  (
    funknd, decarg, f1ds
  ) => let
//
    val istmp = list_is_cons (decarg)
    val () = if istmp then the_tmplev_inc ()
//
    val (pfenv | ()) = the_trans2_env_push ()
//
    val tmplev = the_tmplev_get ()
    val s2qs = list_map_fun (decarg, q1marg_tr_dec)
    val s2qs = list_of_list_vt (s2qs)
    val () = s2qualstlst_set_tmplev (s2qs, tmplev)
//
    val f2ds = f1undeclst_tr (funknd, s2qs, f1ds)
//
    val () = if istmp then the_tmplev_dec ()
//
    val () = the_trans2_env_pop (pfenv | (*none*))
//
    val () = the_d2expenv_add_fundeclst (funknd, f2ds)
//
  in
    d2ecl_fundecs (loc0, funknd, s2qs, f2ds)
  end // end of [D1Cfundecs]
//
| D1Cvaldecs
  (
    knd, isrec, v1ds
  ) => let
    val v2ds = v1aldeclst_tr (isrec, v1ds)
  in
    if not(isrec) then
      d2ecl_valdecs (loc0, knd, v2ds)
    else
      d2ecl_valdecs_rec (loc0, knd, v2ds)
    // end of [if]
  end // end of [D1Cvaldecs]
//
| D1Cvardecs
    (knd, v1ds) => (
    if knd = 0 then let
      val v2ds = v1ardeclst_tr (v1ds) in d2ecl_vardecs (loc0, v2ds)
    end else let // knd = 1
      val v2ds = prv1ardeclst_tr (v1ds) in d2ecl_prvardecs (loc0, v2ds)
    end // end of [if]
  ) // end of [D1Cvardecs]
//
| D1Cinclude (d1cs) => let
    val d2cs = d1eclist_tr (d1cs) in d2ecl_include (loc0, d2cs)
  end // end of [D1Cinclude]
//
| D1Cstaload
  (
    idopt, fil, loadflag, d1cs
  ) => let
    var loaded: int
    val fenv =
      s1taload_tr (loc0, idopt, fil, loadflag, d1cs, loaded)
    // end of [val]
  in
    d2ecl_staload (loc0, idopt, fil, loadflag, fenv, loaded)
  end // end of [D1Cstaload]
//
| D1Cdynload (fil) => d2ecl_dynload (loc0, fil)
//
| D1Clocal
  (
    d1cs_head, d1cs_body
  ) => let
    val (pf1env | ()) = the_trans2_env_push ()
    val d2cs_head = d1eclist_tr (d1cs_head)
    val (pf2env | ()) = the_trans2_env_push ()
    val d2cs_body = d1eclist_tr (d1cs_body)
    val () = the_trans2_env_localjoin (pf1env, pf2env | (*none*))
  in
    d2ecl_local (loc0, d2cs_head, d2cs_body)
  end // end of [D1Clocal]
//
(*
| _ => let
    val () = prerr_error2_loc (loc0)
    val () = prerrln! (": d1ecl_tr: not implemented: d1c0 = ", d2c0)
  in
    d2ecl_none (loc0)
  end // end of [_]
*)
//
end // end of [d1ecl_tr]

(* ****** ****** *)

implement
d1eclist_tr (d1cs) = let
  val d2cs = list_map_fun (d1cs, d1ecl_tr) in list_of_list_vt (d2cs)
end // end of [d1eclist_tr]

(* ****** ****** *)

implement
d1eclist_tr_errck
  (d1cs) = d2cs where
{
  val d2cs = d1eclist_tr (d1cs)
  val () = the_trans2errlst_finalize ()
} // end of [d1eclist_tr_errck]

(* ****** ****** *)

(* end of [pats_trans2_decl.dats] *)
