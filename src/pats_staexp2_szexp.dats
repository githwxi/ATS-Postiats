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
// Start Time: December, 2011
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
implement prerr_FILENAME<> () = prerr "pats_staexp2_szexp"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

extern
fun fprint_labs2zexp : fprint_type (labs2zexp)

implement
fprint_s2zexp (out, x) = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ x of
//
| S2ZEprf () => prstr "S2ZEprf()"
//
| S2ZEptr () => prstr "S2ZEptr()"
//
| S2ZEcst (s2c) => {
    val () = prstr "S2ZEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  }
| S2ZEvar (s2v) => {
    val () = prstr "S2ZEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
//
| S2ZEVar (s2V) => {
    val () = prstr "S2ZE("
    val () = fprint_s2Var (out, s2V)
    val () = prstr ")"
  }
//
| S2ZEextype
    (name, _arg) => {
    val () = prstr "S2ZEextype("
    val () = fprint_string (out, name)
    val () = prstr ")"
  } // end of [S2ZEextype]
| S2ZEextkind
    (name, _arg) => {
    val () = prstr "S2ZEextkind("
    val () = fprint_string (out, name)
    val () = prstr ")"
  } // end of [S2ZEextkind]
//
| S2ZEapp (_fun, _arg) => {
    val () = prstr "S2ZEapp("
    val () = fprint_s2zexp (out, _fun)
    val () = prstr "; "
    val () = $UT.fprintlst (out, _arg, ", ", fprint_s2zexp)
    val () = prstr ")"
  } // end of [S2ZEapp]
//
| S2ZEtyarr(_elt, _dim) => {
    val () = prstr "S2ZEtyarr("
    val () = fprint_s2zexp (out, _elt)
    val () = prstr "; "
    val () = fprint_s2explst (out, _dim)
    val () = prstr ")"
  } // end of [S2ZEtyarr]
| S2ZEtyrec(knd, ls2zes) => {
    val () = prstr "S2ZEtyrec("
    val () = $UT.fprintlst (out, ls2zes, ", ", fprint_labs2zexp)
    val () = prstr ")"
  } // end of [S2ZEtyrec]
//
| S2ZEclo () => prstr "S2ZEclo()"
//
| S2ZEbot () => prstr "S2ZEbot()"
//
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
s2zexp_is_bot (x) =
  case+ x of S2ZEbot () => true | _ => false
// end of [s2zexp_is_bot]

(* ****** ****** *)

extern
fun s2zexp_make_s2cst (s2c: s2cst): s2zexp
implement s2zexp_make_s2cst (s2c) = S2ZEcst s2c

(* ****** ****** *)

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
env_find (env, x0) = let
  fun loop1 (s2vs: s2varlst):<cloref1> bool =
    case+ s2vs of
    | list_cons (s2v, s2vs) =>
        if x0 = s2v then true else loop1 (s2vs)
    | list_nil () => false
  // end of [loop1]
  fun loop2 (s2vss: s2varlstlst):<cloref1> bool =
    case+ s2vss of
    | list_cons (s2vs, s2vss) =>
        if loop1 (s2vs) then true else loop2 (s2vss)
    | list_nil () => false
  // end of [loop2]
in
  loop2 ($UN.castvwtp1 {s2varlstlst} (env))
end // end of [env_find]

end // end of [local]

(* ****** ****** *)

local

fun
s2zexp_tyrec
(
  knd: tyreckind, lxs: labs2zexplst
) : s2zexp = let
//
val isflt = 
(
case+ knd of
| TYRECKINDflt0 _ => true
| TYRECKINDflt1 _ => true 
| _(* non-flt01 *) => false
)
in
//
if
isflt
then (
  case+ lxs of
  | list_cons
    (
      lx, list_nil()
    ) => // list_cons
    let val+SZLABELED(l, x) = lx in x end
  | _ (*non-sing*) => S2ZEtyrec(knd, lxs)
) else S2ZEtyrec(knd, lxs)
//
end // end of [s2zexp_tyrec]

fun
aux_s2exp
(
  env: &env, s2e0: s2exp
) : s2zexp = let
(*
  val () = (
    print "aux_s2exp: s2e0 = "; print_s2exp s2e0; print_newline ()
  ) // end of [val]
*)
//
val
s2f0 = s2exp_hnfize(s2e0)
//
val s2t0 = s2f0.s2exp_srt
//
in
//
case+
s2f0.s2exp_node
of (* case+ *)
//
| _ when
    s2rt_is_prf(s2t0) => S2ZEprf()
| _ when
    s2rt_is_boxed(s2t0) => S2ZEptr()
//
| S2Ecst(s2c) => let
    val isabs = s2cst_get_isabs(s2c)
  in
    case+ isabs of
    | Some(Some(s2e)) => aux_s2exp(env, s2e)
    | _ (*non-Some^2*) => s2zexp_make_s2cst(s2c)
  end // end of [S2Ecst]
//
| S2Evar(s2v) => let
    val isexi = env_find(env, s2v)
  in
    if isexi
      then S2ZEbot() else S2ZEvar(s2v)
    // end of [if]
  end // end of [S2Evar]
//
| S2EVar(s2V) => let
    val s2ze = s2Var_get_szexp(s2V) in s2ze
  end // end of [S2EVar]
//
(*
| S2Edatconptr _ => S2ZEptr () // boxed
| S2Edatcontyp _ => S2ZEptr () // boxed
*)
| S2Eextype (name, _arg) =>
    S2ZEextype (name, aux_arglstlst (env, _arg))
| S2Eextkind(name, _arg) =>
    S2ZEextkind (name, aux_arglstlst (env, _arg))
//
| S2Eapp(s2e_fun, s2es_arg) =>
    aux_s2exp_app (env, s2f0.s2exp_srt, s2e_fun, s2es_arg)
  // end of [S2Eapp]
//
| S2Efun _ => S2ZEclo // HX: it is unboxed
//
| S2Etop(knd, s2e) => aux_s2exp (env, s2e)
//
| S2Etyarr(_elt, _dim) => let
    val _elt = aux_s2exp (env, _elt) in S2ZEtyarr(_elt, _dim)
  end // end of [S2Etyarr]
| S2Etyrec(knd, npf, ls2es) => let
    val ls2zes =
      aux_labs2explst(env, npf, ls2es) in s2zexp_tyrec(knd, ls2zes)
    // end of [val]
  end // end of [S2Etyrec]
//
| S2Eexi (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push(env, s2vs)
    val s2ze = aux_s2exp (env, s2e)
    val ((*popped*)) = env_pop(env)
  in
    s2ze
  end // end of [S2Eexi]
| S2Euni (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push(env, s2vs)
    val s2ze = aux_s2exp(env, s2e)
    val ((*popped*)) = env_pop(env)
  in
    s2ze
  end // end of [S2Eexi]
//
| S2Einvar(s2e) => aux_s2exp(env, s2e)
//
| S2Evararg _ => S2ZEbot() // HX: no info
//
| S2Ewthtype(s2e, _) => aux_s2exp(env, s2e)
//
| _ (*rest-of-s2zexp*) => S2ZEbot() // HX: no info
end // end of [aux_s2exp]

and
aux_s2exp_app
(
  env: &env
, s2t: s2rt, s2e_fun: s2exp, s2es_arg: s2explst
) : s2zexp = let
(*
  val () = (
    print "aux_s2exp_app: s2e_fun = "; print_s2exp s2e_fun; print_newline ()
  ) // end of [val]
  val () = (
    print "aux_s2exp_app: s2es_arg = "; print_s2explst s2es_arg; print_newline ()
  ) // end of [val]
*)
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
  | _ => S2ZEbot () (* HX: really??? *)
end // end of [aux_s2exp_app]

and
aux_arglst (
  env: &env, s2es: s2explst
) : s2zexplst =
  case+ s2es of
  | list_cons
      (s2e, s2es) => let
      val s2t = s2e.s2exp_srt
      val keep = (
        if s2rt_is_prgm (s2t) then true else s2rt_is_tkind (s2t)
      ) : bool // end of [val]
    in
      if keep then
        list_cons (aux_s2exp (env, s2e), aux_arglst (env, s2es))
      else
        aux_arglst (env, s2es) // HX: non-types are all discarded
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_arglst]

and
aux_arglstlst (
  env: &env, s2ess: s2explstlst
) : s2zexplstlst =
  case+ s2ess of
  | list_cons (s2es, s2ess) =>
      list_cons (aux_arglst (env, s2es), aux_arglstlst (env, s2ess))
    // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_arglstlst]

and
aux_labs2explst
(
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
  (s2e0) = s2ze where
{
//
var env = env_make_nil()
val s2ze = aux_s2exp(env, s2e0)
(*
  val () = (
    print "s2zexp_make_s2exp: s2ze = "; print_s2zexp s2ze; print_newline ()
  ) // end of [val]
*)
val ((*void*)) = env_free(env)
//
} // end of [s2zexp_make_s2exp]

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
extern
fun s2zexplstlst_merge_exn
  (xss1: s2zexplstlst, xss2: s2zexplstlst): s2zexplstlst
// end of [s2zexplstlst_merge_exn]
extern
fun labs2zexplst_merge_exn
  (lxs1: labs2zexplst, lxs2: labs2zexplst): labs2zexplst
// end of [labs2zexplst_merge_exn]

(* ****** ****** *)

fun
s2zexp_linkrem
  (x: s2zexp): s2zexp = case+ x of
  | S2ZEVar (s2V) => s2Var_get_szexp (s2V) | _ => x
// end of [s2zexp_linkrem]

(* ****** ****** *)

implement
s2zexp_merge_exn
  (x1, x2) = let
//
fn abort (): s2zexp = $raise S2ZEXPMERGEexn()
//
val s2ze1 = s2zexp_linkrem (x1)
val s2ze2 = s2zexp_linkrem (x2)
//
(*
val () =
  println! ("s2zexp_merge_exn: s2ze1 = ", s2ze1)
val () =
  println! ("s2zexp_merge_exn: s2ze2 = ", s2ze2)
*)
//
in
//
case+ (s2ze1, s2ze2) of
//
| (S2ZEbot (), _) => abort ()
| (_, S2ZEbot ()) => abort ()
//
| (S2ZEprf(), S2ZEprf()) => s2ze1
//
| (S2ZEptr(), S2ZEptr()) => s2ze1
//
| (S2ZEcst(s2c1), S2ZEcst(s2c2)) =>
    if s2c1 = s2c2 then s2ze1 else abort()
| (S2ZEvar(s2v1), S2ZEvar(s2v2)) =>
    if s2v1 = s2v2 then s2ze1 else abort()
//
| (S2ZEVar s2V1, _) => let
    val () =
      s2Var_set_szexp (s2V1, s2ze2) in s2ze2
    // end of [val]
  end // end of [S2ZEVar, _]
| (_, S2ZEVar s2V2) => let
    val () =
      s2Var_set_szexp (s2V2, s2ze1) in s2ze1
    // end of [val]
  end // end of [_, S2ZEVar]
//
| (
   S2ZEextype(name1, _arg1),
   S2ZEextype(name2, _arg2)
  ) =>
    if name1 = name2 then let
      val _arg =
        s2zexplstlst_merge_exn (_arg1, _arg2)
      // end of [val]
    in
      S2ZEextype (name1, _arg)
    end else abort () // end of [if]
| (
   S2ZEextkind(name1, _arg1),
   S2ZEextkind(name2, _arg2)
  ) =>
    if name1 = name2 then let
      val _arg =
        s2zexplstlst_merge_exn(_arg1, _arg2)
      // end of [val]
    in
      S2ZEextkind(name1, _arg)
    end else abort() // end of [if]
//
| (S2ZEapp(s2ze11, s2zes12),
   S2ZEapp(s2ze21, s2zes22)) => let
    val s2ze =
      s2zexp_merge_exn(s2ze11, s2ze21)
    val s2zes =
      s2zexplst_merge_exn(s2zes12, s2zes22)
  in
    S2ZEapp(s2ze, s2zes)
  end
//
| (S2ZEtyarr(elt1, dim1),
   S2ZEtyarr(elt2, dim2)) => let
    val elt = s2zexp_merge_exn(elt1, elt2)
  in
    if s2explst_syneq(dim1, dim2)
      then S2ZEtyarr(elt, dim1) else abort()
    // end of [if]
  end
| (S2ZEtyrec(knd1, ls2zes1),
   S2ZEtyrec(knd2, ls2zes2)) =>
    if knd1 = knd2 then
      S2ZEtyrec
      ( knd1
      , labs2zexplst_merge_exn (ls2zes1, ls2zes2)
      ) (* S2ZEtyrec *)
    else $raise S2ZEXPMERGEexn() // end of [if]
//
// HX-2012-06: this holds as flat closures
| (S2ZEclo(), S2ZEclo()) => S2ZEclo() // are immovable
//
| (_(*rest-of-s2zexp*), _(*rest-of-s2zexp*)) => abort()
//
end // end of [s2zexp]

implement
s2zexplst_merge_exn
  (xs1, xs2) = (
  case+ (xs1, xs2) of
  | (list_cons(x1, xs1),
     list_cons(x2, xs2)) => let
      val x12 = s2zexp_merge_exn (x1, x2)
    in
      list_cons(x12, s2zexplst_merge_exn(xs1, xs2))
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => list_nil ()
  | (_, _) => $raise S2ZEXPMERGEexn()
) (* end of [s2zexplst_merge_exn] *)

implement
s2zexplstlst_merge_exn
  (xss1, xss2) = (
  case+ (xss1, xss2) of
  | (list_cons (xs1, xss1),
     list_cons (xs2, xss2)) => let
      val xs12 = s2zexplst_merge_exn (xs1, xs2)
    in
      list_cons (xs12, s2zexplstlst_merge_exn (xss1, xss2))
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => list_nil ()
  | (_, _) => $raise S2ZEXPMERGEexn()
) (* end of [s2zexplstlst_merge_exn] *)

implement
labs2zexplst_merge_exn
  (lxs1, lxs2) = let
in
  case+ (lxs1, lxs2) of
  | (list_cons (lx1, lxs1),
     list_cons (lx2, lxs2)) => let
      val SZLABELED (l1, x1) = lx1
      and SZLABELED (l2, x2) = lx2
    in
      if l1 = l2 then let
        val x12 = s2zexp_merge_exn (x1, x2)
        val lx = SZLABELED (l1, x12)
        val lxs = labs2zexplst_merge_exn (lxs1, lxs2)
      in
        list_cons (lx, lxs)
      end else
        $raise S2ZEXPMERGEexn()
      // end of [if]
    end // end of [cons, cons]
  | (list_nil (), list_nil ()) => list_nil ()
  | (_, _) => $raise S2ZEXPMERGEexn()
end // end of [labs2zexplst_ismat_exn]

(* ****** ****** *)

(*
** HX: this one is declared in [pats_staexp2_util.sats]
*)
implement
s2zexp_merge
  (x1, x2) = try
  s2zexp_merge_exn (x1, x2)
with
  ~S2ZEXPMERGEexn () => S2ZEbot () // HX: indication of error!
// end of [s2zexp_merge]

(* ****** ****** *)

implement
s2zexp_syneq
  (x1, x2) = let
  val x12 = s2zexp_merge (x1, x2)
in
  if s2zexp_is_bot (x12) then false else true
end // end of [s2zexp_syneq]

(* ****** ****** *)

implement
s2hnf_tszeq
  (s2f1, s2f2) = let
//
val s2e1 = s2hnf2exp (s2f1)
and s2e2 = s2hnf2exp (s2f2)
//
val s2ze1 = s2zexp_make_s2exp (s2e1)
and s2ze2 = s2zexp_make_s2exp (s2e2)
//
(*
val () =
  println! ("s2hnf_tszeq: s2ze1 = ", s2ze1)
val () =
  println! ("s2hnf_tszeq: s2ze2 = ", s2ze2)
*)
//
in
  s2zexp_syneq (s2ze1, s2ze2)
end // end of [s2hnf_tszeq]

(* ****** ****** *)
//
implement
s2exp_tszeq(s2e1, s2e2) =
(
  s2hnf_tszeq(s2exp2hnf(s2e1), s2exp2hnf(s2e2))
) (* end of [s2exp_tszeq] *)
//
(* ****** ****** *)

(* end of [pats_staexp2_szexp.dats] *)
