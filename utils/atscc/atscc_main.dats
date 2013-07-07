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
(* Start time: July, 2013 *)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"
staload _(*anon*) = "libc/DATS/stdlib.dats"

(* ****** ****** *)

staload "./atscc.sats"

(* ****** ****** *)

staload _(*anon*) = "./atscc_util.dats"

(* ****** ****** *)

typedef ca = commarg

(* ****** ****** *)

macdef
unsome (opt) = stropt_unsome (,(opt))
macdef
issome (opt) = stropt_is_some (,(opt))

(* ****** ****** *)

macdef
isfilsats (name) = filename_test_ext (,(name), "sats")
macdef
isfildats (name) = filename_test_ext (,(name), "dats")

(* ****** ****** *)

fun{
} argv_getopt_at
  {n:int}{i:nat}
(
  n: int n, argv: !argv(n), i: int i
) : stropt =
(
  if i < n then stropt_some (argv[i]) else stropt_none ()
) (* end of [argv_getopt_at] *)

(* ****** ****** *)

local
//
// HX: this is a bit heavy-handed, but ...
//
fun auxmain
(
  path: string, sfx: string
) : string = let
//
val
(
  fpf | base
) = filename_get_base (path)
val base2 = g1ofg0 ($UN.strptr2string (base))
val nb = string1_length (base2)
//
val (fpf2 | ext) = filename_get_ext (base2)
val isext = strptr2ptr(ext) > 0
//
#define CONE '\001'
//
val res =
(
if isext then let
//
val ne =
  string0_length ($UN.strptr2string (ext))
val len = nb+i2sz(2) // HX: 2 -> .c
//
implement
string_tabulate$fwork<>
  (i) = let
//
val i = g1ofg0(i)
val ne1 = succ (ne)
//
in
//
case+ 0 of
| _ when (i+ne1 = nb) => '_'
| _ when (i < nb) => base2[i]
| _ when (i = nb+i2sz(0)) => '.'
| _ when (i = nb+i2sz(1)) => 'c'
| _ => CONE
//
end // end of [string_tabulate$fwork]
//
in
  strnptr2string (string_tabulate(len))
end else let
//
val sfx = g1ofg0(sfx)
val nsfx = string1_length (sfx)
val len = nb+nsfx
//
implement
string_tabulate$fwork<>
  (i) = let
//
val i = g1ofg0(i) in
//
case+ 0 of
| _ when (i < nb) => base2[i]
| _ when (i < len) => let
    extern praxi
    __assert{i,j:int}
      (size_t i, size_t j): [i >= j] void
    prval () = __assert (i, nb) in sfx[i-nb]
  end // end of [_ when ...]
| _ => CONE
//
end // end of [string_tabulate$fwork]
//
in
  strnptr2string (string_tabulate(len))
end // end of [if]
) : string // end of [val]
//
prval () = fpf (base) and () = fpf2 (ext)
//
in
  res
end // end of [auxmain]

in (* in of [local] *)

implement
atscc_outname
  (flag, path) = let
in
//
if flag = 0
  then auxmain (path, "@sats.c")
  else auxmain (path, "@dats.c")
// end of [if]
//
end // end of [atscc_outname]

end // end of [local]

(* ****** ****** *)

local

fun aux0
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+2>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt =
(
  if i < n then aux1 (n, argv, i, res) else res
) // end of [aux0]

and aux1
  {n:int}
  {i:nat | i < n}
  .<3*(n-i)+1>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
//
val str0 = argv[i]
//
in
//
case+ 0 of
//
| _ when (str0="-vats") => let
      val res = list_vt_cons{ca}(CAvats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
| _ when (str0="-ccats") => let
      val res = list_vt_cons{ca}(CAccats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
| _ when (str0="-tcats") => let
      val res = list_vt_cons{ca}(CAtcats(), res)
    in
      aux0 (n, argv, i+1, res)
    end // end of [_ when ...]
//
| _ when (str0="-IATS") =>
    aux1_iats (n, argv, i+1, res)
| _ when (str0="-IIATS") =>
    aux1_iiats (n, argv, i+1, res)
//
| _ when (str0="-DATS") =>
    aux1_dats (n, argv, i+1, res)
| _ when (str0="-DDATS") =>
    aux1_ddats (n, argv, i+1, res)
//
| _ when (str0="-fsats") =>
    aux1_fsats (n, argv, i+1, res)
| _ when (str0="-fdats") =>
    aux1_fdats (n, argv, i+1, res)
//
| _ when isfilsats(str0) =>
    aux1_fsats (n, argv, i+0, res)
| _ when isfildats(str0) =>
    aux1_fdats (n, argv, i+0, res)
//
| _ => let
    val res =
      list_vt_cons{ca}(CAgitem(str0), res)
    // end of [val]
  in
    aux0 (n, argv, i+1, res)
  end // end of [_]
//
end // end of [aux1]

(* ****** ****** *)

and aux1_iats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAiats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_iats]

and aux1_iiats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAiats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_iiats]

(* ****** ****** *)

and aux1_dats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAdats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_dats]

and aux1_ddats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAdats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_ddats]

(* ****** ****** *)

and aux1_fsats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAfilats(0, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_fsats]

and aux1_fdats
  {n:int}
  {i:nat | i <= n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at (n, argv, i)
  val res = list_vt_cons{ca}(CAfilats(1, opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_fdats]

in (* in of [local] *)

implement
atsccproc
  (argc, argv) = let
//
prval (
) = lemma_argv_param (argv)
//
val res = list_vt_nil{ca}()
val res = aux0 (argc, argv, 0, res)
val res = list_vt_reverse (res)
//
in
  list_vt2t(res)
end // end of [atsccproc]

end (* end of [local] *)

(* ****** ****** *)

(* end of [atscc_main.dats] *)
