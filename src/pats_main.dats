(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2015 Hongwei Xi, ATS Trustful Software, Inc.
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
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload
ERR = "./pats_error.sats"

(* ****** ****** *)

staload
GLOB = "./pats_global.sats"

(* ****** ****** *)
//
staload "./pats_basics.sats"
//
(* ****** ****** *)
//
macdef
isdebug() =
  (debug_flag_get () > 0)
//
(* ****** ****** *)
//
staload "./pats_comarg.sats"
//
(* ****** ****** *)

staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_parsing.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_jsonize.sats"

(* ****** ****** *)

staload
DEPGEN = "./pats_depgen.sats"
staload
TAGGEN = "./pats_taggen.sats"

(* ****** ****** *)

staload "./pats_staexp1.sats"
staload "./pats_dynexp1.sats"

(* ****** ****** *)
//
staload
TRANS1 = "./pats_trans1.sats"
staload
TRENV1 = "./pats_trans1_env.sats"
//
(* ****** ****** *)

staload "./pats_staexp2.sats"
staload "./pats_stacst2.sats"
staload "./pats_dynexp2.sats"

(* ****** ****** *)

staload
TRANS2 = "./pats_trans2.sats"
staload
TRENV2 = "./pats_trans2_env.sats"

(* ****** ****** *)

staload
CODEGEN2 = "./pats_codegen2.sats"
staload
JSONIZE2 = "./pats_jsonize_synent2.sats"

(* ****** ****** *)

staload "./pats_dynexp3.sats"

(* ****** ****** *)

staload
TRANS3 = "./pats_trans3.sats"
staload
TRENV3 = "./pats_trans3_env.sats"

(* ****** ****** *)

staload
CNSTR3 = "./pats_constraint3.sats"

(* ****** ****** *)
//
staload "./pats_histaexp.sats"
staload "./pats_hidynexp.sats"
//
(* ****** ****** *)

staload TYER = "./pats_typerase.sats"

(* ****** ****** *)

staload CCOMP = "./pats_ccomp.sats"

(* ****** ****** *)
//
// HX-2015-10-02:
//
#define
ATS_DYNLOADFLAG 0 // manual dynloading
#define
ATS_DYNLOADFUN_NAME "libatsopt_dynloadall"
//
(* ****** ****** *)
//
dynload "pats_error.dats"
//
dynload "pats_intinf.dats"
//
dynload "pats_counter.dats"
//
dynload "pats_utils.dats"
dynload "pats_global.dats"
//
dynload "pats_basics.dats"
//
dynload "pats_comarg.dats"
//
dynload "pats_stamp.dats"
//
dynload "pats_symbol.dats"
//
dynload "pats_filename.dats"
//
dynload "pats_location.dats"
//
dynload "pats_jsonize.dats"
//
dynload "pats_errmsg.dats"
//
(* ****** ****** *)

dynload "pats_reader.dats"
dynload "pats_lexbuf.dats"
dynload "pats_lexing.dats"
dynload "pats_lexing_error.dats"
dynload "pats_lexing_print.dats"
dynload "pats_lexing_token.dats"

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
dynload "pats_parsing_util.dats"
dynload "pats_parsing_error.dats"
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
dynload "pats_filename_reloc.dats"
//
dynload "pats_trans1_e0xp.dats"
dynload "pats_trans1_error.dats"
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
//
dynload "pats_dynexp2_dcst.dats"
dynload "pats_dynexp2_dvar.dats"
dynload "pats_dynexp2_dmac.dats"
//
dynload "pats_dynexp2_util.dats"
//
dynload "pats_dynexp2_mapgen.dats"
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
dynload "pats_codegen2.dats"
dynload "pats_codegen2_util.dats"
dynload "pats_codegen2_absrec.dats"
dynload "pats_codegen2_datype.dats"
dynload "pats_codegen2_fprint.dats"
//
dynload "pats_jsonize_synent2.dats"
//
dynload "pats_dynexp3.dats"
dynload "pats_dynexp3_print.dats"
//
dynload "pats_trans3_util.dats"
dynload "pats_trans3_error.dats"
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
dynload pats_lintprgm_myint_gmp.dats
*)
dynload "pats_lintprgm_solve.dats"
//
dynload "pats_constraint3.dats"
//
dynload "pats_constraint3_print.dats"
//
dynload "pats_constraint3_mapgen.dats"
dynload "pats_constraint3_jsonize.dats"
//
dynload "pats_constraint3_init.dats"
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
dynload "pats_ccomp_claulst.dats"
//
dynload "pats_ccomp_lazyeval.dats"
//
dynload "pats_ccomp_trywith.dats"
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
(* ****** ****** *)

%{^
//
extern void patsopt_PATSHOME_set () ;
extern char *patsopt_PATSHOME_get () ;
//
extern void patsopt_PATSHOMERELOC_set () ;
//
extern void patsopt_ATSPKGRELOCROOT_set () ;
//
%} // end of [%{^]

(* ****** ****** *)

fn
patsopt_usage
(
  out: FILEref, arg0: comarg
) : void = let
//
val COMARGkey (_, cmdname) = arg0
//
in
//
fprintln! (out, "Usage: ", cmdname, " <command> ... <command>\n");
fprintln! (out, "where a <command> is of one of the following forms:\n");
//
fprintln! (out, "  -h (for printing out this help usage)");
fprintln! (out, "  --help (for printing out this help usage)");
//
fprintln! (out, "  -v (for printing out the version)");
fprintln! (out, "  --version (for printing out the version)");
//
fprintln! (out, "  -s filenames (for compiling (many) static <filenames>)");
fprintln! (out, "  --static filenames (for compiling (many) static <filenames>)");
//
fprintln! (out, "  -d filenames (for compiling (many) dynamic <filenames>)");
fprintln! (out, "  --dynamic filenames (for compiling (many) dynamic <filenames>)");
//
fprintln! (out, "  -o filename (output into <filename>)");
fprintln! (out, "  --output filename (output into <filename>)");
fprintln! (out, "  --output-w filename (output-write into <filename>)");
fprintln! (out, "  --output-a filename (output-append into <filename>)");
//
fprintln! (out, "  -cc (for compiling into C)");
fprintln! (out, "  -tc (for typechecking only)");
fprintln! (out, "  --compile (for compiling into C)");
fprintln! (out, "  --typecheck (for typechecking only)");
//
(*
fprintln! (out, "  -dep (for generating information on file dependencices)");
*)
fprintln! (out, "  --depgen (for generating information on file dependencices)");
(*
fprintln! (out, "  -tag (for generating tagging information on syntactic entities)");
*)
fprintln! (out, "  --taggen (for generating tagging information on syntactic entities)");
//
fprintln! (out, "  --gline (for generating line pragma information in target code)");
//
fprintln! (out, "  --debug (for enabling the generation of more informative error messages)");
fprintln! (out, "  --debug2 (for enabling the generation of debugging information in target code)");
//
fprintln! (out, "  --pkgreloc (for generating a script to help relocate packages in need)");
//
fprintln! (out, "  --codegen-2 (for outputing code generated from level-2 syntax)");
fprintln! (out, "  --jsonize-2 (for outputing code in JSON based on level-2 syntax)");
//
fprintln! (out, "  --tlcalopt-disable (for disabling tail-call optimization)");
//
fprintln! (out, "  --constraint-export (for exporting constraints in JSON format)");
fprintln! (out, "  --constraint-ignore (for entirely ignoring constraint-solving)");
//
fprint_newline (out);
//
end // end of [patsopt_usage]

(* ****** ****** *)
//
(*
//
HX: VERSION-0.0.1 released on September 2, 2013
HX: VERSION-0.0.2 released on September 19, 2013
HX: VERSION-0.0.3 released in the October of 2013
HX: VERSION-0.0.4 released in the November of 2013
HX: VERSION-0.0.5 released on January 15, 2014
HX: VERSION-0.0.6 released on February 16, 2014
HX: VERSION-0.0.7 released on March 30, 2014
HX: VERSION-0.0.8 released on Sunday, May 4, 2014
//
HX: VERSION-0.1.0 released on Monday, June 9, 2014
HX: VERSION-0.1.1 released on Wednesday, July 30, 2014
HX: VERSION-0.1.2 released on Friday, August 29, 2014
HX: VERSION-0.1.3 released on Monday, September 29, 2014
HX: VERSION-0.1.4 released on Thursday, October 23, 2014
HX: VERSION-0.1.5 released on Thursday, November 20, 2014
HX: VERSION-0.1.6 released on Tuesday, January 6, 2015
HX: VERSION-0.1.7 released on Tuesday, January 20, 2015
HX: VERSION-0.1.8 released on Saturday, January 24, 2015
HX: VERSION-0.1.9 released on Friday, February 27, 2015
HX: VERSION-0.1.10 released on Sunday, March 22, 2015
HX: VERSION-0.1.11 released on Thursday, April 23, 2015
HX: VERSION-0.1.12 released on Saturday, May 16, 2015
HX: VERSION-0.1.13 released on Friday, May 22, 2015
//
HX: VERSION-0.2.0 released on Tuesday, June 9, 2015
HX: VERSION-0.2.1 released on Sunday, July 12, 2015
HX: VERSION-0.2.2 released on Saturday, August 29, 2015
HX: VERSION-0.2.3 released on Tuesday, September 22, 2015
HX: VERSION-0.2.3 released on Wednesday, October 28, 2015
HX: VERSION-0.2.3 released on Tuesday, Decemember 22, 2015
HX: VERSION-0.2.6 released on Saturday, February 6, 2016)
HX: VERSION-0.2.7 released on Saturday, May 14, 2016)
HX: VERSION-0.2.8 released on Wednesday, June 29, 2016)
//
*)
//
(* ****** ****** *)
//
#define
PATS_COPYRIGHT
"Copyright (c) 2011-2016 Hongwei Xi"
//
(* ****** ****** *)
//
extern
fun
patsopt_version
(
  out: FILEref
) : void = "ext#libatsopt_patsopt_version"
//
implement
patsopt_version(out) =
{
//
val () =
fprintf
( out
, "ATS/Postiats version %i.%i.%i with %s\n"
, @(PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION, PATS_COPYRIGHT)
) (* end of [fprintf] *)
//
} (* end of [patsopt_version] *)
//
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

(* ****** ****** *)

typedef
fmode = [m:file_mode] file_mode (m)

typedef
cmdstate = @{
//
  comarg0= comarg
//
, PATSHOME= string
//
, waitkind= waitkind
//
// number of processed input files
//
, ninpfile= int
//
// prelude-loading is done or not
//
, preludeflag= int
//
, infil=filename
//
, outmode= fmode
, outchan= outchan
//
, depgen= int // dep info generation
, taggen= int // tagging info generation
//
, pkgreloc= int // relocating packages
//
, codegenflag= int // codegen based on level-2 syntax
, jsonizeflag= int // jsonize based on level-2 syntax
//
, typecheckflag= int // 0 by default
//
, cnstrsolveflag= int // 0 by default
//
, olevel= int // level for output
//
, nerror= int // number of accumulated errors
} // end of [cmdstate]

(* ****** ****** *)

fun
outchan_make_path
(
  state: &cmdstate, name: string
) : outchan = let
//
val (pfopt | filp) =
  $STDIO.fopen_err (name, state.outmode)
//
in
//
if
filp > null
then let
  prval Some_v (pf) = pfopt
  val filr = $UN.castvwtp_trans {FILEref} @(pf | filp)
in
  OUTCHANptr (filr)
end // end of [then]
else let
  prval None_v () = pfopt
in
  OUTCHANref (stderr_ref)
end // end of [else]
//
end // end of [outchan_make_path]

(* ****** ****** *)

fun
cmdstate_set_outchan
(
  state: &cmdstate, out_new: outchan
) : void = let
  val out_old = state.outchan
  val ((*void*)) = state.outchan := out_new
in
//
case+
out_old of
//
| OUTCHANref _ => ()
//
| OUTCHANptr (filp) => let
    val err = $STDIO.fclose0_err (filp) in (*nothing*)
  end // end of [OUTCHANptr]
//
end // end of [cmdstate_set_outchan]

(* ****** ****** *)

fn isinpwait
(
  state: cmdstate
) : bool =
(
case+
state.waitkind
of // case+
 | WTKinput_sta() => true
 | WTKinput_dyn() => true
 | _ (*non-WTKinput*) => false
) // end of [isinpwait]

fn isoutwait
  (state: cmdstate): bool =
(
case+ state.waitkind of
  | WTKoutput () => true | _(*non-WTKoutput*) => false
) (* end of [isoutwait] *)

fn isdatswait
  (state: cmdstate): bool =
(
case+ state.waitkind of
  | WTKdefine () => true | _(*non-WTKdefine*) => false
) (* end of [isdatswait] *)

fn isiatswait
  (state: cmdstate): bool =
(
case+ state.waitkind of
| WTKinclude () => true | _(*non-WTKinclude*) => false
) (* end of [isiatswait] *)

(* ****** ****** *)

local

var
theOutFilename
  : Stropt = stropt_none
//
val (pf0 | ()) =
  vbox_make_view_ptr{Stropt}(view@(theOutFilename) | &theOutFilename)
// end of [val]

in (* in-of-local *)

fn
theOutFilename_get
(
// argless
) : Stropt = out where
{
  prval vbox pf = pf0
  val out = theOutFilename
  val () = theOutFilename := stropt_none
} // end of [theOutFilename_get]

fn
theOutFilename_set
 (name: Stropt) = () where
{
  prval vbox pf = pf0
  val () = theOutFilename := name
} // end of [theOutFilename_set]

end // end of [local]

(* ****** ****** *)
//
extern
fun
the_fixity_load
  (PATSHOME: string): void =
  "ext#libatsopt_the_fixity_load"
//
implement
the_fixity_load
  (PATSHOME) = let
//
  val given = "prelude/fixity.ats"
  val fullname =
    $FIL.filename_append (PATSHOME, given)
  val fullname = string_of_strptr (fullname)
  val filename =
    $FIL.filename_make (given, given, fullname)
//
  val (
    pffil | ()
  ) = $FIL.the_filenamelst_push(filename)
  val d0cs =
    parse_from_filename_toplevel(0(*sta*), filename)
  val ((*popped*)) =
    $FIL.the_filenamelst_pop(pffil | (*none*))
//
  val (
    pfenv | ()
  ) = $TRENV1.the_fxtyenv_push_nil((*void*))
  val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
  val fxtymap =
    $TRENV1.the_fxtyenv_pop (pfenv | (*none*))
  val ((*joined*)) =
    $TRENV1.the_fxtyenv_pervasive_joinwth (fxtymap)
//
(*
  val () = begin
    print "[fixity_load] is finished."; print_newline ()
  end // end of [val]
*)
//
in
  // empty
end // end of [fixity_load]

(* ****** ****** *)
//
extern
fun
pervasive_load
(
  PATSHOME: string, given: string
) : void = "ext#libatsopt_pervasive_load"
//
implement
pervasive_load
  (PATSHOME, given) = {
//
(*
val () = (
  println! ("pervasive_load: given = ", given)
) (* end of [val] *)
*)
//
val fullname =
  $FIL.filename_append(PATSHOME, given)
val fullname = string_of_strptr(fullname)
//
val filename =
  $FIL.filename_make (given, given, fullname)
//
val (pfpush|()) = 
  $FIL.the_filenamelst_push(filename)
val d0cs =
  parse_from_filename_toplevel(0(*sta*), filename)
val ((*popped*)) =
  $FIL.the_filenamelst_pop(pfpush | (*none*))
//
val PACKNAME = "ATSLIB.prelude"
val ((*default*)) =
  $GLOB.the_PACKNAME_set_name(PACKNAME)
val ((*default*)) =
  $TRENV1.the_EXTERN_PREFIX_set("atspre_")
//
val (pfenv | ()) =
  $TRENV1.the_trans1_env_push((*void*))
val d1cs = $TRANS1.d0eclist_tr_errck(d0cs)
val ((*popped*)) =
  $TRENV1.the_trans1_env_pop(pfenv | (*none*))
//
val (pfenv | ()) =
  $TRENV2.the_trans2_env_push((*void*))
val d2cs = $TRANS2.d1eclist_tr_errck(d1cs)
val ((*joined*)) =
  $TRENV2.the_trans2_env_pervasive_joinwth(pfenv | filename, d2cs)
//
val ((*reset*)) = $GLOB.the_PACKNAME_set_none()
val ((*reset*)) = $TRENV1.the_EXTERN_PREFIX_set_none()
//
} (* end of [pervasive_load] *)

(* ****** ****** *)
//
// HX-2015-10-05:
// For use in libatsopt
//
extern
fun
the_prelude_load
(
  PATSHOME: string
) : void =
  "ext#libatsopt_the_prelude_load"
//
implement
the_prelude_load
  (PATSHOME) = {
//
val () =
the_fixity_load(PATSHOME)
//
val () =
  pervasive_load(PATSHOME, "prelude/basics_pre.sats")
val () =
  pervasive_load(PATSHOME, "prelude/basics_sta.sats")
val () =
  pervasive_load(PATSHOME, "prelude/basics_dyn.sats")
val () =
  pervasive_load(PATSHOME, "prelude/basics_gen.sats")
//
val () = pervasive_load(PATSHOME, "prelude/macrodef.sats")
//
val () = stacst2_initialize () // internalizing some static consts
val () = $CNSTR3.constraint3_initialize () // internalizing some maps
//
(*
//
// HX: Primary
//
*)
//
val () = pervasive_load(PATSHOME, "prelude/SATS/integer.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/pointer.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/arith_prf.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/integer_long.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/integer_size.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/integer_short.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/bool.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/char.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/float.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/string.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/strptr.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/integer_ptr.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/integer_fixed.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/tuple.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/memory.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/reference.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/filebas.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/intrange.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/gorder.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/gnumber.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/grandom.sats")
//
(*
//
// HX: manual loading
//
val () = pervasive_load(PATSHOME, "prelude/SATS/unsafe.sats")
//
*)
//
val () = pervasive_load(PATSHOME, "prelude/SATS/checkast.sats")
//
(*
//
// HX: Secondary
//
*)
//
val () = pervasive_load(PATSHOME, "prelude/SATS/list.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/list_vt.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/option.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/option_vt.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/array.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/array_prf.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/arrayptr.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/arrayref.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/matrix.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/matrixptr.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/matrixref.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/stream.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/stream_vt.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/gprint.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/tostring.sats")
//
val () = pervasive_load(PATSHOME, "prelude/SATS/parray.sats") // null-terminated
//
val () = pervasive_load(PATSHOME, "prelude/SATS/extern.sats") // interfacing externs
//
(*
val () = pervasive_load(PATSHOME, "prelude/SATS/giterator.sats")
val () = pervasive_load(PATSHOME, "prelude/SATS/fcontainer.sats")
*)
//
} (* end of [the_prelude_load] *)

(* ****** ****** *)
//
// HX-2015-10-05:
// For use in libatsopt
//
extern
fun
the_prelude_load_if
(
  PATSHOME: string, flag: &int
) : void =
  "ext#libatsopt_the_prelude_load_if"
//
implement
the_prelude_load_if
  (PATSHOME, flag) =
(
//
if flag = 0 then let
  val () = flag := 1 in the_prelude_load(PATSHOME)
end else () // end of [if]
//
) (* end of [the_prelude_load_if] *)

(* ****** ****** *)
//
extern
fun
do_depgen
(
  state: &cmdstate
, given: string, d0cs: d0eclist
) : void // end of [do_depgen]
extern
fun
do_taggen
(
  state: &cmdstate
, given: string, d0cs: d0eclist
) : void // end of [do_taggen]
//
implement
do_depgen
  (state, given, d0cs) = let
//
  val ents = $DEPGEN.depgen_eval (d0cs)
//
// HX-2015-05-28:
// [trans1] is not allowed after [depgen]
//
  val ((*pop*)) = $FIL.the_filenamelst_ppop ()
//
  val filr = outchan_get_filr (state.outchan)
//
in
  $DEPGEN.fprint_entlst (filr, given, ents)
end // end of [do_depgen]
//
implement
do_taggen
  (state, given, d0cs) = let
//
  val ents = $TAGGEN.taggen_proc (d0cs)
//
// HX-2015-05-28:
// [trans1] is not allowed after [taggen]
//
  val ((*pop*)) = $FIL.the_filenamelst_ppop ()
//
  val filr = outchan_get_filr (state.outchan)
//
in
  $TAGGEN.fprint_entlst (filr, given, ents)
end // end of [do_taggen]
//
(* ****** ****** *)
//
extern
fun
do_pkgreloc
(
  state: &cmdstate
, given: string, d1cs: d1eclist
) : void // end of [do_pkgreloc]
//
implement
do_pkgreloc
  (state, given, d1cs) = let
//
val itms =
  $TRENV1.the_pkgrelocitmlst_get ()
//
val filr =
  outchan_get_filr (state.outchan)
//
in
//
$TRENV1.fprint_pkgrelocitmlst(filr, itms)
//
end // end of [do_pkgreloc]
//
(* ****** ****** *)
//
extern
fun
do_codegen_2
(
  state: &cmdstate
, given: string(*unused*), d2cs: d2eclist
) : void // end-of-fun
//
(* ****** ****** *)

implement
do_codegen_2
  (state, given, d2cs) = let
//
val out = state.outchan
val out = outchan_get_filr(out)
//
in
  $CODEGEN2.d2eclist_codegen_out(out, d2cs)
end // end of [do_codegen_2]

(* ****** ****** *)
//
extern
fun
do_jsonize_2
(
  state: &cmdstate
, given: string(*unused*), d2cs: d2eclist
) : void // end-of-fun
//
(* ****** ****** *)

local

(*
fun
fprint_jsonlst
(
  out: FILEref, jsvs: jsonvalist
) : void = let
//
fun loop
(
  out: FILEref, jsvs: jsonvalist, i: int
) : void = let
in
//
case+ jsvs of
| list_nil
    ((*void*)) => ()
  // list_nil
| list_cons
    (jsv, jsvs) => let
    val () =
    if i > 0
      then fprint_string (out, ",\n")
    // end of [if]
    val ((*void*)) = fprintln! (out, jsv)
  in
    loop (out, jsvs, i+1)
  end // end of [list_cons]
//
end // end of [loop]
//
in
  loop (out, jsvs, 0)
end // end of [fprint_jsonlst]
*)

in (* in of [local] *)

implement
do_jsonize_2
(
  state, given, d2cs
) = let
//
val out = state.outchan
val out = outchan_get_filr(out)
//
in
  $JSONIZE2.d2eclist_jsonize_out(out, d2cs)
end (* end of [do_jsonize_2] *)

end // end of [local]

(* ****** ****** *)
//
extern
fun
do_trans1
(
  state: &cmdstate, given: string, d0cs: d0eclist
) : d1eclist // end-of-function
//
extern
fun
do_trans12
(
  state: &cmdstate, given: string, d0cs: d0eclist
) : d2eclist // end-of-function
//
extern
fun
do_trans123
(
  state: &cmdstate, given: string, d0cs: d0eclist
) : d3eclist // end-of-function
//
extern
fun
do_trans1234
(
  state: &cmdstate, given: string, d0cs: d0eclist
) : hideclist // end-of-function
//
extern
fun
do_transfinal
  (state: &cmdstate, given: string, d0cs: d0eclist): void
extern
fun
do_transfinal2
  (state: &cmdstate, given: string, d0cs: d0eclist): void
//
(* ****** ****** *)

implement
do_trans1
(
  state, given, d0cs
) = let
//
val d1cs =
  $TRANS1.d0eclist_tr_errck (d0cs)
// end of [val]
//
val () = $TRANS1.trans1_finalize ()
//
val () =
if isdebug() then
{
  val () = prerrln! (
    "The 1st translation (fixity) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [if] // end of [val]
//
in
  d1cs
end // end of [do_trans1]

(* ****** ****** *)

implement
do_trans12
(
  state, given, d0cs
) = d2cs where {
//
val d1cs =
  do_trans1 (state, given, d0cs)
//
val () =
if
state.ninpfile >= 2
then (
  $TRENV2.the_trans2_env_initialize ()
) (* end of [then] *)
//
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
val () =
if isdebug() then
{
  val () = prerrln! (
    "The 2nd translation (binding) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [if] // end of [val]
//
} (* end of [do_trans12] *)

(* ****** ****** *)

implement
do_trans123
(
  state, given, d0cs
) = d3cs where {
//
val d2cs =
  do_trans12(state, given, d0cs)
//
val () =
  $TRENV3.the_trans3_env_initialize()
//
val d3cs = $TRANS3.d2eclist_tr_errck(d2cs)
//
(*
val () =
{
//
  val () =
  print "do_trans123: the_s3itmlst =\n"
  val () =
  $TRENV3.fprint_the_s3itmlst (stdout_ref)
  val ((*void*)) = print_newline ((*void*))
//
} (* end of [val] *)
*)
//
val () = 
{
//
val flag =
  state.cnstrsolveflag
val c3t0 =
  $TRENV3.the_trans3_finget_constraint ()
// end of [val]
//
val () = (
//
if
flag = 0
then {
  val () = $CNSTR3.c3nstr_ats2_solve (c3t0)
} (* end of [then] *)
//
) (* end of [val] *)
//
val () =
if
flag > 0
then {
  val filr =
    outchan_get_filr (state.outchan)
  val () = $CNSTR3.c3nstr_export (filr, c3t0)
} (* end of [then] *)
//
} (* end of [val] *)
//
val () =
if
isdebug()
then {
  val () = prerrln! (
    "The 3rd translation (type-checking) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [then] // end of [if] // end of [val]
//
} (* end of [do_trans123] *)

(* ****** ****** *)

implement
do_trans1234
(
  state, given, d0cs
) = hids where {
//
val d3cs =
  do_trans123 (state, given, d0cs)
// end of [d3cs]
//
val hids = $TYER.d3eclist_tyer_errck (d3cs)
//
(*
val () = fprint_hideclist (stdout_ref, hids)
*)
//
val () =
if isdebug() then
{
  val () = prerrln! (
    "The 4th translation (type/proof-erasing) of [", given, "] is successfully completed!"
  ) (* end of [val] *)
} // end of [if] // end of [val]
//
} (* end of [do_trans1234] *)

(* ****** ****** *)

implement
do_transfinal
  (state, given, d0cs) = (
//
case+ 0 of
| _ when
    state.pkgreloc > 0 => let
    val d1cs =
      do_trans1 (state, given, d0cs)
    // end of [val]
  in
    do_pkgreloc (state, given, d1cs)
  end // end of [when ...]
| _ when
    state.codegenflag = 2 => let
    val d2cs =
      do_trans12 (state, given, d0cs)
    // end of [val]
  in
    do_codegen_2 (state, given, d2cs)
  end // end of [when ...]
| _ when
    state.jsonizeflag = 2 => let
    val d2cs =
      do_trans12 (state, given, d0cs)
    // end of [val]
  in
    do_jsonize_2 (state, given, d2cs)
  end // end of [when ...]
| _ when
    state.typecheckflag > 0 =>
  {
    val d3cs = do_trans123 (state, given, d0cs)
  } (* end of [when ...] *)
| _ (*compilation*) => let
    val () = state.olevel := 1 // there is output
    val hids = do_trans1234 (state, given, d0cs)
    val outfil = outchan_get_filr (state.outchan)
    val flag = waitkind_get_stadyn (state.waitkind)
    val ((*void*)) = $CCOMP.ccomp_main (outfil, flag, state.infil, hids)
  in
    // nothing
  end // end of [_]
//
) (* end of [do_transfinal] *)

(* ****** ****** *)

local

fun
auxexn
(
  p0: ptr
, given: string, d0cs: d0eclist, exn: exn
) : void = let
//
fun
auxerr
(
  n: int, outfil: FILEref, given: string, msg: string
) : void = let
val
cmtl =
"/* ****** ****** */\n"
//
in
//
if
(n > 0)
then
fprintf
(
  outfil
, "%s//\n#error(PATSOPT_ERROR_(patsopt(%s): %s))\n//\n%s", @(cmtl, given, msg, cmtl)
) // end of [fprintf]
//
end (* end of [auxerr] *)
//
val
(pf, fpf | p) =
$UN.ptr0_vtake{cmdstate}(p0)
//
val olevel = p->olevel
val outfil = outchan_get_filr (p->outchan)
//
val nerror = p->nerror
val ((*void*)) = p->nerror := nerror + 1
//
prval ((*addback*)) = fpf (pf)
//
in
//
case+ exn of
//
| ~($ERR.PATSOPT_FIXITY_EXN()) =>
  (
    auxerr (olevel, outfil, given, "fixity-errors")
  )
//
| ~($ERR.PATSOPT_TRANS1_EXN()) =>
  (
    auxerr (olevel, outfil, given, "trans1-errors")
  )
//
| ~($ERR.PATSOPT_TRANS2_EXN()) =>
  (
    auxerr (olevel, outfil, given, "trans2-errors")
  )
//
| ~($ERR.PATSOPT_TRANS3_EXN()) =>
  (
    auxerr (olevel, outfil, given, "trans3-errors")
  )
//
| ~($ERR.PATSOPT_TRANS4_EXN()) =>
  (
    auxerr (olevel, outfil, given, "trans4-errors")
  )
//
(*
| $ERR.PATSOPT_FILENONE_EXN(fname) =>
  (
    fold@(exn);  
    fprintf (outfil, "/* ****** ****** */\n//\n", @());
    fprintf (outfil, "#error(patsopt(%s): [%s] cannot be accessed)\n", @(given, fname));
    fprintf (outfil, "//\n/* ****** ****** */\n", @());
    $raise(exn);
  )
*)
//
| exn => $raise(exn)
//
end // end of [auxexn]

in (* in-of-local*)

implement
do_transfinal2
  (state, given, d0cs) = let
//
val p0 = &state
//
in
//
try let
//
val
(pf, fpf | p) =
$UN.ptr0_vtake{cmdstate}(p0)
//
val () = do_transfinal(!p, given, d0cs)
//
prval ((*addback*)) = fpf (pf)
//
in
  // nothing
end with exn => auxexn (p0, given, d0cs, exn)
//
end // end of [do_transfinal2]

end // end of [local]

(* ****** ****** *)

fn*
process_cmdline
  {i:nat} .<i,0>.
(
  state: &cmdstate, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arglst of
//
| ~list_vt_nil() when
    state.ninpfile = 0 => let
    val stadyn =
      waitkind_get_stadyn (state.waitkind)
    // end of [val]
  in
    case+ 0 of
    | _ when
        stadyn >= 0 => {
//
        val () =
        state.infil := $FIL.filename_stdin
//
        val () =
        the_prelude_load_if
          (state.PATSHOME, state.preludeflag)
        // end of [val]
//
        val () =
        if stadyn >= 1
          then $GLOB.the_DYNLOADFLAG_set (1)
        // end of [if]
        val d0cs = parse_from_stdin_toplevel (stadyn)
//
        var istrans: bool = true
        val isdepgen = state.depgen > 0
        val () = if isdepgen then istrans := false
        val istaggen = state.taggen > 0
        val () = if istaggen then istrans := false
//
        val given = "__STDIN__"
//
        val () =
          if isdepgen then do_depgen (state, given, d0cs)
        // end of [val]
        val () =
          if istaggen then do_taggen (state, given, d0cs)
        // end of [val]
//
        val () =
          if istrans then
            $FIL.the_filenamelst_ppush($FIL.filename_stdin)
          // end of [if]
        val () =
          if istrans then do_transfinal2 (state, given, d0cs)
        // end of [val]
//
      } (* end of [_ when ...] *)
    | _ (* stadyn < 0 *) => ((*nothing*))
  end // end of [list_vt_nil when ...]
//
| ~list_vt_nil((*void*)) => ((*void*))
//
| ~list_vt_cons(arg, arglst) => process_cmdline2(state, arg, arglst)
//
end // end of [process_cmdline]

(* ****** ****** *)

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
| _ when
    isinpwait (state) => let
//
// HX: the [inpwait] state stays unchanged
//
    val
    stadyn =
      waitkind_get_stadyn (state.waitkind)
    // end of [val]
    val nif = state.ninpfile
  in
    case+ arg of
    | COMARGkey
        (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1(state, arglst, key)
    | COMARGkey
        (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2(state, arglst, key)
    | COMARGkey (_, given) => let
//
        val () =
        state.ninpfile := state.ninpfile+1
//
        val () =
        the_prelude_load_if
          (state.PATSHOME, state.preludeflag)
        // end of [val]
//
        val () =
        if stadyn >= 1
          then $GLOB.the_DYNLOADFLAG_set(1)
        // end of [if]
        val d0cs =
          parse_from_givename_toplevel(stadyn, given, state.infil)
        // end of [val]
//
        var istrans: bool = true
        val isdepgen = state.depgen > 0
        val () = if isdepgen then istrans := false
        val istaggen = state.taggen > 0
        val () = if istaggen then istrans := false
//
        val () =
          if isdepgen then do_depgen(state, given, d0cs)
        // end of [val]
        val () =
          if istaggen then do_taggen(state, given, d0cs)
        // end of [val]
//
        val () =
          if istrans then do_transfinal2(state, given, d0cs)
        // end of [val]
//
      in
        process_cmdline (state, arglst)
      end (* end of [_] *)
    // end of [case]
  end // end of [_ when isinpwait]
//
| _ when
    isoutwait (state) => let
    val () = state.waitkind := WTKnone ()
//
    val COMARGkey (_, given) = arg
//
    val opt = stropt_some (given)
    val ((*void*)) = theOutFilename_set (opt)
//
    val _new = outchan_make_path (state, given)
    val ((*void*)) = cmdstate_set_outchan (state, _new)
//
  in
    process_cmdline (state, arglst)
  end // end of [_ when isoutwait]
//
| _ when
    isdatswait (state) => let
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

(* ****** ****** *)

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
    val () = state.ninpfile := 0
    val () = state.waitkind := WTKinput_sta
  in
  end // end of [-s]
| "-d" => let
    val () = state.ninpfile := 0
    val () = state.waitkind := WTKinput_dyn
  in
  end // end of [-d]
//
| "-cc" => (state.typecheckflag := 0)
| "-tc" => (state.typecheckflag := 1)
//
| "-dep" => (state.depgen := 1) | "-tag" => (state.taggen := 1)
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
| "-h" => let
    val cmd = state.comarg0
  in
    patsopt_usage (stdout_ref, cmd)
  end // end of ["-h"]
//
| "-v" => patsopt_version (stdout_ref)
//
| _ (*rest*) => comarg_warning (key) // unrecognized key
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey1]

(* ****** ****** *)

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
//
| "--help" =>
  patsopt_usage
    (stdout_ref, state.comarg0)
  // end of [--help]
//
| "--output" =>
    state.waitkind := WTKoutput ()
| "--output-w" => {
    val () = state.outmode := file_mode_w
    val () = state.waitkind := WTKoutput ()
  } // end of [--output-w]
| "--output-a" => {
    val () = state.outmode := file_mode_a
    val () = state.waitkind := WTKoutput ()
  } // end of [--output-a]
//
| "--static" => {
    val () = state.waitkind := WTKinput_sta
  } // end of [--static]
| "--dynamic" => {
    val () = state.waitkind := WTKinput_dyn
  } // end of [--dynamic]
//
| "--compile" => (state.typecheckflag := 0)
| "--typecheck" => (state.typecheckflag := 1)
//
| "--gline" => {
    val () = $GLOB.the_DEBUGATS_dbgline_set (1)
  } // end of [--gline] // mostly for debugging
//
| "--debug" => {
    val () = debug_flag_set (1) // in pats_basics
  } // end of [--debug] // more informative error messages
| "--debug2" => {
    val () = debug_flag_set (1)
    val () = $GLOB.the_DEBUGATS_dbgflag_set (1)
  } // end of [--debug2] // debugging info in generated code
//
| "--depgen" => (state.depgen := 1)
| "--taggen" => (state.taggen := 1)
//
| "--pkgreloc" => {
    val () = state.pkgreloc := 1
    val () = $GLOB.the_PKGRELOC_set (1)
  } (* end of [--pkgreloc] *)
//
| "--codegen-2" => (state.codegenflag := 2)
| "--jsonize-2" => (state.jsonizeflag := 2)
//
| "--tlcalopt-disable" =>
  {
    val () = $GLOB.the_CCOMPATS_tlcalopt_set(0)
  }
//
| "--constraint-export" =>
  {
    val () = state.cnstrsolveflag := 1
  }
| "--constraint-ignore" =>
  {
    val () = state.cnstrsolveflag := ~1
  }
//
| "--version" => patsopt_version (stdout_ref)
//
| _ (*unrecognized*) => comarg_warning (key)
//
) : void // end of [val]
//
in
  process_cmdline (state, arglst)
end // end of [process_cmdline2_COMARGkey2]

(* ****** ****** *)
//
extern
fun
patsopt_main
  {n:pos}
(
  argc: int(n), argc: &(@[string][n])
) : void = "ext#libatsopt_patsopt_main"
//
(* ****** ****** *)

implement
patsopt_main
  (argc, argv) = () where
{
//
val () =
set () where
{ 
  extern
  fun set (): void
    = "mac#patsopt_PATSHOME_set"
  // end of [fun]
} // end of [where] // end of [val]
val () =
set () where
{
  extern
  fun set (): void
    = "mac#patsopt_PATSHOMERELOC_set"
  // end of [fun]
} // end of [where] // end of [val]
//
val () =
set () where
{ 
  extern
  fun set (): void
    = "mac#patsopt_ATSPKGRELOCROOT_set"
  // end of [fun]
} // end of [where] // end of [val]
//
val
PATSHOME = let
//
val opt = get () where
{
  extern
  fun get (): Stropt = "mac#patsopt_PATSHOME_get"
} (* end of [where] *)
val issome = stropt_is_some (opt)
//
in
//
if
issome
then stropt_unsome(opt)
else let
  val () =
  prerrln!
  (
    "The environment variable PATSHOME is undefined!"
  ) (* end of [val] *)
in
  $ERR.abort ((*exit*))
end (* end of [else] *)
//
end : string // end of [val]
//
// for the run-time and atslib
//
val () =
  $FIL.the_prepathlst_push(PATSHOME)
//
val () =
  $TRENV1.the_trans1_env_initialize()
val () =
  $TRENV2.the_trans2_env_initialize()
//
val arglst = comarglst_parse(argc, argv)
val+~list_vt_cons(arg0, arglst) = arglst
//
var
state = @{
  comarg0= arg0
, PATSHOME= PATSHOME
, waitkind= WTKnone ()
//
// number of prcessed input files
//
, ninpfile= 0
//
// load status of prelude files
//
, preludeflag= 0
//
, infil= $FIL.filename_dummy
//
, outmode= file_mode_w
, outchan= OUTCHANref(stdout_ref)
//
, depgen= 0 // file dependency generation
, taggen= 0 // syntax tagging info generation
//
, pkgreloc= 0 // for package relocation
//
, codegenflag= 0 // syntax level for CODEgen
, jsonizeflag= 0 // syntax level for JSONize 
//
, typecheckflag= 0 // compiling by default
//
, cnstrsolveflag= 0 // cnstr-solving by default
//
, olevel= 0 // level of output
//
, nerror= 0 // number of accumulated errors
} : cmdstate // end of [var]
//
val () = process_ATSPKGRELOCROOT ()
//
val () = process_cmdline (state, arglst)
//
// HX-2015-01-09:
// A tool like patscc should receive an error:
//
val () = if state.nerror > 0 then $ERR.abort{void}()
//
} (* end of [where] *) // end of [patsopt_main]
//
(* ****** ****** *)
//
#ifndef
PATSOPT_MAIN_NONE
//
implement
main (argc, argv) =
(
//
if
(argc >= 2)
then patsopt_main (argc, argv)
else prerrln! ("Hello from ATS2(ATS/Postiats)!")
// end of [if]
) (* end of [main] *)
//
#endif // ifndef(PATSOPT_MAIN_NONE)
//
(* ****** ****** *)

(* end of [pats_main.dats] *)
