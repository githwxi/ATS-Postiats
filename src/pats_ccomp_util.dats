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
// Start Time: October, 2012
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

staload "pats_basics.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
tmpvar_is_void (tmp) =
  hisexp_is_void (tmpvar_get_type (tmp))
// end of [tmpvar_is_void]

(* ****** ****** *)

implement
primval_is_void
  (pmv) = hisexp_is_void (pmv.primval_type)
// end of [primval_is_void]

(* ****** ****** *)

implement
primval_is_top (pmv) = (
  case+ pmv.primval_node of PMVtop () => true | _ => false
) // end of [primval_is_top]

(* ****** ****** *)
//
// HX-2013-02:
// [pmv] should not be assgined to a variable:
// it is either a left-value, a field-section, or a lamfix-value
//
implement
primval_is_nshared
  (pmv) = let
in
//
case+
  pmv.primval_node of
| PMVtmpref _ => true // left-value
| PMVargref _ => true // left-value
//
| PMVselcon _ => true // field-selection
| PMVselect _ => true // field-selection
| PMVselect2 _ => true // field-selection
//
| PMVselptr _ => true // left-value
//
| PMVlamfix _ => true // lamfix-value
//
| PMVcastfn (d2c, pmv) => primval_is_nshared (pmv)
//
| _ => false
//
end // end of [primval_is_nshared]

(* ****** ****** *)

implement
primval_make_funlab
  (loc, fl) = let
//
val hse = funlab_get_type (fl)
val funclo = funlab_get_funclo (fl)
//
in
//
case+ funclo of
| FUNCLOfun () => primval_funlab (loc, hse, fl)
| FUNCLOclo (knd) => primval_cfunlab (loc, hse, knd, fl)
//
end // end of [primval_make_funlab]

(* ****** ****** *)

implement
primval_make2_funlab
  (loc, hse0, fl) = let
//
val hse = funlab_get_type(fl)
val funclo = funlab_get_funclo(fl)
//
in
//
case+ funclo of
| FUNCLOfun() => primval_funlab(loc, hse0, fl)
| FUNCLOclo(knd) => primval_cfunlab(loc, hse0, knd, fl)
//
end // end of [primval_make2_funlab]

(* ****** ****** *)

implement
primval_make_d2vfunlab
  (loc, d2v, fl) = let
  val hse = funlab_get_type(fl) in primval_d2vfunlab(loc, hse, d2v, fl)
end // end of [primval_make_d2vfunlab]

(* ****** ****** *)

implement
patckont_is_none(fail) =
  case+ fail of PTCKNTnone() => true | _ => false
// end of [patckont_is_none]

(* ****** ****** *)

implement
tmpsub2stasub (tsub) = let
//
fun loop
  (sub: &stasub, tsub: tmpsub): void = let
in
//
case+ tsub of
| TMPSUBcons
    (s2v, s2e, tsub) => let
    val () = stasub_add (sub, s2v, s2e) in loop (sub, tsub)
  end // end of [TMPSUBcons]
| TMPSUBnil () => ()
//
end // end of [loop]
//
var sub
  : stasub = stasub_make_nil ()
val () = loop (sub, tsub)
//
in
  sub
end // end of [tmpsub2stasub]

(* ****** ****** *)

implement
tmpsub_append
  (xs1, xs2) = let
in
  case+ xs1 of
  | TMPSUBcons (s2v, s2f, xs1) =>
      TMPSUBcons (s2v, s2f, tmpsub_append (xs1, xs2))
  | TMPSUBnil () => xs2
end // end of [tmpsub_append]

(* ****** ****** *)

#if(0)

extern
fun
tailcalck
(
  env: !ccompenv
, tmpret: tmpvar, pmv: primval, ntl0: &int? >> int
) : funlabopt_vt // end of [tailcalck]

implement
tailcalck
  (env, tmpret, pmv, ntl0) = let
//
val () = ntl0 := ~1
val isret = tmpvar_isret (tmpret)
//
in
//
if isret then
(
case+
pmv.primval_node
of (* case+ *)
| PMVcst (d2c) => let
    val () = ntl0 := 0
  in
    ccompenv_find_tailcalenv_cst (env, d2c)
  end // end of [PMVcst]
| PMVfunlab (fl) => let
    val ntl = ccompenv_find_tailcalenv (env, fl)
    val () = ntl0 := ntl
  in
    if ntl >= 0 then Some_vt (fl) else None_vt ()
  end // end of [PMVfunlab]
| PMVcfunlab (knd, fl) => let
    val ntl = ccompenv_find_tailcalenv (env, fl)
    val () = ntl0 := ntl
  in
    if ntl >= 0 then Some_vt (fl) else None_vt ()
  end // end of [PMVcfunlab]
| _ => None_vt ()
) else None_vt () // end of [if]
//
end // end of [tailcalck]

#endif // #if(0)

(* ****** ****** *)

local

fun aux
(
  res: &tmpvarset_vt, x: instr
) : void = let
//
macdef tmpadd (tmp) =
  (res := tmpvarset_vt_add (res, ,(tmp)))
//
in
//
case+ x.instr_node of
//
| INSfunlab _ => ()
| INStmplab _ => ()
//
| INScomment _ => ()
//
| INSmove_val
    (tmp, _) => tmpadd (tmp)
| INSpmove_val
    (tmp, _) => tmpadd (tmp)
//
| INSmove_arg_val _ => ()
//
| INSfcall
    (tmp, _, _, _) => tmpadd (tmp)
| INSfcall2
    (tmp, _, _, _, _) => tmpadd (tmp)
//
| INSextfcall
    (tmp, _fun, _arg) => tmpadd (tmp)
| INSextmcall
    (tmp, _obj, _mtd, _arg) => tmpadd (tmp)
//    
| INScond
  (
    _, _then, _else
  ) => () where
  {
    val ((*void*)) = auxlst(res, _then)
    and ((*void*)) = auxlst(res, _else)
  } // end of [INScond]
//
| INSfreecon _ => ()
//
| INSloop
  (
    _, _, _
  , _init, _, _test, _post, _body
  ) => () where
  {
    val ((*void*)) = auxlst(res, _init)
    and ((*void*)) = auxlst(res, _test)
    and ((*void*)) = auxlst(res, _post)
    and ((*void*)) = auxlst(res, _body)
  } // end of [INSloop]
//
| INSloopexn(knd, tlab) => () // HX: knd=0/1: break/continue
//
| INScaseof (ibrs) => auxibrlst (res, ibrs)
//
| INSletpop() => ()
| INSletpush(pmds) => auxpmdlst(res, pmds)
//
| INSmove_con
    (tmp, _, _, _) => tmpadd(tmp)
  // INSmove_con
//
| INSmove_ref(tmp, _) => tmpadd (tmp)
//
| INSmove_boxrec(tmp, _, _) => tmpadd(tmp)
| INSmove_fltrec(tmp, _, _) => tmpadd(tmp)
//
| INSpatck _ => ()
//
| INSmove_ptrofsel(tmp, _, _, _) => tmpadd(tmp)
//
(*
| INSload_ptrofs (tmp, _, _, _) => tmpadd (tmp)
*)
| INSstore_ptrofs _ => ()
| INSxstore_ptrofs
    (tmp, _, _, _, _) => tmpadd (tmp)
//
| INSmove_delay
    (tmp, _, _, _) => tmpadd (tmp)
| INSmove_lazyeval
    (tmp, _, _, _) => tmpadd (tmp)
//
| INSraise _ => ()
| INStrywith
    (tmp, _try, _with) =>
  (
    tmpadd (tmp);
    auxlst (res, _try); auxibrlst (res, _with)
  )
//
| INSmove_list_nil
    (tmp) => tmpadd (tmp)
| INSpmove_list_nil
    (tmp) => tmpadd (tmp)
| INSpmove_list_cons
    (tmp, _) => tmpadd (tmp)
//
| INSmove_list_phead
   (tmp_hd, tmp_tl, _) => tmpadd (tmp_hd)
| INSmove_list_ptail
    (tmp1_tl, tmp2_tl, _) => tmpadd (tmp1_tl)
//
| INSmove_arrpsz_ptr (tmp, _) => tmpadd (tmp)
//
| INSstore_arrpsz_asz (tmp, _) => tmpadd (tmp)
| INSstore_arrpsz_ptr (tmp, _, _) => tmpadd (tmp)
//
| INSupdate_ptrinc (tmp(*ptr*), _(*type*)) => ()
| INSupdate_ptrdec (tmp(*ptr*), _(*type*)) => ()
//
| INSclosure_initize _ => ()
//
| INStmpdec(tmp) => tmpadd(tmp)
//
| INSextvar(d2c, pmv) => ((*void*))
| INSdcstdef(d2c, pmv) => ((*void*))
//
| INStempenver(_(*d2vs*)) => ((*void*))
//
end // end of [aux]

and auxlst
(
  res: &tmpvarset_vt, xs: instrlst
) : void = let
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val () = aux (res, x) in auxlst (res, xs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxlst]

and auxibr
(
  res: &tmpvarset_vt, ibr: ibranch
) : void = let
in
  auxlst (res, ibr.ibranch_inslst)
end // end of [auxibr]

and auxibrlst
(
  res: &tmpvarset_vt, ibrs: ibranchlst
) : void = let
in
//
case+ ibrs of
| list_cons
    (ibr, ibrs) => let
    val () = auxibr (res, ibr) in auxibrlst (res, ibrs)
  end // end of [list_cons]
| list_nil () => ((*empty*))
//
end // end of [auxibrlst]

and auxpmd
(
  res: &tmpvarset_vt, pmd: primdec
) : void = let
in
//
case+ pmd.primdec_node of
| PMDnone () => ()
//
| PMDlist (pmds) => auxpmdlst (res, pmds)
//
| PMDsaspdec _ => ()
//
| PMDextvar
    (name, inss) => let
    val inss = $UN.cast{instrlst}(inss) in auxlst (res, inss)
  end // end of [PMDextvar]
//
| PMDdatdecs _ => ((*void*))
| PMDexndecs _ => ((*void*))
//
| PMDimpdec (impdec) => let
    val opt = hiimpdec_get_instrlstopt (impdec)
  in
    case+ opt of
    | None () => () | Some (inss) => auxlst (res, inss)
  end // end of [PMDimpdec]
//
| PMDfundecs _ => ((*void*))
//
| PMDvaldecs
    (_, _, inss) => let
    val inss = $UN.cast{instrlst}(inss) in auxlst (res, inss)
  end // end of [PMDvaldecs]
| PMDvaldecs_rec
    (_, _, inss) => let
    val inss = $UN.cast{instrlst}(inss) in auxlst (res, inss)
  end // end of [PMDvaldecs_rec]
//
| PMDvardecs (_, inss) => let
    val inss = $UN.cast{instrlst}(inss) in auxlst (res, inss)
  end // end of [PMDvardecs]
//
| PMDinclude (knd, pmds) => auxpmdlst (res, pmds)
//
| PMDstaload _ => ()
//
| PMDstaloadloc (pfil, nspace, pmds) => auxpmdlst (res, pmds)
//
| PMDdynload _ => ()
//
| PMDlocal (
    pmds_head, pmds_body
  ) => {
    val () = auxpmdlst (res, pmds_head)
    val () = auxpmdlst (res, pmds_body)
  } // end of [PMDlocal]
//
end // end of [auxpmd]

and auxpmdlst (
  res: &tmpvarset_vt, pmds: primdeclst
) : void = let
in
//
case+ pmds of
| list_cons
    (pmd, pmds) => let
    val () = auxpmd (res, pmd) in auxpmdlst (res, pmds)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxpmdlst]

in (* in of [local] *)

implement
instrlst_get_tmpvarset
  (xs) = let
//
var res
  : tmpvarset_vt = tmpvarset_vt_nil ()
val () = auxlst (res, xs)
//
in
  res
end // end of [instrlst_get_tmpvarset]

implement
primdeclst_get_tmpvarset
  (xs) = let
//
var res
  : tmpvarset_vt = tmpvarset_vt_nil ()
val () = auxpmdlst (res, xs)
//
in
  res
end // end of [primdeclst_get_tmpvarset]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_util.dats] *)
