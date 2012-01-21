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
// Start Time: May, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

fn prerr_error2_loc
  (loc: location): void = (
  $LOC.prerr_location loc; prerr ": error(2)"
) // end of [prerr_error2_loc]

(* ****** ****** *)

implement
s2rt_linearize
  (s2t) = let
  var err: int = 0
  var s2t: s2rt = s2t
  val () = case+ s2t of
    | S2RTbas s2tb => (case+ s2tb of
      | S2RTBASimp (name, knd) => let
          val knd = impkind_linearize (knd)
        in
          s2t := S2RTbas (S2RTBASimp (name, knd))
        end // end of [S2RTBASimp]
      | _ => err := 1
      ) // end of [S2RTbas]
    | _ => err := 1
(*
  val () = assertloc (err > 0) // [s2t] maybe [S2RTerr]
*)
in
  s2t
end // end of [s2rt_linearize]

(* ****** ****** *)

local

#define CLO 0
#define CLOPTR 1
#define CLOREF ~1

in // in of [local]

implement
s2rt_prf_lin_fc (
  loc0, isprf, islin, fc
) = begin
  if isprf then begin
    (if islin then s2rt_view else s2rt_prop)
  end else begin case+ islin of
    | _ when islin => begin case+ fc of
      | FUNCLOclo (knd) => begin case+ knd of
        | CLO(*0*) => s2rt_viewt0ype
        | CLOPTR(*1*) => s2rt_viewtype
        | _ (*CLOREF*) => s2rt_err () where {
            val () = prerr_error2_loc (loc0)
            val () = prerr ": a closure reference cannot be linear."
            val () = prerr_newline ()
          } // end of [_]
        end (* end of [FUNCLOclo] *)
      | FUNCLOfun () => s2rt_viewtype
      end // end of [_ when islin]
    | _ => begin case+ fc of
      | FUNCLOclo (knd) => begin case+ knd of
        | CLO => s2rt_t0ype
        | CLOPTR => s2rt_viewtype (*ptr*)
        | _ (*CLOREF*) => s2rt_type (*ref*)
        end // end of [FUNCLOclo]
      | FUNCLOfun () => s2rt_type
      end // end of [_]
  end (* end of [if] *)
end // end of [s2rt_prf_lin_fc]

end // end of [local]

(* ****** ****** *)

(*
** HX: this function is called only when prgm = 0
*)
implement
s2rt_npf_lin_prf_boxed
  (npf, lin, prf, boxed) =
  if npf >= 0 then (
    if lin = 0 then
      if boxed > 0 then s2rt_type else s2rt_t0ype
    else
      if boxed > 0 then s2rt_viewtype else s2rt_viewt0ype
    // end of [if]
  ) else (
    if prf = 0 then (
      if lin = 0 then
        if boxed > 0 then s2rt_type else s2rt_t0ype
      else
        if boxed > 0 then s2rt_viewtype else s2rt_viewt0ype
      // end of [if]
    ) else
      if lin = 0 then
        if boxed > 0 then s2rt_type else s2rt_prop
      else
        if boxed > 0 then s2rt_viewtype else s2rt_view
      // end of [if]
  ) (* end of [if] *)
// end of [s2rt_lin_prf_boxed]

implement
s2rt_npf_lin_prf_prgm_boxed_labs2explst
  (npf, lin, prf, prgm, boxed, ls2es) = let
//
(*
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: npf = "
  val () = fprint_int (stdout_ref, npf)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: lin = "
  val () = fprint_int (stdout_ref, lin)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: prf = "
  val () = fprint_int (stdout_ref, prf)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: prgm = "
  val () = fprint_int (stdout_ref, prgm)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: boxed = "
  val () = fprint_int (stdout_ref, boxed)
  val () = print_newline ()
  val () = print "s2rt_npf_lin_prf_prgm_boxed_labs2explst: labs2explst = "
  val () = fprint_labs2explst (stdout_ref, ls2es)
  val () = print_newline ()
*)
//
fun aux ( // HX: only when prgm = 1
  npf: int, lin: int, xs: labs2explst
) : s2rt =
  if npf > 0 then let
    val- list_cons (_, xs) = xs
  in
    aux (npf-1, lin, xs)
  end else let
    val- list_cons (x, xs) = xs
    val SLABELED (_, _, s2e) = x
    val s2t = s2e.s2exp_srt
(*
    val () = (print "aux: s2t = "; print_s2rt (s2t); print_newline ())
*)
  in
    if s2rt_is_prf (s2t) then
      aux (0(*npf*), lin, xs) // HX: [xs] cannot be nil
    else (
      if lin = 0 then s2t else s2rt_linearize (s2t)      
    ) // end of [if]
  end (* end of [if] *)
(* end of [aux] *)
//
in
  if prgm = 0 then
    s2rt_npf_lin_prf_boxed (npf, lin, prf, boxed)
  else if prgm = 1 then (
    if boxed > 0 then
      if lin = 0 then s2rt_viewtype else s2rt_type
    else aux (npf, lin, ls2es)
  ) else ( // HX: prgm >= 2
    if lin = 0 then
      if boxed > 0 then s2rt_type else s2rt_t0ype
    else
      if boxed > 0 then s2rt_viewtype else s2rt_viewt0ype
    // end of [if]
  ) // end of [if]
end // end of [s2rt_npf_lin_prf_prgm_boxed_labs2explst]

(* ****** ****** *)

implement
s2exp_tyrec
  (knd, npf, ls2es) = let
//
  fun aux01 (
    i: int
  , npf: int, ls2es: labs2explst
  , lin: &int
  , prf: &int
  , prgm: &int
  ) : void =
    case+ ls2es of
    | list_cons (ls2e, ls2es) => let
        val SLABELED (_, _, s2e) = ls2e
        val s2t = s2e.s2exp_srt
        val () = if s2rt_is_lin (s2t) then (lin := lin+1)
        val () = if s2rt_is_prf (s2t)
          then (prf := prf+1) else (if i >= npf then prgm := prgm+1)
        // end of [if] // end of [val]
      in
        aux01 (i+1, npf, ls2es, lin, prf, prgm)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [aux01]
  var lin: int = 0
  var prf: int = 0 and prgm: int = 0
  val () = aux01 (0, npf, ls2es, lin, prf, prgm)
  val boxed = knd // 0/1
//
  val s2t_rec =
    s2rt_npf_lin_prf_prgm_boxed_labs2explst (npf, lin, prf, prgm, boxed, ls2es)
  // end of [val]
  val tyrecknd = (case+ knd of
    | 0 => TYRECKINDflt0 () | _ => TYRECKINDbox ()
  ) : tyreckind // end of [val]
in
  s2exp_tyrec_srt (s2t_rec, tyrecknd, npf, ls2es)
end // end of [s2exp_tyrec]

(* ****** ****** *)

implement
s2cst_select_locs2explstlst (s2cs, xss) = let
//
  fun test1 (
    xs: locs2explst, s2ts: s2rtlst
  ) : bool =
    case+ xs of
    | list_cons (x, xs) => (case+ s2ts of
      | list_cons (s2t, s2ts) => let
          val s2e = x.1 in
          if s2rt_ltmat0 (s2e.s2exp_srt, s2t) then test1 (xs, s2ts) else false
        end // end of [list_cons]
      | list_nil () => false
      ) // end of [list_cons]
    | list_nil () => (case+ s2ts of
      | list_cons _ => false | list_nil () => true
      ) // end of [list_nil]
  (* end of [test1] *)
//
  fun test2 (
    s2t: s2rt, xss: List (locs2explst)
  ) : bool =
    case+ xss of
    | list_cons (xs, xss) => (
        if s2rt_is_fun (s2t) then let
          val- S2RTfun (s2ts_arg, s2t_res) = s2t
        in
          if test1 (xs, s2ts_arg) then test2 (s2t_res, xss) else false
        end else false
      ) // end of [list_cons]
    | list_nil () => true
  (* end of [test2] *)
//
  fun filter (
    s2cs: s2cstlst, xss: List (locs2explst)
  ) : s2cstlst =
    case+ s2cs of
    | list_cons (s2c, s2cs) => let
(*
        val () = print "s2cst_select_locs2explstlst: filter: s2c = "
        val () = print_s2cst (s2c)
        val () = print_newline ()
*)
        val s2t = s2cst_get_srt (s2c)
(*
        val () = print "s2cst_select_locs2explstlst: filter: s2t = ";
        val () = print_s2rt (s2t)
        val () = print_newline ()
*)
      in
        if test2 (s2t, xss) then
          list_cons (s2c, filter (s2cs, xss)) else filter (s2cs, xss)
        // end of [if]
      end // end of [S2CSTLSTcons]
    | list_nil () => list_nil ()
  (* end of [filter] *)
//
in
  if list_is_sing (s2cs)
    then s2cs else filter (s2cs, xss)
  // end of [if]
end // end of [s2cst_select_locs2explstlst]

(* ****** ****** *)

local

#define :: list_vt_cons
assume stasub_viewtype = List_vt @(s2var, s2exp)

in // in of [local]

implement
stasub_make_nil () = list_vt_nil ()

implement
stasub_copy (sub) = list_vt_copy (sub)

implement
stasub_free (sub) = list_vt_free (sub)

implement
stasub_add
  (sub, s2v, s2f) = sub := (s2v, s2f) :: sub
// end of [stasub_add]

implement
stasub_addlst
  (sub, s2vs, s2fs) = let
  fun loop (
    sub: &stasub, s2vs: s2varlst, s2fs: s2explst
  ) : int =
    case+ s2vs of
    | list_cons (s2v, s2vs) => (case+ s2fs of
      | list_cons (s2f, s2fs) => let
          val () = stasub_add (sub, s2v, s2f) in loop (sub, s2vs, s2fs)
        end // end of [list_cons]
      | list_nil () => 1
      )
    | list_nil () => (case+ s2fs of
      | list_cons _ => ~1 | list_nil () => 0
      )
  // end of [loop]
in
  loop (sub, s2vs, s2fs)
end // end of [stasub_addlst]

implement
stasub_find (sub, s2v) = let
  typedef a = s2var and b = s2exp; typedef ab = (a, b)
in
  list_assoc_fun<a,b>
    ($UN.castvwtp1 {List(ab)} (sub), eq_s2var_s2var, s2v)
  // end of [list_assoc_fun]
end // end of [stasub_find]

(*
implement
stasub_get_domain (sub) = let
  typedef a = (s2var, s2exp) and b = s2var
in
  list_map_fun<a><b> ($UN.castvwtp1 {List(a)} (sub), lam (x) =<0> x.0)
end // end of [stasub_get_domain]
*)

implement
stasub_occurcheck
  (sub, s2V) = case+ sub of
  | list_vt_cons (x, !p_xs) => let
      val s2Vs = s2var_get_sVarset (x.0)
      val ismem = s2Varset_is_member (s2Vs, s2V)
    in
      if ismem then let
        prval () = fold@ (sub) in true
      end else let
        val ans = stasub_occurcheck (!p_xs, s2V)
        prval () = fold@ (sub)
      in
        ans
      end (* end of [if] *)
    end // end of [list_vt_cons]
  | list_vt_nil () => let
      prval () = fold@ (sub) in false
    end // end of [list_vt_nil]
// end of [stasub_occurcheck]

end // end of [local]

(* ****** ****** *)

implement
stasub_extend_svarlst (sub, s2vs) = let
//
fun loop (
  sub: &stasub, s2vs: s2varlst, s2vs1: s2varlst_vt
) : s2varlst_vt =
  case+ s2vs of
  | list_cons (s2v, s2vs) => let
      val s2v1 = s2var_dup (s2v)
      val s2e1 = s2exp_var (s2v1)
      val () = stasub_add (sub, s2v, s2e1)
      val s2vs1 = list_vt_cons (s2v1, s2vs1)
    in
      loop (sub, s2vs, s2vs1)
    end // end of [list_cons]
  | list_nil () => s2vs1
// end of [loop]
//
val s2vs1 = loop (sub, s2vs, list_vt_nil ())
//
in
//
list_vt_reverse (s2vs1)
//
end // end of [stasub_extend_svarlst]

(* ****** ****** *)

extern
fun s2exp_subst_flag
  (sub: !stasub, s2e: s2exp, flag: &int): s2exp
// end of [s2exp_subst_flag]

extern
fun s2explst_subst_flag
  (sub: !stasub, s2es: s2explst, flag: &int): s2explst
// end of [s2explst_subst_flag]

extern
fun s2explstlst_subst_flag
  (sub: !stasub, s2ess0: s2explstlst, flag: &int): s2explstlst
// end of [s2explstlst_subst_flag]

extern
fun labs2explst_subst_flag
  (sub: !stasub, ls2es0: labs2explst, flag: &int): labs2explst
// end of [labs2explst_subst_flag]

extern
fun wths2explst_subst_flag
  (sub: !stasub, wths2es0: wths2explst, flag: &int): wths2explst
// end of [wths2explst_subst_flag]

extern
fun s2eff_subst_flag
  (sub: !stasub, s2fe0: s2eff, flag: &int): s2eff
// end of [s2eff_subst_flag]

(* ****** ****** *)

fun
s2var_subst_flag (
  sub: !stasub
, s2e0: s2exp, flag: &int, s2v: s2var
) : s2exp = let
  val ans = stasub_find (sub, s2v)
in
  case+ ans of
  | ~Some_vt (s2e) => let
      val () = flag := flag + 1 in s2e
    end // end of [Some_vt]
  | ~None_vt () => s2e0
end // end of [S2Evar_subst_flag]

fun
s2Var_subst_flag (
  sub: !stasub
, s2e0: s2exp, flag: &int, s2V: s2Var
) : s2exp = let
  val opt = s2Var_get_link (s2V)
in
//
case+ opt of
| Some (s2f) =>
    s2exp_subst_flag (sub, s2f, flag)
| None () => let
    val isfound = stasub_occurcheck (sub, s2V)
  in
    if ~isfound then s2e0 else s2exp_err (s2e0.s2exp_srt)
  end // end of [None]
//
end // end of [s2Var_subst_flag]

fun
s2exp_subst_flag_exiuni (
  knd: int
, sub: !stasub, s2e0: s2exp, flag: &int
, s2vs: s2varlst, s2ps: s2explst, s2e: s2exp
) : s2exp = let
  val flag0 = flag
  var sub1 = stasub_copy (sub)
  val s2vs = stasub_extend_svarlst (sub1, s2vs)
  val s2ps = s2explst_subst_flag (sub1, s2ps, flag)
  val s2e = s2exp_subst_flag (sub1, s2e, flag)
  val () = stasub_free (sub1)
in
  if flag > flag0 then let
    val s2vs = l2l (s2vs)
    val s2f_res = s2exp_exiuni (knd, s2vs, s2ps, s2e)
  in
    s2f_res
  end else let
    val () = list_vt_free (s2vs) in s2e0
  end (* end of [if] *)
end // end of [s2exp_subst_flag_exiuni]

(* ****** ****** *)

implement
s2exp_subst_flag
  (sub, s2e0, flag) = let
  val s2t0 = s2e0.s2exp_srt
in
//
case+ s2e0.s2exp_node of
//
| S2Eint _ => s2e0
| S2Eintinf _ => s2e0
| S2Echar _ => s2e0
//
| S2Ecst _ => s2e0
//
| S2Eextype (name, s2ess) => let
    val flag0 = flag
    val s2ess = s2explstlst_subst_flag (sub, s2ess, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_extype_srt (s2t0, name, s2ess) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Eextype]
//
| S2Evar (s2v) => s2var_subst_flag (sub, s2e0, flag, s2v)
| S2EVar (s2V) => s2Var_subst_flag (sub, s2e0, flag, s2V)
//
| S2Edatconptr (d2c, s2es) => let
    val flag0 = flag
    val s2es = s2explst_subst_flag (sub, s2es, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_datconptr (d2c, s2es) in s2e_res
    end else s2e0
  end // end of [S2Edatconptr]
| S2Edatcontyp (d2c, s2es) => let
    val flag0 = flag
    val s2es = s2explst_subst_flag (sub, s2es, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_datcontyp (d2c, s2es) in s2e_res
    end else s2e0
  end // end of [S2Edatcontyp]
//
| S2Eat (s2e1, s2e2) => let
    val flag0 = flag
    val s2e1 = s2exp_subst_flag (sub, s2e1, flag)
    val s2e2 = s2exp_subst_flag (sub, s2e2, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_at (s2e1, s2e2) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Eat]
//
| S2Esizeof (s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_sizeof (s2e) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Esizeof]
//
| S2Eeqeq (s2e1, s2e2) => let
    val flag0 = flag
    val s2e1 = s2exp_subst_flag (sub, s2e1, flag)
    val s2e2 = s2exp_subst_flag (sub, s2e2, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_eqeq (s2e1, s2e2) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Eeqeq]
//
| S2Eapp (s2e_fun, s2es_arg) => let
    val flag0 = flag
    val s2e_fun = s2exp_subst_flag (sub, s2e_fun, flag)
    val s2es_arg = s2explst_subst_flag (sub, s2es_arg, flag)
  in
    if flag > flag0
      then s2exp_app_srt (s2t0, s2e_fun, s2es_arg) else s2e0
    // end of [if]
  end // end of [S2Eapp]
| S2Elam (s2vs, s2e) => let
    val flag0 = flag
    var sub1 = stasub_copy (sub)
    val s2vs = stasub_extend_svarlst (sub1, s2vs)
    val s2e = s2exp_subst_flag (sub1, s2e, flag)
    val () = stasub_free (sub1)
  in
    if flag > flag0 then
      s2exp_lam_srt (s2t0, (l2l)s2vs, s2e)
    else let
      val () = list_vt_free (s2vs) in s2e0
    end (* end of [if] *)
  end // end of [S2Elam]
| S2Efun (
    fc, lin, s2fe, npf, s2es_arg, s2e_res
  ) => let
    val flag0 = flag
    val s2fe = s2eff_subst_flag (sub, s2fe, flag)
    val s2es_arg = s2explst_subst_flag (sub, s2es_arg, flag)
    val s2e_res = s2exp_subst_flag (sub, s2e_res, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_fun_srt
        (s2t0, fc, lin, s2fe, npf, s2es_arg, s2e_res) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Efun]
| S2Emetfn (opt(*stamp*), s2es_met, s2e_body) => let
    val flag0 = flag    
    val s2es_met = s2explst_subst_flag (sub, s2es_met, flag)
    val s2e_body = s2exp_subst_flag (sub, s2e_body, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_metfn (opt, s2es_met, s2e_body) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Emetfn]
//
| S2Etop (knd, s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then s2exp_top_srt (s2t0, knd, s2e) else s2e0
  end // end of [S2Etop]
//
| S2Etyarr (s2e_elt, s2es_int) => let
    val flag0 = flag
    val s2e_elt = s2exp_subst_flag (sub, s2e_elt, flag)
    val s2es_int = s2explst_subst_flag (sub, s2es_int, flag)
  in
    if flag > flag0 then let
      val s2e_res = s2exp_tyarr (s2e_elt, s2es_int) in s2e_res
    end else s2e0
  end // end of [S2Etyarr]
//
| S2Etyrec (knd, npf, ls2es) => let
    val flag0 = flag
    val ls2es = labs2explst_subst_flag (sub, ls2es, flag)
  in
    if flag > flag0 then let
      val s2e_res =
        s2exp_tyrec_srt (s2t0, knd, npf, ls2es) in s2e_res
    end else s2e0 // end of [if]
  end // end of [S2Etyrec]
//
| S2Einvar (s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then s2exp_invar (s2e) else s2e0
  end // end of [S2Etyvarknd]
//
| S2Erefarg (knd, s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then s2exp_refarg (knd, s2e) else s2e0
  end // end of [S2Erefarg]
//
| S2Eexi (s2vs, s2ps, s2e) =>
    s2exp_subst_flag_exiuni (0(*exi*), sub, s2e0, flag, s2vs, s2ps, s2e)
  // end of [S2Eexi]
| S2Euni (s2vs, s2ps, s2e) =>
    s2exp_subst_flag_exiuni (1(*uni*), sub, s2e0, flag, s2vs, s2ps, s2e)
  // end of [S2Euni]
//
| S2Evararg (s2e) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
  in
    if flag > flag0 then s2exp_vararg (s2e) else s2e0
  end // end of [S2Evararg]
//
| S2Ewth (s2e, ws2es) => let
    val flag0 = flag
    val s2e = s2exp_subst_flag (sub, s2e, flag)
    val ws2es = wths2explst_subst_flag (sub, ws2es, flag)
  in
    if flag > flag0 then s2exp_wth (s2e, ws2es) else s2e0
  end // end of [S2Ewth]
//
| S2Eerr _ => s2e0
// end of [case]
end // end of [s2exp_subst_flag]

(* ****** ****** *)

implement
s2explst_subst_flag
  (sub, s2es0, flag) =
  case+ s2es0 of
  | list_cons (s2e, s2es) => let
      val flag0 = flag
      val s2e = s2exp_subst_flag (sub, s2e, flag)
      val s2es = s2explst_subst_flag (sub, s2es, flag)
    in
      if flag > flag0 then list_cons (s2e, s2es) else s2es0
    end (* end of [list_cons] *)
  | list_nil () => list_nil ()
// end of [s2explst_subst_flag]

(* ****** ****** *)

implement
s2explstlst_subst_flag
  (sub, s2ess0, flag) =
  case+ s2ess0 of
  | list_cons (s2es, s2ess) => let
      val flag0 = flag
      val s2es = s2explst_subst_flag (sub, s2es, flag)
      val s2ess = s2explstlst_subst_flag (sub, s2ess, flag) 
    in
      if flag > flag0 then list_cons (s2es, s2ess) else s2ess0
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [s2explstlst_subst_flag]

implement
labs2explst_subst_flag
  (sub, ls2es0, flag) =
  case+ ls2es0 of
  | list_cons (ls2e, ls2es) => let
      val SLABELED (l, name, s2e) = ls2e
      val flag0 = flag
      val s2e = s2exp_subst_flag (sub, s2e, flag)
      val ls2es = labs2explst_subst_flag (sub, ls2es, flag)
    in
      if flag > flag0 then let
        val ls2e = SLABELED (l, name, s2e) in list_cons (ls2e, ls2es)
      end else ls2es0 // end of [if]
    end // end of [LABS2EXPLSTcons]
  | list_nil () => list_nil ()
// end of [labs2explst_subst_flag]

implement
wths2explst_subst_flag
  (sub, ws2es0, flag) =
  case+ ws2es0 of
  | WTHS2EXPLSTnil () => WTHS2EXPLSTnil ()
  | WTHS2EXPLSTcons_some (knd, s2e, ws2es) => let
      val flag0 = flag
      val s2e = s2exp_subst_flag (sub, s2e, flag)
      val ws2es = wths2explst_subst_flag (sub, ws2es, flag)
    in
      if flag > flag0
        then WTHS2EXPLSTcons_some (knd, s2e, ws2es) else ws2es0
      // end of [if]
    end // end of [WTHS2EXPLSTcons_some]
  | WTHS2EXPLSTcons_none (ws2es) => let
      val flag0 = flag
      val ws2es = wths2explst_subst_flag (sub, ws2es, flag)
    in
      if flag > flag0 then WTHS2EXPLSTcons_none (ws2es) else ws2es0
    end // end of [WTHS2EXPLSTcons_none]
// end of [wths2explst_subst_flag]

implement
s2eff_subst_flag
  (sub, s2fe0, flag) =
  case+ s2fe0 of
  | S2EFFset (efs, s2es) => let
      val flag0 = flag
      val s2es = s2explst_subst_flag (sub, s2es, flag)
    in
      if flag > flag0 then S2EFFset (efs, s2es) else s2fe0
    end // end of [S2EFFset]
  | _ => s2fe0 // end of [_]
// end of s2eff_subst_flag

(* ****** ****** *)

implement
s2exp_subst (sub, s2e) = let
  var flag: int = 0 in s2exp_subst_flag (sub, s2e, flag)
end // end of [s2exp_subst]

(* ****** ****** *)

implement
s2explst_subst (sub, s2es) = let
  var flag: int = 0 in s2explst_subst_flag (sub, s2es, flag)
end // end of [s2explst_subst]

implement
s2explst_subst_vt
  (sub, s2es) = case+ s2es of
  | list_cons (s2e, s2es) => let
      val s2e = s2exp_subst (sub, s2e)
      val s2es = s2explst_subst_vt (sub, s2es)
    in
      list_vt_cons (s2e, s2es)
    end // end of [list_cons]
  | list_nil () => list_vt_nil ()
// end of [s2explst_subst_vt]

(* ****** ****** *)

implement
s2expopt_subst
  (sub, opt) =
  case+ opt of
  | Some s2e => let
      var flag: int = 0
      val s2e = s2exp_subst_flag (sub, s2e, flag)
    in
      if flag > 0 then Some (s2e) else opt
    end // end of [Some]
  | None () => opt
// end of [s2expopt_subst]

(* ****** ****** *)

implement
s2exp_alpha
  (s2v, s2v_new, s2e) = let
  var sub = stasub_make_nil ()
  val () = stasub_add (sub, s2v, s2exp_var (s2v_new))
  val s2e_new = s2exp_subst (sub, s2e)
  val () = stasub_free (sub)
in
  s2e_new
end // end of [s2exp_alpha]

implement
s2explst_alpha
  (s2v, s2v_new, s2es) = let
  fun aux (
    s2es0: s2explst
  ) :<cloref1> s2explst =
    case+ s2es0 of
    | list_cons (s2e, s2es) => let
        var flag: int = 0
        extern castfn ptrof {a:type} (x: a):<> ptr
        val s2e_new = s2exp_alpha (s2v, s2v_new, s2e)
        val () = if ptrof(s2e) != ptrof(s2e_new) then flag := flag + 1
        val s2es_new = aux (s2es)
        val () = if ptrof (s2es) != ptrof (s2es_new) then flag := flag + 1
      in
        if flag > 0 then list_cons (s2e_new, s2es_new) else s2es0
      end // end of [list_cons]
    | list_nil () => s2es0
  // end of [aux]
in
  aux (s2es)
end // end of [s2explst_alpha]

(* ****** ****** *)

local

fun aux_s2exp (
  s2e0: s2exp, fvs: &s2varset_vt
) : void = let
in
//
case+ s2e0.s2exp_node of
//
| S2Eint _ => ()
| S2Eintinf _ => ()
| S2Echar _ => ()
//
| S2Ecst _ => ()
//
| S2Eextype (_(*name*), s2ess) => aux_s2explstlst (s2ess, fvs)
//
| S2Evar s2v => {
    val () = fvs := s2varset_vt_add (fvs, s2v)
  } // end of [S2Evar]
| S2EVar s2V => aux_s2Var (s2V, fvs)
//
| S2Edatconptr (d2c, s2es_arg) => aux_s2explst (s2es_arg, fvs)
| S2Edatcontyp (d2c, s2es_arg) => aux_s2explst (s2es_arg, fvs)
//
| S2Eat (s2e1, s2e2) => (
    aux_s2exp (s2e1, fvs); aux_s2exp (s2e2, fvs)
  ) // end of [s2Eat]
| S2Esizeof (s2e) => aux_s2exp (s2e, fvs)
//
| S2Eeqeq (s2e1, s2e2) => (
    aux_s2exp (s2e1, fvs); aux_s2exp (s2e2, fvs)
  ) // end of [s2Eeqeq]
//
| S2Eapp (s2e_fun, s2es_arg) => (
    aux_s2exp (s2e_fun, fvs); aux_s2explst (s2es_arg, fvs)
  ) // end of [S2Eapp]
| S2Elam (s2vs, s2e) => let
    var fvs1 = s2varset_vt_nil ()
    val () = aux_s2exp (s2e, fvs1)
    val () = fvs1 := s2varset_vt_delist (fvs1, s2vs)
  in
    fvs := s2varset_vt_union (fvs, fvs1)
  end // end of [S2Elam]
| S2Efun (
    _,  _, s2fe, _, s2es_arg, s2e_res
  ) => {
    val () = aux_s2eff (s2fe, fvs)
    val () = aux_s2explst (s2es_arg, fvs)
    val () = aux_s2exp (s2e_res, fvs)
  } // end of [S2Efun]
| S2Emetfn (opt, s2es, s2e) => (
    aux_s2explst (s2es, fvs); aux_s2exp (s2e, fvs)
  ) // end of [S2Emetfn]
//
| S2Etop (_(*knd*), s2e) => aux_s2exp (s2e, fvs)
//
| S2Etyarr (s2e_elt, s2es_dim) => (
    aux_s2exp (s2e_elt, fvs); aux_s2explst (s2es_dim, fvs)
  ) // end of [S2Etyarr]
| S2Etyrec (_(*knd*), _(*npf*), ls2es) => aux_labs2explst (ls2es, fvs)
//
| S2Einvar (s2e) => aux_s2exp (s2e, fvs)
//
| S2Erefarg (_, s2e) => aux_s2exp (s2e, fvs)
//
| S2Eexi (s2vs, s2ps, s2e) => aux_s2exp_exiuni (s2vs, s2ps, s2e, fvs)
| S2Euni (s2vs, s2ps, s2e) => aux_s2exp_exiuni (s2vs, s2ps, s2e, fvs)
//
| S2Evararg s2e => aux_s2exp (s2e, fvs)
//
| S2Ewth (s2e, ws2es) => (
    aux_s2exp (s2e, fvs); aux_wths2explst (ws2es, fvs)
  ) // end of [S2Ewth]
//
| S2Eerr () => ()
// end of [case]
end // end of [aux_s2exp]

and aux_s2explst (
  s2es0: s2explst, fvs: &s2varset_vt
) : void = case+ s2es0 of
  | list_cons (s2e, s2es) => (
      aux_s2exp (s2e, fvs); aux_s2explst (s2es, fvs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [aux_s2explst]

and aux_s2explstlst (
  s2ess0: s2explstlst, fvs: &s2varset_vt
) : void = case+ s2ess0 of
  | list_cons (s2es, s2ess) => (
      aux_s2explst (s2es, fvs); aux_s2explstlst (s2ess, fvs)
    ) // end of [list_cons]
  | list_nil () => ()
// end of [aux_s2explstlst]

and aux_labs2explst (
  ls2es0: labs2explst, fvs: &s2varset_vt
) : void = case+ ls2es0 of
  | list_cons (ls2e, ls2es) => let
      val SLABELED (_, _, s2e) = ls2e
      val () = aux_s2exp (s2e, fvs)
    in
      aux_labs2explst (ls2es, fvs)
    end // end of [list_cons]
  | list_nil () => ()
// end of [aux_labs2explst]

and aux_wths2explst (
  ws2es0: wths2explst, fvs: &s2varset_vt
) : void = case+ ws2es0 of
  | WTHS2EXPLSTnil () => ()
  | WTHS2EXPLSTcons_some (_, s2e, ws2es) => (
      aux_s2exp (s2e, fvs); aux_wths2explst (ws2es, fvs)
    )
  | WTHS2EXPLSTcons_none (ws2es) => aux_wths2explst (ws2es, fvs)
// end of [aux_wths2explst]

and aux_s2Var (
  s2V: s2Var, fvs: &s2varset_vt
) : void = let
  val opt = s2Var_get_link s2V
in
  case+ opt of
  | Some s2e => aux_s2exp (s2e, fvs)
  | None () => let
      val s2e = s2exp_err (s2Var_get_srt (s2V))
    in
      s2Var_set_link (s2V, Some (s2e))
    end // end of [None]
end // end of [aux_s2Var]

and aux_s2exp_exiuni (
  s2vs: s2varlst, s2ps: s2explst, s2e: s2exp, fvs: &s2varset_vt
) : void = let
  var fvs1 = s2varset_vt_nil ()
  val () = aux_s2explst (s2ps, fvs1)
  val () = aux_s2exp (s2e, fvs1)
  val () = fvs1 := s2varset_vt_delist (fvs1, s2vs)
in
  fvs := s2varset_vt_union (fvs, fvs1)
end // end of [aux_s2exp_exiuni]

and aux_s2eff (
  s2fe: s2eff, fvs: &s2varset_vt
) : void =
  case+ s2fe of
  | S2EFFall _ => ()
  | S2EFFnil _ => ()
  | S2EFFset (_, s2es) => aux_s2explst (s2es, fvs)
// end of [aux_s2eff]

in // in of [local]

implement
s2exp_freevars
  (s2e0) = fvs where {
  var fvs = s2varset_vt_nil ()
  val () = aux_s2exp (s2e0, fvs)
} // end of [s2exp_freevars]

end // end of [local]

(* ****** ****** *)

(* end of [pats_staexp2_util1.dats] *)
