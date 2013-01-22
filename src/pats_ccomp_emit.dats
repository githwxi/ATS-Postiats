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
// Start Time: November, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"

(* ****** ****** *)

staload "./pats_errmsg.sats"
staload _(*anon*) = "./pats_errmsg.dats"
implement prerr_FILENAME<> () = prerr "pats_ccomp_emit"

(* ****** ****** *)

staload LAB = "./pats_label.sats"
overload = with $LAB.eq_label_label

(* ****** ****** *)

staload
STMP = "./pats_stamp.sats"

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
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
typedef d2con = $S2E.d2con
staload
D2E = "./pats_dynexp2.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"

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
emit_int (out, x) = fprint_int (out, x)
implement
emit_ATSPMVint (out, x) = (
  emit_text (out, "ATSPMVint("); emit_int (out, x); emit_rparen (out)
) // end of [emit_ATSPMVint]

(* ****** ****** *)

implement
emit_bool (out, x) = fprint_bool (out, x)
implement
emit_ATSPMVbool
  (out, x) = (
  emit_text (out, "ATSPMVbool_"); emit_bool (out, x); emit_text (out, "()")
) // end of [emit_ATSPMVbool]

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
      else fprintf (out, "\\%.3o", @($UN.cast2uint(c)))
    // end of [if]
  ) // end of [_]
//
end // end of [auxch]

in (* in of [local] *)

implement
emit_char (out, c) = auxch (out, c)

implement
emit_string
  (out, str) = let
//
fun auxch2 (
  out: FILEref, c: char
) : void = let
in
//
if (c = '"') then
  emit_text (out, "\\\"") else auxch (out, c)
// end of [if]
end // end of [auxch2]
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
  val sym =
    $FIL.filename_get_full (fil)
  // end of [val]
  val name = $SYM.symbol_get_name (sym)
in
  emit_ident (out, name)
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
    val () = $FIL.fprint_filename (out, fil)
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

implement
emit_d2con
  (out, d2c) = let
  val fil = $S2E.d2con_get_fil (d2c)
  val sym = $S2E.d2con_get_sym (d2c)
  val name = $SYM.symbol_get_name (sym)
  val () = emit_filename (out, fil)
  val () = emit_text (out, "__")
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
    val name = $D2E.d2cst_get_name (d2c)
    val () = emit_filename (out, fil)
    val () = emit_text (out, "__")
    val () = emit_ident (out, name)
  in
    // nothing
  end // end of [DCSTEXTDEFnone]
//
| $SYN.DCSTEXTDEFsome_ext (name) => let
    var name: string = name
    val isemp = string_is_empty (name)
    val () = if isemp then name := $D2E.d2cst_get_name (d2c)
  in
    emit_ident (out, name)
  end // end of [DCSTEXTDEFsome_ext]
//
| $SYN.DCSTEXTDEFsome_mac (name) => let
    var name: string = name
    val isemp = string_is_empty (name)
    val () = if isemp then name := $D2E.d2cst_get_name (d2c)
  in
    emit_ident (out, name)
  end // end of [ // end of [DCSTEXTDEFsome_mac]
//
| $SYN.DCSTEXTDEFsome_sta (name) => let
    var name: string = name
    val isemp = string_is_empty (name)
    val () = if isemp then name := $D2E.d2cst_get_name (d2c)
  in
    emit_ident (out, name)
  end // end of [DCSTEXTDEFsome_sta]
//
end // end of [emit_d2cst]

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

fun auxtmp (
  out: FILEref, tmp: tmpvar
) : void = let
//
val knd =
  tmpvar_get_topknd (tmp)
//
val () = (case+ 0 of
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

fun auxmain (
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
val () = (
  if ~isvoid
    then emit_text (out, "ATStmpdec(")
    else emit_text (out, "ATStmpdec_void(")
  // end of [if]
) : void // end of [val]
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

extern fun emit_primval_tmp : emit_primval_type
extern fun emit_primval_tmpref : emit_primval_type
extern fun emit_primval_arg : emit_primval_type
extern fun emit_primval_argref : emit_primval_type
extern fun emit_primval_d2cst : emit_primval_type
extern fun emit_primval_ptrof : emit_primval_type
extern fun emit_primval_refarg : emit_primval_type

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
(*
| PMVcst _ => emit_primval_d2cst (out, pmv0)
*)
//
| PMVint (i) => emit_ATSPMVint (out, i)
| PMVbool (b) => emit_ATSPMVbool (out, b)
| PMVchar (c) => emit_ATSPMVchar (out, c)
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
| PMVextval
    (name) => fprintf (out, "ATSextval(%s)", @(name))
  // end of [PMVextval]
//
| PMVsizeof (hselt) => emit_sizeof (out, hselt)
//
| PMVptrof _ => emit_primval_ptrof (out, pmv0)
| PMVrefarg _ => emit_primval_refarg (out, pmv0)
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
emit_primval_arg
  (out, pmv0) = let
//
val-PMVarg (narg) = pmv0.primval_node
//
in
  fprintf (out, "arg%i", @(narg))
end // end of [emit_primval_arg]

(* ****** ****** *)

implement
emit_primval_argref
  (out, pmv0) = let
//
val-PMVargref (narg) = pmv0.primval_node
//
val () = emit_text (out, "ATSderef(")
val () = fprintf (out, "arg%i", @(narg))
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_argref]

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
emit_primval_ptrof
  (out, pmv0) = let
//
val-PMVptrof
  (pmv) = pmv0.primval_node
//
val () =
  emit_text (
  out, "ATSPMVptrof("
) // end of [val]
val () = emit_primval (out, pmv)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_ptrof]

(* ****** ****** *)

implement
emit_primval_refarg
  (out, pmv0) = let
//
val-PMVrefarg
  (knd, pmv) = pmv0.primval_node
//
val () = (
  if knd = 0
    then emit_text (out, "ATSPMVrefarg0(")
    else emit_text (out, "ATSPMVrefarg1(")
  // end of [if]
) : void // end of [val]
//
val () = emit_primval (out, pmv)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [emit_primval_refarg]

(* ****** ****** *)

local

fun auxmain (
  out: FILEref
, pmv: primval, hse: hisexp
) : void = let
  val () = emit_text (out, "ATSderef2(")
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
emit_funtype_arg_res (
  out, hses_arg, hse_res
) = let
  val () = emit_hisexp (out, hse_res)
  val () = emit_text (out, "(*)(")
  val () = emit_hisexplst_sep (out, hses_arg, ", ")
  val () = emit_text (out, ")")
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

typedef
emit_instr_type = (FILEref, instr) -> void

extern fun emit_instr_funcall : emit_instr_type
extern fun emit_instr_move_con : emit_instr_type
extern fun emit_instr_move_rec : emit_instr_type
extern fun emit_instr_move_selcon : emit_instr_type
extern fun emit_instr_move_select : emit_instr_type
extern fun emit_instr_move_select2 : emit_instr_type
extern fun emit_instr_move_ptrofsel : emit_instr_type
extern fun emit_instr_load_varofs : emit_instr_type
extern fun emit_instr_load_ptrofs : emit_instr_type
extern fun emit_instr_store_varofs : emit_instr_type
extern fun emit_instr_store_ptrofs : emit_instr_type

(* ****** ****** *)

extern
fun emit_move_val (
  out: FILEref, tmp: tmpvar, pmv: primval
) : void // end of [emit_move_val]
implement
emit_move_val
  (out, tmp, pmv) = let
  val isvoid = primval_is_void (pmv)
  val () = (
    if ~isvoid
      then emit_text (out, "ATSINSmove(")
      else emit_text (out, "ATSINSmove_void(")
    // end of [if]
  ) : void // end of [val]
  val () = emit_tmpvar (out, tmp)
  val () = emit_text (out, ", ")
  val () = emit_primval (out, pmv)
  val () = emit_text (out, ") ;")
in
  // nothing
end // end of [emit_move_val]

extern
fun emit_pmove_val (
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
| INSfunlab (flab) => {
    val () =
      emit_text (out, "__patsflab_")
    val () = emit2_funlab (out, flab)
    val () = emit_text (out, ":")
  } // end of [INSfunlab]
//
| INSmove_val
    (tmp, pmv) => emit_move_val (out, tmp, pmv)
  // end of [INSmove_val]
| INSpmove_val
    (tmp, pmv) => emit_pmove_val (out, tmp, pmv)
  // end of [INSpmove_val]
//
| INSfuncall _ => emit_instr_funcall (out, ins)
//
| INScond (
    pmv_cond, inss_then, inss_else
  ) => {
    val () = emit_text (out, "ATSif(")
    val () = emit_primval (out, pmv_cond)
    val () = emit_text (out, ") ATSthen() {\n")
    val () = emit_instrlst (out, inss_then)
    val () = emit_text (out, "\n} ATSelse() {\n")
    val () = emit_instrlst (out, inss_else)
    val () =
      emit_text (out, "\n} /* end of [if] */")
    // end of [val]
  } // end of [INScond]
//
| INSswitch (xs) => {
    val () = emit_text (out, "ATSdo() {\n")
    val () =
      emit_text (out, "\n} ATSwhile(0) ; /* end of [do] */")
    // end of [val]
  } // end of [INSswitch]
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
| INSmove_selcon _ => emit_instr_move_selcon (out, ins)
| INSmove_select _ => emit_instr_move_select (out, ins)
| INSmove_select2 _ => emit_instr_move_select2 (out, ins)
//
| INSmove_ptrofsel _ => emit_instr_move_ptrofsel (out, ins)
//
| INSload_varofs _ => emit_instr_load_varofs (out, ins)
| INSload_ptrofs _ => emit_instr_load_ptrofs (out, ins)
//
| INSstore_varofs _ => emit_instr_store_varofs (out, ins)
| INSstore_ptrofs _ => emit_instr_store_ptrofs (out, ins)
//
| INSmove_list_nil (tmp) => {
    val () = emit_text (out, "ATSINSmove_list_nil(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ")")
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

fun auxcon (
  out: FILEref
, tmp: tmpvar
, hit_con: hitype
) : void = let
//
val () = emit_text (out, "ATSINSmove_con(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_hitype (out, hit_con)
val () = emit_text (out, ") ;\n")
//
in
  // nothing
end // end of [auxcon]

fun auxtag (
  out: FILEref
, tmp: tmpvar, d2c: d2con
) : void = let
//
val flag = (
  case+ 0 of
  | _ when $S2E.d2con_is_nullary (d2c) => 0
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
val () = emit_text (out, ") ;")
val () = emit_text (out, "\n#endif")
//
in
  // nothing
end // end of [auxtag]

fun auxarg (
  out: FILEref
, tmp: tmpvar
, hit_con: hitype
, lxs: labprimvalist
) : void = let
in
//
case+ lxs of
| list_cons
    (lx, lxs) => let
    val+LABPRIMVAL (l, x) = lx
    val () = emit_text (out, "ATSINSstore_con_ofs(")
    val () = emit_tmpvar (out, tmp)
    val () = emit_text (out, ", ")
    val () = emit_hitype (out, hit_con)
    val () = emit_text (out, ", ")
    val () = emit_labelext (out, 0, l)
    val () = emit_text (out, ", ")
    val () = emit_primval (out, x)
    val () = emit_text (out, ") ;\n")
  in
    auxarg (out, tmp, hit_con, lxs)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [auxarg]

in (* in of [local] *)

implement
emit_instr_move_con (out, ins) = let
//
val- INSmove_con
  (tmp, d2c, hse_sum, arg) = ins.instr_node
//
val hit_con = hisexp_typize (hse_sum)
//
val () = emit_newline (out)
val () = auxcon (out, tmp, hit_con)
val () = auxtag (out, tmp, d2c)
val () = {
  val iscons = list_is_cons (arg)
  val () = if iscons then emit_newline (out)
} (* end of [val] *)
val () = auxarg (out, tmp, hit_con, arg)
//
in
end // end of [emit_instr_move_con]

end // end of [local]

(* ****** ****** *)

implement
emit_instr_move_rec (out, ins) = let
//
fun loop (
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
| INSmove_fltrec (
    tmp, lpmvs, hse_rec
  ) => let
    val hit_rec = hisexp_typize (hse_rec)
    val extknd = hisexp_get_extknd (hse_rec)
  in
    loop (0(*boxknd*), extknd, tmp, hit_rec, lpmvs, 0)
  end // end of [INSmove_fltrec]
| INSmove_boxrec (
    tmp, lpmvs, hse_rec
  ) => let
    val hit_rec = hisexp_typize (hse_rec)
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

implement
emit_instr_funcall
  (out, ins) = let
//
val loc0 = ins.instr_loc
val-INSfuncall
  (tmp, pmv_fun, hse_fun, pmvs_arg) = ins.instr_node
(*
val () = (
  println! ("emit_instr_funcall: pmv_fun = ", pmv_fun)
) // end of [val]
*)
val isvoid = tmpvar_is_void (tmp)
val () = (
  if ~isvoid
    then emit_text (out, "ATSINSmove(")
    else emit_text (out, "ATSINSmove_void(")
  // end of [if]
) : void // end of [val]
//
val () = (
  emit_tmpvar (out, tmp); emit_text (out, ", ")
) (* end of [val] *)
//
in
//
case+ pmv_fun.primval_node of
//
| PMVfunlab (flab) => let
    val () = emit_funlab (out, flab)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [PMVfun]
//
| PMVcst (d2c) => let
    val () = emit_d2cst (out, d2c)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [PMVcst]
//
| PMVtmpltcst _ => let
    val () = emit_primval (out, pmv_fun)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [PMVtmpltcst]
| PMVtmpltcstmat _ => let
    val () = emit_primval (out, pmv_fun)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [PMVtmpltcstmat]
//
| PMVtmpltvar _ => let
    val () = emit_primval (out, pmv_fun)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [PMVtmpltvar]
//
| _(*function variable*) => let
    val () = emit_primval (out, pmv_fun)
    val () = emit_text (out, "(")
    val () = emit_primvalist (out, pmvs_arg)
    val () = emit_text (out, ")) ;")
  in
    // nothing
  end // end of [_]
//
(*
| _ => let
    val () = prerr_interror_loc (loc0)
    val () = (
      prerr ": emit_instr_funcall: hse_fun = "; prerr_hisexp (hse_fun); prerr_newline ()
    ) // end of [val]
    val () = assertloc (false)
  in
    // nothing
  end // end of [_]
*)
//
end // end of [emit_instr_funcall]

(* ****** ****** *)

local

fun auxsel (
  out: FILEref
, pmv: primval
, hse_sum: hisexp
, lab: label
) : void = let
//
val () = emit_text (out, "ATSselcon(")
val () = emit_primval (out, pmv)
val () = emit_text (out, ", ")
val () = emit_hisexp (out, hse_sum)
val () = emit_text (out, ", ")
val () = emit_labelext (out, 0(*ext*), lab)
val () = emit_rparen (out)
//
in
  // nothing
end // end of [auxsel]

in (* in of [local] *)

implement
emit_instr_move_selcon
  (out, ins) = let
//
val-INSmove_selcon
  (tmp, pmv, hse_sum, lab) = ins.instr_node
//
val () = emit_text (out, "ATSINSmove(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxsel (out, pmv, hse_sum, lab)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_selcon]

end // end of [local]

(* ****** ****** *)

local

fun auxfnd (
  l0: label, lxs: labhisexplst
) : hisexp = let
  val-list_cons (lx, lxs) = lxs
  val HSLABELED (l, opt, x) = lx
in
  if l0 = l then x else auxfnd (l0, lxs)
end // end of [auxfnd]

fun auxsel (
  hse0: hisexp, pml: primlab
) : hisexp = let
in
//
case+
  pml.primlab_node of
//
| PMLlab (lab) => (
  case+ hse0.hisexp_node of
  | HSEtyrec
      (knd, lhses) => auxfnd (lab, lhses)
    // end of [HSEtyrec]
  | HSEtyrecsin
      (lhse) => labhisexp_get_elt (lhse)
    // end of [HSEtyrecsin]
  | _ => let
      val () = prerr_interror ()
      val () = prerr (": auxsel: hse0 = ")
      val () = prerr_hisexp (hse0)
      val () = prerr_newline ()
      val () = assertloc (false)
    in
      $ERR.abort ()
    end // end of [_]
  ) // end of [PMLlab]
| PMLind (ind) => let
    val-HSEtyarr (hse_elt, s2es) = hse0.hisexp_node
  in
    hse_elt
  end // end of [PMLind]
//
end // end of [auxsel]

fun auxselist (
  hse0: hisexp, pmls: primlablst
) : List_vt @(hisexp, primlab) = let
//
vtypedef
res = List_vt @(hisexp, primlab)
fun loop (
  hse0: hisexp, pmls: primlablst, res: res
) : res = (
  case+ pmls of
  | list_cons (pml, pmls) => let
      val hse1 = auxsel (hse0, pml)
      val res = list_vt_cons ( @(hse0, pml), res )
    in
      loop (hse1, pmls, res)
    end // end of [list_cons]
  | list_nil () => res
) // end of [loop]
//
in
  loop (hse0, pmls, list_vt_nil ())
end // end of [auxselist]

fun auxmain (
  out: FILEref
, knd: int
, pmv: primval
, hse_rt: hisexp
, xys: List_vt @(hisexp, primlab)
, i: int
) : void = let
in
//
case+ xys of
| ~list_vt_cons
    (xy, xys) => let
    val hse = xy.0
    val pml = xy.1
    var issin: bool = false
    val boxknd = hisexp_get_boxknd (hse)
    val () = (
      if boxknd <= 0 then let
        val () =
          issin := hisexp_is_tyrecsin (hse)
        // end of [val]
      in
        if issin
          then emit_text (out, "ATSselrecsin(")
          else (
            if boxknd >= 0 // HX: it is a rec
              then emit_text (out, "ATSselfltrec(")
              else emit_text (out, "ATSselarrind(")
            // end of [if]
          ) // end of [if]
        // end of [if]
      end else
        emit_text (out, "ATSselboxrec(")
      // end of [if]
    ) : void // end of [val]
    val () = auxmain (out, knd, pmv, hse_rt, xys, i + 1)
    val () = emit_text (out, ", ")
    val () = emit_hisexp (out, hse)
    val () = emit_text (out, ", ")
    val extknd = hisexp_get_extknd (hse)
    val () = emit_primlab (out, extknd, pml)
    val () = emit_rparen (out)
  in
    // nothing
  end // end of [list_vt_cons]
| ~list_vt_nil () => (
    case+ knd of
    | 0 => emit_primval (out, pmv)
    | _ => emit_primval_deref (out, pmv, hse_rt)
  ) // end of [list_vt_nil]
//
end // end of [auxmain]
//
in // in of [local]

implement
emit_instr_move_select
  (out, ins) = let
//
val-INSmove_select
  (tmp, pmv, hse_rt, pml) = ins.instr_node
//
val xys = list_vt_sing @(hse_rt, pml)
val () = emit_text (out, "ATSINSmove(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxmain (out, 0(*non*), pmv, hse_rt, xys, 0)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_move_select]

(* ****** ****** *)

implement
emit_instr_move_select2
  (out, ins) = let
//
val-INSmove_select2
  (tmp, pmv, hse_rt, pmls) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSmove(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxmain (out, 0(*non*), pmv, hse_rt, xys, 0)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_move_select2]

(* ****** ****** *)

implement
emit_instr_move_ptrofsel
  (out, ins) = let
//
val-INSmove_ptrofsel
  (tmp, pmv, hse_rt, pmls) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSmove(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = emit_text (out, "ATSPMVptrof(")
val () = auxmain (out, 1(*ptr*), pmv, hse_rt, xys, 0)
val () = emit_text (out, ")) ; ")
//
in
  // nothing
end // end of [emit_instr_move_ptrofsel]

(* ****** ****** *)

implement
emit_instr_load_varofs
  (out, ins) = let
//
val-INSload_varofs
  (tmp, pmv, hse_rt, pmls) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSload(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxmain (out, 0(*non*), pmv, hse_rt, xys, 0)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_load_ptrofs]

(* ****** ****** *)

implement
emit_instr_load_ptrofs
  (out, ins) = let
//
val-INSload_ptrofs
  (tmp, pmv, hse_rt, pmls) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSload(")
val () = emit_tmpvar (out, tmp)
val () = emit_text (out, ", ")
val () = auxmain (out, 1(*ptr*), pmv, hse_rt, xys, 0)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_load_ptrofs]

(* ****** ****** *)

implement
emit_instr_store_varofs
  (out, ins) = let
//
val-INSstore_varofs
  (pmv_l, hse_rt, pmls, pmv_r) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSstore(")
val () = auxmain (out, 0(*non*), pmv_l, hse_rt, xys, 0)
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv_r)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_store_varofs]

(* ****** ****** *)

implement
emit_instr_store_ptrofs
  (out, ins) = let
//
val-INSstore_ptrofs
  (pmv_l, hse_rt, pmls, pmv_r) = ins.instr_node
//
val xys = auxselist (hse_rt, pmls)
val () = emit_text (out, "ATSINSstore(")
val () = auxmain (out, 1(*non*), pmv_l, hse_rt, xys, 0)
val () = emit_text (out, ", ")
val () = emit_primval (out, pmv_r)
val () = emit_text (out, ") ; ")
//
in
  // nothing
end // end of [emit_instr_store_ptrofs]

end // end of [local]

(* ****** ****** *)

implement
emit_funarglst
  (out, hits) = let
//
fun loop (
  out: FILEref
, hits: hisexplst, sep: string, i: int
) : void = let
in
//
case+ hits of
| list_cons
    (hit, hits) => let
    val () =
      if i > 0 then emit_text (out, sep)
    val () = emit_hisexp (out, hit)
    val () = fprintf (out, " arg%i", @(i))
  in
    loop (out, hits, sep, i+1)
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [loop]
//
in
  loop (out, hits, ", ", 0)
end // end of [emit_funarglst]

(* ****** ****** *)

local

fun auxfun (
  out: FILEref, fent: funent
) : void = let
//
val flab = funent_get_lab (fent)
val tmpknd = funlab_get_tmpknd (flab)
val qopt = funlab_get_d2copt (flab)
val isqua = (
  case+ qopt of Some _ => true | None _ => false
) : bool // end of [val]
val flopt = funlab_get_origin (flab)
val isext = (
  case+ flopt of Some _ => false | None () => isqua
) : bool // end of [val]
val issta = not (isext)
//
val () =
  if tmpknd > 0 then emit_text (out, "#if(0)\n")
// end of [val]
//
val () = if isext then emit_text (out, "ATSglobaldec()\n")
val () = if issta then emit_text (out, "ATSstaticdec()\n")
//
val () =
  emit_hisexp (out, hse_res) where {
  val hse_res = funlab_get_type_res (flab)
} // end of [val]
//
val () = emit_text (out, "\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, " (")
//
val () =
  emit_funarglst (out, hses_arg) where {
  val hses_arg = funlab_get_type_arg (flab)
} // end of [val]
//
val () = emit_text (out, ") ;\n")
//
val () =
  if tmpknd > 0 then emit_text (out, "#endif // end of [TEMPLATE]\n")
// end of [val]
//
val () = emit_newline (out)
//
in
  // nothing
end // end of [auxfun]

in // in of [local]

implement
emit_funent_ptype
  (out, fent) = let
//
  val () = auxfun (out, fent)
//
in
  // nothing
end // end of [emit_funentry_ptype]

end // end of [local]

(* ****** ****** *)

local

fun auxtmp (
  out: FILEref, fent: funent
) : void = let
//
val imparg = funent_get_imparg (fent)
val tmparg = funent_get_tmparg (fent)
val tsubopt = funent_get_tmpsub (fent)
//
val () = emit_text (out, "/*\n")
val () = emit_text (out, "imparg = ")
val () = $S2E.fprint_s2varlst (out, imparg)
val () = emit_text (out, "\n")
val () = emit_text (out, "tmparg = ")
val () = $S2E.fprint_s2explstlst (out, tmparg)
val () = emit_text (out, "\n")
val () = emit_text (out, "tmpsub = ")
val () = fprint_tmpsubopt (out, tsubopt)
val () = emit_text (out, "\n")
val () = emit_text (out, "*/\n")
//
in
  // nothing
end // end of [auxtmp]

in // in of [local]

implement
emit_funent_implmnt
  (out, fent) = let
//
val loc0 = funent_get_loc (fent)
//
val flab = funent_get_lab (fent)
//
val fc = funlab_get_funclo (flab)
val hits_arg = funlab_get_type_arg (flab)
val hse_res = funlab_get_type_res (flab)
//
val tmpret = funent_get_tmpret (fent)
//
// function header
//
val knd =
  funlab_get_tmpknd (flab)
val qopt =
  funlab_get_d2copt (flab)
val isqua =
  (case+ qopt of Some _ => true | None _ => false): bool
// end of [val]
val flopt = funlab_get_origin (flab)
val isext = (
  case+ flopt of Some _ => false | None () => isqua
) : bool // end of [val]
val issta = not (isext)
//
val () =
  if isext then emit_text (out, "ATSglobaldec()\n")
val () =
  if issta then emit_text (out, "ATSstaticdec()\n")
//
val istmp = funent_is_tmplt (fent)
val () = if istmp then auxtmp (out, fent)
//
val () = emit_hisexp (out, hse_res)
val () = emit_text (out, "\n")
val () = emit_funlab (out, flab)
val () = emit_text (out, " (")
val () = emit_funarglst (out, hits_arg)
val () = emit_text (out, ")\n")
//
// function body
//
val () = emit_text (out, "{\n")
val tmplst = funent_get_tmpvarlst (fent)
val () = emit_text (out, "/* tmpvardeclst(beg) */\n")
val () = emit_tmpdeclst (out, tmplst)
val () = emit_text (out, "/* tmpvardeclst(end) */\n")
val () = emit_text (out, "/* funbodyinstrlst(beg) */\n")
val body_inss = funent_get_instrlst (fent)
val () = emit_instrlst (out, body_inss)
val () = emit_text (out, "\n")
val () = emit_text (out, "/* funbodyinstrlst(end) */\n")
//
// function return
//
val isvoid = tmpvar_is_void (tmpret)
val () = (
  if ~isvoid
    then emit_text(out, "ATSreturn(")
    else emit_text(out, "ATSreturn_void(")
  // end of [if]
) : void // end of [val]
//
val () = emit_tmpvar (out, tmpret)
val () = emit_text (out, ") ;")
//
val () = emit_text (out, "\n}")
val () =
  emit_text (out, " /* end of [")
val () = emit_funlab (out, flab)
val () = emit_text (out, "] */\n")
//
in
end // end of [emit_funent_implmnt]

end // end of [local]

(* ****** ****** *)

local

staload UN = "prelude/SATS/unsafe.sats"

fun emit_primdec
  (out: FILEref, pmd: primdec) : void = let
in
//
case+ pmd.primdec_node of
//
| PMDnone () => ()
//
| PMDdatdecs _ => ()
| PMDexndecs _ => ()
//
| PMDfundecs _ => ()
//
| PMDvaldecs
    (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
| PMDvaldecs_rec (knd, hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDvardecs (hvds, inss) =>
    emit_instrlst_ln (out, $UN.cast{instrlst}(inss))
//
| PMDimpdec _ => ()
//
| PMDstaload _ => ()
//
| PMDlocal (
    pmds_head, pmds_body
  ) => {
    val () =
      emit_text (out, "/* local */\n")
    val () = emit_primdeclst (out, pmds_head)
    val () =
      emit_text (out, "/* in of [local] */\n")
    val () = emit_primdeclst (out, pmds_body)
    val () =
      emit_text (out, "/* end of [local] */\n")
    // end of [val]
  } // end of [PMDlocal]
//
end // end of [emit_primdec]

in // in of [local]

implement
emit_primdeclst
  (out, pmds) = let
in
//
case+ pmds of
| list_cons
    (pmd, pmds) => let
    val () =
      emit_primdec (out, pmd) in emit_primdeclst (out, pmds)
    // end of [val]
  end // end of [list_cons]
| list_nil () => ()
//
end // end of [emit_primdeclst]

end // end of [local]

(* ****** ****** *)

(* end of [pats_ccomp_emit.dats] *)
