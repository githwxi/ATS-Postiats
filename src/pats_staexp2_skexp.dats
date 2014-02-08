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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

implement
fprint_s2kexp
  (out, s2ke) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ s2ke of
| S2KEany () => {
    val () = prstr "S2KEany()"
  }
| S2KEcst (s2c) => {
    val () = prstr "S2KEcst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  }
| S2KEvar (s2v) => {
    val () = prstr "S2KEvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
//
| S2KEextype (name, _arg) => {
    val () = prstr "S2KEextype("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
| S2KEextkind (name, _arg) => {
    val () = prstr "S2KEextkind("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
//
| S2KEfun
    (_arg, _res) => {
    val () = prstr "S2KEfun("
    val () = fprint_s2kexplst (out, _arg)
    val () = prstr "; "
    val () = fprint_s2kexp (out, _res)
    val () = prstr ")"
  }
| S2KEapp
    (_fun, _arg) => {
    val () = prstr "S2KEapp("
    val () = fprint_s2kexp (out, _fun)
    val () = prstr "; "
    val () = fprint_s2kexplst (out, _arg)
    val () = prstr ")"
  }
| S2KEtyarr (s2ke) => {
    val () = prstr "S2KEtyarr("
    val () = fprint_s2kexp (out, s2ke)
    val () = prstr ")"
  }
| S2KEtyrec
    (knd, ls2kes) => {
    val () = prstr "S2KEtyrec("
    val () = fprint_tyreckind (out, knd)
    val () = prstr "; "
    val () = $UT.fprintlst (out, ls2kes, ", ", fprint_labs2kexp)
    val () = prstr ")"
  }
//
(*
| _ => prstr "S2KE...(...)"
*)
//
end // end of [fprint_s2kexp]

implement
fprint_s2kexplst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s2kexp)
// end of [fprint_s2kexplst]

implement
fprint_labs2kexp
  (out, x) = {
  val SKLABELED (l, s2ke) = x
  val () = $LAB.fprint_label (out, l)
  val () = fprint_string (out, "=")
  val () = fprint_s2kexp (out, s2ke)
} // end of [fprint_labs2kexp]

implement
print_s2kexp (x) = fprint_s2kexp (stdout_ref, x)
implement
prerr_s2kexp (x) = fprint_s2kexp (stderr_ref, x)

(* ****** ****** *)

local
//
absviewtype env
extern fun env_make_nil (): env
extern fun env_pop (env: &env): void
extern fun env_push (env: &env, s2vs: s2varlst): void
extern fun env_free (env: env): void
extern fun env_find (env: &env, s2v: s2var): bool
//
in (* in of [local] *)

(* ****** ****** *)

local
//
assume env = List_vt (s2varlst)
//
in (* in of [local] *)
//
implement env_make_nil () = list_vt_nil ()
//
implement
env_pop (env) =
(
  case+ env of
  | ~list_vt_cons (_, xss) => env := xss | _ => ()
) (* end of [env_pop] *)
//
implement
env_push (env, s2vs) = env := list_vt_cons (s2vs, env)
//
implement
env_free (env) = list_vt_free (env)
//
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
//
end // end of [local]

(* ****** ****** *)

local

fun aux_s2exp
(
  env: &env, s2e0: s2exp
) : s2kexp = let
(*
  val () = (
    print "aux_s2exp: s2e0 = "; print_s2exp s2e0; print_newline ()
  ) // end of [val]
*)
  val s2f0 = s2exp_hnfize (s2e0)
in
//
case s2f0.s2exp_node of
| S2Ecst (s2c) => S2KEcst (s2c)
| S2Evar (s2v) => let
    val isexi = env_find (env, s2v)
  in
    if isexi then S2KEany () else S2KEvar (s2v)
  end
//
| S2EVar (s2V) => S2KEany () // see s2zexp for info
//
| S2Eextype (
    name, _arg
  ) => S2KEextype (name, aux_arglstlst (env, _arg))
| S2Eextkind (
    name, _arg
  ) => S2KEextkind (name, aux_arglstlst (env, _arg))
//
| S2Efun (
    _(*fc*), _(*lin*), _(*s2fe*), npf, _arg, _res
  ) => let
  in
    S2KEfun (aux_s2explst (env, _arg), aux_s2exp (env, _res))
  end // end of [S2Efun]
//
| S2Eapp (_fun, _arg) => let
    val _fun = aux_s2exp (env, _fun)
    val _arg = aux_arglst (env, _arg)
  in
    S2KEapp (_fun, _arg)
  end // end of [S2Eapp]
//
| S2Etyarr (_elt, _dim) => let
    val _elt = aux_s2exp (env, _elt) in S2KEtyarr (_elt)
  end // end of [S2Etyarr]
| S2Etyrec (knd, npf, ls2es) => let
    val ls2kes = aux_labs2explst (env, ls2es) in S2KEtyrec (knd, ls2kes)
  end // end of [S2Etyrec]
//
| S2Erefarg (knd, s2e) => aux_s2exp (env, s2e)
//
| S2Eexi (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push (env, s2vs)
    val s2ke = aux_s2exp (env, s2e)
    val () = env_pop (env)
  in
    s2ke
  end // end of [S2Eexi]
| S2Euni (
    s2vs, _(*s2ps*), s2e
  ) => let
    val () = env_push (env, s2vs)
    val s2ke = aux_s2exp (env, s2e)
    val () = env_pop (env)
  in
    s2ke
  end // end of [S2Eexi]
//
| S2Ewthtype (s2e, ws2es) => aux_s2exp (env, s2e)
//
| _ => S2KEany () // HX: no available info
//
end // end of [aux_s2exp]

and aux_arglst
(
  env: &env, s2es: s2explst
) : s2kexplst =
  case+ s2es of
  | list_cons (s2e, s2es) => let
      val s2t = s2e.s2exp_srt
      val iskeep = s2rt_is_tkind (s2t)
      val iskeep = if iskeep then true else s2rt_is_prgm (s2t)
    in
      if iskeep then let
        val s2ke = aux_s2exp (env, s2e)
      in
        list_cons (s2ke, aux_arglst (env, s2es))
      end else
        aux_arglst (env, s2es) // HX: non-types are all discarded
      // end of [if]
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_arglst]

and aux_arglstlst
(
  env: &env, s2ess: s2explstlst
) : s2kexplstlst =
  case+ s2ess of
  | list_cons
      (s2es, s2ess) =>
      list_cons (aux_arglst (env, s2es), aux_arglstlst (env, s2ess))
    // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_arglstlst]

and aux_s2explst
(
  env: &env, s2es: s2explst
) : s2kexplst =
  case+ s2es of
  | list_cons
      (s2e, s2es) =>
      list_cons (aux_s2exp (env, s2e), aux_s2explst (env, s2es))
    // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_s2explst]

and aux_labs2explst
(
  env: &env, ls2es: labs2explst
) : labs2kexplst =
  case+ ls2es of
  | list_cons
      (ls2e, ls2es) => let
      val SLABELED
        (l, _(*named*), s2e) = ls2e
      val s2ke = aux_s2exp (env, s2e)
      val ls2ke = SKLABELED (l, s2ke)
      val ls2kes = aux_labs2explst (env, ls2es)
    in
      list_cons (ls2ke, ls2kes)
    end // end of [list_cons]
  | list_nil () => list_nil ()
// end of [aux_labs2explst]

in (* in of [local] *)

implement
s2kexp_make_s2exp
  (s2e0) = let
(*
  val () = (
    print "s2kexp_make_s2exp: s2e0 = "; print_s2exp s2e0; print_newline ()
  ) // end of [val]
*)
  var env = env_make_nil ()
  val s2ke = aux_s2exp (env, s2e0)
  val () = env_free (env)
(*
  val () = (
    print "s2kexp_make_s2exp: s2ke = "; print_s2kexp s2ke; print_newline ()
  ) // end of [val]
*)
in
  s2ke
end // end of [s2kexp_make_s2exp]

end // end of [local]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

exception S2KEXPISMATexn of ()

extern
fun s2kexp_ismat_exn
  (x1: s2kexp, x2: s2kexp): void
// end of [s2kexp_ismat_exn]
extern
fun s2kexplst_ismat_exn
  (xs1: s2kexplst, xs2: s2kexplst): void
// end of [s2kexplst_ismat_exn]
extern
fun s2kexplstlst_ismat_exn
  (xss1: s2kexplstlst, xss2: s2kexplstlst): void
// end of [s2kexplstlst_ismat_exn]
extern
fun labs2kexplst_ismat_exn
  (lxs1: labs2kexplst, lxs2: labs2kexplst): void
// end of [labs2kexplst_ismat_exn]

(* ****** ****** *)

local

fn abort (): void = $raise S2KEXPISMATexn()

in (* in of [local] *)

implement
s2kexp_ismat_exn
  (x1, x2) = let
in
//
case+ (x1, x2) of
| (S2KEany (), _) => ()
| (_, S2KEany ()) => ()
| (S2KEcst s2c1, S2KEcst s2c2) =>
    if s2cst_subeq (s2c1, s2c2) then () else abort ()
| (S2KEvar s2v1, S2KEvar s2v2) =>
    if s2v1 = s2v2 then () else abort ()
//
| (
   S2KEextype (name1, _arg1),
   S2KEextype (name2, _arg2)
  ) => (
    if name1 = name2
      then s2kexplstlst_ismat_exn (_arg1, _arg2) else abort ()
    // end of [if]
  ) (* S2KEextype *)
| (
   S2KEextkind (name1, _arg1),
   S2KEextkind (name2, _arg2)
  ) => (
    if name1 = name2
      then s2kexplstlst_ismat_exn (_arg1, _arg2) else abort ()
    // end of [if]
  ) (* S2KEextkind *)
//
| (S2KEfun (_arg1, _res1),
   S2KEfun (_arg2, _res2)) => let
    val () =
      s2kexplst_ismat_exn (_arg2, _arg1) // contra-variant
    // end of [val]
  in
    s2kexp_ismat_exn (_res1, _res2)
  end // end of [fun, fun]
| (S2KEapp (x1, _), S2KEcst _) => s2kexp_ismat_exn (x1, x2)
//
| (S2KEapp (_fun1, _arg1),
   S2KEapp (_fun2, _arg2)) =>
  {
    val () = s2kexp_ismat_exn (_fun1, _fun2)
    val () = s2kexplst_ismat_exn (_arg1, _arg2)
  } // end of [S2KEapp, S2KEapp]
//
| (S2KEtyarr (elt1),
   S2KEtyarr (elt2)) => s2kexp_ismat_exn (elt1, elt2)
| (S2KEtyrec (knd1, ls2kes1),
   S2KEtyrec (knd2, ls2kes2)) =>
  if knd1 = knd2
    then labs2kexplst_ismat_exn (ls2kes1, ls2kes2) else abort ()
  // end of [if]
//
| (_, _) => abort ()
//
end // end of [s2kexp_ismat_exn]

implement
s2kexplst_ismat_exn
  (xs1, xs2) = let
in
  case+ (xs1, xs2) of
  | (list_cons (x1, xs1),
     list_cons (x2, xs2)) => let
      val () = s2kexp_ismat_exn (x1, x2)
    in
      s2kexplst_ismat_exn (xs1, xs2)
    end // end of [if]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => abort ()
end // end of [s2kexplst_ismat_exn]

implement
s2kexplstlst_ismat_exn
  (xss1, xss2) = let
in
  case+ (xss1, xss2) of
  | (list_cons (xs1, xss1),
     list_cons (xs2, xss2)) => let
      val () = s2kexplst_ismat_exn (xs1, xs2)
    in
      s2kexplstlst_ismat_exn (xss1, xss2)
    end // end of [if]
  | (list_nil (), list_nil ()) => ()
  | (_, _) => abort ()
end // end of [s2kexplstlst_ismat_exn]

implement
labs2kexplst_ismat_exn
  (lxs1, lxs2) = let
in
//
case+ (lxs1, lxs2) of
| (list_cons (lx1, lxs1),
   list_cons (lx2, lxs2)) => let
    val SKLABELED (l1, x1) = lx1
    and SKLABELED (l2, x2) = lx2
  in
    if l1 = l2 then let
      val () = s2kexp_ismat_exn (x1, x2)
    in
      labs2kexplst_ismat_exn (lxs1, lxs2)
    end else abort () // end of [if]
  end // end of [cons, cons]
| (list_nil (), list_nil ()) => ()
| (_, _) => abort ()
end // end of [labs2kexplst_ismat_exn]

end // end of [local]

(* ****** ****** *)

(*
** HX: this one is declared in pats_staexp2_util.sats
*)
implement
s2kexp_ismat
  (x1, x2) = try let
  val () = s2kexp_ismat_exn (x1, x2) in true
end with
  ~S2KEXPISMATexn () => false // HX: indication of error!
// end of [s2kexp_ismat]

implement
s2kexplst_ismat
  (xs1, xs2) = try let
  val () = s2kexplst_ismat_exn (xs1, xs2) in true
end with
  ~S2KEXPISMATexn () => false // HX: indication of error!
// end of [s2kexplst_ismat]

(* ****** ****** *)

(* end of [pats_staexp2_skexp.dats] *)
