(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload SYM = "pats_symbol.sats"
macdef EQEQ = $SYM.symbol_EQEQ
overload = with $SYM.eq_symbol_symbol

(* ****** ****** *)

staload "pats_basics.sats"
macdef prerr_ifdebug (x) = if (debug_flag_get () > 0) then prerr ,(x)

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_staexp2.sats"
staload "pats_dynexp2.sats"

(* ****** ****** *)

staload "pats_trans2.sats"
staload "pats_trans2_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_error2_loc
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_error2_loc]
fn prerr_interror () = prerr "INTERROR(pats_trans2_decl)"
fn prerr_interror_loc (loc: location) = (
  $LOC.prerr_location loc; prerr ": INTERROR(pats_trans2_decl)"
) // end of [prerr_interror_loc]

(* ****** ****** *)

fn d1atsrtdec_tr (
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
    , list_nil () // argvar
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
  ) : s2cstlst =
    case+ d1cs of
    | list_cons (d1c, d1cs) => begin
        list_cons (aux (i, res, d1c), auxlst (i+1, res, d1cs))
      end // end of [cons]
    | list_nil () => list_nil ()
  // end of [auxlst]
//
in
  auxlst (0, res, d1c.d1atsrtdec_con)
end // end of [d1atsrtdec_tr]

fn d1atsrtdeclst_tr
  (d1cs: d1atsrtdeclst) = let
//
  typedef T = (d1atsrtdec, s2rtdat, s2rt)
//
  fun loop1 (xs0: List_vt (T)): void =
    case+ xs0 of
    | ~list_vt_cons (x, xs) => let
        val s2cs = d1atsrtdec_tr (x.2, x.0)
        val () = s2rtdat_set_conlst (x.1, s2cs)
      in
        loop1 (xs)
      end // end of [list_vt_cons]
    | ~list_vt_nil () => ()
  // end of [loop1]
//
  fun loop2 (
    d1cs: d1atsrtdeclst, res: List_vt (T)
  ) : void =
    case+ d1cs of
    | list_cons (d1c, d1cs) => let
        val id = d1c.d1atsrtdec_sym
        val s2td = s2rtdat_make (id)
        val s2t = S2RTbas (S2RTBASdef s2td)
//
        val s2ts_arg = '[s2t, s2t]
        val s2t_eqeq = s2rt_fun (s2ts_arg, s2rt_bool)
        val s2c_eqeq = s2cst_make (
          EQEQ // sym
        , d1c.d1atsrtdec_loc
        , s2t_eqeq // srt
        , None () // isabs
        , false // iscon
        , false // isrec
        , false // isasp
        , None () // islst
        , list_nil () // argvar 
        , None () // def
        ) // end of [val]
        val () = the_s2expenv_add_scst (s2c_eqeq)
//
        val () = the_s2rtenv_add (id, S2TEsrt s2t)
      in
        loop2 (d1cs, list_vt_cons (@(d1c, s2td, s2t), res))
      end // end of [list_cons]
    | list_nil () => loop1 res
  // end of [loop2]
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
        s2rt_fun (a1msrt_tr (x), aux (xs, res))
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
  , list_nil () // argvar
  , None () // def
  ) // end of [s2cst_make]
in
  the_s2expenv_add_scst (s2c)
end // end of [s1tacst_tr]

(* ****** ****** *)

fn s1tacon_tr (
  s2t_res: s2rt, d: s1tacon
) : void = let
  val id = d.s1tacon_sym
  val loc = d.s1tacon_loc
//
  val argvar = let
    fn f1 (x: a1srt): syms2rt = let
      val sym = (case+ x.a1srt_sym of
        | None () => $SYM.symbol_empty | Some sym => sym
      ) : symbol
      val s2t = s1rt_tr (x.a1srt_srt)
    in
      (sym, s2t)
    end // end of [f1]
    fn f2 (x: a1msrt): syms2rtlst = l2l (list_map_fun (x.a1msrt_arg, f1))
  in
    l2l (list_map_fun (d.s1tacon_arg, f2))
  end : List (syms2rtlst) // end of [val]
//
  val s2t_fun = let
    fun aux (
      s2t_res: s2rt, xss: List (syms2rtlst)
    ) : s2rt =
      case+ xss of
      | list_cons (xs, xss) => let
          val s2ts_arg = l2l (list_map_fun<syms2rt><s2rt> (xs, lam x =<0> x.1))
          val s2t_res = s2rt_fun (s2ts_arg, s2t_res)
        in
          aux (s2t_res, xss)
        end
      | list_nil () => s2t_res
    // end of [aux]
  in
    aux (s2t_res, argvar)
  end : s2rt // end of [val]
//
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
  in
    l2l (list_map_fun (argvar, f2))
  end : List (s2varlst) // end of [val]
  val def = let
    fun aux (
      s2t_fun: s2rt, s2vss: List (s2varlst), s2e: s2exp
    ) : s2exp =
      case+ s2vss of
      | list_cons (s2vs, s2vss) => let
          val- S2RTfun (_, s2t1_fun) = s2t_fun
        in
          s2exp_lam_srt (s2t_fun, s2vs, aux (s2t1_fun, s2vss, s2e))
        end // end of [list_cons]
      | list_nil () => s2e
   in
     case+ d.s1tacon_def of
     | Some s1e => let
         val s2e =
           s1exp_trdn (s1e, s2t_res)
         // end of [val]
         val s2e_def = aux (s2t_fun, s2vss, s2e)
       in
         Some s2e_def
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
  , Some def // isabs
  , true // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , argvar // argvar
  , None () // def
  ) // end of [val]
in
  the_s2expenv_add_scst (s2c)
end // end of [s1tacon_tr]

fn s1taconlst_tr (
  knd: int, ds: s1taconlst
) : void = let
  fun aux (s2t: s2rt, ds: s1taconlst): void =
    case+ ds of
    | list_cons (d, ds) => let
        val () = s1tacon_tr (s2t, d) in aux (s2t, ds)
      end
    | list_nil () => ()
  // end of [aux]
  val s2t_res = s2rt_impredicative (knd)
in
  aux (s2t_res, ds)
end // end of [s1taconlst_tr]

(* ****** ****** *)

fn s1expdef_tr_arg
  (xss: s1arglstlst): List_vt (s2varlst) = let
  fn f1 (x: s1arg): s2var = let
    val s2t = (case+ x.s1arg_srt of
      | Some s1t => s1rt_tr (s1t)
      | None () => S2RTVar (s2rtVar_make (x.s1arg_loc))
    ) : s2rt
  in
    s2var_make_id_srt (x.s1arg_sym, s2t)
  end // end of [f1]
  fn f2 (
    xs: s1arglst
  ) : s2varlst = s2vs where {
    val s2vs = l2l (list_map_fun (xs, f1))
    val () = the_s2expenv_add_svarlst (s2vs)
  } // end of [f2]
in
  list_map_fun (xss, f2)
end // end of [s1expdef_tr_arg]

fn s1expdef_tr_def (
  xss: s1arglstlst, res: s2rtopt, def: s1exp
) : s2exp = let 
//
  val (pfenv | ()) = the_s2expenv_push_nil ()
  val s2vss = s1expdef_tr_arg (xss)
  val def = (case+ res of
    | Some s2t => s1exp_trdn (def, s2t) | None () => s1exp_trup def
  ) : s2exp // end of [val]
  val () = the_s2expenv_pop_free (pfenv | (*none*))
//
  fun aux (
    def: s2exp, s2vss: List_vt (s2varlst)
  ) : s2exp = begin
    case+ s2vss of
    | ~list_vt_cons
        (s2vs, s2vss) => let
        val body = aux (def, s2vss)
        val s2ts_arg = list_map_fun (s2vs, s2var_get_srt)
        val s2ts_arg = l2l (s2ts_arg)
        val s2t_fun = s2rt_fun (s2ts_arg, body.s2exp_srt)
      in
        s2exp_lam_srt (s2t_fun, s2vs, body)
      end // end of [::]
    | ~list_vt_nil () => def
  end // end of [aux]
//
in
  aux (def, s2vss)
end // end of [s1expdef_tr_body]

fn s1expdef_tr (
  res: s2rtopt, d: s1expdef
) : s2cst = let
//
fn auxerr (d: s1expdef): void = {
  val () = prerr_error2_loc (d.s1expdef_loc)
  val () = prerr_ifdebug ": s1expdef_tr"
  val () = prerr ": the sort for the definition does not match"
  val () = prerr " the sort assigned to the static constant ["
  val () = $SYM.prerr_symbol (d.s1expdef_sym)
  val () = prerr "]."
  val () = prerr_newline ()
} // end of [auxerr]
//
  val res1 = s1rtopt_tr (d.s1expdef_res)
  val res = (case+ res of
    | Some s2t => (case+ res1 of
      | Some s2t1 => let
          val test = s2rt_ltmat1 (s2t1, s2t)
        in
          if test then res1 else (auxerr (d); res)
        end // end of [Some]
      | None () => res
      )
    | None () => res1
  ) : s2rtopt // end of [val]
  val def = s1expdef_tr_def (d.s1expdef_arg, res, d.s1expdef_def)
in
  s2cst_make (
    d.s1expdef_sym // symbol
  , d.s1expdef_loc // location
  , def.s2exp_srt // srt
  , None () // isabs
  , false // iscon
  , false // isrec
  , false // isasp
  , None () // islst
  , list_nil () // argvar
  , Some (def) // def
  ) // end of [s2cst_make]
end // end of [s1expdef_tr]

fn s1expdeflst_tr
  (knd: int, ds: s1expdeflst): void = let
  val res = (
    if knd >= 0 then Some (s2rt_impredicative knd) else None ()
  ) : s2rtopt
  val s2cs = aux (ds) where {
    fun aux (ds: s1expdeflst):<cloref1> List_vt (s2cst) =
      case+ ds of
      | list_cons (d, ds) => let
          val s2c = s1expdef_tr (res, d) in list_vt_cons (s2c, aux ds)
        end
      | list_nil () => list_vt_nil ()
    // end of [aux]
  } // end of [val]
  val () = aux (s2cs) where {
    fun aux (s2cs: List_vt (s2cst)): void =
      case+ s2cs of
      | ~list_vt_cons (s2c, s2cs) => let
          val () = the_s2expenv_add_scst (s2c) in aux (s2cs)
        end
      | ~list_vt_nil () => ()
    // end of [aux]
  } // end of [val]
in
  // nothing
end // end of [s1expdeflst_tr]

(* ****** ****** *)

implement
d1ecl_tr (d1c0) = let
  val loc0 = d1c0.d1ecl_loc
in
//
case+ d1c0.d1ecl_node of
| D1Cnone () => d2ecl_none (loc0)
| D1Clist (ds) => let
    val ds = l2l (list_map_fun (ds, d1ecl_tr))
  in
    d2ecl_list (loc0, ds)
  end // end of [D1Clist]
| D1Ce1xpdef (id, def) => let
    val () = the_s2expenv_add (id, S2ITMe1xp def)
(*
    val () = the_d2expenv_add (id, D2ITMe1xp def)
*)
  in
    d2ecl_none (loc0)
  end // end of [D1Ce1xpdef]
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
| D1Csexpdefs (knd, ds) => let
    val () = s1expdeflst_tr (knd, ds) in d2ecl_none (loc0)
  end // end of [D1Csexpdefs]
| _ => let
    val () = $LOC.prerr_location (loc0)
    val () = prerr ": d1ecl_tr: not implemented: d1c0 = "
    val () = fprint_d1ecl (stderr_ref, d1c0)
    val () = prerr_newline ()
    val () =  $ERR.abort ()
  in
    d2ecl_none (loc0)
  end // end of [_]
//
end // end of [d1ec_tr]

(* ****** ****** *)

implement
d1eclist_tr (d1cs) = l2l (list_map_fun (d1cs, d1ecl_tr))

(* ****** ****** *)

(* end of [pats_trans2_decl.dats] *)
