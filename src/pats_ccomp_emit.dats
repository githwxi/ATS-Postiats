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
// Start Time: November, 2012
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_emit"

(* ****** ****** *)

staload
LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"

(* ****** ****** *)

staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload
SYM = "./pats_symbol.sats"
staload
SYN = "./pats_syntax.sats"

(* ****** ****** *)

staload
GLOB = "./pats_global.sats"

(* ****** ****** *)

staload
S2E = "./pats_staexp2.sats"
typedef s2cst = $S2E.s2cst
typedef d2con = $S2E.d2con

(* ****** ****** *)

staload
S2UT = "./pats_staexp2_util.sats"

(* ****** ****** *)

staload
D2E = "./pats_dynexp2.sats"
typedef d2cst = $D2E.d2cst
typedef d2var = $D2E.d2var
typedef d2varlst = $D2E.d2varlst
typedef d2ecl = $D2E.d2ecl
typedef d2eclist = $D2E.d2eclist

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

implement
emit_text
  (out, txt) = fprint_string (out, txt)
// end of [emit_text]

(* ****** ****** *)

implement
emit_lparen (out) = emit_text (out, "(")
implement
emit_rparen (out) = emit_text (out, ")")

(* ****** ****** *)

implement
emit_newline (out) = fprint_newline (out)

(* ****** ****** *)

implement
emit_location
  (out, loc) = $LOC.fprint_location (out, loc)
// end of [emit_location]

(* ****** ****** *)

implement
emit_int (out, x) = fprint_int (out, x)
implement
emit_ATSPMVint (out, x) = (
  emit_text (out, "ATSPMVint("); emit_int (out, x); emit_rparen (out)
) // end of [emit_ATSPMVint]
implement
emit_ATSPMVintrep (out, x) = (
  emit_text (out, "ATSPMVintrep("); emit_text (out, x); emit_rparen (out)
) // end of [emit_ATSPMVintrep]

(* ****** ****** *)

implement
emit_bool (out, x) = fprint_bool (out, x)
implement
emit_ATSPMVbool
  (out, x) = (
  emit_text (out, "ATSPMVbool_"); emit_bool (out, x); emit_text (out, "()")
) // end of [emit_ATSPMVbool]

(* ****** ****** *)

implement
emit_float (out, x) = fprintf (out, "%.18f", @(x))
implement
emit_ATSPMVfloat
  (out, x) = (
  emit_text (out, "ATSPMVfloat("); emit_float (out, x); emit_text (out, ")")
) // end of [emit_ATSPMVfloat]

(* ****** ****** *)

local

fun auxch (
  out: FILEref, c: char
) : void = let
in
//
case+ c of
| '\'' => emit_text (out, "\\'")
| '\n' => emit_text (out, "\\n")
| '\t' => emit_text (out, "\\t")
| '\\' => emit_text (out, "\\\\")
| _ => (
    if char_isprint (c)
      then fprint_char (out, c)
      else let
        val uc= uchar_of_char (c) in
        fprintf (out, "\\%.3o", @($UN.cast2uint(uc)))
      end // end of [else]
    // end of [if]
  ) // end of [_]
//
end // end of [auxch]

fun auxch2 (
  out: FILEref, c: char
) : void = let
in
//
case+ c of
| '"' => emit_text (out, "\\\"")
| '\n' => emit_text (out, "\\n")
| '\t' => emit_text (out, "\\t")
| '\\' => emit_text (out, "\\\\")
| _ => (
    if char_isprint (c)
      then fprint_char (out, c)
      else let
        val uc = uchar_of_char (c) in
        fprintf (out, "\\%.3o", @($UN.cast2uint(uc)))
      end // end of [else]
    // end of [if]
  ) // end of [_]
//
end // end of [auxch2]

in (* in of [local] *)

implement
emit_char (out, c) = auxch (out, c)

implement
emit_string
  (out, str) = let
//
fun auxstr (
  out: FILEref, str: string
) : void = let
//
val isnot = string_isnot_empty (str)
in
//
if isnot then let
  val p = $UN.cast2Ptr1 (str)
  val () = auxch2 (out, $UN.ptrget<char> (p))
  val str = $UN.cast{string}(p+1)
in
  auxstr (out, str)  
end else () // end of [if]
//
end // end of [auxstr]
//
val () = auxstr (out, str)
//
in
  // nothing
end // end of [emit_string]

end // end of [local]

(* ****** ****** *)

implement
emit_ATSPMVchar (out, c) = {
  val () = emit_text (out, "ATSPMVchar('")
  val () = emit_char (out, c)
  val () = emit_text (out, "')")
} // end of [emit_ATSPMVchar]

implement
emit_ATSPMVstring (out, str) = {
  val () = emit_text (out, "ATSPMVstring(\"")
  val () = emit_string (out, str)
  val () = emit_text (out, "\")")
} // end of [emit_ATSPMVstring]

(* ****** ****** *)

implement
emit_ATSPMVi0nt
  (out, tok) = {
  val () =
    emit_text (out, "ATSPMVi0nt(")
  val () = $SYN.fprint_i0nt (out, tok)
  val () = emit_rparen (out)
} // end of [emit_ATSPMVi0nt]

implement
emit_ATSPMVf0loat
  (out, tok) = {
  val () =
    emit_text (out, "ATSPMVf0loat(")
  val () = $SYN.fprint_f0loat (out, tok)
  val () = emit_rparen (out)
} // end of [emit_ATSPMVf0loat]

(* ****** ****** *)

implement
emit_symbol
  (out, sym) = $SYM.fprint_symbol (out, sym)
// end of [emit_symbol]

(* ****** ****** *)

local

staload
TM = "libc/SATS/time.sats"
stadef time_t = $TM.time_t

in // in of [local]

implement
emit_time_stamp (out) = let
//
var tm: time_t
val () = tm := $TM.time_get ()
val (pfopt | p_tm) = $TM.localtime (tm)
//
val () = emit_text (out, "/*\n");
val () = emit_text (out, "**\n");
val () = emit_text (out, "** The C code is generated by ATS/Postiats\n");
val () = emit_text (out, "** The compilation time is: ")
//
val () =
  if p_tm > null then let
  prval Some_v @(pf1, fpf1) = pfopt
  val tm_min = $TM.tm_get_min (!p_tm)
  val tm_hour = $TM.tm_get_hour (!p_tm)
  val tm_mday = $TM.tm_get_mday (!p_tm)
  val tm_mon = 1 + $TM.tm_get_mon (!p_tm)
  val tm_year = 1900 + $TM.tm_get_year (!p_tm)
  prval () = fpf1 (pf1)
in
  fprintf (out
  , "%i-%i-%i: %2ih:%2im\n"
  , @(tm_year, tm_mon, tm_mday, tm_hour, tm_min)
  )
end else let
  prval None_v () = pfopt
in
  emit_text (out, "**UNKNOWN**\n")
end // end of [if]
//
val () = emit_text (out, "**\n")
val () = emit_text (out, "*/\n")
//
in
  emit_newline (out)
end // end of [emit_time_stamp]

end // end of [local]

(* ****** ****** *)

local

fun aux (
  out: FILEref, c: char
) = let
  val isalnum_ = 
    if char_isalnum (c) then true else (c = '_')
  // end of [val]
in
  case+ 0 of
  | _ when isalnum_ => fprint_char (out, c)
  | _ => {
      val () = fprintf (out, "_%.3o$", @($UN.cast2uint(c)))
    } // end of [_]
end // end of [aux]

in (* in of [local] *)

implement
emit_ident
  (out, name) = let
  val isnot = string_isnot_empty (name)
in
//
if isnot then let
  val p = $UN.cast2Ptr1 (name)
  val c = $UN.ptrget<char> (p)
  val () = aux (out, c)
  val name = $UN.cast{string}(p+1)
in
  emit_ident (out, name)
end // end of [if]
//
end // end of [emit_ident]

end // end of [local]

(* ****** ****** *)

implement
emit_label
  (out, lab) = () where {
  val () = $LAB.fprint_label (out, lab)
} // end of [emit_label]

implement
emit_atslabel
  (out, lab) = () where {
  val () = emit_text (out, "atslab$")
  val () = $LAB.fprint_label (out, lab)
} // end of [emit_atslabel]

implement
emit_labelext
  (out, knd, lab) = let
// HX: knd = 0/1 : ats/ext
in
//
if knd > 0
  then emit_label (out, lab)
  else emit_atslabel (out, lab)
// end of [if]
//
end // end of [emit_labelext]

(* ****** ****** *)

implement
emit_filename
  (out, fil) = let
  val fsymb =
    $FIL.filename_get_fullname (fil)
  // end of [val]
  val fname = $SYM.symbol_get_name (fsymb)
in
  emit_ident (out, fname)
end // end of [emit_filename]

(* ****** ****** *)

implement
emit_primcstsp
  (out, pmc) = let
in
//
case+ pmc of
| PMCSTSPmyfil (fil) => {
    val () =
      emit_text (
      out, "ATSCSTSPmyfil(\""
    ) // end of [val]
    val (
    ) = $FIL.fprint_filename_full (out, fil)
    val () = emit_text (out, "\")")
  }
| PMCSTSPmyloc (loc) => {
    val () =
      emit_text (
      out, "ATSCSTSPmyloc(\""
    ) // end of [val]
    val () = $LOC.fprint_location (out, loc)
    val () = emit_text (out, "\")")
  }
| PMCSTSPmyfun (flab) => {
    val () =
      emit_text (
      out, "ATSCSTSPmyfun(\""
    ) // end of [val]
    val () = fprint_funlab (out, flab)
    val () = emit_text (out, "\")")
  }
//
end // end of [emit_primcstsp]

(* ****** ****** *)

implement
emit_sizeof
  (out, hselt) = let
//
val () =
  emit_text (out, "ATSPMVsizeof(")
val () = emit_hisexp (out, hselt)
val () = emit_rparen (out)
//
in
end // end of [emit_sizeof]

(* ****** ****** *)

local

fun
aux_prfx (
  out: FILEref, s2c: s2cst
) : void = let
//
val pack =
  $S2E.s2cst_get_pack (s2c)
// end of [val]
val issome = stropt_is_some (pack)
//
in
//
if issome then let
  val pack = stropt_unsome (pack)
in
  emit_ident (out, pack)
end else let
  val fil = $S2E.s2cst_get_fil (s2c)
in
  emit_filename (out, fil)
end // end of [if]
//
end // end of [aux_prfx]

in (* in of [local] *)

implement
emit_s2cst
  (out, s2c) = let
  val () = aux_prfx (out, s2c)
  val () = emit_text (out, "_")
  val name = $S2E.s2cst_get_name (s2c)
  val () = emit_ident (out, name)
in
  // nothing
end // end of [emit_s2cst]

end // end of [local]

(* ****** ****** *)

local

fun
aux_prfx
(
  out: FILEref
, fil: $FIL.filename, packopt: Stropt
) : void = let
//
val isnone = stropt_is_none (packopt)
//
in
//
if isnone then
(
  emit_filename (out, fil)
) else let
  val packname = stropt_unsome (packopt)
in
  emit_ident (out, packname)
end // end of [if]
//
end // end of [aux_prfx]

in (* in of [local] *)

implement
emit_d2con
  (out, d2c) = let
  val fil = $S2E.d2con_get_fil (d2c)
  val packopt = $S2E.d2con_get_pack (d2c)
  val () = aux_prfx (out, fil, packopt)
  val () = emit_text (out, "_")
  val name = $S2E.d2con_get_name (d2c)
  val () = emit_ident (out, name)
  val tag = $S2E.d2con_get_tag (d2c)
  val () = if
    tag >= 0 then let // HX: not exncon
    val () = fprintf (out, "_%i", @(tag))
  in
    // nothing
  end // end of [val]
in
  // nothing
end // end of [emit_d2con]

(* ****** ****** *)

implement
emit_d2cst
  (out, d2c) = let
//
val extdef = $D2E.d2cst_get_extdef (d2c)
//
in
//
case+ extdef of
| $SYN.DCSTEXTDEFnone () => let
    val fil = $D2E.d2cst_get_fil (d2c)
    val packopt = $D2E.d2cst_get_pack (d2c)
    val () = aux_prfx (out, fil, packopt)
    val () = emit_text (out, "_")
    val name = $D2E.d2cst_get_name (d2c)
    val () = emit_ident (out, name)
  in
    // nothing
  end // end of [DCSTEXTDEFnone]
//
| $SYN.DCSTEXTDEFsome_ext (name) => emit_ident (out, name)
| $SYN.DCSTEXTDEFsome_mac (name) => emit_ident (out, name)
| $SYN.DCSTEXTDEFsome_sta (name) => emit_ident (out, name)
//
end // end of [emit_d2cst]

end // end of [local]

(* ****** ****** *)

implement
emit2_d2cst
  (out, d2c) = emit_ident (out, $D2E.d2cst_get_name (d2c))
// end of [emit2_d2cst]

(* ****** ****** *)

implement
emit_tmplab
  (out, tlab) = let
  val () = emit_text (out, "__patstlab_")
in
  $STMP.fprint_stamp (out, tmplab_get_stamp (tlab))
end // end of [emit_tmplab]

implement
emit_tmplabint
  (out, tlab, i) = let
  val () = emit_tmplab (out, tlab)
  val () = fprintf (out, "$%i", @(i))
in
  // nothing
end // end of [emit_tmplabint]

(* ****** ****** *)

local

val the_nfnx = ref_make_elt<int> (0)

in (* in of [local] *)

implement
emit_set_nfnx (nfnx) = (!the_nfnx := nfnx)

implement
emit_funarg
  (out, narg) = let
  val nfnx = !the_nfnx
in
  if nfnx <= 1
    then fprintf (out, "arg%i", @(narg))
    else fprintf (out, "a%irg%i", @(nfnx, narg))
  // end of [val]
end // end of [emit_funarg]

implement
emit_funargx
  (out, narg) = let
  val nfnx = !the_nfnx
in
  if nfnx <= 1
    then fprintf (out, "argx%i", @(narg))
    else fprintf (out, "a%irgx%i", @(nfnx, narg))
  // end of [val]
end // end of [emit_funargx]

end // end of [local]

(* ****** ****** *)

local

fun auxtmp (
  out: FILEref, tmp: tmpvar
) : void = let
//
val knd = tmpvar_get_topknd (tmp)
//
val () =
(
  case+ 0 of
  | _ when knd = 0 => let
    in
      emit_text (out, "tmp") // local temporary variable
    end // end of [_]
  | _ (*(static)top*) => let
    in
      emit_text (out, "statmp") // static toplevel temporary
    end // end of [knd = 1]
) : void // end of [val]
//
val isref = tmpvar_isref (tmp)
val () = if isref then emit_text (out, "ref")
val isret = tmpvar_isret (tmp)
val () = if isret then emit_text (out, "ret")
//
val opt = tmpvar_get_origin (tmp)
//
in
//
case+ opt of
| Some (tmpp) => let
    val sfx = tmpvar_get_suffix (tmp)
    val stmp = tmpvar_get_stamp (tmpp)
    val () = $STMP.fprint_stamp (out, stmp)
    val () = fprintf (out, "$%i", @(sfx))
  in
    // nothing
  end // end of [Some]
| None () => let
    val stmp = tmpvar_get_stamp (tmp)
    val () = $STMP.fprint_stamp (out, stmp)
  in
    // nothing
  end // end of [None]
//
end // end of [auxtmp]

in (* in of [local] *)

implement
emit_tmpvar
  (out, tmp) = auxtmp (out, tmp)
// end of [emit_tmpvar]

end // end of [local]

(* ****** ****** *)

local

fun auxmain
(
  out: FILEref, flab: funlab
) : void = let
//
val qopt = funlab_get_d2copt (flab)
val tmparg = funlab_get_tmparg (flab)
//
val () = (
  case+ qopt of
  | Some (d2c) => let
      val () = emit_d2cst (out, d2c)
    in
      // nothing
    end // end of [Some]
  | None () => let
      val () = emit_ident (out, funlab_get_name (flab))
    in
      // nothing
    end // end of [None]
) : void // end of [val]
//
val tmpknd =
  funlab_get_tmpknd (flab)
val () =
  if tmpknd > 0 then {
  val () = emit_text (out, "$")
  val stamp = funlab_get_stamp (flab)
  val () = $STMP.fprint_stamp (out, stamp)
} // end of [val]
//
in
  // nothing
end // end of [auxmain]

in (* in of [local] *)

implement
emit_funlab
  (out, flab) = let
//
val opt = funlab_get_origin (flab)
val () = (
  case+ opt of
  | Some (
     flab_1 // origin
    ) => emit_funlab (out, flab_1)
  | None () => auxmain (out, flab)
) // end of [val]
val sfx = funlab_get_suffix (flab)
val () = if sfx > 0 then fprintf (out, "$%i", @(sfx))
//
in
  // nothing
end // end of [emit_funlab]

implement
emit2_funlab
  (out, flab) = let
//
val qopt = funlab_get_d2copt (flab)
val name = (
  case+ qopt of
  | Some (
      d2c
    ) => $D2E.d2cst_get_name (d2c)
  | None () => funlab_get_name (flab)
) : string // end of [val]
val () = emit_ident (out, name)
//
in
  // nothing
end // end of [emit2_funlab]

end // end of [local]

(* ****** ****** *)

implement
emit_tmpdec
  (out, tmp) = let
//
val hse = tmpvar_get_type (tmp)
val isvoid = hisexp_is_void (hse)
val knd = tmpvar_get_topknd (tmp)
//
val () =
(
  if knd = 0
    then emit_text (out, "ATStmpdec") // local
    else emit_text (out, "ATSstatmpdec") // toplevel
  // end of [if]
) : void // end of [val]
val () =
(
  if isvoid then emit_text (out, "_void")
)
//
val () = emit_text (out, "(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [emit_tmpdec]

implement
emit_tmpdeclst
  (out, tmps) = let
in
//
case+ tmps of
| list_cons
    (tmp, tmps) => let
    val () = emit_tmpdec (out, tmp) in emit_tmpdeclst (out, tmps)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_tmpdeclst]

(* ****** ****** *)

typedef
emit_primval_type = (FILEref, primval) -> void

(* ****** ****** *)
//
extern fun emit_primval_arg : emit_primval_type
extern fun emit_primval_argref : emit_primval_type
extern fun emit_primval_argenv : emit_primval_type
//
extern fun emit_primval_tmp : emit_primval_type
extern fun emit_primval_tmpref : emit_primval_type
//
extern fun emit_primval_env : emit_primval_type
//
extern fun emit_primval_d2cst : emit_primval_type
//
extern fun emit_primval_castfn : emit_primval_type
//
extern fun emit_primval_selcon : emit_primval_type
extern fun emit_primval_select : emit_primval_type
extern fun emit_primval_select2 : emit_primval_type
//
extern fun emit_primval_selptr : emit_primval_type
//
extern fun emit_primval_ptrof : emit_primval_type
extern fun emit_primval_ptrof2 : emit_primval_type
//
extern fun emit_primval_ptrofsel : emit_primval_type
//
extern fun emit_primval_refarg : emit_primval_type
//
extern fun emit_primval_funlab : emit_primval_type
extern fun emit_primval_cfunlab : emit_primval_type
//
extern fun emit_primval_err : emit_primval_type
//
(* ****** ****** *)

implement
emit_primval
  (out, pmv0) = let
//
val loc0 = pmv0.primval_loc
//
in
//
case+ pmv0.primval_node of
| PMVtmp _ => emit_primval_tmp (out, pmv0)
| PMVtmpref _ => emit_primval_tmpref (out, pmv0)
| PMVarg _ => emit_primval_arg (out, pmv0)
| PMVargref _ => emit_primval_argref (out, pmv0)
| PMVargenv _ => emit_primval_argenv (out, pmv0)
//
| PMVenv _ => emit_primval_env (out, pmv0)
//
| PMVcst _ => emit_primval_d2cst (out, pmv0)
//
| PMVint (i) => emit_ATSPMVint (out, i)
| PMVintrep (rep) => emit_ATSPMVintrep (out, rep)
//
| PMVbool (b) => emit_ATSPMVbool (out, b)
| PMVchar (c) => emit_ATSPMVchar (out, c)
| PMVfloat (f) => emit_ATSPMVfloat (out, f)
| PMVstring (str) => emit_ATSPMVstring (out, str)
//
| PMVi0nt (tok) => emit_ATSPMVi0nt (out, tok)
| PMVf0loat (tok) => emit_ATSPMVf0loat (out, tok)
//
| PMVcstsp (pmc) => emit_primcstsp (out, pmc)
//
| PMVtop () => fprintf (out, "ATStop()", @())
| PMVempty () => fprintf (out, "ATSempty()", @())
//
| PMVextval (name) =>
    fprintf (out, "ATSextval(%s)", @(name))
//
| PMVcastfn _ => emit_primval_castfn (out, pmv0)
//
| PMVsizeof (hselt) => emit_sizeof (out, hselt)
//
| PMVselcon _ => emit_primval_selcon (out, pmv0)
| PMVselect _ => emit_primval_select (out, pmv0)
| PMVselect2 _ => emit_primval_select2 (out, pmv0)
//
| PMVselptr _ => emit_primval_selptr (out, pmv0)
//
| PMVptrof _ => emit_primval_ptrof (out, pmv0)
| PMVptrofsel _ => emit_primval_ptrofsel (out, pmv0)
//
| PMVrefarg _ => emit_primval_refarg (out, pmv0)
//
| PMVfunlab _ => emit_primval_funlab (out, pmv0)
| PMVcfunlab _ => emit_primval_cfunlab (out, pmv0)
//
| PMVlamfix (knd, pmv) => emit_primval (out, pmv)
//
| PMVerr () => emit_primval_err (out, pmv0)
//
| _ => let
(*
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_primval: pmv0 = "; prerr pmv0; prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
*)
  in
    fprint_primval (out, pmv0)
  end // end of [_]
//
end // end of [emit_primval]

(* ****** ****** *)

implement
emit_primvalist
  (out, pmvs) = let
//
fun loop (
  out: FILEref, pmvs: primvalist, i: int
) : void = let
in
//
case+ pmvs of
| list_cons
    (pmv, pmvs) => let
    val () =
      if i > 0 then emit_text (out, ", ")
    // end of [val]
    val () = emit_primval (out, pmv)
  in
    loop (out, pmvs, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, pmvs, 0)
end // end of [emit_primvalist]

(* ****** ****** *)

implement
emit_primval_arg
  (out, pmv0) = let
//
val-PMVarg (n) = pmv0.primval_node
//
in
  emit_funarg (out, n)
end // end of [emit_primval_arg]

(* ****** ****** *)

implement
emit_primval_argref
  (out, pmv0) = let
//
val-PMVargref (n) = pmv0.primval_node
//
in
  emit_funarg (out, n)
end // end of [emit_primval_argref]

(* ****** ****** *)

implement
emit_primval_argenv
  (out, pmv0) = let
//
val-PMVargenv (nenv) = pmv0.primval_node
//
in
  fprintf (out, "env%i", @(nenv))
end // end of [emit_primval_argenv]

(* ****** ****** *)

implement
emit_primval_tmp
  (out, pmv0) = let
//
val-PMVtmp (tmp) = pmv0.primval_node
//
in
  emit_tmpvar (out, tmp)
end // end of [emit_primval_tmp]

implement
emit_primval_tmpref
  (out, pmv0) = let
//
val-PMVtmpref (tmp) = pmv0.primval_node
//
in
  emit_tmpvar (out, tmp)
end // end of [emit_primval_tmpref]

(* ****** ****** *)

implement
emit_d2env
  (out, d2e) = let
//
val d2v =
  d2env_get_var (d2e)
//
in
  emit_d2var_env (out, d2v)
end (* end of [emit_d2env] *)

implement
emit_d2var_env
  (out, d2v) = let
//
val opt = the_funent_varbindmap_find (d2v)
//
in
//
case+ opt of
| ~Some_vt (pmv) =>
    emit_primval (out, pmv)
| ~None_vt () => let
    val () = emit_text (out, "ATSPMVenv")
    val () = emit_lparen (out)
    val () = emit_symbol (out, $D2E.d2var_get_sym (d2v))
    val () = emit_rparen (out)
  in
    // nothing
  end (* end of [None_vt] *)
//
end // end of [emit_d2var_env]

(* ****** ****** *)

implement
emit_d2envlst
  (out, d2es) = let
//
fun auxlst
(
  out: FILEref, d2es: d2envlst, i: int
) : int = let
in
//
case+ d2es of
| list_cons
    (d2e, d2es) => let
    val () =
      if (i > 0) then emit_text (out, ", ")
    // end of [val]
    val () = emit_d2env (out, d2e)
  in
    auxlst (out, d2es, i+1)
  end // end of [list_cons]
| list_nil () => (i)
//
end (* end of [auxlst] *)
//
in
  auxlst (out, d2es, 0)
end // end of [emit_d2envlst]

(* ****** ****** *)

implement
emit_primval_env
  (out, pmv0) = let
//
val-PMVenv (d2v) = pmv0.primval_node
//
in
  emit_d2var_env (out, d2v)
end (* end of [emit_primval_env] *)

(* ****** ****** *)

implement
emit_primval_d2cst
  (out, pmv0) = let
//
val-PMVcst (d2c) = pmv0.primval_node
//
in
  emit_d2cst (out, d2c)
end // end of [emit_primval_d2cst]

(* ****** ****** *)

implement
emit_primval_castfn
  (out, pmv0) = let
//
val hse0 = pmv0.primval_type
val-PMVcastfn
  (d2c, arg) = pmv0.primval_node
//
val () = emit_text (out, "ATSPMVcastfn(")
val () = emit2_d2cst (out, d2c) // local name
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse0)
val () = emit_text (out, ", ")
val () = emit_primval (out, arg)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_castfn]

(* ****** ****** *)

implement
emit_primval_ptrof
  (out, pmv0) = let
//
val-PMVptrof (pmv) = pmv0.primval_node
//
in
  emit_primval_ptrof2 (out, pmv)
end // end of [emit_primval_ptrof]

implement
emit_primval_ptrof2
  (out, pmv) = let
//
fun testselptr0
  (pmv: primval): bool =
(
case+ pmv.primval_node of
| PMVselptr (_, _, list_nil ()) => true | _ => false
)
//
val test = testselptr0 (pmv)
//
in
//
if test then let
  val-PMVselptr
    (pmv_ptr, _, _) = pmv.primval_node
  // end of [val]
in
  emit_primval (out, pmv_ptr)
end else let
  val isvoid = primval_is_void (pmv)
  val () = emit_text (out, "ATSPMVptrof")
  val () = if isvoid then emit_text (out, "_void")
  val () = emit_lparen (out)
  val () = emit_primval (out, pmv(*lvalue*))
  val () = emit_rparen (out)
in
  // nothing
end // end of [if]
//
end // end of [emit_primval_ptrof2]

(* ****** ****** *)

implement
emit_primval_refarg
  (out, pmv0) = let
//
val-PMVrefarg
  (knd, freeknd, pmv) = pmv0.primval_node
//
val () =
  if (knd = 0) then emit_text (out, "ATSPMVrefarg0(")
val () =
  if (knd > 0) then emit_text (out, "ATSPMVrefarg1(")
//
val () =
  if (knd = 0) then emit_primval (out, pmv)
val () =
  if (knd > 0) then emit_primval_ptrof2 (out, pmv)
//
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_refarg]

(* ****** ****** *)

implement
emit_primval_funlab
  (out, pmv0) = let
//
val-PMVfunlab
  (flab) = pmv0.primval_node
//
val isenv = funlab_is_envful (flab)
//
val () =
(
if isenv then
{
  val loc0 = pmv0.primval_loc
  val () = prerr_errccomp_loc (loc0)
  val () =
  (
    prerr ": the function is expected to be envless but it is not."
  ) // end of [val]
  val () = prerr_newline ()
} // end of [if]
)
//
val () =
(
if isenv then
  emit_text (out, "ATSERRORnotenvless(")
)
//
val () = emit_text (out, "ATSPMVfunlab(")
val () = emit_funlab (out, flab)
val () = emit_rparen (out)
//
val () = if isenv then emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_funlab]

(* ****** ****** *)

implement
emit_primval_cfunlab
  (out, pmv0) = let
//
val-PMVcfunlab
  (knd, flab) = pmv0.primval_node
val opt = funlab_get_funent (flab)
val d2es =
(
case+ opt of
| Some (fent) =>
    funent_eval_d2envlst (fent)
| None () => list_nil ()
) : d2envlst
//
val () = emit_text (out, "ATSPMVcfunlab(")
val () = emit_int (out, knd)
val () = emit_text (out, ", ")
val () = emit_funlab (out, flab)
val () = emit_text (out, ", (")
val nenv = emit_d2envlst (out, d2es)
val () = emit_text (out, "))")
//
in
  // nothing
end // end of [emit_primval_cfunlab]

(* ****** ****** *)

local

fun auxmain
(
  out: FILEref
, pmv: primval, hse: hisexp
) : void = let
  val () =
    emit_text (out, "ATSderef(")
  // end of [val]
  val () = emit_primval (out, pmv)
  val () = emit_text (out, ", ")
  val () = emit_hisexp (out, hse)
  val () = emit_rparen (out)
in
  // nothing
end // end of [auxmain]

in (* in of [local] *)

implement
emit_primval_deref
  (out, pmv, hse) = let
in
//
case+ pmv.primval_node of
| PMVptrof (pmv) => emit_primval (out, pmv)
| _ => auxmain (out, pmv, hse)
//
end // end of [emit_primval_deref]

end // end of [local]

(* ****** ****** *)

implement
emit_primval_err
  (out, pmv) = let
//
val () = emit_text (out, "PMVerr(\"")
val () = emit_location (out, pmv.primval_loc)
val () = emit_text (out, "\")")
//
in
  // nothing
end // end of [emit_primval_err]

(* ****** ****** *)

implement
emit_funtype_arg_res
(
  out, hses_arg, hse_res
) = let
  val () = emit_hisexp (out, hse_res)
  val () = emit_text (out, "(*)(")
  val () = emit_hisexplst_sep (out, hses_arg, ", ")
  val () = emit_rparen (out)
in
  // nothing
end // end of [emit_funtype_arg_res]

(* ****** ****** *)

implement
emit_primlab
  (out, extknd, pml) = let
in
//
case+
  pml.primlab_node
of // case
| PMLlab (lab) => {
    val () = emit_labelext (out, extknd, lab)
  } // end of [PMLlab]
| PMLind (pmvs) => {
    val () = emit_text (out, "[")
    val () = emit_primvalist (out, pmvs)
    val () = emit_text (out, "]")
  } // end of [PMLind]
//
end // end of [emit_primlab]

(* ****** ****** *)
//
extern fun emit_instr_move_con : emit_instr_type
extern fun emit_instr_move_rec : emit_instr_type
//
(*
extern fun emit_instr_load_ptrofs : emit_instr_type
*)
extern fun emit_instr_store_ptrofs : emit_instr_type
extern fun emit_instr_xstore_ptrofs : emit_instr_type
//
extern fun emit_instr_raise : emit_instr_type
//
(* ****** ****** *)

extern
fun emit_move_val
(
  out: FILEref, tmp: tmpvar, pmv: primval
) : void // end of [emit_move_val]
implement
emit_move_val
  (out, tmp, pmv) = let
//
val isvoid = primval_is_void (pmv)
//
val () = emit_text (out, "ATSINSmove")
val () =
(
  if isvoid then emit_text (out, "_void")
)
val () = emit_text (out, "(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv)
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_move_val]

extern
fun emit_pmove_val
(
  out: FILEref, tmp: tmpvar, pmv: primval
) : void // end of [emit_pmove_val]
implement
emit_pmove_val
  (out, tmp, pmv) = let
  val () = emit_text (out, "ATSINSpmove(")
  val () = emit_tmpvar (out, tmp)
  val () = emit_text (out, ", ")
  val () = emit_hisexp (out, pmv.primval_type)
  val () = emit_text (out, ", ")
  val () = emit_primval (out, pmv)
  val () = emit_text (out, ") ;")
in
  // nothing
end // end of [emit_pmove_val]

(* ****** ****** *)

extern
fun emit_move_ptralloc
  (out: FILEref, tmp: tmpvar, hit: hitype): void
implement
emit_move_ptralloc
  (out, tmp, hit) = let
  val () =
    emit_text (out, "ATSINSmove_ptralloc(")
  val () = emit_tmpvar (out, tmp)
  val () = emit_text (out, ", ")
  val () = emit_hitype (out, hit)
  val () = emit_text (out, ") ;")
in
  // nothing
end // end of [emit_move_ptralloc]

(* ****** ****** *)

implement
emit_instr
  (out, ins) = let
//
val loc0 = ins.instr_loc
// (*
val () =
(
  fprint (out, "/*\n");
  fprint (out, "emit_instr: loc0 = "); $LOC.fprint_location2 (out, loc0);
  fprint (out, "\n*/\n");
)
// *)
(*
val (
) = fprintln!
  (out, "/*\n", "emit_instr: ins = ", ins, "\n*/")
*)
//
// generating #line progma for debugging
//
val gline =
  $GLOB.the_DEBUGATS_dbgline_get ()
val () = (
  if gline > 0 then $LOC.fprint_line_pragma (out, loc0)
) : void // end of [val]
//
val gflag =
  $GLOB.the_DEBUGATS_dbgflag_get ()
val () = (
//
// HX: generating debug information
//
  if gflag > 0 then let
    val () = emit_text (out, "/* ")
    val () = fprint_instr (out, ins)
    val () = emit_text (out, " */\n")
  in
    // empty
  end // end of [if]
) : void // end of [val]
//
in
//
case+ ins.instr_node of
//
| INSfunlab (flab) =>
  {
    val (
    ) = emit_text (out, "__patsflab_")
    val () =
    (
      emit2_funlab (out, flab); emit_text (out, ":")
    )
  } // end of [INSfunlab]
| INStmplab (tlab) =>
  {
    val () =
    (
      emit_tmplab (out, tlab); emit_text (out, ":")
    )
  } // end of [INStmplab]
//
| INScomment (string) =>
  {
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, string)
    val () = emit_text (out, "\n*/")
  }
//
| INSmove_val
    (tmp, pmv) => emit_move_val (out, tmp, pmv)
  // end of [INSmove_val]
| INSpmove_val
    (tmp, pmv) => emit_pmove_val (out, tmp, pmv)
  // end of [INSpmove_val]
//
| INSfcall _ => emit_instr_fcall (out, ins)
| INSfcall2 _ => emit_instr_fcall2 (out, ins)
| INSextfcall _ => emit_instr_extfcall (out, ins)
//
| INScond
  (
    pmv_cond, inss_then, inss_else
  ) => {
    val () = emit_text (out, "ATSif(\n")
    val () = emit_primval (out, pmv_cond)
    val () = emit_text (out, "\n) ATSthen() {\n")
    val () = emit_instrlst (out, inss_then)
    val () = emit_text (out, "\n} ATSelse() {\n")
    val () = emit_instrlst (out, inss_else)
    val () =
      emit_text (out, "\n} /* ATSendif */")
    // end of [val]
  } // end of [INScond]
//
| INSfreecon (pmv) => let
    val () = emit_text (out, "ATSINSfreecon(")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ") ;")
  in
    // nothing
  end // end of [INSfreecon]
//
| INSloop
  (
    tlab_init, tlab_fini, tlab_cont
  , inss_init, pmv_test, inss_test, inss_post, inss_body
  ) => {
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, "** loop-init(beg)\n")
    val () = emit_text (out, "*/\n")
    val () =
    (
      emit_instrlst (out, inss_init); emit_newline (out)
    )
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, "** loop-init(end)\n")
    val () = emit_text (out, "*/\n")
    val () = (
      emit_text (out, "ATSLOOPopen(");
      emit_tmplab (out, tlab_init); emit_text (out, ", ");
      emit_tmplab (out, tlab_fini); emit_text (out, ", ");
      emit_tmplab (out, tlab_cont); emit_text (out, ")\n")
    ) // end of [val]
//
    val () =
    (
      emit_instrlst (out, inss_test); emit_newline (out)
    )
//
    val () = emit_text (out, "ATSif(")
    val () = emit_text (out, "ATSCKnot(")
    val () = emit_primval (out, pmv_test)
    val () = emit_text (out, ")) ATSbreak() ;")
    val () = emit_newline (out)
//
    val () =
    (
      emit_instrlst (out, inss_body); emit_newline (out)
    )
//
    val ispost = list_is_cons (inss_post)
//
    val () = if ispost then
    {
      val () = emit_text (out, "/*\n")
      val () = emit_text (out, "** continue after post-update\n")
      val () = emit_text (out, "*/\n")
      val () = emit_tmplab (out, tlab_cont)
      val () = emit_text (out, ":\n")
      val () = emit_instrlst (out, inss_post)
      val () = emit_newline (out)
    } // end of [if] // end of [val]
//
    val () = (
      emit_text (out, "ATSLOOPclose(");
      emit_tmplab (out, tlab_init); emit_text (out, ", ");
      emit_tmplab (out, tlab_fini); emit_text (out, ", ");
      emit_tmplab (out, tlab_cont); emit_text (out, ") ;")
    ) // end of [val]
//
    val () = emit_newline (out)
  } // end of [INSloop]
//
| INSloopexn
    (knd, tlab) => let
    val () = (
      if knd = 0
        then emit_text (out, "ATSbreak2(")
        else emit_text (out, "ATScontinue2(")
      // end of [if]
    ) : void // end of [val]
    val () = emit_tmplab (out, tlab)
    val () = emit_text (out, ") ;")
  in
    // nothing
  end // end of [INSloopexn]
//
| INScaseof (ibrs) => let
    val () = emit_text (out, "ATScaseofbeg()\n")
    val () = emit_ibranchlst (out, ibrs)
    val () = emit_text (out, "ATScaseofend()\n")
  in
    // nothing
  end // end of [INScaseof]
//
| INStrywith
  (
    tmp_exn, inss_try, ibrs_with
  ) => let
//
    val () =
    emit_text (out, "ATStrywith_try(")
    val () = emit_tmpvar (out, tmp_exn)
    val () = emit_text (out, ")\n")
//
    val () = emit_instrlst_ln (out, inss_try)
//
    val () =
    emit_text (out, "ATStrywith_with(")
    val () = emit_tmpvar (out, tmp_exn)
    val () = emit_text (out, ")\n")
//
    val () = emit_text (out, "ATScaseofbeg()\n")
    val () = emit_ibranchlst (out, ibrs_with)
    val () = emit_text (out, "ATScaseofend()\n")
//
    val () = emit_text (out, "ATStrywith_end()")
  in
    // empty
  end // end of [INStrywith]
//
| INSletpop () => let
    val () = emit_text (out, "/*\n")
    val () = fprint_instr (out, ins)
    val () = emit_text (out, "\n*/")
  in
    // nothing
  end // end of [INSletpop]
| INSletpush (pmds) => let
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, "letpush(beg)")
    val () = emit_text (out, "\n*/\n")
    val () = emit_primdeclst (out, pmds)
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, "letpush(end)")
    val () = emit_text (out, "\n*/\n")
  in
    // nothing
  end // end of [INSletpush]
//
| INSmove_con _ => emit_instr_move_con (out, ins)
//
| INSmove_fltrec _ => emit_instr_move_rec (out, ins)
| INSmove_boxrec _ => emit_instr_move_rec (out, ins)
//
| INSpatck (pmv, patck, fail) => emit_instr_patck (out, ins)
//
| INSstore_ptrofs _ => emit_instr_store_ptrofs (out, ins)
| INSxstore_ptrofs _ => emit_instr_xstore_ptrofs (out, ins)
//
| INSraise _ => emit_instr_raise (out, ins)
//
| INSmove_list_nil (tmp) => {
    val () = emit_text (out, "ATSINSmove_list_nil(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ") ;")
  }
| INSpmove_list_nil (tmp) => {
    val () = emit_text (out, "ATSINSpmove_list_nil(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ") ;")
  }
| INSpmove_list_cons
    (tmp, hse_elt) => {
    val () = emit_text (out, "ATSINSpmove_list_cons(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse_elt)
    val () = emit_text (out, ") ;")
  }
| INSmove_list_phead
    (tmphd, tmptl, hse_elt) => {
    val () = emit_text (out, "ATSINSmove_list_phead(")
    val () = emit_tmpvar (out, tmphd)
    val () = emit_text (out, ", ")
    val () = emit_tmpvar (out, tmptl)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse_elt)
    val () = emit_text (out, ") ;")
  }
| INSmove_list_ptail
    (tmptl1, tmptl2, hse_elt) => {
    val () = emit_text (out, "ATSINSmove_list_ptail(")
    val () = emit_tmpvar (out, tmptl1)
    val () = emit_text (out, ", ")
    val () = emit_tmpvar (out, tmptl2)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse_elt)
    val () = emit_text (out, ") ;")
  }
//
| INSmove_arrpsz_ptr
    (tmp, psz) => {
    val () = emit_text (out, "ATSINSmove_arrpsz_ptr(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_tmpvar (out, psz)
    val () = emit_text (out, ") ;")
  } // end of [INSmove_arrpsz_ptr]
//
| INSstore_arrpsz_asz
    (tmp, asz) => {
    val () = emit_text (out, "ATSINSstore_arrpsz_asz(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_int (out, asz)
    val () = emit_text (out, ") ;")
  } // end of [INSstore_arrpsz_asz]
| INSstore_arrpsz_ptr
    (tmp, hse, asz) => {
    val () = emit_text (out, "ATSINSstore_arrpsz_ptr(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse)
    val () = emit_text (out, ", ")
    val () = emit_int (out, asz)
    val () = emit_text (out, ") ;")
  } // end of [INSstore_arrpsz_ptr]
//
| INSupdate_ptrinc
    (tmp, hse) => {
    val () = emit_text (out, "ATSINSupdate_ptrinc(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse)
    val () = emit_text (out, ") ;")     
  } // end of [INSupdate_ptrinc]
| INSupdate_ptrdec
    (tmp, hse) => {
    val () = emit_text (out, "ATSINSupdate_ptrdec(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse)
    val () = emit_text (out, ") ;")
  } // end of [INSupdate_ptrdec]
//
| INStmpdec (tmp) => let
    val () = emit_text (out, "/*\n")
    val () = emit_text (out, "ATSINStmpdec(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_rparen (out)
    val () = emit_text (out, ") ;")
    val () = emit_text (out, "\n*/")
  in
    // nothing
  end // end of [INStmpdec]
//
| INSdcstdef (d2c, pmv) => let
    val () = emit_text (out, "ATSdyncst_valbind(")
    val () = emit_d2cst (out, d2c)
    val () = emit_text (out, ", ")
    val () = emit_primval (out, pmv)
    val () = emit_text (out, ") ;")
  in
    // nothing
  end // end of [INSdcstdef]
//
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_instr: ins = "; prerr_instr (ins); prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
end // end of [emit_instr]

(* ****** ****** *)

implement
emit_instrlst
  (out, inss) = let
//
fun loop (
  out: FILEref, inss: instrlst, sep: string, i: int
) : void = let
in
//
case+ inss of
| list_cons
    (ins, inss) => let
    val () =
      if i > 0 then
        emit_text (out, sep)
      // end of [if]
    val () = emit_instr (out, ins)
  in
    loop (out, inss, sep, i+1)
  end // end of [list_cons]
| list_nil () => let
    val () =
      if i = 0 then emit_text (out, "/* (*nothing*) */")
    // end of [val]
  in
    // nothing
  end // end of [list_nil]
//
end // end of [loop]
//
in
  loop (out, inss, "\n", 0)
end // end of [emit_instrlst]    

implement
emit_instrlst_ln
  (out, inss) = let
  val () =
    emit_instrlst (out, inss) in emit_text (out, "\n")
  // end of [val]
end // end of [emit_instrlst_ln]

(* ****** ****** *)

local

fun auxcon0
(
  out: FILEref, tmp: tmpvar, d2c: d2con
) : void = let
//
val islst = $S2E.d2con_is_listlike (d2c)
//
val tag =
(
  if islst then 0 else $S2E.d2con_get_tag (d2c)
) : int // end of [val]
//
val () = emit_text (out, "ATSINSmove_con0(")
val () =
(
  emit_tmpvar (out, tmp); emit_text (out, ", "); emit_int (out, tag)
)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [auxcon0]

(* ****** ****** *)

fun auxtag
(
  out: FILEref, tmp: tmpvar, d2c: d2con
) : void = let
//
val flag =
(
case+ 0 of
(*
| _ when $S2E.d2con_is_nullary (d2c) => 0
*)
| _ when $S2E.d2con_is_listlike (d2c) => 0
| _ when $S2E.d2con_is_singular (d2c) => 0
| _ => 1 // HX: tag assignment is needed
) : int // end of [val]
//
val tag = $S2E.d2con_get_tag (d2c)
val () = fprintf (out, "#if(%i)\n", @(flag))
val () = emit_text (out, "ATSINSstore_con_tag(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_int (out, tag)
val () = emit_text (out, ") ;\n")
val () = emit_text (out, "#endif\n")
//
in
  // nothing
end // end of [auxtag]

fun auxarg
(
  out: FILEref
, tmp: tmpvar, hit_con: hitype, lxs: labprimvalist
) : void = let
in
//
case+ lxs of
//
| list_cons
    (lx, lxs) => let
    val+LABPRIMVAL (l, x) = lx
    val istop = primval_is_top (x)
    val () =
      if istop then emit_text (out, "#if(0)\n")
    // end of [val]
    val () = emit_text (out, "ATSINSstore_con_ofs(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hitype (out, hit_con)
    val () = emit_text (out, ", ")
    val () = emit_labelext (out, 0, l)
    val () = emit_text (out, ", ")
    val () = emit_primval (out, x)
    val () = emit_text (out, ") ;\n")
    val () =
      if istop then emit_text (out, "#endif\n")
    // end of [val]
  in
    auxarg (out, tmp, hit_con, lxs)
  end // end of [list_cons]
//
| list_nil () => ()
//
end // end of [auxarg]

fun auxcon1
(
  out: FILEref
, tmp: tmpvar, d2c: d2con
, hit_con: hitype, arg: labprimvalist
) : void = let
//
val (
) = emit_text (out, "ATSINSmove_con1(")
val (
) = (
  emit_tmpvar (out, tmp);
  emit_text (out, ", "); emit_hitype (out, hit_con)
)
val () = emit_text (out, ") ;\n")
//
val () = auxtag (out, tmp, d2c)
val () = auxarg (out, tmp, hit_con, arg)
//
in
  // nothing
end // end of [auxcon1]

(* ****** ****** *)

fun auxexn0
(
  out: FILEref, tmp: tmpvar, d2c: d2con
) : void = let
//
val () = emit_text (out, "ATSINSmove_exn0(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_d2con (out, d2c)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [auxexn0]

fun auxexn1
(
  out: FILEref
, tmp: tmpvar, d2c: d2con
, hit_con: hitype, arg: labprimvalist
) : void = let
//
val (
) = emit_text (out, "ATSINSmove_exn1(")
val (
) = (
  emit_tmpvar (out, tmp);
  emit_text (out, ", "); emit_hitype (out, hit_con)
)
val () = emit_text (out, ") ;\n")
//
val (
) = emit_text (out, "ATSINSstore_exntag(")
val (
) = (
  emit_tmpvar (out, tmp); emit_text (out, ", "); emit_d2con (out, d2c)
) (* end of [val] *)
val () = emit_text (out, ") ;\n")
//
val (
) = emit_text (out, "ATSINSstore_exnmsg(")
val (
) = (
  emit_tmpvar (out, tmp); emit_text (out, ", "); emit_d2con (out, d2c)
) (* end of [val] *)
val () = emit_text (out, ") ;\n")
//
val () = auxarg (out, tmp, hit_con, arg)
//
in
  // nothing
end // end of [auxexn1]

in (* in of [local] *)

implement
emit_instr_move_con (out, ins) = let
//
val- INSmove_con
  (tmp, d2c, hse_sum, arg) = ins.instr_node
//
val () = emit_newline (out)
//
val iscon = $S2E.d2con_is_con (d2c)
val isexn = $S2E.d2con_is_exn (d2c)
val isnul = $S2E.d2con_is_nullary (d2c)
//
in
//
if isnul then let
  val () = if iscon then auxcon0 (out, tmp, d2c)
  val () = if isexn then auxexn0 (out, tmp, d2c) 
in
  // nothing
end else let
  val hit_con = hisexp_typize (0, hse_sum)
  val () = (
    if iscon then auxcon1 (out, tmp, d2c, hit_con, arg)
  ) : void // end of [val]
  val () = (
    if isexn then auxexn1 (out, tmp, d2c, hit_con, arg)
  ) : void // end of [val]
in
  // nothing
end // end of [if]
//
end // end of [emit_instr_move_con]

end // end of [local]

(* ****** ****** *)

implement
emit_instr_move_rec (out, ins) = let
//
fun loop
(
  boxknd: int
, extknd: int
, tmp: tmpvar
, hit_rec: hitype
, lxs: labprimvalist
, i: int
) :<cloref1> void = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val LABPRIMVAL (l, x) = lx
    val () =
      if i > 0 then emit_text (out, "\n")
    val () =
      if boxknd = 0 then emit_text (out, "ATSINSstore_fltrec_ofs (")
    val () =
      if boxknd > 0 then emit_text (out, "ATSINSstore_boxrec_ofs (")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hitype (out, hit_rec)
    val () = emit_text (out, ", ")
    val () = emit_labelext (out, extknd, l)
    val () = emit_text (out, ", ")
    val () = emit_primval (out, x)
    val () = emit_text (out, ") ;")
  in
    loop (boxknd, extknd, tmp, hit_rec, lxs, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
//
case- ins.instr_node of
| INSmove_fltrec
  (
    tmp, lpmvs, hse_rec
  ) => let
    val hit_rec = hisexp_typize (1, hse_rec)
    val extknd = hisexp_get_extknd (hse_rec)
  in
    loop (0(*boxknd*), extknd, tmp, hit_rec, lpmvs, 0)
  end // end of [INSmove_fltrec]
| INSmove_boxrec
  (
    tmp, lpmvs, hse_rec
  ) => let
    val hit_rec = hisexp_typize (0, hse_rec)
//
    val () = emit_text (out, "ATSINSmove_boxrec(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hitype (out, hit_rec)
    val () = emit_text (out, ") ;\n")
//
    val extknd = hisexp_get_extknd (hse_rec)
  in
    loop (1(*boxknd*), extknd, tmp, hit_rec, lpmvs, 0)
  end // end of [INSmove_boxrec]
//
end // end of [emit_instr_move_rec]

(* ****** ****** *)

local

fun auxsel
(
  out: FILEref
, pmv: primval
, hse_sum: hisexp
, lab: label
) : void = let
//
val () = emit_text (out, "ATSSELcon(")
val () = emit_primval (out, pmv)
val () = emit_text (out, ", ")
val () = emit_hisexp_sel (out, hse_sum)
val () = emit_text (out, ", ")
val () = emit_labelext (out, 0(*ext*), lab)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [auxsel]

in (* in of [local] *)

implement
emit_primval_selcon
  (out, pmv0) = let
//
val-PMVselcon
  (pmv, hse_sum, lab) = pmv0.primval_node
//
in
  auxsel (out, pmv, hse_sum, lab)
end // end of [emit_instr_selcon]

end // end of [local]

(* ****** ****** *)

local

fun auxfnd
(
  l0: label, lxs: labhisexplst
) : hisexp = let
  val-list_cons (lx, lxs) = lxs
  val HSLABELED (l, opt, x) = lx
in
  if l0 = l then x else auxfnd (l0, lxs)
end // end of [auxfnd]

fun auxsel
(
  hse0: hisexp, pml: primlab
) : hisexp = let
in
//
case+
  pml.primlab_node of
//
| PMLlab (lab) => (
  case+
    hse0.hisexp_node of
  | HSEtyrec
      (knd, lhses) => auxfnd (lab, lhses)
    // end of [HSEtyrec]
  | HSEtyrecsin
      (lhse) => labhisexp_get_elt (lhse)
    // end of [HSEtyrecsin]
  | HSEtysum
      (d2c, lhses) => auxfnd (lab, lhses)
    // end of [HSEtysum]
  | _ => let
      val () = prerr_interror ()
      val () = prerr (": auxsel: hse0 = ")
      val () = prerr_hisexp (hse0)
      val () = prerr_newline ()
      val () = assertloc (false)
    in
      $ERR.abort ()
    end // end of [_]
  ) (* end of [PMLlab] *)
//
| PMLind (ind) => let
    val-HSEtyarr
      (hse_elt, s2es) = hse0.hisexp_node in hse_elt
    // end of [val]
  end // end of [PMLind]
//
end // end of [auxsel]

fun auxselist
(
  hse0: hisexp, pmls: primlablst
) : List_vt @(hisexp, primlab) = let
//
vtypedef
res = List_vt @(hisexp, primlab)
fun loop
(
  hse0: hisexp, pmls: primlablst, res: res
) : res =
(
  case+ pmls of
  | list_cons (pml, pmls) => let
      val hse1 = auxsel (hse0, pml)
      val res = list_vt_cons ( @(hse0, pml), res )
    in
      loop (hse1, pmls, res)
    end // end of [list_cons]
  | list_nil () => res
) (* end of [loop] *)
//
in
  loop (hse0, pmls, list_vt_nil ())
end // end of [auxselist]

fun auxmain
(
  out: FILEref
, knd: int
, pmv: primval
, hse_rt: hisexp
, xys: List_vt @(hisexp, primlab)
, i: int
) : void = let
(*
val () = fprintln! (stdout_ref, "auxmain: hse_rt = ", hse_rt)
*)
in
//
case+ xys of
| ~list_vt_cons
    (xy, xys) => let
//
    val hse = xy.0
    val pml = xy.1
//
    var hse: hisexp = hse
    var pmv: primval = pmv
    val () = (
      case+
        hse.hisexp_node of
      | HSEtyarr
          (hse_elt, _) => {
          val () = hse := hse_elt
          val () =
            pmv := primval_ptrof (pmv.primval_loc, hisexp_typtr, pmv)
          // end of [val]
        } // end of [HSEtyarr]
      | _ => () // end of [_]
    ) : void // end of [val]
//
    var issin: bool = false
    val boxknd = hisexp_get_boxknd (hse)
    val () = (
      if boxknd <= 0 then let
        val () =
          issin := hisexp_is_tyrecsin (hse)
        // end of [val]
      in
        if issin
          then emit_text (out, "ATSSELrecsin(")
          else (
            if boxknd >= 0 // HX: it is a rec
              then emit_text (out, "ATSSELfltrec(")
              else emit_text (out, "ATSSELarrptrind(")
            // end of [if]
          ) // end of [if]
        // end of [if]
      end else
        emit_text (out, "ATSSELboxrec(")
      // end of [if]
    ) : void // end of [val]
//
    val () = auxmain (out, knd, pmv, hse_rt, xys, i + 1)
//
    val () = emit_text (out, ", ")
    val () = emit_hisexp_sel (out, hse)
    val () = emit_text (out, ", ")
    val extknd = hisexp_get_extknd (hse)
    val () = emit_primlab (out, extknd, pml)
    val () = emit_rparen (out)
  in
    // nothing
  end // end of [list_vt_cons]
| ~list_vt_nil () => let
  in
    case+ knd of
    | 0 => emit_primval (out, pmv)
    | _ => emit_primval_deref (out, pmv, hse_rt)
  end // end of [list_vt_nil]
//
end // end of [auxmain]

(* ****** ****** *)

in (* in of [local] *)

(* ****** ****** *)

implement
emit_primval_select
  (out, pmv0) = let
//
val-PMVselect
  (pmv, hse_rt, pml) = pmv0.primval_node
//
val xys = list_vt_sing @(hse_rt, pml)
//
in
  auxmain (out, 0(*non*), pmv, hse_rt, xys, 0)
end // end of [emit_primval_select]

(* ****** ****** *)

implement
emit_primval_select2
  (out, pmv0) = let
//
val-PMVselect2
  (pmv, hse_rt, pmls) = pmv0.primval_node
//
val () = let
  val xys = auxselist (hse_rt, pmls)
in
  auxmain (out, 0(*non*), pmv, hse_rt, xys, 0)
end // end of [val]
//
in
  // nothing
end // end of [emit_primval_select2]

(* ****** ****** *)

implement
emit_primval_selptr
  (out, pmv0) = let
//
val-PMVselptr
  (pmv, hse_rt, pmls) = pmv0.primval_node
//
val () = let
  val xys = auxselist (hse_rt, pmls)
in
  auxmain (out, 1(*ptr*), pmv, hse_rt, xys, 0)
end // end of [val]
//
in
  // nothing
end // end of [emit_primval_selptr]

(* ****** ****** *)

implement
emit_primval_ptrofsel
  (out, pmv0) = let
//
val-PMVptrofsel
  (pmv, hse_rt, pmls) = pmv0.primval_node
//
val () = emit_text (out, "ATSPMVptrof(")
//
val () = let
  val xys = auxselist (hse_rt, pmls)
in
  auxmain (out, 1(*ptr*), pmv, hse_rt, xys, 0)
end // end of [val]
//
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_ptrofsel]

(* ****** ****** *)

implement
emit_instr_store_ptrofs
  (out, ins) = let
//
val-INSstore_ptrofs
  (pmv_l, hse_rt, pmls, pmv_r) = ins.instr_node
//
val () = emit_text (out, "ATSINSstore(")
//
val () = let
  val xys = auxselist (hse_rt, pmls)
in
  auxmain (out, 1(*ptr*), pmv_l, hse_rt, xys, 0)
end // end of [val]
//
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv_r)
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_instr_store_ptrofs]

(* ****** ****** *)

implement
emit_instr_xstore_ptrofs
  (out, ins) = let
//
val-INSxstore_ptrofs
  (tmp, pmv_l, hse_rt, pmls, pmv_r) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSxstore(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxmain (out, 1(*non*), pmv_l, hse_rt, xys, 0)
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv_r)
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_instr_xstore_ptrofs]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

implement
emit_instr_raise
  (out, ins) = let
//
val-INSraise
  (tmp, pmv_exn) = ins.instr_node
//
val (
) = emit_text (out, "ATSINSraise_exn(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv_exn)
val () = emit_text (out, ") ;")
//
in
  // nothing
end // end of [emit_instr_raise]

(* ****** ****** *)

(* end of [pats_ccomp_emit.dats] *)
