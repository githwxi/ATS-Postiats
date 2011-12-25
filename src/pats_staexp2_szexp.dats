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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: December, 2011
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "prelude/DATS/list.dats"
staload "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "pats_basics.sats"

(* ****** ****** *)

staload "pats_errmsg.sats"
staload _(*anon*) = "pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_exp_up"

(* ****** ****** *)

staload UT = "pats_utils.sats"
staload _(*anon*) = "pats_utils.dats"

(* ****** ****** *)

staload LAB = "pats_label.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_staexp2_util.sats"

(* ****** ****** *)

extern
fun fprint_labs2zexp : fprint_type (labs2zexp)

implement
fprint_s2zexp (out, x) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ x of
| S2ZEany () => prstr "S2ZEany()"
| S2ZEapp (_fun, _arg) => {
    val () = prstr "S2ZEapp("
    val () = fprint_s2zexp (out, _fun)
    val () = prstr "; "
    val () = $UT.fprintlst (out, _arg, ", ", fprint_s2zexp)
    val () = prstr ")"
  }
| S2ZEcst (s2c) => {
    val () = prstr "S2ZEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  }
| S2ZEptr () => prstr "S2ZEptr()"
| S2ZEextype (name, _arg) => {
    val () = prstr "S2ZEextype("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
| S2ZEtyarr (_elt, _dim) => {
    val () = prstr "S2ZEtyarr("
    val () = fprint_s2zexp (out, _elt)
    val () = fprint_s2explst (out, _dim)
    val () = prstr ")"
  }
| S2ZEtyrec (knd, ls2zes) => {
    val () = prstr "S2ZEtyrec("
    val () = $UT.fprintlst (out, ls2zes, ", ", fprint_labs2zexp)
    val () = prstr ")"
  }
| S2ZEvar (s2v) => {
    val () = prstr "S2ZEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
| S2ZEerr () => prstr "S2ZEerr()"
end // end of [fprint_s2zexp]

implement
print_s2zexp (x) = fprint_s2zexp (stdout_ref, x)
implement
prerr_s2zexp (x) = fprint_s2zexp (stderr_ref, x)

implement
fprint_labs2zexp
  (out, x) = let
  val SZLABELED (l, s2ze) = x
  val () = $LAB.fprint_label (out, l)
  val () = fprint_string (out, "=")
  val () = fprint_s2zexp (out, s2ze)
in
  // nothing
end // end of [fprint_labs2zexp]

(* ****** ****** *)

implement
s2zexp_is_err (x) =
  case+ x of S2ZEerr () => true | _ => false
// end of [s2zexp_is_err]

(* ****** ****** *)

extern
fun s2zexp_make_s2cst (s2c: s2cst): s2zexp
implement s2zexp_make_s2cst (s2c) = S2ZEcst s2c

local

absviewtype env
extern fun env_make_nil (): env
extern fun env_pop (env: &env): void
extern fun env_push (env: &env, s2vs: s2varlst): void
extern fun env_free (env: env): void
extern fun env_find (env: &env, s2v: s2var): bool

in // in of [local]

local
assume env = List_vt (s2varlst)
in // in of [local]
implement env_make_nil () = list_vt_nil ()
implement
env_pop (env) =
  case+ env of
  | ~list_vt_cons (_, xss) => env := xss
  | _ => ()
// end of [env_pop]
implement
env_push (env, s2vs) = env := list_vt_cons (s2vs, env)
implement
env_free (env) = list_vt_free (env)
implement
env_find (env, x0) = list_exists_cloptr<s2var> (
  $UN.castvwtp1 {s2varlst} (env), lam x =<0> eq_s2var_s2var (x0, x)
) // end of [env_find]

end // end of [local]

(* ****** ****** *)

local

fun aux_s2exp (
  env: &env, s2e0: s2exp
) : s2zexp = let
// (*
  val () = (
    print "aux_s2exp: s2e0 = "; print_s2exp s2e0; print_newline ()
  ) // end of [val]
// *)
  val s2f0 = s2exp_hnfize (s2e0)
in
//
case+ s2f0.s2exp_node of
//
| S2Evar s2v => let
    val isexi = env_find (env, s2v)
  in
    if isexi then S2ZEvar (s2v) else S2ZEerr ()
  end // end of [S2Evar]
| S2Ecst s2c => let
    val isabs = s2cst_get_isabs (s2c)
  in
    case+ isabs of
    | Some (Some s2e) => aux_s2exp (env, s2e)
    | _ => s2zexp_make_s2cst (s2c)
  end // end of [S2Ecst]
//
| S2Edatconptr _ => S2ZEptr ()
| S2Edatcontyp _ => S2ZEptr ()
| S2Eextype (name, _arg) =>
    S2ZEextype (name, aux_arglstlst (env, _arg))
| S2Efun _ => S2ZEptr ()
//
| S2Eapp (s2e_fun, s2es_arg) =>
    aux_s2exp_app (env, s2f0.s2exp_srt, s2e_fun, s2es_arg)
  // end of [S2Eapp]
//
| S2Etop (knd, s2e) => aux_s2exp (env, s2e)
//
| S2Etyarr (_elt, _dim) => let
    val _elt = aux_s2exp (env, _elt) in S2ZEtyarr (_elt, _dim)
  end // end of [S2Etyarr]
| S2Etyrec (knd, npf, ls2es) => let
    val ls2zes = aux_labs2explst (env, npf, ls2es) in S2ZEtyrec (knd, ls2zes)
  end // end of [S2Etyrec]
//
| S2Einvar (s2e) => aux_s2exp (env, s2e)
| S2Evararg _ => S2ZEany ()
//
| S2Eexi (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push (env, s2vs)
    val s2ze = aux_s2exp (env, s2e)
    val () = env_pop (env)
  in
    s2ze
  end // end of [S2Eexi]
| S2Euni (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push (env, s2vs)
    val s2ze = aux_s2exp (env, s2e)
    val () = env_pop (env)
  in
    s2ze
  end // end of [S2Eexi]
//
| S2Ewth (s2e, _) => aux_s2exp (env, s2e)
| S2Eerr () => S2ZEerr ()
| _ => S2ZEany ()
end // end of [aux_s2exp]

and aux_s2exp_app (
  env: &env
, s2t: s2rt
, s2e_fun: s2exp, s2es_arg: s2explst
) : s2zexp = let
// (*
  val () = (
    print "aux_s2exp_app: s2e_fun = "; print_s2exp s2e_fun; print_newline ()
  ) // end of [val]
  val () = (
    print "aux_s2exp_app: s2es_arg = "; print_s2explst s2es_arg; print_newline ()
  ) // end of [val]
// *)
  val s2f_fun = s2exp_hnfize (s2e_fun)
in
  case+ s2f_fun.s2exp_node of
  | S2Ecst s2c => let
      val isabs = s2cst_get_isabs (s2c)
    in
      case+ isabs of
      | Some (Some s2e_fun) => let
          val s2e = s2exp_app_srt (s2t, s2e_fun, s2es_arg)
        in
          aux_s2exp (env, s2e)
        end // end of [Some]
      | _ => let
          val s2ze_fun = s2zexp_make_s2cst (s2c)
        in
          S2ZEapp (s2ze_fun, aux_arglst (env, s2es_arg))
        end // HX: can be incorrect for certain constructors
    end (* end of [S2Ecst] *)
  | _ => S2ZEany () (* HX: ??? *)
end // end of [aux_s2exp_app]

and aux_arglst (
  env: &env, s2es: s2explst
) : s2zexplst =
  case+ s2es of
  | list_cons (s2e, s2es) =>
      if s2rt_is_prgm (s2e.s2exp_srt) then
        list_cons (aux_s2exp (env, s2e), aux_arglst (env, s2es))
      else
        aux_arglst (env, s2es) // HX: non-types are all discarded
      // end of [if]
  | list_nil () => list_nil ()
// end of [aux_arglst]

and aux_arglstlst (
  env: &env, s2ess: s2explstlst
) : s2zexplstlst =
  case+ s2ess of
  | list_cons (s2es, s2ess) =>
      list_cons (aux_arglst (env, s2es), aux_arglstlst (env, s2ess))
    // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_arglstlst]

and aux_labs2explst (
  env: &env, npf: int, ls2es: labs2explst
) : labs2zexplst =
  case+ ls2es of
  | list_cons (ls2e, ls2es) =>
      if npf > 0 then
        aux_labs2explst (env, npf-1, ls2es)
      else let
        val SLABELED
          (l, _(*named*), s2e) = ls2e
        val s2ze = aux_s2exp (env, s2e)
        val ls2ze = SZLABELED (l, s2ze)
      in
        list_cons (ls2ze, aux_labs2explst (env, npf, ls2es))
      end (* end of [if] *)
    // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_labs2explst]

in // in of [local]

implement
s2zexp_make_s2exp
  (s2e0) = let
  var env = env_make_nil ()
  val s2ze = aux_s2exp (env, s2e0)
  val () = env_free (env)
// (*
  val () = (
    print "s2zexp_make_s2exp: s2ze = "; print_s2zexp s2ze; print_newline ()
  ) // end of [val]
// *)
in
  s2ze
end // end of [s2zexp_make_s2exp]

end // end of [local]

end // end of [local]

(* ****** ****** *)

exception S2ZEXPMERGEexn of ()

extern
fun s2zexp_merge_exn
  (x1: s2zexp, x2: s2zexp): s2zexp
// end of [s2zexp_merge_exn]
extern
fun s2zexplst_merge_exn
  (xs1: s2zexplst, xs2: s2zexplst): s2zexplst
// end of [s2zexplst_merge_exn]

implement
s2zexp_merge_exn
  (s2ze1, s2ze2) = let
  fn abort (): s2zexp = $raise S2ZEXPMERGEexn ()
in
//
case+ (s2ze1, s2ze2) of
| (S2ZEany (), _) => s2ze2
| (_, S2ZEany ()) => s2ze1
| (S2ZEapp (s2ze11, s2zes12),
   S2ZEapp (s2ze21, s2zes22)) => let
    val s2ze = s2zexp_merge_exn (s2ze11, s2ze21)
    val s2zes = s2zexplst_merge_exn (s2zes12, s2zes22)
  in
    S2ZEapp (s2ze, s2zes)
  end
| (S2ZEcst s2c1, S2ZEcst s2c2) =>
    if s2c1 = s2c2 then s2ze1 else abort ()
| (S2ZEptr (), S2ZEptr ()) => s2ze1
| (S2ZEextype (name1, _),
   S2ZEextype (name2, _)) =>
     if name1 = name2 then s2ze1 else abort ()
| (S2ZEvar s2v1, S2ZEvar s2v2) =>
    if s2v1 = s2v2 then s2ze1 else abort ()
| (S2ZEerr (), _) => abort ()
| (_, S2ZEerr ()) => abort ()
| (_, _) => abort ()
//
end // end of [s2zexp]

implement
s2zexplst_merge_exn (xs1, xs2) =
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1), list_cons (x2, xs2)) =>
      list_cons (s2zexp_merge_exn (x1, x2), s2zexplst_merge_exn (xs1, xs2))
  | (_, _) => list_nil ()
// end of [s2zexplst_merge_exn]

(* ****** ****** *)

implement
s2zexp_merge
  (x1, x2) = try
  s2zexp_merge_exn (x1, x2)
with
  ~S2ZEXPMERGEexn () => S2ZEerr ()
// end of [s2zexp_merge]

(* ****** ****** *)

(* end of [pats_staexp2_szexp.dats] *)
