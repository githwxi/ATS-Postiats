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
// Start Time: March, 2011
//
(* ****** ****** *)

staload "libc/SATS/stdio.sats"
staload "libc/SATS/string.sats"

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload FIL = "pats_filename.sats"
staload LOC = "pats_location.sats"
staload SYM = "pats_symbol.sats"

(* ****** ****** *)

staload "pats_basics.sats"
macdef isdebug () = (debug_flag_get () > 0)

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"
staload "pats_parsing.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload TRANS1 = "pats_trans1.sats"
staload TRENV1 = "pats_trans1_env.sats"

(* ****** ****** *)

staload "pats_staexp2.sats"
staload "pats_stacst2.sats"
staload "pats_dynexp2.sats"
staload TRANS2 = "pats_trans2.sats"
staload TRENV2 = "pats_trans2_env.sats"

(* ****** ****** *)

staload "pats_dynexp3.sats"
staload TRANS3 = "pats_trans3.sats"
staload TRENV3 = "pats_trans3_env.sats"

(* ****** ****** *)

staload CNSTR3 = "pats_constraint3.sats"

(* ****** ****** *)

staload "pats_comarg.sats"

(* ****** ****** *)
//
dynload "pats_error.dats"
//
dynload "pats_counter.dats"
dynload "pats_intinf.dats"
dynload "pats_utils.dats"
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
dynload "pats_syntax_print.dats"
dynload "pats_syntax.dats"

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
dynload "pats_dynexp1_syndef.dats"
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
dynload "pats_staexp2_scst.dats"
dynload "pats_staexp2_svar.dats"
dynload "pats_staexp2_sVar.dats"
dynload "pats_staexp2_dcon.dats"
//
dynload "pats_staexp2_skexp.dats"
dynload "pats_staexp2_szexp.dats"
//
dynload "pats_staexp2_util1.dats"
dynload "pats_staexp2_util2.dats"
//
dynload "pats_staexp2_error.dats"
dynload "pats_staexp2_solve.dats"
//
dynload "pats_patcst2.dats"
//
dynload "pats_dynexp2.dats"
dynload "pats_dynexp2_print.dats"
dynload "pats_dynexp2_dcst.dats"
dynload "pats_dynexp2_dvar.dats"
dynload "pats_dynexp2_dmac.dats"
//
dynload "pats_dynexp2_util.dats"
//
dynload "pats_namespace.dats"
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
//
dynload "pats_trans3_p2at.dats"
dynload "pats_trans3_patcon.dats"
dynload "pats_trans3_syncst.dats"
dynload "pats_trans3_dynexp_up.dats"
dynload "pats_trans3_dynexp_dn.dats"
dynload "pats_trans3_appsym.dats"
dynload "pats_trans3_caseof.dats"
dynload "pats_trans3_selab.dats"
dynload "pats_trans3_deref.dats"
dynload "pats_trans3_assgn.dats"
dynload "pats_trans3_xchng.dats"
dynload "pats_trans3_loopexn.dats"
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
dynload "pats_comarg.dats"
//
(* ****** ****** *)
//
#define PATS_MAJOR_VERSION 1
#define PATS_MINOR_VERSION 0
#define PATS_MICRO_VERSION 0
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
  (out: FILEref): void = {
  val () = fprintf (out
, "ATS/Postiats version %i.%i.%i with Copyright (c) 2011-20?? Hongwei Xi\n"
, @(PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION)
  ) // end of [fprintf]
} // end of [patsopt_version]

(* ****** ****** *)

fn is_DATS_flag
  (s: string): bool =
  if strncmp (s, "-DATS", 5) = 0 then true else false
// end of [is_DATS_flag]

fn is_IATS_flag
  (s: string): bool =
  if strncmp (s, "-IATS", 5) = 0 then true else false
// end of [is_IATS_flag]

(* ****** ****** *)

local

fn string_extract (
  s: string, k: size_t
) : Stropt = let
  val s = string1_of_string (s)
  val n = string1_length (s)
  val k = size1_of_size (k)
in
  if n > k then let
    val sub = string_make_substring (s, k, n-k)
    val sub = string_of_strbuf (sub)
  in
    stropt_some (sub)
  end else
    stropt_none
  // end of [if]
end // [string_extract]

in // in of [local]

fn DATS_extract (s: string) = string_extract (s, 5)
fn IATS_extract (s: string) = string_extract (s, 5)

end // end of [local]

(* ****** ****** *)

datatype
waitkind =
  | WAITKINDnone of ()
  | WAITKINDinput_sta of () // -s ...
  | WAITKINDinput_dyn of () // -d ...
  | WAITKINDoutput of () // -o ...
  | WAITKINDdefine of () // -DATS ...
  | WAITKINDinclude of () // -IATS ...
// end of [waitkind]

fn waitkind_get_stadyn
  (knd: waitkind): int =
  case+ knd of
  | WAITKINDinput_sta () => 0
  | WAITKINDinput_dyn () => 1
  | _ => ~1 // this is not a valid input kind
// end of [cmdkind_get_stadyn]

(* ****** ****** *)

typedef
cmdstate = @{
  comarg0= comarg
//
, waitkind= waitkind
//
, preludeflg= int // prelude-loading is done or not
//
, ninputfile= int // number of processed input files
//
, typecheckonly= bool
} // end of [cmdstate]

fn isinpwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WAITKINDinput_sta () => true
  | WAITKINDinput_dyn () => true
  | _ => false
// end of [isinpwait]

fn isoutwait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WAITKINDoutput () => true | _ => false
// end of [isoutwait]

fn isdatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WAITKINDdefine () => true | _ => false
// end of [isdatswait]

fn isiatswait
  (state: cmdstate): bool =
  case+ state.waitkind of
  | WAITKINDinclude () => true | _ => false
// end of [isiatswait]

(* ****** ****** *)

local

var theOutFilename: Stropt = stropt_none
val (pf0 | ()) = vbox_make_view_ptr {Stropt}
  (view@ (theOutFilename) | &theOutFilename)
// end of [prval]

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
  // end of [val]
//
  val (pffil | ()) = 
    $FIL.the_filenamelst_push (filename)
  val d0cs = parse_from_filename_toplevel (0(*sta*), filename)
  val () = $FIL.the_filenamelst_pop (pffil | (*none*))
//
  val (pfenv | ()) = $TRENV1.the_fxtyenv_push_nil ()
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
pervasive_load (
  ATSHOME: string, basename: string
) : void = {
  val fullname =
    $FIL.filename_append (ATSHOME, basename)
  val fullname = string_of_strptr (fullname)
  val filename =
    $FIL.filename_make (basename, fullname)
  // end of [val]
//
  val (pfpush | ()) = 
    $FIL.the_filenamelst_push (filename)
  val d0cs = parse_from_filename_toplevel (0(*sta*), filename)
  val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
  val (pfenv | ()) = $TRENV1.the_trans1_env_push ()
  val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
  val () = $TRENV1.the_trans1_env_pop (pfenv | (*none*))
//
  val (pfenv | ()) = $TRENV2.the_trans2_env_push ()
  val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
  val () = $TRENV2.the_trans2_env_pervasive_joinwth (pfenv | (*none*))
//
} // end of [pervasive_load]

(* ****** ****** *)

fun prelude_load (
  ATSHOME: string
) : void = {
  val () = fixity_load (ATSHOME)
//
  val () = pervasive_load (ATSHOME, "prelude/basics_pre.sats")
  val () = pervasive_load (ATSHOME, "prelude/basics_sta.sats")
  val () = pervasive_load (ATSHOME, "prelude/basics_dyn.sats")
//
  val () = stacst2_initialize () // internalizing some static consts
  val () = $CNSTR3.constraint3_initialize () // internalizing some maps
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/arith_prf.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/bool.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/char.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/float.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/integer.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/pointer.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/string.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/strptr.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/lazy.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/lazy_vt.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/fcontainer.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/fiterator.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/array.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/array_prf.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/arrayref.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/arrnull.sats") // null-terminated
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/list.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/list_vt.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/option.sats")
  val () = pervasive_load (ATSHOME, "prelude/SATS/option_vt.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/reference.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/filebas.sats")
//
  val () = pervasive_load (ATSHOME, "prelude/SATS/extern.sats")
//
} // end of [prelude_load]

fun prelude_load_if (
  ATSHOME: string, flag: &int
) : void =
  if flag = 0 then let
    val () = flag := 1 in prelude_load (ATSHOME)
  end else () // end of [if]
// end of [prelude_load_if]

(* ****** ****** *)

viewtypedef comarglst (n:int) = list_vt (comarg, n)

(* ****** ****** *)

fn comarg_warning
  (str: string) = {
  val () = prerr ("waring(ATS)")
  val () = prerr (": unrecognized command line argument [")
  val () = prerr (str)
  val () = prerr ("] is ignored.")
  val () = prerr_newline ()
} // end of [comarg_warning]

(* ****** ****** *)
//
// HX: for processing command-line flag: -DATSXYZ=def or -DATS XYZ=def
//
fun process_DATS_def
  (def: string): void = let
  val def = string1_of_string (def)
  val opt = parse_from_string (def, p_datsdef)
in
  case+ opt of
  | ~Some_vt (def) => let
      val DATSDEF (id, opt) = def
      val e1xp = (case+ opt of
        | Some x => $TRANS1.e0xp_tr (x)
        | None _ => e1xp_none ($LOC.location_dummy)
      ) : e1xp // end of [val]
    in
      $TRENV1.the_e1xpenv_add (id, e1xp)
    end // end of [Some_vt]
  | ~None_vt () => let
      val () = prerr ("error(ATS)")
      val () = prerr (": the command-line argument [")
      val () = prerr (def)
      val () = prerr ("] cannot be properly parsed.")
      val () = prerr_newline ()
    in
      $ERR.abort ()
    end // end of [None_vt]
end // end of [process_DATS_def]

fun process_IATS_dir
  (dir: string): void = () where {
  val (pfpush | ()) = $FIL.the_pathlst_push (dir)
  prval () = __assert (pfpush) where {
    // HX: this is a permanent push!
    extern prfun __assert (pf: $FIL.the_pathlst_push_v): void
  } // end of [prval]
} (* end of [process_IATS_dir] *)

(* ****** ****** *)

fn do_trans12 (
  basename: string, d0cs: d0eclist
) : d2eclist = let
//
  val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
//
  val () = if isdebug() then {
    val () = print "The 1st translation (fixity) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if]
//
  val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
  val () = if isdebug() then {
    val () = print "The 2nd translation (binding) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if]
in
  d2cs
end // end of [do_trans12]

(* ****** ****** *)

fn do_trans123 (
  basename: string, d0cs: d0eclist
) : d3eclist = let
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
    val () = print "The 3rd translation (typechecking) of ["
    val () = print_string (basename)
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if]
in
  d3cs
end // end of [do_trans123]

(* ****** ****** *)

fn*
process_cmdline
  {i:nat} .<i,0>. (
  ATSHOME: string
, state: &cmdstate
, arglst: comarglst (i)
) :<fun1> void = let
in
//
case+ arglst of
| ~list_vt_cons (arg, arglst) => (
    process_cmdline2 (ATSHOME, state, arg, arglst)
  ) // endof [list_vt_cons]
| ~list_vt_nil ()
    when state.ninputfile = 0 => let
    val stadyn = waitkind_get_stadyn (state.waitkind)
  in
    case+ 0 of
    | _ when stadyn >= 0 => {
        val () = prelude_load_if (
          ATSHOME, state.preludeflg // loading once
        ) // end of [val]
        val d0cs = parse_from_stdin_toplevel (stadyn)
        val d2cs = do_trans123 ("STDIN", d0cs)
      } // end of [_ when ...]
    | _ => ()
  end // end of [list_vt_nil when ...]
| ~list_vt_nil () => ()
//
end // end of [process_cmdline]

and
process_cmdline2
  {i:nat} .<i,2>. (
  ATSHOME: string
, state: &cmdstate
, arg: comarg
, arglst: comarglst (i)
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
    | COMARGkey (1, key) when nif > 0 =>
        process_cmdline2_COMARGkey1 (ATSHOME, state, arglst, key)
    | COMARGkey (2, key) when nif > 0 =>
        process_cmdline2_COMARGkey2 (ATSHOME, state, arglst, key)
    | COMARGkey (_, basename) => let
        val () = state.ninputfile := state.ninputfile + 1
        val () = prelude_load_if (ATSHOME, state.preludeflg)
        val d0cs = parse_from_basename_toplevel (stadyn, basename)
        val d1cs = $TRANS1.d0eclist_tr_errck (d0cs)
        val () = fprint_d1eclist (stdout_ref, d1cs)
        val () = fprint_newline (stdout_ref)
      in
        process_cmdline (ATSHOME, state, arglst)
      end (* end of [_] *)
  end // end of [_ when isinpwait]
//
| _ when isoutwait (state) => let
    val () = state.waitkind := WAITKINDnone ()
    val COMARGkey (_, basename) = arg
    val basename = string1_of_string (basename)
    val () = theOutFilename_set (stropt_some (basename))
  in
    process_cmdline (ATSHOME, state, arglst)
  end // end of [_ when isoutwait]
//
| _ when isdatswait (state) => let
    val () = state.waitkind := WAITKINDnone ()
    val COMARGkey (_, def) = arg
    val () = process_DATS_def (def)
  in
    process_cmdline (ATSHOME, state, arglst)
  end // end of [_ when isdatswait]
//
| _ when isiatswait (state) => let
    val () = state.waitkind := WAITKINDnone ()
    val COMARGkey (_, dir) = arg
    val () = process_IATS_dir (dir)
  in
    process_cmdline (ATSHOME, state, arglst)
  end
//
| COMARGkey (1, key) =>
    process_cmdline2_COMARGkey1 (ATSHOME, state, arglst, key)
| COMARGkey (2, key) =>
    process_cmdline2_COMARGkey2 (ATSHOME, state, arglst, key)
| COMARGkey (_, key) => let
    val () = state.waitkind := WAITKINDnone ()
    val () = comarg_warning (key)
  in
    process_cmdline (ATSHOME, state, arglst)
  end // end of [COMARGkey]
//
end // end of [process_cmdline2]

and
process_cmdline2_COMARGkey1
  {i:nat} .<i,1>. (
  ATSHOME: string
, state: &cmdstate
, arglst: comarglst (i)
, key: string
) :<fun1> void = let
  val () = state.waitkind := WAITKINDnone ()
  val () = (case+ key of
    | "-s" => {
        val () = state.ninputfile := 0
        val () = state.waitkind := WAITKINDinput_sta
      }
    | "-d" => {
        val () = state.ninputfile := 0
        val () = state.waitkind := WAITKINDinput_dyn
      }
    | "-o" => {
        val () = state.waitkind := WAITKINDoutput ()
      }
    | "-tc" => state.typecheckonly := true
    | _ when is_DATS_flag (key) => let
        val def = DATS_extract (key)
        val issome = stropt_is_some (def)
      in
        if issome then let
          val def = stropt_unsome (def)
        in
          process_DATS_def (def)
        end else let
          val () = state.waitkind := WAITKINDdefine ()
        in
          // nothing
        end // end of [if]
      end
    | _ when is_IATS_flag (key) => let
        val dir = IATS_extract (key)
        val issome = stropt_is_some (dir)
      in
        if issome then let
          val dir = stropt_unsome (dir)
        in
          process_IATS_dir (dir)
        end else let
          val () = state.waitkind := WAITKINDinclude ()
        in
          // nothing
        end // end of [if]
      end
    | "-v" => patsopt_version (stdout_ref)
    | _ => comarg_warning (key)
  ) : void // end of [val]
in
  process_cmdline (ATSHOME, state, arglst)
end // end of [process_cmdline2_COMARGkey1]

and
process_cmdline2_COMARGkey2
  {i:nat} .<i,1>. (
  ATSHOME: string
, state: &cmdstate
, arglst: comarglst (i)
, key: string
) :<fun1> void = let
  val () = state.waitkind := WAITKINDnone ()
  val () = (case+ key of
    | "--static" => state.waitkind := WAITKINDinput_sta
    | "--dynamic" => state.waitkind := WAITKINDinput_dyn
    | "--output" => state.waitkind := WAITKINDoutput ()
    | "--version" => patsopt_version (stdout_ref)
    | _ => comarg_warning (key)
  ) : void // end of [val]
in
  process_cmdline (ATSHOME, state, arglst)
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
(*
val ATSHOME = let
  val opt = get () where {
    extern fun get (): Stropt = "patsopt_ATSHOME_get"
  } // end of [val]
in
  if stropt_is_some (opt)
    then stropt_unsome (opt) else let
    val () = prerr ("The environment variable ATSHOME is undefined")
    val () = prerr_newline ()
  in
    $ERR.abort ()
  end // end of [if]
end : string // end of [ATSHOME]
*)
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
val () = $FIL.the_prepathlst_push (ATSHOME) // for the run-time and atslib
val () = $TRENV1.the_trans1_env_initialize ()
val () = $TRENV2.the_trans2_env_initialize ()
//
val arglst = comarglst_parse (argc, argv)
val ~list_vt_cons (arg0, arglst) = arglst
//
var state = @{
  comarg0 = arg0
//
, waitkind= WAITKINDnone ()
//
, preludeflg= 0
//
, ninputfile= 0
//
, typecheckonly= false
} : cmdstate
//
val () = process_cmdline (ATSHOME, state, arglst)
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
