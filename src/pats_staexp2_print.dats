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

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
INTINF = "./pats_intinf.sats"
macdef
fprint_intinf = $INTINF.fprint_intinf

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"
macdef fprint_symbol = $SYM.fprint_symbol
staload STMP = "./pats_stamp.sats"
macdef fprint_stamp = $STMP.fprint_stamp
staload SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload EFF = "./pats_effect.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_staexp2.sats"
staload "./pats_staexp2_util.sats"

(* ****** ****** *)

implement
fprint_s2rtdat (out, x) = let
  val sym = s2rtdat_get_sym (x) in fprint_symbol (out, sym)
end // end of [fprint_s2rtdat]

(* ****** ****** *)

implement
fprint_s2rtbas (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2RTBASpre (sym) => {
    val () = prstr "S2RTBASpre("
    val () = fprint_symbol (out, sym)
    val () = prstr ")"
  } // end of [S2RTBASpre]
| S2RTBASimp (knd, sym) => {
    val () = prstr "S2RTBASimp("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_symbol (out, sym)
    val pol = test_polkind (knd)
    val () = if pol > 0 then prstr "+"
    val () = if pol < 0 then prstr "-"
    val () = prstr ")"
  } // end of [S2RTBASimp]
| S2RTBASdef (s2td) => {
    val () = prstr "S2RTBASdef("
    val () = fprint_s2rtdat (out, s2td)
    val () = prstr ")"
  } // end of [S2RTBASdef]
//
end // end of [fprint_s2rtbas]

(* ****** ****** *)

implement
fprint_s2rt (out, x) = let
//
val x = s2rt_delink (x)
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ x of
| S2RTbas (s2tb) => {
    val () = prstr "S2RTbas("
    val () = fprint_s2rtbas (out, s2tb)
    val () = prstr ")"
  }
| S2RTfun (s2ts, s2t) => {
    val () = prstr "S2RTfun("
    val () = fprint_s2rtlst (out, s2ts)
    val () = prstr "; "
    val () = fprint_s2rt (out, s2t)
    val () = prstr ")"
  }
| S2RTtup (s2ts) => {
    val () = prstr "S2RTtup("
    val () = fprint_s2rtlst (out, s2ts)
    val () = prstr ")"
  }
| S2RTVar _ => {
    val () = prstr "S2RTVar("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
//
| S2RTerr () => prstr "S2RTerr()"
//
end // end of [fprint_s2rt]

implement print_s2rt (x) = fprint_s2rt (stdout_ref, x)
implement prerr_s2rt (x) = fprint_s2rt (stderr_ref, x)

implement
fprint_s2rtlst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s2rt)
// end of [fprint_s2rtlst]
implement print_s2rtlst (xs) = fprint_s2rtlst (stdout_ref, xs)
implement prerr_s2rtlst (xs) = fprint_s2rtlst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2itm (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2ITMvar (s2v) => {
    val () = prstr "S2ITMvar("
    val () = fprint_s2var (out, s2v)
    val () = prstr ")"
  }
| S2ITMcst (s2cs) => {
    val () = prstr "S2ITMcst("
    val () = fprint_s2cstlst (out, s2cs)
    val () = prstr ")"
  }
| S2ITMe1xp (e1xp) => {
    val () = prstr "S2ITMe1xp("
    val () = fprint_e1xp (out, e1xp)
    val () = prstr ")"
  }
| S2ITMdatconptr (d2c) => {
    val () = prstr "S2ITMdatconptr("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
| S2ITMdatcontyp (d2c) => {
    val () = prstr "S2ITMdatcontyp("
    val () = fprint_d2con (out, d2c)
    val () = prstr ")"
  }
| S2ITMfilenv (fenv) => {
    val () = prstr "S2ITMfilenv("
    val () = $FIL.fprint_filename_full (out, filenv_get_name fenv)
    val () = prstr ")"
  } (* end of [S2ITMfilenv] *)
//
end // end of [fprint_s2itm]

implement print_s2itm (xs) = fprint_s2itm (stdout_ref, xs)
implement prerr_s2itm (xs) = fprint_s2itm (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_tyreckind
  (out, knd) = let
//
macdef prstr (s) = fprint_string (out, ,(s))
//
in
//
case+ knd of
| TYRECKINDbox () => fprint_string (out, "box")
| TYRECKINDbox_lin () => fprint_string (out, "boxlin")
| TYRECKINDflt0 () => fprint_string (out, "flt0")
| TYRECKINDflt1 (stmp) =>
  (
    prstr "flt1("; fprint_stamp (out, stmp); prstr ")"
  ) // end of [TYRECKINDflt1]
| TYRECKINDflt_ext (name) => fprintf (out, "fltext(%s)", @(name))
//
end // end of [fprint_tyreckind]

implement
print_tyreckind (knd) = fprint_tyreckind (stdout_ref, knd)
implement
prerr_tyreckind (knd) = fprint_tyreckind (stderr_ref, knd)

(* ****** ****** *)

implement
fprint_s2hnf
  (out, x) = fprint_s2exp (out, s2hnf2exp x)
// end of [fprint_s2hnf]
implement
print_s2hnf (x) = print_s2exp (s2hnf2exp x)
implement
prerr_s2hnf (x) = prerr_s2exp (s2hnf2exp x)

(* ****** ****** *)

implement
fprint_s2exp (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x.s2exp_node of
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
| S2Ecst (s2c) => {
    val () = prstr "S2Ecst("
    val () = fprint_s2cst (out, s2c)
    val () = prstr ")"
  }
//
| S2Eextype (name, s2ess) => {
    val () = prstr "S2Eextype("
    val () = fprint_string (out, name)
    val () = (
      case+ s2ess of
      | list_nil () => () | list_cons _ => let
          val () = prstr ("; ") in fprint_s2explstlst (out, s2ess)
        end // end of [list_cons]
    ) // end of [val]
    val () = prstr ")"
  } // end of [S2Eextype]
| S2Eextkind (name, s2ess) => {
    val () = prstr "S2Eextkind("
    val () = fprint_string (out, name)
    val () = (
      case+ s2ess of
      | list_nil () => () | list_cons _ => let
          val () = prstr ("; ") in fprint_s2explstlst (out, s2ess)
        end // end of [list_cons]
    ) // end of [val]
    val () = prstr ")"
  } // end of [S2Eextype]
//
| S2Evar (x) => {
    val () = prstr "S2Evar("
    val () = fprint_s2var (out, x)
    val () = prstr ")"
  } // end of [S2Evar]
| S2EVar (X) => {
    val () = prstr "S2EVar("
    val () = fprint_s2Var (out, X)
    val () = prstr ")"
  } // end of [S2EVar]
//
| S2Ehole (s2h) => {
    val () = prstr "S2Ehole("
    val () = fprint_s2hole (out, s2h)
    val () = prstr ")"
  } // end of [S2Ehole]
//
| S2Edatcontyp (d2c, arg) => {
    val () = prstr "S2Edatcontyp("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_s2explst (out, arg)
    val () = prstr ")"
  } // end of [S2Edatcontyp]
| S2Edatconptr (d2c, rt, arg) => {
    val () = prstr "S2Edatconptr("
    val () = fprint_d2con (out, d2c)
    val () = prstr "; "
    val () = fprint_s2exp (out, rt)
    val () = prstr "; "
    val () = fprint_s2explst (out, arg)
    val () = prstr ")"
  } // end of [S2Edatconptr]
//
| S2Eat (s2e1, s2e2) => {
    val () = prstr "S2Eat("
    val () = fprint_s2exp (out, s2e1)
    val () = prstr ", "
    val () = fprint_s2exp (out, s2e2)
    val () = prstr ")"
  } // end of [S2Eat]
| S2Esizeof (s2e) => {
    val () = prstr "S2Esizeof("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Esizeof]
//
| S2Eeff (s2fe) => {
    val () = prstr "S2Eeff("
    val () = fprint_s2eff (out, s2fe)
    val () = prstr ")"
  } // end of [S2Eeff]
| S2Eeqeq (s2e1, s2e2) => {
    val () = prstr "S2Eeqeq("
    val () = fprint_s2exp (out, s2e1)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e2)
    val () = prstr ")"
  } // end of [S2Eeqeq]
| S2Eproj (s2ae, s2te, s2ls) => {
    val () = prstr "S2Eproj("
    val () = fprint_s2exp (out, s2ae)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2te)
    val () = prstr "; "
    val () = fprint_s2lablst (out, s2ls)
    val () = prstr ")"
  } // end of [S2Eproj]
//
| S2Eapp (s2e_fun, s2es_arg) => {
    val () = prstr "S2Eapp("
    val () = fprint_s2exp (out, s2e_fun)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2es_arg)
    val () = prstr ")"
  } // end of [S2Eapp]
| S2Elam (s2vs_arg, s2e_body) => {
    val () = prstr "S2Elam("
    val () = fprint_s2varlst (out, s2vs_arg)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e_body)
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
    val () = fprint_s2eff (out, s2fe)
    val () = prstr "; "
    val () = fprintf (out, "npf=%i", @(npf))
    val () = prstr "; "
    val () = fprint_s2explst (out, s2es_arg)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e_res)
    val () = prstr ")"
  } // end of [S2Efun]
//
| S2Emetfun (
    opt, s2es_met, s2e_body
  ) => {
    val () = prstr "S2Emetfun("
    val () = fprint_s2explst (out, s2es_met)
    val () = prstr "; "
    val () = (
      case+ opt of
      | Some stamp => $STMP.fprint_stamp (out, stamp)
      | None () => ()
    ) // end of [val]
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e_body)
    val () = prstr ")"
  } // end of [S2Emetfun]
//
| S2Emetdec
    (s2es1, s2es2) => {
    val () = prstr "S2Emetdec(("
    val () = fprint_s2explst (out, s2es1)
    val () = prstr ") < ("
    val () = fprint_s2explst (out, s2es2)
    val () = prstr "))"
  } // end of [S2Emetdec]
//
| S2Etop
    (knd, s2e) => {
    val () = prstr "S2Etop("
    val () = fprintf (out, "knd=%i", @(knd))
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Etop]
| S2Ewithout (s2e) => {
    val () = prstr "S2Ewithout("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  }
//
| S2Etyarr (s2e_elt, s2es_dim) => {
    val () = prstr "S2Etyarr("
    val () = fprint_s2exp (out, s2e_elt)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2es_dim)
    val () = prstr ")"
  } // end of [S2Etyarr]
| S2Etyrec (knd, npf, ls2es) => {
    val () = prstr "S2Etyrec("
    val () = fprint_tyreckind (out, knd)
    val () = prstr "; "
    val () = fprintf (out, "npf=%i", @(npf))
    val () = prstr "; "
    val () = fprint_labs2explst (out, ls2es)
    val () = prstr ")"
  } // end of [S2Etyrec]
//
| S2Einvar (s2e) => {
    val () = prstr "S2Einvar("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Einvar]
//
| S2Erefarg (knd, s2e) => { // knd=0/1:val/ref
    val () = prstr "S2Erefarg("
    val () = fprint_int (out, knd)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Erefarg]
//
| S2Evararg (s2e) => {
    val () = prstr "S2Evararg("
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Evararg]
//
| S2Eexi (
    s2vs, s2ps, s2e
  ) => {
    val () = prstr "S2Eexi("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2ps)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Eexi]
| S2Euni (
    s2vs, s2ps, s2e
  ) => {
    val () = prstr "S2Euni("
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr "; "
    val () = fprint_s2explst (out, s2ps)
    val () = prstr "; "
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2Euni]
//
| S2Ewth (s2e, ws2es) => {
    val () = prstr "S2Ewth("
    val () = fprint_s2exp (out, s2e)
    val () = prstr "; "
    val () = fprint_wths2explst (out, ws2es)
    val () = prstr ")"
  }
//
| S2Eerr () => prstr "S2Eerr()"
//
(*
| _ => prstr "S2E...(...)"
*)
//
end // end of [fprint_s2exp]

implement print_s2exp (x) = fprint_s2exp (stdout_ref, x)
implement prerr_s2exp (x) = fprint_s2exp (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s2explst
  (out, xs) = $UT.fprintlst (out, xs, ", ", fprint_s2exp)
// end of [fprint_s2explst]

implement
print_s2explst (xs) = fprint_s2explst (stdout_ref, xs)
implement
prerr_s2explst (xs) = fprint_s2explst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2expopt
  (out, opt) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ opt of
  | Some (s2e) => (
      prstr "Some("; fprint_s2exp (out, s2e); prstr ")"
    ) // end of [Some]
  | None () => prstr "None()"
end // end of [fprint_s2expopt]

implement
print_s2expopt (opt) = fprint_s2expopt (stdout_ref, opt)
implement
prerr_s2expopt (opt) = fprint_s2expopt (stderr_ref, opt)

(* ****** ****** *)

implement
fprint_s2explstlst
  (out, xss) = $UT.fprintlst (out, xss, "; ", fprint_s2explst)
// end of [fprint_s2explstlst]

(* ****** ****** *)

implement
fprint_s2explstopt
  (out, opt) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
  case+ opt of
  | Some (s2es) => (
      prstr "Some("; fprint_s2explst (out, s2es); prstr ")"
    ) // end of [Some]
  | None () => ()
end // end of [fprint_s2explstopt]

(* ****** ****** *)

extern
fun fprint_labs2exp : fprint_type (labs2exp)

implement
fprint_labs2exp (out, x) = {
  val SLABELED (l, name, s2e) = x
  val () = $LAB.fprint_label (out, l)
  val () = fprint_string (out, "=")
  val () = fprint_s2exp (out, s2e)
} // end of [fprint_labs2exp]

implement
fprint_labs2explst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_labs2exp)
// end of [fprint_labs2explst]

(* ****** ****** *)

implement
fprint_wths2explst
  (out, ws2es) = let
//
fun loop (
  out: FILEref, xs: wths2explst, i: int
) : void = let
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
    val () = fprint_s2exp (out, x)
    val () = fprint_string (out, ")")
  in
    loop (out, xs, i + 1)
  end // end of [WTHS2EXPLSTcons_invar]
| WTHS2EXPLSTcons_trans
    (k, x, xs) => let
    val () = if i > 0
      then fprint_string (out, ", ")
    val () = fprint_string (out, "trans(")
    val () = fprint_int (out, k)
    val () = fprint_string (out, "; ")
    val () = fprint_s2exp (out, x)
    val () = fprint_string (out, ")")
  in
    loop (out, xs, i + 1)
  end // end of [WTHS2EXPLSTcons_trans]
| WTHS2EXPLSTcons_none (xs) => let
    val () = if i > 0 then fprint_string (out, ", ")
    val () = fprintf (out, "none()", @())
  in
    loop (out, xs, i + 1)
  end // end of [WTHS2EXPLSTcons_none]
//
end // end of [loop]
//
in
  loop (out, ws2es, 0)
end // end of [fprint_wths2explst]

(* ****** ****** *)

implement
fprint_s2lab
  (out, s2l) = let
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
    val () = $UT.fprintlst (out, ind, ", ", fprint_s2exp)
    val () = prstr ")"
  }
//
end // end of [fprint_s2lab]

implement
print_s2lab (x) = fprint_s2lab (stdout_ref, x)
implement
prerr_s2lab (x) = fprint_s2lab (stderr_ref, x)

implement
fprint_s2lablst
  (out, xs) = $UT.fprintlst (out, xs, " ,", fprint_s2lab)
// end of [fprint_s2lablst]

(* ****** ****** *)

implement
fprint_s2eff
  (out, s2fe) = let
  macdef prstr (s) = fprint_string (out, ,(s))
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
    val () = fprint_s2exp (out, s2e)
    val () = prstr ")"
  } // end of [S2EFFexp]
| S2EFFadd
    (s2fe1, s2fe2) => {
    val () = prstr "S2EFFadd("
    val () = fprint_s2eff (out, s2fe1)
    val () = prstr ", "
    val () = fprint_s2eff (out, s2fe2)
    val () = prstr ")"
  } // end of [S2EFFadd]
//
end // end of [s2eff]

implement
print_s2eff (x) = fprint_s2eff (stdout_ref, x)
implement
prerr_s2eff (x) = fprint_s2eff (stderr_ref, x)

(* ****** ****** *)

implement
fprint_s2qua (out, s2q) = {
  val () = fprint_s2varlst (out, s2q.s2qua_svs)
  val () = fprint_string (out, "; ")
  val () = fprint_s2explst (out, s2q.s2qua_sps)
} // end of [fprint_s2qua]

implement
fprint_s2qualst (out, s2qs) =
  $UT.fprintlst (out, s2qs, "; ", fprint_s2qua)
// end of [fprint_s2qualst]

implement
print_s2qualst (xs) = fprint_s2qualst (stdout_ref, xs)
implement
prerr_s2qualst (xs) = fprint_s2qualst (stderr_ref, xs)

(* ****** ****** *)

implement
fprint_s2rtext (out, x) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ x of
| S2TEsrt (s2t) => {
    val () = prstr "S2TEsrt("
    val () = fprint_s2rt (out, s2t)
    val () = prstr ")"
  }
| S2TEsub _ => {
    val () = prstr "S2TEsub("
    val () = fprint_string (out, "...")
    val () = prstr ")"
  }
| S2TEerr () => prstr "S2TEerr()"
//
end // end of [fprint_s2rtext]

(* ****** ****** *)

implement
fprint_s2exparg (out, s2a) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ s2a.s2exparg_node of
| S2EXPARGone () => prstr "S2EXPARGone()"
| S2EXPARGall () => prstr "S2EXPARGall()"
| S2EXPARGseq (s2es) => {
    val () = prstr "S2EXPARGseq("
    val () = fprint_s2explst (out, s2es)
    val () = prstr ")"
  } // end of [S2EXPARGseq]
//
end // end of [fprint_s2exparg]

implement
fprint_s2exparglst (out, xs) =
  $UT.fprintlst (out, xs, ", ", fprint_s2exparg)
// end of [fprint_s2exparglst]

(* ****** ****** *)

implement
fprint_sp2at
  (out, sp2t) = let
  macdef prstr (s) = fprint_string (out, ,(s))
in
//
case+ sp2t.sp2at_node of
| SP2Tcon (s2c, s2vs) => {
    val () = prstr "SP2Tcon("
    val () = fprint_s2cst (out, s2c)
    val () = prstr "; "
    val () = fprint_s2varlst (out, s2vs)
    val () = prstr ")"
  } // end of [SP2Tcon]
| SP2Terr () => prstr "SP2Terr()"
//
end // end of [fprint_sp2at]

(* ****** ****** *)

(* end of [pats_staexp2_print.dats] *)
