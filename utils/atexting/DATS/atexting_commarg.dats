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

staload
"libats/ML/SATS/string.sats"
staload _ =
"libats/ML/DATS/string.dats"

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)

fun{}
argv_getopt_at
  {n:int}{i:nat}
(
  n: int n, argv: !argv(n), i: int i
) : Option(string) =
(
  if i < n then Some(argv[i]) else None()
) (* end of [argv_getopt_at] *)

(* ****** ****** *)

vtypedef
commarglst_vt = List0_vt(commarg)

(* ****** ****** *)

local

fun
is_ns
(
  x0: string
) : bool = (x0 = "-ns")
fun
is_nsharp
(
  x0: string
) : bool = (x0 = "--nsharp")
fun
is_nsharp_eq
(
  x0: string
) : bool =
  string_is_prefix("--nsharp=")

in (* in-of-local *)

implement
commarglst_parse
  {n}(n, argv) = let
//
fun
aux
{i:nat | i <= n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt =
(
if
i < n
then let
//
val arg = argv[i]
//
in
//
case+ 0 of
| _ when
    is_ns(arg) =>
    aux_nsharp(i, argv, res)
| _ when
    is_nsharp(arg) =>
    aux_nsharp(i, argv, res)
| _(* rest *) => let
    val res =
    list_vt_cons
      (CAgitem(arg), res)
    // end of [val]
  in
    aux(i+1, argv, res)
  end // end of [rest-of-kind]
//
end // end of [then]
else res // end of [else]
//
) (* end of [aux] *)
//
and
aux_nsharp
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
  val opt = argv_getopt_at(argv, i+1)
  val res = list_vt_cons(CAnsharp(opt), res)

//
val res =
  aux(0, argv, list_vt_nil(*void*))
//
in
  list0_of_list_vt(list_vt_reverse(res))
end // end of [commarglst_parse]

end // end of [local]

(* ****** ****** *)

(* end of [atexting_commarg.dats] *)
