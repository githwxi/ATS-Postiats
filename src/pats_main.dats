(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
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
staload "pats_dynexp2.sats"
staload TRANS2 = "pats_trans2.sats"
staload TRENV2 = "pats_trans2_env.sats"

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
dynload "pats_parsing_misc.dats"
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
dynload "pats_staexp2_print.dats"
dynload "pats_staexp2_sort.dats"
dynload "pats_staexp2_scst.dats"
dynload "pats_staexp2_svar.dats"
dynload "pats_staexp2_sVar.dats"
dynload "pats_staexp2_dcon.dats"
//
dynload "pats_staexp2_util1.dats"
dynload "pats_staexp2_util2.dats"
//
dynload "pats_dynexp2.dats"
//
dynload "pats_namespace.dats"
dynload "pats_trans2_env.dats"
dynload "pats_trans2_error.dats"
dynload "pats_trans2_sort.dats"
dynload "pats_trans2_staexp.dats"
dynload "pats_trans2_dynexp.dats"
dynload "pats_trans2_decl.dats"
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
fn atsopt_version
  (out: FILEref): void = {
  val () = fprintf (out
, "ATS/Postiats version %i.%i.%i with Copyright (c) 2011-20?? Hongwei Xi\n"
, @(PATS_MAJOR_VERSION, PATS_MINOR_VERSION, PATS_MICRO_VERSION)
  ) // end of [fprintf]
} // end of [atsopt_version]

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

var the_output_filename: Stropt = stropt_none
val (pf0 | ()) = vbox_make_view_ptr {Stropt}
  (view@ (the_output_filename) | &the_output_filename)
// end of [prval]

in // in of [local]

fn the_output_filename_get
  (): Stropt = out where {
  prval vbox pf = pf0
  val out = the_output_filename
  val () = the_output_filename := stropt_none
} // end of [output_filename_get]

fn the_output_filename_set
  (name: Stropt) = () where {
  prval vbox pf = pf0
  val () = the_output_filename := name
} // end of [output_filename_set]

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
  val (pfpush | ()) = 
    $FIL.the_filenamelst_push (filename)
  val d0cs = parse_from_filename_toplevel (0(*sta*), filename)
  val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
  val (pfenv | ()) = $TRENV1.the_fxtyenv_push_nil ()
  val d1cs = $TRANS1.d0eclist_tr (d0cs)
  val map = $TRENV1.the_fxtyenv_pop (pfenv | (*none*))
  val () = $TRENV1.the_fxtyenv_pervasive_joinwth (map)
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
prelude_load (
  ATSHOME: string
) : void = {
  val () = fixity_load (ATSHOME)
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
  val () = prerr "waring(ATS)"
  val () = prerr ": unrecognized command line argument ["
  val () = prerr str
  val () = prerr "] is ignored."
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
      val () = prerr "error(ATS)"
      val () = prerr ": the command-line argument ["
      val () = prerr (def)
      val () = prerr "] cannot be properly parsed."
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
  val d1cs = $TRANS1.d0eclist_tr (d0cs)
  val () = if isdebug () then {
    val () = print "The 1st translation (fixity) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if]
//
  val d2cs = $TRANS2.d1eclist_tr (d1cs)
//
  val () = if isdebug () then {
    val () = print "The 2nd translation (binding) of ["
    val () = print basename
    val () = print "] is successfully completed!"
    val () = print_newline ()
  } // end of [if]
in
  d2cs
end // end of [do_trans12]

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
        val d2cs = do_trans12 ("STDIN", d0cs)
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
        val d1cs = $TRANS1.d0eclist_tr (d0cs)
        val () = fprint_d1eclist (stdout_ref, d1cs)
        val () = fprint_newline (stdout_ref)
      in
        process_cmdline (ATSHOME, state, arglst)
      end (* end of [_] *)
  end // end of [ _ when isinpwait]
//
| _ when isoutwait (state) => let
    val () = state.waitkind := WAITKINDnone ()
    val COMARGkey (_, basename) = arg
    val basename = string1_of_string (basename)
    val () = the_output_filename_set (stropt_some (basename))
  in
    process_cmdline (ATSHOME, state, arglst)
  end // end of [ _ when isoutwait]
//
| _ when isdatswait (state) => let
    val () = state.waitkind := WAITKINDnone ()
    val COMARGkey (_, def) = arg
    val () = process_DATS_def (def)
  in
    process_cmdline (ATSHOME, state, arglst)
  end
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
  end
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
    | "-v" => atsopt_version (stdout_ref)
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
    | "--version" => atsopt_version (stdout_ref)
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
  fun set (): void = "mac#atsopt_ATSHOME_set"
} // end of [where] // end of [val]
val () = set () where { extern
  fun set (): void = "mac#atsopt_ATSHOMERELOC_set"
} // end of [where] // end of [val]
//
val ATSHOME = let
  val opt = get () where {
    extern fun get (): Stropt = "atsopt_ATSHOME_get"
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
static char *atsopt_ATSHOME = (char*)0 ;
static char *atsopt_ATSHOMERELOC = (char*)0 ;
extern char *getenv (const char *name) ; // [stdlib.h]
//
ats_ptr_type
atsopt_ATSHOME_get () {
  return atsopt_ATSHOME ; // optional string
} // end of [atsopt_ATSHOME_get]
ATSinline()
ats_void_type
atsopt_ATSHOME_set () {
  atsopt_ATSHOME = getenv ("ATSHOME") ; return ;
} // end of [atsopt_ATSHOME_set]
//
ats_ptr_type
atsopt_ATSHOMERELOC_get () {
  return atsopt_ATSHOMERELOC ; // optional string
} // end of [atsopt_ATSHOMERELOC_get]
ATSinline()
ats_void_type
atsopt_ATSHOMERELOC_set () {
  atsopt_ATSHOMERELOC = getenv ("ATSHOMERELOC") ; return ;
} // end of [atsopt_ATSHOMERELOC_set]
//
%} // end of [%{^]

(* ****** ****** *)

(* end of [pats_main.dats] *)
