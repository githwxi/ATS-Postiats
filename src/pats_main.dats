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

staload "pats_location.sats"
staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"
staload "pats_parsing.sats"

(* ****** ****** *)

staload "pats_staexp1.sats"
staload "pats_dynexp1.sats"
staload "pats_trans1.sats"

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
dynload "pats_fixity_prec.dats"
dynload "pats_fixity_fxty.dats"
dynload "pats_syntax_print.dats"
dynload "pats_syntax.dats"

dynload "pats_tokbuf.dats"
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
dynload "pats_trans1_sort.dats"
dynload "pats_trans1_staexp.dats"
dynload "pats_trans1_dynexp.dats"
dynload "pats_trans1_decl.dats"
//
(* ****** ****** *)

implement
main (
  argc, argv
) = () where {
//
  val () = println! ("Hello from ATS/Postiats!")
//
  var buf: tokbuf
  val () = tokbuf_initialize_getc (buf, lam () =<cloptr1> getchar ())
  var nerr: int = 0
//
  val d0cs = p_toplevel_dyn (buf, nerr)
//
  val () = println! ("nerr = ", nerr)
  val () = if (nerr > 0) then tokbuf_discard_all (buf)
  val () = if (nerr = 0) then fprint_d0eclist (stdout_ref, d0cs)
  val () = if (nerr = 0) then print_newline ()
//
  val () = tokbuf_uninitialize (buf)
//
  val () = fprint_the_lexerrlst (stdout_ref)
  val () = fprint_the_parerrlst (stdout_ref)
//
  val d1cs = d0eclist_tr (d0cs)
  val () = fprint_d1eclist (stdout_ref, d1cs)
  val () = print_newline ()
//
} // end of [main]

(* ****** ****** *)

(* end of [pats_main.dats] *)
