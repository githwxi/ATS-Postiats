(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: April, 2014
//
(* ****** ****** *)

#define ATS_PACKNAME "ATSLIB.libats.libc"
#define ATS_DYNLOADFLAG 0 // no need for staloading at run-time
#define ATS_EXTERN_PREFIX "atslib_libc_" // prefix for external names

(* ****** ****** *)
//
staload
"libats/libc/SATS/sys/stat.sats"
//
(* ****** ****** *)
//
staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

implement
{(*tmp*)}
mkdirp (path, mode) = let
//
#define NUL '\000'
val dirsep = dirsep_get<> ()
//
fun auxmk
(
  path: string, mode: mode_t
) : int = let
  var st: stat?
  val ret = stat (path, st)
  prval () = opt_clear{stat}(st)
in
  if ret < 0 then mkdir (path, mode) else 0(*isexi*)
end // end of [auxmk]
//
fnx loop
  (p0: ptr, p1: ptr): int = let
  val c = $UN.ptr0_get<char> (p1)
in
//
if (
c != NUL
) then (
  if c = dirsep
    then loop2 (p0, p1) else loop (p0, ptr_succ<char> (p1))
  // end of [if]
) else (
  auxmk ($UN.cast{string}(p0), mode)
) (* end of [if] *)
//
end // end of [loop]
//
and loop2
  (p0: ptr, p1: ptr): int = let
  val () = $UN.ptr0_set<char> (p1, NUL)
  val ret = auxmk ($UN.cast{string}(p0), mode)
  val () = $UN.ptr0_set<char> (p1, dirsep)
in
  if ret >= 0 then loop (p0, ptr_succ<char> (p1)) else ret
end // end of [loop2]
//
val path = string0_copy (path)
//
val p0 = $UN.castvwtp1{ptr}(path)
//
val c0 = $UN.ptr0_get<char> (p0)
val ret =
(
if (
c0 != NUL
) then (
  if c0 = dirsep
    then loop (p0, ptr_succ<char> (p0)) else loop (p0, p0)
  // end of [if]
) else (0)
) : int // end of [val]
//
val ((*freed*)) = strptr_free (path)
//
in
  ret
end // end of [mkdirp]

(* ****** ****** *)

(* end of [stat.dats] *)
