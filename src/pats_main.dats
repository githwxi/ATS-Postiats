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

(* ****** ****** *)

staload UT = "pats_utils.sats"

(* ****** ****** *)

staload ERR = "pats_error.sats"
staload FIL = "pats_filename.sats"
staload LOC = "pats_location.sats"

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

staload "pats_comarg.sats"

(* ****** ****** *)
//
dynload "pats_debug.dats"
dynload "pats_error.dats"
dynload "pats_utils.dats"
//
dynload "pats_symbol.dats"
dynload "pats_filename.dats"
dynload "pats_location.dats"
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
//
dynload "pats_trans1_env.dats"
dynload "pats_trans1_e0xp.dats"
dynload "pats_trans1_effect.dats"
dynload "pats_trans1_sort.dats"
dynload "pats_trans1_staexp.dats"
dynload "pats_trans1_dynexp.dats"
dynload "pats_trans1_decl.dats"
//
dynload "pats_comarg.dats"
//
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
  val d0cs = parse_from_filename_toplevel (0(*sta*), fullname)
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
//
val () = fixity_load (ATSHOME)
//
val d0cs = parse_from_stdin_toplevel (1(*dyn*))
val () = fprint_d0eclist (stdout_ref, d0cs)
val () = print_newline ()
//
val d1cs = $TRANS1.d0eclist_tr (d0cs)
val () = fprint_d1eclist (stdout_ref, d1cs)
val () = print_newline ()
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
