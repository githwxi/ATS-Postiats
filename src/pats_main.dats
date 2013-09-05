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
// Start Time: March, 2011
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)
//
staload "./pats_basics.sats"
//
macdef isdebug () = (debug_flag_get () > 0)
//
(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload GLOB = "./pats_global.sats"

(* ****** ****** *)

staload
FIL = "./pats_filename.sats"
staload
LOC = "./pats_location.sats"

(* ****** ****** *)

staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_parsing.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload DEPGEN = "./pats_depgen.sats"
staload TAGGEN = "./pats_taggen.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"
staload TRANS1 = "./pats_trans1.sats"
staload TRENV1 = "./pats_trans1_env.sats"

(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"
staload TRANS2 = "./pats_trans2.sats"
staload TRENV2 = "./pats_trans2_env.sats"

(* ****** ****** *)

staload "./pats_dynexp3.sats"
staload TRANS3 = "./pats_trans3.sats"
staload TRENV3 = "./pats_trans3_env.sats"

(* ****** ****** *)

staload CNSTR3 = "./pats_constraint3.sats"

(* ****** ****** *)

staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"
staload TYER = "./pats_typerase.sats"

(* ****** ****** *)

staload CCOMP = "./pats_ccomp.sats"

(* ****** ****** *)

staload "./pats_comarg.sats"

(* ****** ****** *)
//
dynload "pats_error.dats"
//
dynload "pats_intinf.dats"
dynload "pats_counter.dats"
//
dynload "pats_utils.dats"
dynload "pats_global.dats"
//
dynload "pats_basics.dats"
//
dynload "pats_stamp.dats"
dynload "pats_symbol.dats"
dynload "pats_filename.dats"
dynload "pats_location.dats"
dynload "pats_errmsg.dats"
//
(* ****** ****** *)

dynload "pats_reader.dats"
dynload "pats_lexbuf.dats"
dynload "pats_lexing_token.dats"
dynload "pats_lexing_print.dats"
dynload "pats_lexing_error.dats"
dynload "pats_lexing.dats"

dynload "pats_label.dats"
dynload "pats_effect.dats"
dynload "pats_fixity_prec.dats"
dynload "pats_fixity_fxty.dats"
dynload "pats_syntax.dats"
dynload "pats_syntax_print.dats"
dynload "pats_depgen.dats"
dynload "pats_taggen.dats"

dynload "pats_tokbuf.dats"
dynload "pats_parsing.dats"
dynload "pats_parsing_error.dats"
dynload "pats_parsing_util.dats"
dynload "pats_parsing_kwds.dats"
dynload "pats_parsing_base.dats"
dynload "pats_parsing_e0xp.dats"
dynload "pats_parsing_sort.dats"
dynload "pats_parsing_staexp.dats"
dynload "pats_parsing_p0at.dats"
dynload "pats_parsing_dynexp.dats"
dynload "pats_parsing_decl.dats"
dynload "pats_parsing_toplevel.dats"
//
dynload "pats_symmap.dats"
dynload "pats_symenv.dats"
//
dynload "pats_staexp1.dats"
dynload "pats_staexp1_print.dats"
dynload "pats_dynexp1.dats"
dynload "pats_dynexp1_print.dats"
//
dynload "pats_trans1_env.dats"
//
dynload "pats_e1xpval.dats"
dynload "pats_e1xpval_error.dats"
//
dynload "pats_trans1_error.dats"
dynload "pats_trans1_e0xp.dats"
dynload "pats_trans1_effect.dats"
dynload "pats_trans1_sort.dats"
dynload "pats_trans1_staexp.dats"
dynload "pats_trans1_p0at.dats"
dynload "pats_trans1_syndef.dats"
dynload "pats_trans1_dynexp.dats"
dynload "pats_trans1_decl.dats"
//
dynload "pats_staexp2.dats"
dynload "pats_stacst2.dats"
//
dynload "pats_staexp2_print.dats"
dynload "pats_staexp2_pprint.dats"
//
dynload "pats_staexp2_sort.dats"
//
dynload "pats_staexp2_scst.dats"
dynload "pats_staexp2_svar.dats"
dynload "pats_staexp2_svvar.dats"
//
dynload "pats_staexp2_hole.dats"
dynload "pats_staexp2_ctxt.dats"
//
dynload "pats_staexp2_dcon.dats"
//
dynload "pats_staexp2_skexp.dats"
dynload "pats_staexp2_szexp.dats"
//
dynload "pats_staexp2_util1.dats"
dynload "pats_staexp2_util2.dats"
dynload "pats_staexp2_util3.dats"
//
dynload "pats_staexp2_error.dats"
dynload "pats_staexp2_solve.dats"
//
dynload "pats_patcst2.dats"
//
dynload "pats_dynexp2.dats"
dynload "pats_dyncst2.dats"
//
dynload "pats_dynexp2_print.dats"
dynload "pats_dynexp2_dcst.dats"
dynload "pats_dynexp2_dvar.dats"
dynload "pats_dynexp2_dmac.dats"
//
dynload "pats_dynexp2_util.dats"
//
dynload "pats_namespace.dats"
//
dynload "pats_trans2_env.dats"
dynload "pats_trans2_error.dats"
dynload "pats_trans2_sort.dats"
dynload "pats_trans2_staexp.dats"
dynload "pats_trans2_p1at.dats"
dynload "pats_trans2_dynexp.dats"
dynload "pats_trans2_impdec.dats"
dynload "pats_trans2_decl.dats"
//
dynload "pats_dynexp3.dats"
dynload "pats_dynexp3_print.dats"
//
dynload "pats_trans3_error.dats"
dynload "pats_trans3_util.dats"
//
dynload "pats_trans3_env.dats"
dynload "pats_trans3_env_print.dats"
dynload "pats_trans3_env_scst.dats"
dynload "pats_trans3_env_svar.dats"
dynload "pats_trans3_env_termet.dats"
dynload "pats_trans3_env_effect.dats"
dynload "pats_trans3_env_dvar.dats"
dynload "pats_trans3_env_lamlp.dats"
dynload "pats_trans3_env_pfman.dats"
dynload "pats_trans3_env_lstate.dats"
//
dynload "pats_dmacro2.dats"
dynload "pats_dmacro2_print.dats"
dynload "pats_dmacro2_eval0.dats"
dynload "pats_dmacro2_eval1.dats"
//
dynload "pats_trans3_p2at.dats"
dynload "pats_trans3_patcon.dats"
dynload "pats_trans3_syncst.dats"
dynload "pats_trans3_dynexp_up.dats"
dynload "pats_trans3_dynexp_dn.dats"
dynload "pats_trans3_appsym.dats"
dynload "pats_trans3_caseof.dats"
dynload "pats_trans3_selab.dats"
dynload "pats_trans3_ptrof.dats"
dynload "pats_trans3_viewat.dats"
dynload "pats_trans3_deref.dats"
dynload "pats_trans3_assgn.dats"
dynload "pats_trans3_xchng.dats"
dynload "pats_trans3_lvalres.dats"
dynload "pats_trans3_fldfrat.dats"
dynload "pats_trans3_looping.dats"
dynload "pats_trans3_decl.dats"
//
dynload "pats_lintprgm.dats"
dynload "pats_lintprgm_print.dats"
(*
//
// HX: ATS_DYNLOADFLAG set to 0
//
dynload pats_lintprgm_myint_int.dats
dynload pats_lintprgm_myint_intinf.dats
*)
dynload "pats_lintprgm_solve.dats"
//
dynload "pats_constraint3.dats"
dynload "pats_constraint3_init.dats"
dynload "pats_constraint3_print.dats"
dynload "pats_constraint3_simplify.dats"
dynload "pats_constraint3_icnstr.dats"
dynload "pats_constraint3_solve.dats"
//
dynload "pats_histaexp.dats"
dynload "pats_histaexp_print.dats"
dynload "pats_histaexp_funlab.dats"
//
dynload "pats_hidynexp.dats"
dynload "pats_hidynexp_print.dats"
dynload "pats_hidynexp_util.dats"
//
dynload "pats_typerase_error.dats"
dynload "pats_typerase_staexp.dats"
dynload "pats_typerase_dynexp.dats"
dynload "pats_typerase_decl.dats"
//
dynload "pats_ccomp.dats"
dynload "pats_ccomp_print.dats"
//
dynload "pats_ccomp_hitype.dats"
//
dynload "pats_ccomp_tmplab.dats"
dynload "pats_ccomp_tmpvar.dats"
//
dynload "pats_ccomp_d2env.dats"
//
dynload "pats_ccomp_funlab.dats"
dynload "pats_ccomp_funent.dats"
//
dynload "pats_ccomp_util.dats"
//
dynload "pats_ccomp_ccompenv.dats"
dynload "pats_ccomp_instrseq.dats"
//
dynload "pats_ccomp_hipat.dats"
//
dynload "pats_ccomp_dynexp.dats"
//
dynload "pats_ccomp_caseof.dats"
dynload "pats_ccomp_trywith.dats"
dynload "pats_ccomp_claulst.dats"
//
dynload "pats_ccomp_looping.dats"
//
dynload "pats_ccomp_decl.dats"
//
dynload "pats_ccomp_subst.dats"
dynload "pats_ccomp_environ.dats"
dynload "pats_ccomp_template.dats"
//
dynload "pats_ccomp_emit.dats"
dynload "pats_ccomp_emit2.dats"
dynload "pats_ccomp_emit3.dats"
dynload "pats_ccomp_main.dats"
//
dynload "pats_comarg.dats"
//
(* ****** ****** *)

fn patsopt_usage
(
  out: FILEref, arg0: comarg
) : void = let
//
val COMARGkey (_, cmdname) = arg0
//
in
//
fprintln! (out, "usage: ", cmdname, " <command> ... <command>\n");
fprintln! (out, "where a <command> is of one of the following forms:\n");
fprintln! (out, "  -h (for printing out this help usage)");
fprintln! (out, "  --help (for printing out this help usage)");
fprintln! (out, "  -v (for printing out the version)");
fprintln! (out, "  --version (for printing out the version)");
fprintln! (out, "  -s filenames (for compiling (many) static <filenames>)");
fprintln! (out, "  --static filenames (for compiling (many) static <filenames>)");
fprintln! (out, "  -d filenames (for compiling (many) dynamic <filenames>)");
fprintln! (out, "  --dynamic filenames (for compiling (many) dynamic <filenames>)");
fprintln! (out, "  -o filename (output into <filename>)");
fprintln! (out, "  --output filename (output into <filename>)");
fprintln! (out, "  -tc (for typechecking only)");
fprintln! (out, "  --typecheck (for typechecking only)");
fprintln! (out, "  --gline (for generating line pragma information in target code)");
fprintln! (out, "  --depgen (for generating information on file dependencices)");
fprintln! (out, "  --taggen (for generating tagging information on syntactic entities)");
fprint_newline (out);
//
end // end of [patsopt_usage]

(* ****** ****** *)
//
#define PATS_MAJOR_VERSION 0
#define PATS_MINOR_VERSION 0
#define PATS_MICRO_VERSION 1
(*
//
// HX-2011-04-27: this is supported in Postiats:
//
#define PATS_fVER
  (MAJOR, MINOR, MICRO) %(1000 * (1000 * MAJOR + MINOR) + MICRO)
#define PATS_VERSION
  PATS_fVER (PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION)
// end of [PATS_VERSION]
*)
//
fn patsopt_version
  (out: FILEref, arg0: comarg): void =
{
  val () = fprintf (out
, "ATS/Postiats version %i.%i.%i with Copyright (c) 2011-2013 Hongwei Xi\n"
, @(PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION)
  ) // end of [fprintf]
} // end of [patsopt_version]

(* ****** ****** *)

datatype
waitkind =
  | WTKnone of ()
  | WTKinput_sta of () // -s ...
  | WTKinput_dyn of () // -d ...
  | WTKoutput of () // -o ...
  | WTKdefine of () // -DATS ...
  | WTKinclude of () // -IATS ...
// end of [waitkind]

fn waitkind_get_stadyn
  (knd: waitkind): int =
  case+ knd of
  | WTKinput_sta () => 0
  | WTKinput_dyn () => 1
  | _ => ~1 // this is not a valid input kind
// end of [cmdkind_get_stadyn]

(* ****** ****** *)

datatype
outchan =
  | OUTCHANref of (FILEref) | OUTCHANptr of (FILEref)
// end of [outchan]

fun
outchan_get_filr
  (oc: outchan): FILEref = (
  case+ oc of
  | OUTCHANref (filr) => filr | OUTCHANptr (filr) => filr
) // end of [outchan_get_filr]

fun
outchan_make_path
  (name: string): outchan = let
//
val (pfopt | filp) =
  $STDIO.fopen_err (name, file_mode_w)
//
in
//
if filp > null then let
  prval Some_v (pf) = pfopt
  val filr = $UN.castvwtp_trans {FILEref} @(pf | filp)
in
  OUTCHANptr (filr)
end else let
  prval None_v () = pfopt
in
  OUTCHANref (stderr_ref)
end // end of [if]
//
end // end of [outchan_make_path]

(* ****** ****** *)

typedef
cmdstate = @{
  comarg0= comarg
//
, ATSHOME= string
//
, waitkind= waitkind
// prelude-loading is done or not
, preludeflg= int
// number of processed input files
, ninputfile= int
//
, infil=filename
//
, outchan= outchan
//
, depgenflag= int // dep info generation
, taggenflag= int // tagging info generation
//
, typecheckonly= bool
// number of accumulated errors
, nerror= int
} // end of [cmdstate]

(* ****** ****** *)

fun cmdstate_set_outchan (
  state: &cmdstate, _new: outchan
) : void = let
  val _old = state.outchan
  val () = state.outchan := _new
in
  case+ _old of
  | OUTCHANref _ => ()
  | OUTCHANptr (filp) => let
      val _err = $STDIO.fclose0_err (filp) in (*nothing*)
    end // end of [OUTCHANptr]
end // end of [cmdstate_set_outchan]

(* ****** ****** *)

fn isinpwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKinput_sta () => true
  | WTKinput_dyn () => true
  | _ => false
// end of [isinpwait]

fn isoutwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKoutput () => true | _ => false
// end of [isoutwait]

fn isdatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKdefine () => true | _ => false
// end of [isdatswait]

fn isiatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WTKinclude () => true | _ => false
// end of [isiatswait]

(* ****** ****** *)

local

var theOutFilename
  : Stropt = stropt_none
val (pf0 | ()) =
  vbox_make_view_ptr{Stropt}(view@ (theOutFilename) | &theOutFilename)
// end of [val]

in // in of [local]

fn theOutFilename_get
  (): Stropt = out where {
  prval vbox pf = pf0
  val out = theOutFilename
  val () = theOutFilename := stropt_none
} // end of [theOutFilename_get]

fn theOutFilename_set
  (name: Stropt) = () where {
  prval vbox pf = pf0
  val () = theOutFilename := name
} // end of [theOutFilename_set]

end // end of [local]

(* ****** ****** *)

fn fixity_load
  (ATSHOME: string): void = let
//
  val basename = "prelude/fixity.ats"
  val fullname =
    $FIL.filename_append (ATSHOME, basename)
  val fullname = string_of_strptr (fullname)
  val filename =
    $FIL.filename_make (basename, fullname)
//
  val (pffil | ()) = 
    $FIL.the_filenamelst_push (filename)
  val d0cs = parse_from_filename_toplevel (0(*sta*), filename)
  val () = $FIL.the_filenamelst_pop (pffil | (*none*))
//
  val (
    pfenv | ()
  ) = $TRENV1.the_fxtyenv_push_nil ()
  val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
  val fxtymap = $TRENV1.the_fxtyenv_pop (pfenv | (*none*))
  val () = $TRENV1.the_fxtyenv_pervasive_joinwth (fxtymap)
(*
  val () = begin
    print "[fixity_load] is finished."; print_newline ()
  end // end of [val]
*)
in
  // empty
end // end of [fixity_load]

(* ****** ****** *)

fun
pervasive_load
(
  ATSHOME: string, basename: string
) : void =
{
(*
val (
) = println!
  ("pervasive_load: basename = ", basename)
*)
val fullname =
  $FIL.filename_append (ATSHOME, basename)
val fullname = string_of_strptr (fullname)
val filename =
  $FIL.filename_make (basename, fullname)
//
val (pfpush | ()) = 
  $FIL.the_filenamelst_push (filename)
val d0cs =
  parse_from_filename_toplevel (0(*sta*), filename)
val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
val () = $TRENV1.the_EXTERN_PREFIX_set ("atspre_")
val () = $GLOB.the_PACKNAME_set_name ("ATSLIB.prelude")
//
val (pfenv | ()) =
  $TRENV1.the_trans1_env_push ((*void*))
val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
val () = $TRENV1.the_trans1_env_pop (pfenv | (*none*))
//
val (pfenv | ()) =
  $TRENV2.the_trans2_env_push ((*void*))
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
val () = $TRENV2.the_trans2_env_pervasive_joinwth (pfenv | (*none*))
//
val () = $GLOB.the_PACKNAME_set_none ()
val () = $TRENV1.the_EXTERN_PREFIX_set_none ()
//
} // end of [pervasive_load]

(* ****** ****** *)

fun prelude_load
(
  ATSHOME: string
) : void = {
  val () = fixity_load (ATSHOME)
//
  val (
  ) = pervasive_load (ATSHOME, "prelude/basics_pre.sats")
  val (
  ) = pervasive_load (ATSHOME, "prelude/basics_sta.sats")
  val (
  ) = pervasive_load (ATSHOME, "prelude/basics_dyn.sats")
  val (
  ) = pervasive_load (ATSHOME, "prelude/basics_gen.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/macrodef.sats")
//
  val () = stacst2_initialize () // internalizing some static consts
  val () = $CNSTR3.constraint3_initialize () // internalizing some maps
//
  val (
  ) = pervasive_load (ATSHOME, "prelude/SATS/arith_prf.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/integer.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/pointer.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/bool.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/char.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/integer_ptr.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/integer_fixed.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/float.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/memory.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/string.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/strptr.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/tuple.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/reference.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/filebas.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/intrange.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/lazy.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/lazy_vt.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/gorder.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/gnumber.sats")
//
(*
  val () = pervasive_load (ATSHOME, "prelude/SATS/unsafe.sats") // manual loading
*)
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/list.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/list_vt.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/option.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/option_vt.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/array.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/array_prf.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/arrayptr.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/arrayref.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/matrix.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/matrixptr.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/matrixref.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/gprint.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/parray.sats") // null-terminated
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/extern.sats") // interfacing externs
//
(*
  val () = pervasive_load (ATSHOME, "prelude/SATS/giterator.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/fcontainer.sats")
*)
//
} // end of [prelude_load]

(* ****** ****** *)

fun prelude_load_if
(
  ATSHOME: string, flag: &int
) : void =
  if flag = 0 then let
    val () = flag := 1 in prelude_load (ATSHOME)
  end else () // end of [if]
// end of [prelude_load_if]

(* ****** ****** *)

extern
fun do_trans12
(
  basename: string, d0cs: d0eclist
) : d2eclist // end of [do_trans12]

extern
fun do_trans123
(
  basename: string, d0cs: d0eclist
) : d3eclist // end of [do_trans123]

extern
fun do_trans1234
(
  basename: string, d0cs: d0eclist
) : hideclist // end of [do_trans1234]

extern
fun do_transfinal
(
  state: &cmdstate, basename: string, d0cs: d0eclist
) : void // end of [do_transfinal]

(* ****** ****** *)

implement
do_trans12 (
  basename, d0cs
) = let
//
  val d1cs =
    $TRANS1.d0eclist_tr_errck (d0cs)
  // end of [val]
  val () = $TRANS1.trans1_finalize ()
//
  val () = if isdebug() then {
    val () = print "The 1st translation (fixity) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if] // end of [val]
//
  val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
  val () = if isdebug() then {
    val () = print "The 2nd translation (binding) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if] // end of [val]
in
  d2cs
end // end of [do_trans12]

(* ****** ****** *)

implement
do_trans123 (
  basename, d0cs
) = let
//
  val d2cs = do_trans12 (basename, d0cs)
  val () = $TRENV3.trans3_env_initialize ()
  val d3cs = $TRANS3.d2eclist_tr_errck (d2cs)
//
(*
  val () = {
    val () = print "do_trans123: the_s3itmlst =\n"
    val () = $TRENV3.fprint_the_s3itmlst (stdout_ref)
    val () = print_newline ()
  } // end of [val]
*)
//
  val () = // constraint solving
    $CNSTR3.c3nstr_solve (c3t) where {
    val c3t = $TRENV3.trans3_finget_constraint ()
  } // end of [val]
//
  val () = if isdebug() then {
    val () = print "The 3rd translation (type-checking) of ["
    val () = print_string (basename)
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if] // end of [val]
in
  d3cs
end // end of [do_trans123]

(* ****** ****** *)

implement
do_trans1234 (
  basename, d0cs
) = let
//
val d3cs =
  do_trans123 (basename, d0cs)
// end of [d3cs]
val hids = $TYER.d3eclist_tyer (d3cs)
//
(*
val () = fprint_hideclist (stdout_ref, hids)
*)
//
val () =
if isdebug() then {
  val () = print "The 4th translation (type/proof-erasing) of ["
  val () = print_string (basename)
  val () = print "] is successfully completed!"
  val () = print_newline ()
} // end of [if] // end of [val]
//
in
  hids
end // end of [do_trans1234]

(* ****** ****** *)

implement
do_transfinal
  (state, basename, d0cs) = let
in
//
case+ 0 of
| _ when state.typecheckonly => let
    val d3cs = do_trans123 (basename, d0cs) in (*nothing*)
  end // end of [...]
| _ => let
    val hids = do_trans1234 (basename, d0cs)
    val out = outchan_get_filr (state.outchan)
    val flag = waitkind_get_stadyn (state.waitkind)
    val () = $CCOMP.ccomp_main (out, flag, state.infil, hids)
  in
    // nothing
  end // end of [_]
//
end // end of [do_transfinal]

(* ****** ****** *)

fn*
process_cmdline
  {i:nat} .<i,0>. (
  state: &cmdstate, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arglst of
| ~list_vt_cons
    (arg, arglst) =>
    process_cmdline2 (state, arg, arglst)
| ~list_vt_nil ()
    when state.ninputfile = 0 => let
    val stadyn =
      waitkind_get_stadyn (state.waitkind)
    // end of [val]
  in
    case+ 0 of
    | _ when stadyn >= 0 => {
        val ATSHOME = state.ATSHOME
        val () =
          prelude_load_if (
          ATSHOME, state.preludeflg // loading once
        ) // end of [val]
//
        val () = state.infil := $FIL.filename_stdin
//
        val d0cs = parse_from_stdin_toplevel (stadyn)
//
        var istrans: bool = true
        val isdepgen = state.depgenflag > 0
        val () = if isdepgen then istrans := false
        val istaggen = state.taggenflag > 0
        val () = if istaggen then istrans := false
//
        val () = (
        if isdepgen then let
          val ents = $DEPGEN.depgen_eval (d0cs)
          val filr = outchan_get_filr (state.outchan)
        in
          $DEPGEN.fprint_entry (filr, "<STDIN>", ents)
        end // end of [if]
        ) (* end of [val] *)
//
        val () = (
        if istrans then do_transfinal (state, "<STDIN>", d0cs)
        ) (* end of [val] *)
//
      } // end of [_ when ...]
    | _ => ()
  end // end of [list_vt_nil when ...]
| ~list_vt_nil () => ()
//
end // end of [process_cmdline]

and
process_cmdline2
  {i:nat} .<i,2>.
(
  state: &cmdstate
, arg: comarg, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arg of
//
| _ when isinpwait (state) => let
//
// HX: the [inpwait] state stays unchanged
//
    val stadyn = waitkind_get_stadyn (state.waitkind)
    val nif = state.ninputfile
  in
    case+ arg of
    | COMARGkey
        (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1 (state, arglst, key)
    | COMARGkey
        (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2 (state, arglst, key)
    | COMARGkey
        (_, basename) => let
        val ATSHOME = state.ATSHOME
        val () = state.ninputfile := state.ninputfile + 1
        val () = prelude_load_if (ATSHOME, state.preludeflg)
//
        val d0cs = parse_from_basename_toplevel (stadyn, basename, state.infil)
//
        var istrans: bool = true
        val isdepgen = state.depgenflag > 0
        val () = if isdepgen then istrans := false
        val istaggen = state.taggenflag > 0
        val () = if istaggen then istrans := false
//
        val () = (
        if isdepgen then let
          val ents = $DEPGEN.depgen_eval (d0cs)
          val filr = outchan_get_filr (state.outchan)
        in
          $DEPGEN.fprint_entry (filr, basename, ents)
        end // end of [if]
        ) (* end of [val] *)
//
        val () = (
        if istrans then do_transfinal (state, basename, d0cs)
        ) (* end of [val] *)
//
      in
        process_cmdline (state, arglst)
      end (* end of [_] *)
  end // end of [_ when isinpwait]
//
| _ when isoutwait (state) => let
    val () = state.waitkind := WTKnone ()
//
    val COMARGkey (_, basename) = arg
//
    val opt = stropt_some (basename)
    val () = theOutFilename_set (opt)
//
    val _new = outchan_make_path (basename)
    val () = cmdstate_set_outchan (state, _new)
//
  in
    process_cmdline (state, arglst)
  end // end of [_ when isoutwait]
//
| _ when isdatswait (state) => let
    val () = state.waitkind := WTKnone ()
    val COMARGkey (_, def) = arg
    val () = process_DATS_def (def)
  in
    process_cmdline (state, arglst)
  end // end of [_ when isdatswait]
//
| _ when isiatswait (state) => let
    val () = state.waitkind := WTKnone ()
    val COMARGkey (_, dir) = arg
    val () = process_IATS_dir (dir)
  in
    process_cmdline (state, arglst)
  end
//
| COMARGkey (1, key) =>
    process_cmdline2_COMARGkey1 (state, arglst, key)
| COMARGkey (2, key) =>
    process_cmdline2_COMARGkey2 (state, arglst, key)
| COMARGkey (_, key) => let
    val () = comarg_warning (key)
    val () = state.waitkind := WTKnone ()
  in
    process_cmdline (state, arglst)
  end // end of [COMARGkey]
//
end // end of [process_cmdline2]

and
process_cmdline2_COMARGkey1
  {i:nat} .<i,1>.
(
  state: &cmdstate
, arglst: comarglst (i)
, key: string // [key]: the string following [-]
) :<fun1> void = let
//
val () = state.waitkind := WTKnone ()
val () =
(
case+ key of
//
| "-o" => let
    val () = state.waitkind := WTKoutput
  in
  end // end of [-o]
| "-s" => let
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput_sta
  in
  end // end of [-s]
| "-d" => let
    val () = state.ninputfile := 0
    val () = state.waitkind := WTKinput_dyn
  in
  end // end of [-d]
//
| "-tc" => {
    val () = state.typecheckonly := true
  } // end of [-tc]
//
| "-dep" => {
    val () = state.depgenflag := 1
  } // end of [-dep]
//
| _ when
    is_DATS_flag (key) => let
    val def = DATS_extract (key)
    val issome = stropt_is_some (def)
  in
    if issome then let
      val def = stropt_unsome (def)
    in
      process_DATS_def (def)
    end else let
      val () = state.waitkind := WTKdefine ()
    in
      // nothing
    end // end of [if]
  end
| _ when
    is_IATS_flag (key) => let
    val dir = IATS_extract (key)
    val issome = stropt_is_some (dir)
  in
    if issome then let
      val dir = stropt_unsome (dir)
    in
      process_IATS_dir (dir)
    end else let
      val () = state.waitkind := WTKinclude ()
    in
      // nothing
    end // end of [if]
  end
//
| "-h" => patsopt_usage (stdout_ref, state.comarg0)
| "-v" => patsopt_version (stdout_ref, state.comarg0)
//
| _ => comarg_warning (key) // unrecognized key
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey1]

and
process_cmdline2_COMARGkey2
  {i:nat} .<i,1>.
(
  state: &cmdstate
, arglst: comarglst (i)
, key: string // [key]: the string following [--]
) :<fun1> void = let
//
val () = state.waitkind := WTKnone ()
val () =
(
case+ key of
| "--output" =>
    state.waitkind := WTKoutput ()
//
| "--static" =>
    state.waitkind := WTKinput_sta
| "--dynamic" =>
    state.waitkind := WTKinput_dyn
//
| "--typecheck" => {
    val () = state.typecheckonly := true
  } // end of [--typecheck]
//
| "--gline" => {
    val () = $GLOB.the_DEBUGATS_dbgline_set (1)
  } // end of [--gline]
//
| "--depgen" => {
    val () = state.depgenflag := 1
  } // end of [--depgen]
| "--taggen" => {
    val () = state.taggenflag := 1
  } // end of [--taggen]
//
| "--help" => patsopt_usage (stdout_ref, state.comarg0)
| "--version" => patsopt_version (stdout_ref, state.comarg0)
//
| _ => comarg_warning (key) // unrecognized key
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey2]

(* ****** ****** *)

implement
main (
  argc, argv
) = () where {
//
val () = println! ("Hello from ATS/Postiats!")
//
val () = set () where { extern
  fun set (): void = "mac#patsopt_ATSHOME_set"
} // end of [where] // end of [val]
val () = set () where { extern
  fun set (): void = "mac#patsopt_ATSHOMERELOC_set"
} // end of [where] // end of [val]
//
val () = set () where { extern
  fun set (): void = "mac#patsopt_PATSHOME_set"
} // end of [where] // end of [val]
//
val ATSHOME = let
  val opt = get () where {
    extern fun get (): Stropt = "patsopt_PATSHOME_get"
  } // end of [val]
in
  if stropt_is_some (opt)
    then stropt_unsome (opt) else let
    val () = prerr ("The environment variable PATSHOME is undefined")
    val () = prerr_newline ()
  in
    $ERR.abort ()
  end // end of [if]
end : string // end of [ATSHOME]
//
// for the run-time and atslib
//
val () = $FIL.the_prepathlst_push (ATSHOME)
//
val () = $TRENV1.the_trans1_env_initialize ()
val () = $TRENV2.the_trans2_env_initialize ()
//
val arglst = comarglst_parse (argc, argv)
val+~list_vt_cons (arg0, arglst) = arglst
//
var
state = @{
  comarg0= arg0
, ATSHOME= ATSHOME
, waitkind= WTKnone ()
// load status of prelude files
, preludeflg= 0
// number of prcessed input files
, ninputfile= 0
//
, infil= $FIL.filename_dummy
// HX: the default output channel
, outchan= OUTCHANref (stdout_ref)
//
, depgenflag= 0 // dep info generation
, taggenflag= 0 // tagging info generation
//
, typecheckonly= false
, nerror= 0 // number of accumulated errors
} : cmdstate // end of [var]
//
val () = process_cmdline (state, arglst)
//
} // end of [main]

(* ****** ****** *)

%{^
//
// HX-2011-04-18:
// there is no need for marking these variables as
// GC roots as the values stored in them cannot be GCed
//
static char *patsopt_ATSHOME = (char*)0 ;
static char *patsopt_ATSHOMERELOC = (char*)0 ;
static char *patsopt_PATSHOME = (char*)0 ;
extern char *getenv (const char *name) ; // [stdlib.h]
//
ats_ptr_type
patsopt_ATSHOME_get () {
  return patsopt_ATSHOME ; // optional string
} // end of [patsopt_ATSHOME_get]
ATSinline()
ats_void_type
patsopt_ATSHOME_set () {
  patsopt_ATSHOME = getenv ("ATSHOME") ; return ;
} // end of [patsopt_ATSHOME_set]
//
ats_ptr_type
patsopt_ATSHOMERELOC_get () {
  return patsopt_ATSHOMERELOC ; // optional string
} // end of [patsopt_ATSHOMERELOC_get]
ATSinline()
ats_void_type
patsopt_ATSHOMERELOC_set () {
  patsopt_ATSHOMERELOC = getenv ("ATSHOMERELOC") ; return ;
} // end of [patsopt_ATSHOMERELOC_set]
//
ats_ptr_type
patsopt_PATSHOME_get () {
  return patsopt_PATSHOME ; // optional string
} // end of [patsopt_PATSHOME_get]
ATSinline()
ats_void_type
patsopt_PATSHOME_set () {
  patsopt_PATSHOME = getenv ("PATSHOME") ; return ;
} // end of [patsopt_PATSHOME_set]
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [pats_main.dats] *)
