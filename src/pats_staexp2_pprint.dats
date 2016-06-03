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
// Start Time: January, 2012
//
(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"
staload "./pats_intinf.sats"

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"

(* ****** ****** *)
//
staload EFF = "./pats_effect.sats"
staload SYN = "./pats_syntax.sats"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"

(* ****** ****** *)

local

#define MAXLEVEL 100

fun aux_s2exp (
  out: FILEref, n: int, s2e0: s2exp
) : void = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ s2e0.s2exp_node of
//
| S2Eint (x) => {
    val () = prstr "S2Eint("
    val () = fprint_int (out, x)
    val () = prstr ")"
  }
| S2Eintinf (x) => {
    val () = prstr "S2Eintinf("
    val () = fprint_intinf (out, x)
    val () = prstr ")"
  }
//
| S2Efloat (rep) => {
    val () = prstr "S2Efloat("
    val () = fprint_string (out, rep)
    val () = prstr ")"
  }
| S2Estring (str) => {
    val () = prstr "S2Estring("
    val () = fprint_string (out, str)
    val () = prstr ")"
  }
//
| S2Ecst (s2c) => {
    val () = prstr "S2Ecst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  }
//
| S2Eextype
    (name, s2ess) => {
    val () = prstr "S2Eextype("
    val () = fprint_string (out, name)
    val () = (
      case+ s2ess of
      | list_nil () => ()
      | list_cons _ => let
          val () = prstr ("; ") in aux_s2explstlst (out, n, s2ess)
        end // end of [list_cons]
    ) // end of [val]
    val () = prstr ")"
  } // end of [S2Eextype]
| S2Eextkind
    (name, s2ess) => {
    val () = prstr "S2Eextkind("
    val () = fprint_string (out, name)
    val () = (
      case+ s2ess of
      | list_nil () => ()
      | list_cons _ => let
          val () = prstr ("; ") in aux_s2explstlst (out, n, s2ess)
        end // end of [list_cons]
    ) // end of [val]
    val () = prstr ")"
  } // end of [S2Eextkind]
//
| S2Evar (x) => {
    val () = prstr "S2Evar("
    val () = fprint_s2var (out, x)
    val () = prstr ")"
  } // end of [S2Evar]
| S2EVar (X) => {
    val opt = s2Var_get_link (X)
    val () = prstr "S2EVar("
    val () = fprint_s2Var (out, X)
    val () = (
      case+ opt of
      | Some (s2e) => {
          val () = prstr "->"
          val () = aux_s2exp_if (out, n-1, s2e)
        } // end of [Some]
      | None () => ()
    ) // end of [val]
    val () = prstr ")"
  } // end of [S2EVar]
//
| S2Ehole (s2h) => {
    val () = prstr "S2Ehole("
    val () = fprint_s2hole (out, s2h)
    val () = prstr ")"
  } // end of [S2Ehole]
//
| S2Edatcontyp
    (d2c, arg) => {
    val () = prstr "S2Edatcontyp("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = aux_s2explst (out, n, arg)
    val () = prstr ")"
  } // end of [S2Edatcontyp]
| S2Edatconptr
    (d2c, rt, arg) => {
    val () = prstr "S2Edatconptr("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = aux_s2exp (out, n, rt)
    val () = prstr "; "
    val () = aux_s2explst (out, n, arg)
    val () = prstr ")"
  } // end of [S2Edatconptr]
//
| S2Eat (s2e1, s2e2) => {
    val () = prstr "S2Eat("
    val () = aux_s2exp (out, n, s2e1)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e2)
    val () = prstr ")"
  } // end of [S2Eat]
| S2Esizeof (s2e) => {
    val () = prstr "S2Esizeof("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Esizeof]
//
| S2Eeff (s2fe) => {
    val () = prstr "S2Eeff("
    val () = aux_s2eff (out, n, s2fe)
    val () = prstr ")"
  } // end of [S2Eeff]
| S2Eeqeq (s2e1, s2e2) => {
    val () = prstr "S2Eeqeq("
    val () = aux_s2exp (out, n, s2e1)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e2)
    val () = prstr ")"
  } // end of [S2Eeqeq]
| S2Eproj (s2a, s2e, s2ls) => {
    val () = prstr "S2Eproj("
    val () = aux_s2exp (out, n, s2a)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e)
    val () = prstr "; "
    val () = aux_s2lablst (out, n, s2ls)
    val () = prstr ")"
  } // end of [S2Eproj]
//
| S2Eapp (s2e_fun, s2es_arg) => {
    val () = prstr "S2Eapp("
    val () = aux_s2exp (out, n, s2e_fun)
    val () = prstr "; "
    val () = aux_s2explst (out, n, s2es_arg)
    val () = prstr ")"
  } // end of [S2Eapp]
| S2Elam (s2vs_arg, s2e_body) => {
    val () = prstr "S2Elam("
    val () = fprint_s2varlst (out, s2vs_arg)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e_body)
    val () = prstr ")"
  } // end of [S2Elam]
| S2Efun (
    fc, lin, s2fe, npf, s2es_arg, s2e_res
  ) => {
    val () = prstr "S2Efun("
    val () = fprint_funclo (out, fc)
    val () = prstr "; "
    val () = fprintf (out, "lin=%i", @(lin))
    val () = prstr "; "
    val () = prstr "eff="
    val () = aux_s2eff (out, n, s2fe)
    val () = prstr "; "
    val () = fprintf (out, "npf=%i", @(npf))
    val () = prstr "; "
    val () = aux_s2explst (out, n, s2es_arg)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e_res)
    val () = prstr ")"
  } // end of [S2Efun]
| S2Emetfun (
    opt, s2es_met, s2e_body
  ) => {
    val () = prstr "S2Emetfun("
    val () = aux_s2explst (out, n, s2es_met)
    val () = prstr "; "
    val () = (
      case+ opt of
      | Some stamp => $STMP.fprint_stamp (out, stamp)
      | None () => ()
    ) // end of [val]
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e_body)
    val () = prstr ")"
  } // end of [S2Emetfun]
//
| S2Emetdec
    (s2es1, s2es2) => {
    val () = prstr "S2Emetdec(("
    val () = aux_s2explst (out, n, s2es1)
    val () = prstr ") < ("
    val () = aux_s2explst (out, n, s2es2)
    val () = prstr "))"
  } // end of [S2Emetdec]
//
| S2Etop
    (knd, s2e) => {
    val () = prstr "S2Etop("
    val () = fprintf (out, "knd=%i", @(knd))
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Etop]
| S2Ewithout (s2e) => {
    val () = prstr "S2Ewithout("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  }
//
| S2Etyarr (s2e_elt, s2es_dim) => {
    val () = prstr "S2Etyarr("
    val () = aux_s2exp (out, n, s2e_elt)
    val () = prstr "; "
    val () = aux_s2explst (out, n, s2es_dim)
    val () = prstr ")"
  } // end of [S2Etyarr]
| S2Etyrec (knd, npf, ls2es) => {
    val () = prstr "S2Etyrec("
    val () = fprint_tyreckind (out, knd)
    val () = prstr "; "
    val () = fprintf (out, "npf=%i", @(npf))
    val () = prstr "; "
    val () = aux_labs2explst (out, n, ls2es)
    val () = prstr ")"
  } // end of [S2Etyrec]
//
| S2Einvar (s2e) => {
    val () = prstr "S2Einvar("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Einvar]
//
| S2Erefarg (knd, s2e) => { // knd=0/1:val/ref
    val () = prstr "S2Erefarg("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Erefarg]
//
| S2Evararg (s2e) => {
    val () = prstr "S2Evararg("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Evararg]
//
| S2Eexi (
    s2vs, s2ps, s2e
  ) => {
    val () = prstr "S2Eexi("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = aux_s2explst (out, n, s2ps)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Eexi]
| S2Euni (
    s2vs, s2ps, s2e
  ) => {
    val () = prstr "S2Euni("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = aux_s2explst (out, n, s2ps)
    val () = prstr "; "
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2Euni]
//
| S2Ewthtype
    (s2e, ws2es) => {
    val () = prstr "S2Ewth("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr "; "
    val () = aux_wths2explst (out, n, ws2es)
    val () = prstr ")"
  }
//
| S2Eerrexp((*void*)) => prstr "S2Eerrexp()"
//
(*
| _ => prstr "S2E...(...)"
*)
//
end // end of [aux_s2exp]

and aux_s2exp_if (
  out: FILEref, n: int, s2e: s2exp
) : void =
  if n > 0 then
    aux_s2exp (out, n, s2e) else fprint_string (out, "...")
  // end of [if]
// end of [aux_s2exp_if]

and aux_s2explst (
  out: FILEref, n:int, s2es: s2explst
) : void = let
  fun loop (
    s2es: s2explst, i: int
  ) :<cloref1> void =
    case+ s2es of
    | list_cons (s2e, s2es) => {
        val () = if i > 0 then fprint_string (out, ", ")
        val () = aux_s2exp (out, n, s2e)
        val () = loop (s2es, i+1)
      } // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [loop]
in
  loop (s2es, 0)
end // end of [aux_s2explst]

and aux_s2explstlst (
  out: FILEref, n:int, s2ess: s2explstlst
) : void = let
  fun loop (
    s2ess: s2explstlst, i: int
  ) :<cloref1> void =
    case+ s2ess of
    | list_cons (s2es, s2ess) => {
        val () = if i > 0 then fprint_string (out, "; ")
        val () = aux_s2explst (out, n, s2es)
        val () = loop (s2ess, i+1)
      } // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [loop]
in
  loop (s2ess, 0)
end // end of [aux_s2explstlst]

and aux_labs2explst (
  out: FILEref, n: int, ls2es: labs2explst
) : void = let
  fun loop (
    ls2es: labs2explst, i: int
  ) :<cloref1> void =
    case+ ls2es of
    | list_cons (ls2e, ls2es) => {
        val SLABELED (l, name, s2e) = ls2e
        val () = if i > 0 then fprint_string (out, ", ")
        val () = $LAB.fprint_label (out, l)
        val () = fprint_string (out, "=")
        val () = aux_s2exp (out, n, s2e)
        val () = loop (ls2es, i+1)
      } // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [loop]
in
  loop (ls2es, 0)
end // end of [aux_labs2explst]

and aux_wths2explst (
  out: FILEref, n: int, ws2es: wths2explst
) : void = let
//
fun loop (
  out: FILEref, xs: wths2explst, i: int
) :<cloref1> void = let
in
//
case+ xs of
| WTHS2EXPLSTnil () => ()
| WTHS2EXPLSTcons_invar
    (k, x, xs) => let
    val () = if i > 0
      then fprint_string (out, ", ")
    val () = fprint_string (out, "invar(")
    val () = fprint_int (out, k)
    val () = fprint_string (out, "; ")
    val () = aux_s2exp (out, n, x)
    val () = fprint_string (out, ")")
  in
    loop (out, xs, i+1)
  end // end of [WTHS2EXPLSTcons_invar]
| WTHS2EXPLSTcons_trans
    (k, x, xs) => let
    val () = if i > 0
      then fprint_string (out, ", ")
    val () = fprint_string (out, "trans(")
    val () = fprint_int (out, k)
    val () = fprint_string (out, "; ")
    val () = aux_s2exp (out, n, x)
    val () = fprint_string (out, ")")
  in
    loop (out, xs, i+1)
  end // end of [WTHS2EXPLSTcons_trans]
| WTHS2EXPLSTcons_none
    (xs) => let
    val () = if i > 0
      then fprint_string (out, ", ")
    val () = fprintf (out, "none()", @())
  in
    loop (out, xs, i+1)
  end // end of [WTHS2EXPLSTcons_none]
//
end // end of [loop]
//
in
  loop (out, ws2es, 0)
end // end of [aux_wths2explst]

and aux_s2lab (
  out: FILEref, n: int, s2l: s2lab
) : void = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ s2l of
| S2LABlab (lab) => {
    val () = prstr "S2LABlab("
    val () = $LAB.fprint_label (out, lab)
    val () = prstr ")"
  }
| S2LABind (ind) => {
    val () = prstr "S2LABind("
    val () = aux_s2explst (out, n, ind)
    val () = prstr ")"
  }
//
end // end of [aux_s2lab]

and aux_s2lablst (
  out: FILEref, n: int, s2ls: s2lablst
) : void = let
  fun loop (
    s2ls: s2lablst, i: int
  ) :<cloref1> void =
    case+ s2ls of
    | list_cons
        (s2l, s2ls) => let
        val () = if i > 0 then fprint_string (out, ", ")
        val () = aux_s2lab (out, n, s2l)
      in
        loop (s2ls, i+1)
      end // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [loop]
in
  loop (s2ls, 0)
end // end of [aux_s2lablst]

and aux_s2eff (
  out: FILEref, n: int, s2fe: s2eff
) : void = let
  macdef prstr (x) = fprint_string (out, ,(x))
in
//
case+ s2fe of
| S2EFFset
    (efs) => {
    val () = prstr "S2EFFset("
    val () = $EFF.fprint_effset (out, efs)
    val () = prstr ")"
  } // end of [S2EFFset]
| S2EFFexp
    (s2e) => {
    val () = prstr "S2EFFexp("
    val () = aux_s2exp (out, n, s2e)
    val () = prstr ")"
  } // end of [S2EFFexp]
| S2EFFadd
    (s2fe1, s2fe2) => {
    val () = prstr "S2EFFadd("
    val () = aux_s2eff (out, n, s2fe1)
    val () = prstr ", "
    val () = aux_s2eff (out, n, s2fe2)
    val () = prstr ")"
  } // end of [S2EFFadd]
//
end // end of [aux_s2eff]

in // in of [local]

implement
fpprint_s2exp
  (out, s2e) = aux_s2exp (out, MAXLEVEL, s2e)
implement
pprint_s2exp (s2e) = fpprint_s2exp (stdout_ref, s2e)
implement
pprerr_s2exp (s2e) = fpprint_s2exp (stderr_ref, s2e)

implement
fpprint_s2explst
  (out, s2es) = aux_s2explst (out, MAXLEVEL, s2es)
implement
pprint_s2explst (s2es) = fpprint_s2explst (stdout_ref, s2es)
implement
pprerr_s2explst (s2es) = fpprint_s2explst (stderr_ref, s2es)

implement
fpprint_s2explstlst
  (out, s2ess) = aux_s2explstlst (out, MAXLEVEL, s2ess)
// end of [fpprint_s2explstlst]

implement
fpprint_labs2explst
  (out, ls2es) = aux_labs2explst (out, MAXLEVEL, ls2es)
// end of [fpprint_labs2explst]

implement
fpprint_wths2explst
  (out, ws2es) = aux_wths2explst (out, MAXLEVEL, ws2es)
// end of [fpprint_wths2explst]

end // end of [local]

(* ****** ****** *)

implement
fpprint_t2mpmarg
  (out, x) = fpprint_s2explst (out, x.t2mpmarg_arg)
// end of [fpprint_t2mpmarg]

implement
fpprint_t2mpmarglst
  (out, xs) = $UT.fprintlst (out, xs, "><", fpprint_t2mpmarg)
// end of [fpprint_t2mpmarglst]

(* ****** ****** *)

(* end of [pats_staexp2_pprint.dats] *)
