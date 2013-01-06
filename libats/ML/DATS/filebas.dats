(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2012 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: January, 2013 *)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

macdef
prelude_fileref_open_opt = fileref_open_opt
macdef
prelude_fileref_get_line_charlst = fileref_get_line_charlst
macdef
prelude_fileref_get_lines_charlstlst = fileref_get_lines_charlstlst
macdef
prelude_fileref_get_line_string = fileref_get_line_string
macdef
prelude_fileref_get_lines_stringlst = fileref_get_lines_stringlst

(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/option0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/filebas.sats"

(* ****** ****** *)

implement
fileref_open_opt
  (path, mode) = let
  val opt = prelude_fileref_open_opt (path, mode)
in
  option0_of_option_vt (opt)
end // end of [fileref_open_opt]

(* ****** ****** *)

implement
fileref_get_line_charlst (filr) =
  list0_of_list_vt (prelude_fileref_get_line_charlst (filr))
// end of [fileref_get_line_charlst]

implement
fileref_get_lines_charlstlst (filr) =
  $UN.castvwtp0{list0(charlst0)} (prelude_fileref_get_lines_charlstlst (filr))
// end of [fileref_get_lines_charlstlst]

(* ****** ****** *)

implement
fileref_get_line_string (filr) =
  string_of_strptr (prelude_fileref_get_line_string (filr))
// end of [fileref_get_line_string]

implement
fileref_get_lines_stringlst (filr) =
  $UN.castvwtp0{list0(string)}(prelude_fileref_get_lines_stringlst (filr))
// end of [fileref_get_lines_stringlst]

(* ****** ****** *)

(* end of [filebas.dats] *)
