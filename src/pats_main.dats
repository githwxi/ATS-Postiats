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

staload "pats_location.sats"
staload "pats_lexbuf.sats"
staload "pats_lexing.sats"

(* ****** ****** *)

dynload "pats_filename.dats"
dynload "pats_location.dats"
dynload "pats_lexbuf.dats"
dynload "pats_lexing_print.dats"
dynload "pats_lexing.dats"

(* ****** ****** *)

implement
main (
  argc, argv
) = () where {
//
  val () = println! ("Hello from ATS/Postiats!")
//
  var buf: lexbuf
  val () = lexbuf_initialize_getchar (buf, lam () =<cloref1> getchar ())
  val () = while (true) let
    val tok = lexing_next_token (buf)
// (*
    val () = (print ("loc = "); print (tok.token_loc); print_newline ())
// *)
    val () = println! ("token = ", tok)
  in
    case+ tok.token_node of
    | TOKEN_eof () => break | _ => continue
  end // end of [val]
  val () = lexbuf_uninitialize (buf)
//
} // end of [main]

(* ****** ****** *)

(* end of [pats_main.dats] *)
