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
(* Start time: September, 2013 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*INT*) = "prelude/DATS/integer.dats"
staload _(*STRING*) = "prelude/DATS/string.dats"
staload _(*STRING*) = "prelude/DATS/strptr.dats"
staload _(*UNSAFE*) = "prelude/DATS/unsafe.dats"

(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/string.sats"
//
staload "libats/ML/SATS/filebas.sats"
//
(* ****** ****** *)

staload DIR = "libc/SATS/dirent.sats"
staload _(*anon*) = "libc/DATS/dirent.dats"

(* ****** ****** *)

staload QUE = "libats/SATS/qlist.sats"
staload _(*anon*) = "libats/DATS/qlist.dats"

(* ****** ****** *)

stadef dirent = $DIR.dirent
stadef DIRptr1 = $DIR.DIRptr1
stadef qstruct0 = $QUE.qstruct0

(* ****** ****** *)

implement
dirname_get_fnamelst
  (dirname) = let
//
vtypedef res = $QUE.qstruct0 (string)
//
fun loop
(
  dirp: !DIRptr1, res: &res >> _
) : void = let
//
var ent: dirent?
var result: ptr?
//
val err = $DIR.readdir_r (dirp, ent, result)
//
in
//
if result > 0 then let
  prval () = opt_unsome{dirent}(ent)
  val d_name = $DIR.dirent_get_d_name_gc (ent)
  val () = $QUE.qstruct_insert (res, strptr2string(d_name))
in
  loop (dirp, res)
end else let
  prval () = opt_unnone{dirent}(ent)
in
  // nothing
end // end of [if]
//
end // end of [loop]
//
val dirp = $DIR.opendir (dirname)
//
in
//
if $DIR.DIRptr2ptr(dirp) > 0 then let
  var res: $QUE.qstruct
  val () = $QUE.qstruct_initize{string}(res)
  val () = loop (dirp, res)
  val res2 = $QUE.qstruct_takeout_list (res)
  prval () = $QUE.qstruct_uninitize{string}(res)
  val () = $DIR.closedir_exn (dirp)
in
  g0ofg1_list_vt (res2)  
end else let
  prval () = $DIR.DIRptr_free_null (dirp)
in
  list0_nil(*void*)
end // end of [if]
//
end // end of [dirname_get_fnamelst]

(* ****** ****** *)

(* end of [dirent.dats] *)
