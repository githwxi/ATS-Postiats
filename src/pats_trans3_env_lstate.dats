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
// Start Time: May, 2012
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

staload "./pats_basics.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement
prerr_FILENAME<> () = prerr "pats_trans3_lstate"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"
staload "./pats_staexp2_error.sats"

(* ****** ****** *)

staload "./pats_dynexp2.sats"
(*
overload compare with compare_d2var_d2var
*)

(* ****** ****** *)

staload SOL = "./pats_staexp2_solve.sats"

(* ****** ****** *)

staload "./pats_trans3.sats"
staload "./pats_trans3_env.sats"

(* ****** ****** *)

#define l2l list_of_list_vt

(* ****** ****** *)

implement
lstbefitm_make
  (d2v, linval) = let
  val opt = d2var_get_type (d2v) in '{
  lstbefitm_var= d2v, lstbefitm_linval= linval, lstbefitm_type= opt
} end // end of [lstbefitm_make]

(* ****** ****** *)

implement
fprint_lstbefitm (out, x) = let
//
macdef
  prstr (s) = fprint_string (out, ,(s))
// end of [macdef]
val () = prstr "lstbefitm("
val () = fprint_d2var (out, x.lstbefitm_var)
val () = prstr ", "
val () = fprint_int (out, x.lstbefitm_linval)
val () = prstr ", "
val opt = x.lstbefitm_type
val () = (
  case+ opt of
  | Some (s2e) =>
      (prstr "Some("; fprint_s2exp (out, s2e); prstr ")")
  | None () => prstr "None()"
) : void // end of [val]
val () = prstr ")" // end of [val]
//
in
  // nothing
end // end of [fprint_lstbefitm]

implement
fprint_lstbefitmlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_lstbefitm)
// end of [fprint_lstbefitmlst]

(* ****** ****** *)

implement
lstbefitmlst_restore_type
  (xs) = list_app_fun (xs, f) where {
  fun f (x: lstbefitm): void =
    d2var_set_type (x.lstbefitm_var, x.lstbefitm_type)
  // end of [f]
} // end of [where] // end of [lstbefitmlst_restore_type]

implement
lstbefitmlst_restore_linval_type
  (xs) = list_app_fun (xs, f) where {
  fun f (x: lstbefitm): void = let
    val d2v = x.lstbefitm_var
    val () =
      d2var_set_linval (d2v, x.lstbefitm_linval)
    val () = d2var_set_type (d2v, x.lstbefitm_type)
  in
    // nothing
  end // end of [f]
} // end of [where] // end of [lstbefitmlst_restore_type]

(* ****** ****** *)

typedef saityp = s2expopt
typedef saityplst = List (saityp)
viewtypedef saityplst_vt = List_vt (saityp)

extern
fun fprint_saityp : fprint_type (saityp)
implement
fprint_saityp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ x of
  | Some (s2e) =>
      (prstr "Some("; fpprint_s2exp (out, s2e); prstr ")")
  | None () => prstr "None()"
end // end of [fprint_saityp]

extern
fun fprint_saityplst : fprint_type (saityplst)
implement
fprint_saityplst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_saityp)
// end of [fprint_saityplst]

extern
fun fprint_saityplst_vt (out: FILEref, xs: !saityplst_vt): void
implement
fprint_saityplst_vt
  (out, xs) = fprint_saityplst (out, $UN.castvwtp1 {saityplst} (xs))
// end of [fprint_saityplst_vt]

(* ****** ****** *)

extern
fun saityplst_check
  (d2v: d2var, xs: saityplst): int // 0/1: skip/merge
// end of [saityplst_check]

local

fun auxlst (
  s2e0: s2exp, xs: saityplst
) : int = (
  case+ xs of
  | list_cons (x, xs) => (
    case+ x of
    | Some (s2e) => let
        val iseq = s2exp_refeq (s2e0, s2e)
      in
        if iseq then auxlst (s2e0, xs) else 1(*merge*)
      end // end of [SAITYPsome]
    | None () => auxlst (s2e0, xs)
    ) // end of [list_cons]
  | list_nil () => 0 (*skip*)
) // end of [auxlst_check]

in // in of [local]

implement
saityplst_check
  (d2v, xs) = let
  val-list_cons (x, xs) = xs
in
//
case x of
| Some (s2e0) => let
    val () = d2var_set_type (d2v, Some s2e0)
  in
    auxlst (s2e0, xs)
  end // end of [None]
| None () => let
    val () = d2var_set_type (d2v, None ()) in 0(*skip*)
  end // end of [None]
//
end // end of [saityplst_check]

end // end of [local]

(* ****** ****** *)

viewtypedef
lstaftitm = @{
  lstaftitm_var= d2var
, lstaftitm_knd= int // 0/1/2: skip/merge/sub+merge
, lstaftitm_type= s2expopt // it can be found in [lstaftitm_var]
, lstaftitm_saits= saityplst_vt
} // end of [lstaftitm]
viewtypedef
lstaftitmlst = List_vt (lstaftitm)

(* ****** ****** *)

extern
fun fprint_lstaftitm
  (out: FILEref, x: &lstaftitm): void
implement
fprint_lstaftitm
  (out, x) = let
  macdef prstr (s) =
    fprint_string (out, ,(s))
  val () = prstr "LSTAFTITM(\n"
  val () = fprint_d2var (out, x.lstaftitm_var)
  val () = prstr "\n"
  val () = fprint_int (out, x.lstaftitm_knd)
  val () = prstr "\n"
  val () = fprint_s2expopt (out, x.lstaftitm_type)
  val () = prstr "\n"
  val () = fprint_saityplst_vt (out, x.lstaftitm_saits)
  val () = prstr "\n)"
in
  // nothing
end // end of [fprint_lstaftitm]

extern
fun fprint_lstaftitmlst
  (out: FILEref, xs: !lstaftitmlst): void
implement
fprint_lstaftitmlst
  (out, xs) = (
  case+ xs of
  | list_vt_cons
      (!p_x, !p_xs1) => let
      val () = fprint_lstaftitm (out, !p_x)
      val () = fprint_newline (out)
      val () = fprint_lstaftitmlst (out, !p_xs1)
      prval () = fold@ (xs)
    in
      // nothing
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (xs)
) // end of [fprint_lstaftitmlst]

extern
fun lstaftitmlst_free (xs: lstaftitmlst): void
implement
lstaftitmlst_free (xs) = (
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val-~list_vt_nil () = x.lstaftitm_saits
    in
      lstaftitmlst_free (xs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
) // end of [lstaftitmlst_free]

(* ****** ****** *)

extern
fun lstaftitmlst_make
  (xs: lstbefitmlst): lstaftitmlst
implement
lstaftitmlst_make (xs) = let
//
fun loop
(
  xs: lstbefitmlst
, res: &lstaftitmlst? >> lstaftitmlst
) : void = let
in
  case+ xs of
  | list_cons (x, xs) => let
      val d2v = x.lstbefitm_var
      val () =
        res := list_vt_cons {lstaftitm}{0} (?, ?)
      // end of [val]
      val+list_vt_cons (!p_x, !p_res1) = res
      val () = p_x->lstaftitm_var := d2v
      val () = p_x->lstaftitm_knd := 0(*default*)
      val () = p_x->lstaftitm_type := None(*default*)
      val () = p_x->lstaftitm_saits := list_vt_nil
      val () = loop (xs, !p_res1)
    in
      fold@ (res)
    end
  | list_nil () => (res := list_vt_nil ())
end // end of [loop]
//
var res: lstaftitmlst
val () = loop (xs, res)
//
in
  res
end // end of [lstaftitmlst_make]

(* ****** ****** *)

extern
fun lstaftitmlst_update (xs: !lstaftitmlst): void
implement
lstaftitmlst_update (xs) =
(
//
case+ xs of
| list_vt_cons
    (!p_x, !p_xs1) => let
    val d2v = p_x->lstaftitm_var
    val sait = d2var_get_type (d2v)
    val saits = p_x->lstaftitm_saits
    val () = p_x->lstaftitm_saits := list_vt_cons (sait, saits)
    val () = lstaftitmlst_update (!p_xs1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [list_vt_cons]
| list_vt_nil () => fold@ (xs)
//
) // end of [lstaftitmlst_update]

(* ****** ****** *)

extern
fun lstaftitmlst_reverse
  (xs: !lstaftitmlst): void // reverse saityplst
implement
lstaftitmlst_reverse
  (xs) = (
//
case+ xs of
| list_vt_cons
    (!p_x, !p_xs1) => let
    val saits = p_x->lstaftitm_saits
    val () = p_x->lstaftitm_saits := list_vt_reverse (saits)
    val () = lstaftitmlst_reverse (!p_xs1)
    prval () = fold@ (xs)
  in
    // nothing
  end // end of [list_vt_cons]
| list_vt_nil () => fold@ (xs)
//
) // end of [lstaftitmlst_reverse]

(* ****** ****** *)

dataviewtype
lstaftc3nstr =
LSTAFTC3NSTR of (lstaftitmlst, List_vt (c3nstroptref))

(* ****** ****** *)

assume lstaftc3nstr_viewtype = lstaftc3nstr

(* ****** ****** *)

implement
fprint_lstaftc3nstr
  (out, x) = let
//
val LSTAFTC3NSTR (!p_lsais, _) = x
val () = fprint_lstaftitmlst (out, !p_lsais)
prval () = fold@ (x)
//
in
  // nothing
end // end of [fprint_lstaftc3nstr]

(* ****** ****** *)

implement
lstaftc3nstr_initize
  (lsbis) = let
//
val lsais = lstaftitmlst_make (lsbis)
val ctrs = list_vt_nil {c3nstroptref} ()
//
in
  LSTAFTC3NSTR (lsais, ctrs)
end // end of [lstaftc3nstr_initize]

(* ****** ****** *)

implement
lstaftc3nstr_update
  (lsaft, ctr) = let
//
val+LSTAFTC3NSTR (!p1_lsais, !p2_ctrs) = lsaft
val () = lstaftitmlst_update (!p1_lsais)
val () = !p2_ctrs := list_vt_cons (ctr, !p2_ctrs)
prval () = fold@ (lsaft)
//
in
  // nothing
end // end of [lstaftc3nstr_update]

(* ****** ****** *)

implement
lstaftc3nstr_finalize
  (lsaft) = let
//
val+~LSTAFTC3NSTR (lsais, ctrs) = lsaft
val () = lstaftitmlst_free (lsais)
val-list_vt_nil () = ctrs // HX: [ctrs] should be nil!
//
in
  // nothing
end // end of [lstaftc3nstr_finalize]

(* ****** ****** *)

extern
fun lstaftc3nstr_check
  (lsaft: !lstaftc3nstr, invres: i2nvresstate): void
// end of [lstaftc3nstr_check]

local

fun d2var_is_done
  (d2v: d2var): bool = let
  val opt = d2var_get_finknd (d2v)
in
  case+ opt of D2VFINdone _ => true | _ => false
end // end of [d2var_is_done]

fun aux1
  (xs: !lstaftitmlst): d2varlst_vt =
(
//
case+ xs of
| list_vt_cons
    (!p_x, !p_xs1) => let
    val d2v = p_x->lstaftitm_var
    val ans = let
      val isdone = d2var_is_done (d2v)
    in
      if isdone then 0 else let
        val saits = $UN.castvwtp1{saityplst}(p_x->lstaftitm_saits)
      in
        saityplst_check (d2v, saits)
      end // end of [if]
    end : int // end of [val]
    val d2vs = aux1 (!p_xs1)
    prval () = fold@ (xs)
  in
    if ans(*merge*) > 0 then list_vt_cons (d2v, d2vs) else d2vs
  end // end of [list_vt_cons]
| list_vt_nil () => let
    prval () = fold@ (xs) in list_vt_nil ()
  end // end of [list_vt_nil]
//
) // end of [aux1]

fun aux2
(
  d2v0: d2var, d2vs: d2varlst, k: &int
) : s2expopt =
(
//
case+ d2vs of
| list_cons
    (d2v, d2vs) => let
    val sgn = compare (d2v0, d2v)
  in
    if sgn = 0 then let
      val opt = d2var_get_mastype (d2v) in (k := 1; opt)
    end else
      aux2 (d2v0, d2vs, k)
    // end of [if]
  end // end of [list_cons]
| list_nil () => None ()
//
) // end of [aux2]

fun aux3
(
  d2v0: d2var
, args: i2nvarglst, d2vs: d2varlst, k: &int
) : s2expopt =
(
//
case+ args of
| list_cons
    (arg, args) => let
    val d2v =
      i2nvarg_get_var (arg)
    // end of [val]
    val sgn = compare (d2v0, d2v)
  in
    if sgn = 0 then let
      val () = k := 2 in i2nvarg_get_type (arg)
    end else
      aux3 (d2v0, args, d2vs, k)
    // end of [if]
  end // end of [list_cons]
| list_nil () => aux2 (d2v0, d2vs, k)
//
) // end of [aux3]

fun auxlst
(
  xs: !lstaftitmlst, args: i2nvarglst, d2vs: d2varlst
) : void = let
in
//
case+ xs of
| list_vt_cons
    (!p_x, !p_xs1) => let
    val d2v0 = p_x->lstaftitm_var
    var knd: int = 0
    val opt = aux3 (d2v0, args, d2vs, knd)
    val () = p_x->lstaftitm_knd := knd
    val () = p_x->lstaftitm_type := opt
    val () = if knd > 0 then d2var_set_type (d2v0, opt)
    val () = auxlst (!p_xs1, args, d2vs)
  in
    fold@ (xs)
  end // end of [list_vt_cons]
| list_vt_nil () => fold@ (xs)
//
end // end of [auxlst]

in (* in of [local] *)

implement
lstaftc3nstr_check
  (lsaft, invres) = let
//
val+LSTAFTC3NSTR (!p_lsais, _) = lsaft
//
val d2vs = aux1 (!p_lsais)
//
val () = let
  val args = invres.i2nvresstate_arg
  val d2vs = $UN.castvwtp1 {d2varlst} (d2vs)
in
  auxlst (!p_lsais, args, d2vs)
end // end of [val]
//
val () = list_vt_free (d2vs)
//
prval () = fold@ (lsaft)
//
in
  // nothing
end // end of [lstaftc3nstr_check]

end // end of [local]

(* ****** ****** *)

local

fun auxerr_some
(
  loc: loc_t, d2v: d2var, s2e0: s2exp
) : void = let
  val () = prerr_error3_loc (loc)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is consumed but it should be retained with the type ["
  val () = prerr_s2exp (s2e0)
  val () = prerr "] instead."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_some (loc, d2v, s2e0))
end // end of [auxerr_some]

fun auxerr_none
(
  loc: loc_t, d2v: d2var, s2e: s2exp
) : void = let
  val () = prerr_error3_loc (loc)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is retained with the type ["
  val () = prerr_s2exp (s2e)
  val () = prerr "] but it should be consumed instead."
  val () = prerr_newline ()
in
  the_trans3errlst_add (T3E_d2var_some (loc, d2v, s2e))
end // end of [auxerr_none]

fun auxerr_some2
(
  loc: loc_t, d2v: d2var, s2e0: s2exp, s2e: s2exp
) : void = let
  val () = prerr_error3_loc (loc)
  val () = prerr ": the dynamic variable ["
  val () = prerr_d2var (d2v)
  val () = prerr "] is retained but with a type that fails to merge."
  val () = prerr_newline ()
  val () = prerr_the_staerrlst ()
in
  the_trans3errlst_add (T3E_d2var_some2 (loc, d2v, s2e0, s2e))
end // end of [auxerr_some2]

fun auxsait
(
  loc: loc_t
, d2v: d2var (* perform merge for [d2v] *)
, knd: int // HX: 0/1/2 : skip/merge/sub+merge
, sub: !stasub
, sait0: s2expopt, sait: s2expopt
) : void = let
in
//
case+ sait0 of
| Some(s2e0) => (
  case+ sait of
  | Some(s2e) => (
    case+ 0 of
    | _ when knd >= 1 => let
        val
        s2e0 = (
          if knd >= 2
            then s2exp_subst (sub, s2e0) else s2e0
          // end of [if]
        ) : s2exp // end of [val]
//
        val
        (pfpush|()) =
        trans3_env_push()
        val err = $SOL.s2exp_tyleq_solve (loc, s2e, s2e0)
        val knd = C3TKlstate_var (d2v)
        val ((*void*)) = trans3_env_pop_and_add (pfpush | loc, knd)
//
        val () =
        if (err > 0) then {
          val () = prerr_the_staerrlst ()
          val () = auxerr_some2 (loc, d2v, s2e0, s2e)
        } (* end of [if] *) // end of [val]
      in
        // nothing
      end
    | _ (* knd = 0 *) => ()
    ) // end of [Some]
  | None ((*void*)) => auxerr_some (loc, d2v, s2e0)
  )
| None((*void*)) =>
  (
    case+ sait of
    | Some(s2e) => auxerr_none (loc, d2v, s2e) | None() => ()
  ) (* end of [None] *)
//
end // end of [auxsait]

fun auxmain
(
  xs: !lstaftitmlst
, ctr: c3nstroptref, sub: !stasub
) : void = (
  case+ xs of
  | list_vt_cons
      (!p_x, !p_xs1) => let
      val d2v = p_x->lstaftitm_var
      val knd = p_x->lstaftitm_knd
      val sait0 = d2var_get_type (d2v)
      val-~list_vt_cons (sait, saits) = p_x->lstaftitm_saits
      val () = p_x->lstaftitm_saits := saits
      val ctrloc = ctr.c3nstroptref_loc
      val () = auxsait (ctrloc, d2v, knd, sub, sait0, sait)
      val () = auxmain (!p_xs1, ctr, sub)
    in
      fold@ (xs)
    end // end of [list_vt_cons]
  | list_vt_nil () => fold@ (xs)
) // end of [auxmain]

fun auxmainlst
(
  xs: !lstaftitmlst
, ctrs: List_vt (c3nstroptref), invres: i2nvresstate
) : void = let
in
//
case+ ctrs of
| ~list_vt_cons
    (ctr, ctrs) => let
    val ctrloc = ctr.c3nstroptref_loc
    val sub =
      stasub_make_svarlst (ctrloc, invres.i2nvresstate_svs)
    val s2ps = s2explst_subst_vt (sub, invres.i2nvresstate_gua)
//
    val
    (pfpush|()) = trans3_env_push()
//
    val () = trans3_env_add_proplst_vt (ctrloc, s2ps)
    val () = auxmain (xs, ctr, sub)
//
    val s3is = trans3_env_pop (pfpush | (*none*))
    val c3t0 =
      c3nstr_itmlst (ctrloc, C3TKlstate(), (l2l)s3is)
    val () = let
      val ref = ctr.c3nstroptref_ref in !ref := Some (c3t0)
    end // end of [val]
//
    val () = stasub_free (sub)
  in
    auxmainlst (xs, ctrs, invres)
  end // end of [list_vt_cons]
//
| ~list_vt_nil((*void*)) => ()
//
end // end of [auxmainlst]

in // in of [local]

implement
lstaftc3nstr_process
  (lsaft, invres) = let
//
val () =
  lstaftc3nstr_check (lsaft, invres)
//
(*
val () = print "lstaftc3nstr_process:\n"
val () = fprint_lstaftc3nstr (stdout_ref, lsaft)
*)
//
val
LSTAFTC3NSTR
  (!p_lsais, !p_ctrs) = lsaft
//
val ctrs = !p_ctrs
val () = !p_ctrs := list_vt_nil ()
val () = auxmainlst (!p_lsais, ctrs, invres)
//
prval ((*void*)) = fold@ (lsaft)
//
in
  // nothing
end // end of [lstaftc3nstr_process]

end // end of [local]

(* ****** ****** *)

implement
i2nvarglst_update
  (loc, args) = let
in
//
case+ args of
| list_cons
    (arg, args) => let
//
    val d2v = i2nvarg_get_var (arg)
    val opt = i2nvarg_get_type (arg)
(*
    val () = println! ("i2nvarglst_update: d2v = ", d2v)
    val () = println! ("i2nvarglst_update: opt = ", opt)
*)
    val () =
      d2var_inc_linval (d2v)
    // end of [val]
//
    val () = d2var_set_type (d2v, opt)
//
  in
    i2nvarglst_update (loc, args)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [i2nvarglst_update]

(* ****** ****** *)

implement
i2nvresstate_update
  (loc, invres) = let
//
val () =
  trans3_env_add_svarlst (invres.i2nvresstate_svs)
val () =
  trans3_env_hypadd_proplst (loc, invres.i2nvresstate_gua)
//
in
//
// HX-2012-08:
// updating is already done during merge but this is
  i2nvarglst_update (loc, invres.i2nvresstate_arg) // more appropriate
//
end // end of [i2nvresstate_update]

(* ****** ****** *)

(* end of [pats_trans3_lstate.dats] *)
