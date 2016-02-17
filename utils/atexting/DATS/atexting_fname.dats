(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)
//
datatype
filename = FNAME of (string)
//
assume filename_type = filename
//
(* ****** ****** *)

implement
filename_dummy = FNAME ("")
implement
filename_stdin = FNAME ("__STDIN__")

(* ****** ****** *)

implement
filename_make(path) = FNAME(path)

(* ****** ****** *)

implement
fprint_filename
  (out, fil) = let
//
val+FNAME (fname) = fil
//
in
  fprint_string (out, fname)
end // end of [fprint_filename]

(* ****** ****** *)

(* end of [atexting_fname.dats] *)
