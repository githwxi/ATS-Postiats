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
// Start Time: April, 2011
//
(* ****** ****** *)

staload
STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload ERR = "./pats_error.sats"
staload FIL = "./pats_filename.sats"
staload SYM = "./pats_symbol.sats"

(* ****** ****** *)

staload "./pats_lexing.sats"
staload "./pats_tokbuf.sats"
staload "./pats_syntax.sats"

(* ****** ****** *)

staload "./pats_parsing.sats"

(* ****** ****** *)

implement
parse_from_string
  (inp, f) = let
  var buf: tokbuf
  val () = tokbuf_initialize_string (buf, inp)
  var nerr: int = 0
  val res = f (buf, 0(*bt*), nerr)
  val _(*EOF*) = p_EOF (buf, 0, nerr) // HX: all tokens need to consumed
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
  val err1 = fprint_the_lexerrlst (stderr_ref)
  val err2 = fprint_the_parerrlst (stderr_ref)
  val () = if (err1 + err2) > 0 then $ERR.abort {void} ()
in
  d0cs
end // end of [parse_from_tokbuf]

(* ****** ****** *)

implement
parse_from_filename_toplevel
  (stadyn, fil) = let
//
var buf: tokbuf
prval pfmod = file_mode_lte_r_r
//
local
val fname =
  $FIL.filename_get_fullname (fil)
in (* in of [local] *)
val fname = $SYM.symbol_get_name (fname)
end // end of [local]
//
val (
  pffil | filp
) = $STDIO.fopen_exn (fname, file_mode_r)
val () =
  tokbuf_initialize_filp (pfmod, pffil | buf, filp)
// end of [val]
//
val (pfpush | ()) = $FIL.the_filenamelst_push (fil)
val d0cs = parse_from_tokbuf_toplevel (stadyn, buf)
val () = $FIL.the_filenamelst_pop (pfpush | (*none*))
//
val () = tokbuf_uninitialize (buf)
//
in
  d0cs
end // end of [parser_from_filename_toplevel]

implement
parse_from_givename_toplevel
  (stadyn, given, filref) = let
//
val filopt =
  $FIL.filenameopt_make_local (given)
// end of [val]
in
//
case+ filopt of
| ~Some_vt (fil) => let
    val () = filref := fil
    val d0cs = 
      parse_from_filename_toplevel (stadyn, fil)
    val () = $FIL.the_filenamelst_ppush (fil) // permanent push
  in
    d0cs
  end // end of [Some_vt]
| ~None_vt () => let
    val () = filref := $FIL.filename_dummy
    val () = prerrln! (
      "error(ATS): the file of the name [", given, "] is not available."
    ) (* end of [val] *)
(*
    val () = assertloc (false) // HX: immediately abort!
*)
  in
    list_nil ()
  end // end of [None_vt]
//
end // end of [parse_from_givename_toplevel]

(* ****** ****** *)

implement
parse_from_fileref_toplevel
  (stadyn, inp) = d0cs where {
  var buf: tokbuf
  val () = tokbuf_initialize_getc
    (buf, lam () =<cloptr1> $STDIO.fgetc0_err (inp))
  val d0cs = parse_from_tokbuf_toplevel (stadyn, buf)
  val () = tokbuf_uninitialize (buf)
} // end of [parser_from_fileref_toplevel]

implement
parse_from_stdin_toplevel
  (stadyn) =
  parse_from_fileref_toplevel (stadyn, stdin_ref)
// end of [parser_from_stdin_toplevel]

(* ****** ****** *)

(* end of [pats_parsing.dats] *)
