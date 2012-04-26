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
//
// Author of the file: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: March, 2012
//
(* ****** ****** *)

staload "prelude/SATS/filebas.sats"

(* ****** ****** *)

implement file_mode_r = file_mode ("r")
implement file_mode_rr = file_mode ("r+")
implement file_mode_w = file_mode ("w")
implement file_mode_ww = file_mode ("w+")
implement file_mode_a = file_mode ("a")
implement file_mode_aa = file_mode ("a+")

(* ****** ****** *)

implement fileref_load<int> = fileref_load_int
implement fileref_load<char> = fileref_load_char
implement fileref_load<float> = fileref_load_float
implement fileref_load<double> = fileref_load_double
implement fileref_load<string> = fileref_load_string

(* ****** ****** *)

implement{a}
fileref_get_opt (r) = let
  var x: a
  val yn = fileref_load<a> (r, x)
in
  option_vt_make_opt<a> (yn, x)
end // end of [fileref_get_opt]

(* ****** ****** *)

implement
fileref_get_exnmsg
  (r, msg) = let
  var x: a
  val yn = fileref_load<a> (r, x)
in
  if yn then let
    prval () = opt_unsome (x) in x
  end else let
    prval () = opt_unnone (x) in exit_errmsg {a} (1, errmsg)
  end (* end of [if] *)
end // end of [fileref_get_exnmsg]

(* ****** ****** *)

(* end of [filebas.dats] *)
