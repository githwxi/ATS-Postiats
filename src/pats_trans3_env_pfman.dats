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
// Start Time: March, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_trans3_env_pfman"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
typedef label = $LAB.label

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_dynexp2.sats"
staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload "./pats_trans3_env.sats"

(* ****** ****** *)

dataviewtype
d2varmrklst = // marked list
  | D2VMRKLSTcons of (d2var, d2varmrklst)
  | D2VMRKLSTmark of (int(*knd*), d2varmrklst) // knd: 0/1: stop/cont
  | D2VMRKLSTnil of ()
// end of [d2varmrklst]

(* ****** ****** *)

extern
fun the_d2varmrklst_get_view_ptr ()
  : [l:addr] (
  d2varmrklst @ l, d2varmrklst @ l -<lin,prf> void | ptr l
) // end of [the_d2varmrklst_get_view_ptr]

(* ****** ****** *)

local

assume pfmanenv_push_v = unit_v

(* ****** ****** *)

val
the_d2varmrklst =
  ref<d2varmrklst> (D2VMRKLSTnil)
// end of [val]

fun
pushenv .<>.
  (knd: int): (
  pfmanenv_push_v | void
) = let
  val (vbox pf | p) =
    ref_get_view_ptr (the_d2varmrklst)
  val () = !p := D2VMRKLSTmark (knd, !p)
in
  (unit_v | ())
end // end of [pushenv]

in // in of [local]

(* ****** ****** *)

implement
the_d2varmrklst_get_view_ptr () = let
  val [l:addr]
    (vbox pf | p) = ref_get_view_ptr (the_d2varmrklst)
  viewdef V = d2varmrklst @ l
  prval (pf, fpf) = __assert (pf) where {
    extern praxi __assert (pf: !V): (V, V -<lin,prf> void)
  } // end of [prval]
in
  (pf, fpf | p)
end // end of [the_d2varmrklst_get_view_ptr]

(* ****** ****** *)

implement
fprint_the_pfmanenv (out) = let
  fun loop (
    out: FILEref, xs: !d2varmrklst
  ) : void =
    case+ xs of
    | D2VMRKLSTcons
        (d2v, !p_xs) => let
        val () = fprint_d2var (out, d2v)
        val () = fprint_newline (out)
        val () = loop (out, !p_xs)
      in
        fold@ (xs)
      end // end of [D2VARNLSTcons]
    | D2VMRKLSTmark (knd, !p_xs) => let
        val () = fprintf
          (out, "D2VMRKLSTmark(%d)", @(knd))
        val () = fprint_newline (out)        
        val () = loop (out, !p_xs) in fold@ (xs)
      end // end of [D2VARNLSTmark]
    | D2VMRKLSTnil () => fold@ (xs)
  // end of [loop]
  val () = fprint_string
    (out, "the current pfmanenv is:\n")
  val (vbox pf | p) = ref_get_view_ptr (the_d2varmrklst)
in
  $effmask_ref (loop (out, !p))
end // end of [fprint_the_pfmanenv]

(* ****** ****** *)

implement
the_pfmanenv_pop
  (pfpush | (*void*)) = let
  prval unit_v () = pfpush
  fun loop (
    xs: d2varmrklst
  ) : d2varmrklst =
    case+ xs of
    | ~D2VMRKLSTcons (_, xs) => loop (xs)
    | ~D2VMRKLSTmark (knd, xs) => xs
    | ~D2VMRKLSTnil () => D2VMRKLSTnil ()
  // end of [loop]
  val (vbox pf | p) = ref_get_view_ptr (the_d2varmrklst)
in
  !p := $effmask_ref (loop (!p))
end // end of [the_pfmanenv_pop]

(* ****** ****** *)

#define PUSH_LET 1 // continue
#define PUSH_LAM ~1 // stopping
#define PUSH_LLAM 0 // flexible
#define PUSH_TRY ~1 // stopping

implement
the_pfmanenv_push_let () = pushenv (PUSH_LET)
implement
the_pfmanenv_push_lam
  (lin: int) = pushenv (if lin = 0 then PUSH_LAM else PUSH_LLAM)
implement
the_pfmanenv_push_try () = pushenv (PUSH_TRY)

(* ****** ****** *)

implement
the_pfmanenv_add_dvar
  (d2v) = let
//
val islin =
  d2var_is_linear (d2v)
val () = if islin then let
  val (vbox pf | p) = ref_get_view_ptr (the_d2varmrklst)
in
  !p := D2VMRKLSTcons (d2v, !p)
end // end of [if]
//
val ismut =
  d2var_is_mutabl (d2v)
val () = if ismut then let
  val-Some (d2vw) = d2var_get_view (d2v)
  val (vbox pf | p) = ref_get_view_ptr (the_d2varmrklst)
in
  !p := D2VMRKLSTcons (d2vw, !p)
end // end of [if]
//
in
  // nothing
end // end of [the_pfmanenv_add_dvar]

(* ****** ****** *)

implement
the_pfmanenv_add_dvarlst
  (d2vs) = (
  list_app_fun (d2vs, the_pfmanenv_add_dvar)
) // end of [the_pfmanenv_add_dvarlst]

implement
the_pfmanenv_add_dvaropt
  (opt) = (
  case+ opt of
  | Some (d2v) => the_pfmanenv_add_dvar (d2v)
  | None () => ()
) // end of [the_pfmanenv_add_dvaropt]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

extern
fun the_pfmanenv_add_labp3atlst (xs: labp3atlst): void

implement
the_pfmanenv_add_p3at
  (p3t) = let
//
val opt = p3at_get_dvaropt (p3t)
val () = the_pfmanenv_add_dvaropt (opt)
//
in
//
case+ p3t.p3at_node of
//
| P3Tany (d2v) => the_pfmanenv_add_dvar (d2v)
| P3Tvar (d2v) => the_pfmanenv_add_dvar (d2v)
//
| P3Tcon (
    _(*pck*), d2c, npf, p3ts
  ) => the_pfmanenv_add_p3atlst (p3ts)
//
| P3Tann (p3t, s2e) => the_pfmanenv_add_p3at (p3t)
//
| P3Tint _ => ()
| P3Tintrep _ => ()
//
| P3Tbool _ => ()
| P3Tchar _ => ()
| P3Tfloat _ => ()
| P3Tstring _ => ()
//
| P3Ti0nt _ => ()
| P3Tf0loat _ => ()
//
| P3Tempty _ => ()
//
| P3Trec (
    knd, npf, lp3ts
  ) =>
    the_pfmanenv_add_labp3atlst (lp3ts)
  // end of [P3Trec]
| P3Tlst (
    lin, s2e_elt, p3ts
  ) => the_pfmanenv_add_p3atlst (p3ts)
//
| P3Trefas (d2v, p3t) => {
    val () = the_pfmanenv_add_dvar (d2v)
    val () = the_pfmanenv_add_p3at (p3t)
  } // end of [P3Trefas]
//
| P3Texist (s2vs, p3t) => the_pfmanenv_add_p3at (p3t)
//
| P3Tvbox (d2v) => the_pfmanenv_add_dvar (d2v)
//
| P3Terrpat ((*void*)) => ()
//
end // end of [the_pfmanenv_add_p3at]

implement
the_pfmanenv_add_p3atlst
  (p3ts) = list_app_fun<p3at> (p3ts, the_pfmanenv_add_p3at)
// end of [the_pfmanenv_add_p3atlst]

implement
the_pfmanenv_add_labp3atlst
  (xs) = loop (xs) where {
  fun loop (
    xs: labp3atlst
  ) : void =
    case+ xs of
    | list_cons (x, xs) => let
        val LABP3AT (l, p3t) = x
        val () = the_pfmanenv_add_p3at (p3t)
      in
        loop (xs)
      end // end of [list_cons]
    | list_nil () => ()
  // end of [loop]
} // end of [the_pfmanenv_add_labp3atlst]

(* ****** ****** *)

extern
fun s2exp_search_atview
  (s2e: s2exp, s2l: s2hnf): Option_vt @(s2exp (*ctx*), s2exp(*at*))
// end of [s2exp_search_atview]

(* ****** ****** *)

local

extern
fun d2var_search
  (d2v: d2var, s2l: s2exp, res: &s2exp): Option_vt (s2exp)
// end of [d2var_search]
extern
fun d2var_search_sexp
  (d2v: d2var, s2l: s2exp, s2e: s2exp, res: &s2exp): Option_vt (s2exp)
// end of [d2var_search_sexp]
extern
fun d2var_search_labsexplst
  (d2v: d2var, s2l: s2exp, ls2e: labs2explst, res: &s2exp): Option_vt (labs2explst)
// end of [d2var_search_labsexplst]
extern
fun d2var_search_sexp_at
  (d2v: d2var, s2l: s2exp, s2e: s2exp, res: &s2exp): Option_vt (s2exp)
// end of [d2var_search_at]
extern
fun d2var_search_sexp_tyrec
  (d2v: d2var, s2l: s2exp, s2e: s2exp, res: &s2exp): Option_vt (s2exp)
// end of [d2var_search_sexp_tyrec]

in // in of [local]

implement
d2var_search
  (d2v, s2l, res) = let
(*
val () = (
  println! ("d2var_search: d2v = ", d2v);
  println! ("d2var_search: s2l = ", s2l);
) (* end of [val] *)
*)
//
val opt = d2var_get_type (d2v)
//
in
//
case+ opt of
| Some s2e =>
    d2var_search_sexp (d2v, s2l, s2e, res)
| None () => None_vt ()
//
end // end of [d2var_search]

implement
d2var_search_sexp
  (d2v, s2l, s2e, res) = let
  val s2e = s2exp_hnfize (s2e)
in
  case+ s2e.s2exp_node of
  | S2Eat _ =>
      d2var_search_sexp_at (d2v, s2l, s2e, res)
    // end of [S2Eat]
  | S2Etyrec _ =>
      d2var_search_sexp_tyrec (d2v, s2l, s2e, res)
    // end of [S2Etyrec]
  | _ => None_vt ()
end // end of [d2var_search_sexp]

implement
d2var_search_labsexplst
  (d2v, s2l, ls2es, res) =
  case+ ls2es of
  | list_cons (ls2e, ls2es) => let
      val
      SLABELED(l, name, s2e) = ls2e
      val opt =
        d2var_search_sexp(d2v, s2l, s2e, res)
      // end of [val]
    in
      case+ opt of
      | ~None_vt() => let
           val opt =
           (
             d2var_search_labsexplst
               (d2v, s2l, ls2es, res)
             // d2var_search_labsexplst
           ) (* end of [val] *)
         in
           case+ opt of
           | ~None_vt
               ((*void*)) => None_vt()
             // end of [None_vt]
           | ~Some_vt(ls2es_ctx) =>
               Some_vt (list_cons(ls2e, ls2es_ctx))
             // end of [Some_vt]
         end // end of [None_vt]
      | ~Some_vt(s2e_ctx) =>
         (

          Some_vt(list_cons(SLABELED(l, name, s2e_ctx), ls2es))
         ) (* en dof [Some_vt] *)
      // end of [case]
    end // end of [list_cons]
  | list_nil () => None_vt ()
// end of [d2var_search_labsexplst]

implement
d2var_search_sexp_at
(
  d2v, s2l, s2e, res
) = let
//
val-
S2Eat(s2e1,s2e2) = s2e.s2exp_node
//
val iseq = s2exp_syneq(s2l, s2e2)
//
in
//
if
iseq
then let
  val () = res := s2e1
  val s2t1 = s2e1.s2exp_srt
  val s2h1 = s2hole_make_srt(s2t1)
  val s2e1 = s2exp_hole(s2h1)
  val s2e_ctx = s2exp_at(s2e1, s2e2)
in
  Some_vt(s2e_ctx)
end else let
  val opt =
    d2var_search_sexp
      (d2v, s2l, s2e1, res)
    // d2var_search_sexp
  // end of [opt]
in
//
case+ opt of
| ~None_vt() => None_vt(*void*)
| ~Some_vt(s2e_ctx) => Some_vt(s2exp_at(s2e_ctx, s2e2))
  // end of [Some_vt]
//
end // end of [if]
//
end // end of [d2var_search_sexp_at]

implement
d2var_search_sexp_tyrec
(
  d2v, s2l, s2e, res
) = let
//
val-
S2Etyrec(knd, npf, ls2es) = s2e.s2exp_node
//
var res2: labs2explst = list_nil()
val opt = d2var_search_labsexplst(d2v, s2l, ls2es, res)
//
in
//
case+ opt of
| ~None_vt
    ((*void*)) => None_vt ()
  // end of [None_vt]
| ~Some_vt
    (ls2es_ctx) => let
    val s2t = s2e.s2exp_srt
  in
    Some_vt(s2exp_tyrec_srt(s2t, knd, npf, ls2es_ctx))
  end // end of [Some_vt]
//
end // end of [d2var_search_sexp_tyrec]

implement
pfobj_search_atview
  (s2l0) = let
//
(*
val () = (
  println! ("pfobj_search_atview: s2l0 = ", s2l0)
) (* end of [val] *)
*)
//
fun
loop (
  xs: !d2varmrklst
, s2l0: s2exp, res: &s2exp
) : Option_vt @(d2var, s2exp) = let
//
(*
val () =
println!
  ("pfobj_search_atview: loop")
*)
//
in
//
case+ xs of
//
| D2VMRKLSTcons
    (d2v, !p_xs) => let
    val opt =
      d2var_search(d2v, s2l0, res)
    // end of [val]
  in
    case+ opt of
    | ~Some_vt
        (s2e_ctx) =>
      (
        fold@ (xs); Some_vt @(d2v, s2e_ctx)
      ) // end of [Some_vt]
    | ~None_vt () => let
        val opt =
          loop(!p_xs, s2l0, res) in fold@(xs); opt
      // end of [val]
      end // end of [None]
  end // end of [D2VMARKLSTcons]
//
// HX-2015-01-12:
// searching is only blocked by [lam]
//
| D2VMRKLSTmark
    (knd, !p_xs) => (
    if knd > 0 then let
      val opt =
        loop (!p_xs, s2l0, res) in fold@ (xs); opt
      // end of [val]
    end else (fold@ (xs); None_vt ())
  ) (* end of [D2VMARKLSTmark] *)
//
| D2VMRKLSTnil((*void*)) => (fold@ (xs); None_vt())
//
end // end of [loop]
//
var
res: s2exp =
  s2exp_t0ype_err()
val (pf, fpf | p0_lst) =
  the_d2varmrklst_get_view_ptr ()
//
val opt = loop (!p0_lst, s2l0, res)
//
prval ((*void*)) = fpf (pf)
//
in
//
case+ opt of
//
| ~None_vt
    ((*void*)) => None_vt()
  // end of [None_vt]
//
| ~Some_vt(x) => let
    val obj = PFOBJ(x.0, x.1, res, s2l0) in Some_vt(obj)
  end // end of [Some_vt]
//
end // end of [pfobj_search_atview]

end // end of [local]

(* ****** ****** *)

(* end of [pats_trans3_env_pfman.dats] *)
