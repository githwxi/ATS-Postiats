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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload ERR = "pats_error.sats"

(* ****** ****** *)

staload "pats_lexing.sats"
staload "pats_tokbuf.sats"
staload "pats_syntax.sats"

(* ****** ****** *)

staload "pats_parsing.sats"

(* ****** ****** *)

implement
parse_from_string
  (inp, f) = let
  var buf: tokbuf
  val () = tokbuf_initialize_string (buf, inp)
  var nerr: int = 0
  val res = f (buf, 0(*bt*), nerr)
  val () = tokbuf_uninitialize (buf)
in
  if nerr = 0 then Some_vt (res) else None_vt ()
end // end of [parser_from_string]

(* ****** ****** *)

implement
parse_from_tokbuf_toplevel
  (stadyn, buf) = let
  var nerr: int = 0
  val () = the_lexerrlst_clear ()
  val () = the_parerrlst_clear ()
  val d0cs = (if stadyn = 0 then
    p_toplevel_sta (buf, nerr) else p_toplevel_dyn (buf, nerr)
  ) : d0eclist // end of [val]
  val () = if nerr > 0 then {
    val () = fprint_the_lexerrlst (stderr_ref)
    val () = fprint_the_parerrlst (stderr_ref)
    val () = $ERR.abort {void} ()
  } // end of [val]
in
  d0cs
end // end of [parse_from_tokbuf]

implement
parse_from_filename_toplevel
  (stadyn, fullname) = let
  var buf: tokbuf
  prval pfmod = file_mode_lte_r_r
  val (pffil | p_fil) = $STDIO.fopen_exn (fullname, file_mode_r)
  val () = tokbuf_initialize_filp (pfmod, pffil | buf, p_fil)
  val d0cs = parse_from_tokbuf_toplevel (stadyn, buf)
  val () = tokbuf_uninitialize (buf)
in
  d0cs
end // end of [parser_from_filename_toplevel]

implement
parse_from_stdin_toplevel
  (stadyn) = d0cs where {
  var buf: tokbuf
  val () = tokbuf_initialize_getc (buf, lam () =<cloptr1> $STDIO.getchar ())
  val d0cs = parse_from_tokbuf_toplevel (stadyn, buf)
  val () = tokbuf_uninitialize (buf)
} // end of [parser_from_stdin_toplevel]

(* ****** ****** *)

(* end of [pats_parsing.sats] *)
