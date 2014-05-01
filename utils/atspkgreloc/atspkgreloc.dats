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

(* Author: Hongwei Xi *)
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: April, 2014 *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload
STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)
//
staload
STAT = "libc/sys/SATS/stat.sats"
staload
_(*STAT*) = "libc/sys/DATS/stat.dats"
//
typedef stat = $STAT.stat
typedef mode_t = $STAT.mode_t
//
(* ****** ****** *)

extern
fun{}
pkgreloc_dmode (): mode_t
implement{
} pkgreloc_dmode () = $UN.cast{mode_t}(0755)
extern
fun{}
pkgreloc_fmode (): mode_t
implement{
} pkgreloc_fmode () = $UN.cast{mode_t}(0644)

(* ****** ****** *)

extern
fun{
} pkgreloc
(
  source: string, target: string
) : int // end o [pkgreloc]
extern
fun{
} pkgreloc2
(
  source: string, target: string
) : int // end o [pkgreloc2]
extern
fun pkgreloc_curl
(
  source: string, target: string
) : int // end o [pkgreloc_curl]
//
extern
fun pkgreloc_fileref (inp: FILEref): void
//
(* ****** ****** *)

implement{
} pkgreloc
  (source, target) = let
//
var st: stat?
val ret = $STAT.stat (target, st)
prval ((*void*)) = opt_clear{stat}(st)
in
  if ret < 0 then pkgreloc2 (source, target) else (0)
end // end of [pkgreloc]

(* ****** ****** *)

implement{
} pkgreloc2
  (source, target) = let
//
val target = g1ofg0(target)
val dirsep = dirsep_get<> ()
//
val rindex =
  string_rindex (target, dirsep)
//
var err0: int = 0
//
val () =
if rindex >= 0 then
{
  val rindex = g1i2u (rindex)
  val tprefx =
    string_make_substring (target, i2sz(0), rindex)
  val mode = pkgreloc_dmode<> ()
  val err = $STAT.mkdirp<> ($UN.strnptr2string(tprefx), mode)
  val () = err0 := err
  val ((*freed*)) = strnptr_free (tprefx)
} (* end of [if] *) // end of [val]
//
in
  if err0 >= 0 then pkgreloc_curl (source, target) else err0
end // end of [pkgreloc2]

(* ****** ****** *)

implement
pkgreloc_curl
  (source, target) = ret where
{
//
val arglst =
$list_vt{string}
  ("curl", " ", "-o", " ", target, " ", source, " ", "2>/dev/null")
val command = stringlst_concat ($UN.castvwtp1{List(string)}(arglst))
val ((*freed*)) = free (arglst)
val ret = $STDLIB.system ($UN.strptr2string(command))
val ((*freed*)) = free (command)
//
} (* end of [pkgreloc_curl] *)

(* ****** ****** *)

local

fun
auxfind
(
  filr: FILEref, field: string
) : Strptr0 = let
//
val isnot =
  fileref_isnot_eof (filr)
//
in
//
if isnot then let
  val line = fileref_get_line_string (filr)
  val start = strstr ($UN.strptr2string (line), field)
in
  if start >= 0 then line else (free (line); auxfind (filr, field))
end else strptr_null ()
//
end // end of [auxfind]

in (* in-of-local *)

implement
pkgreloc_fileref
  (filr) = let
//
val isnot =
  fileref_isnot_eof (filr)
//
in
//
if isnot then let
//
val srcloc = "pkgreloc_source:"
val tgtloc = "pkgreloc_target:"
val source = auxfind (filr, srcloc)
val target = auxfind (filr, tgtloc)
val p0_source = strptr2ptr (source)
val p0_target = strptr2ptr (target)
//
val () =
if (p0_source > 0 && p0_target > 0) then
{
  val p2_source = ptr_add<char> (p0_source, length(srcloc))
  val p2_target = ptr_add<char> (p0_target, length(tgtloc))
  val err = pkgreloc ($UN.cast{string}(p2_source), $UN.cast{string}(p2_target))
} (* end of [if] *) // end of [val]
//
val () = free (source) and () = free (target)
//
in
  pkgreloc_fileref (filr)
end else ((*void*))
//
end // end of [pkgreloc_fileref]

end // end of [local]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
val () = pkgreloc_fileref (stdin_ref)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [atspkgreloc.dats] *)
