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

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
//
staload
"libats/ML/SATS/list0.sats"
staload _ =
"libats/ML/DATS/list0.dats"
//
staload
"libats/ML/SATS/string.sats"
staload _ =
"libats/ML/DATS/string.dats"
//
staload
"libats/ML/SATS/option0.sats"
staload _ =
"libats/ML/DATS/option0.dats"
//
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
) : option0(string) =
(
  if i < n then Some0(argv[i]) else None0()
) (* end of [argv_getopt_at] *)

(* ****** ****** *)

vtypedef
commarglst_vt = List0_vt(commarg)

(* ****** ****** *)

local
//
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
  string_is_prefix("--nsharp=", x0)
//
fun
is_i
(
  x0: string
) : bool = (x0 = "-i")
fun
is_input
(
  x0: string
) : bool = (x0 = "--input")
fun
is_input_eq
(
  x0: string
) : bool =
  string_is_prefix("--input=", x0)
//
fun
is_o
(
  x0: string
) : bool = (x0 = "-o")
fun
is_output
(
  x0: string
) : bool = (x0 = "--output")
fun
is_output_eq
(
  x0: string
) : bool =
  string_is_prefix("--output=", x0)
//
fun
aftereq_get_arg
(
  x0: string
) : option0(string) = let
//
#define NUL '\000'
//
fun
aux
(
  p: ptr
) : option0(string) = let
//
val c =
  $UN.ptr0_get<char>(p)
val p1 = ptr_succ<char>(p)
//
in
//
if
c = '='
then (
  Some0(string_copy($UN.cast{string}(p1)))
) else (
  if c != NUL then aux(p1) else None0(*void*)
) (* end of [if] *)
//
end // end of [aux]
//
in
  aux(string2ptr(x0))
end // end of [nsharp_get_arg]

in (* in-of-local *)

implement
commarglst_parse
  {n}(n, argv) = let
//
fun
aux{i:nat}
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
//
| _ when
    is_ns(arg) =>
    aux_nsharp(i, argv, res)
| _ when
    is_nsharp(arg) =>
    aux_nsharp(i, argv, res)
| _ when
    is_nsharp_eq(arg) =>
    aux_nsharp_eq(i, argv, res)
//
| _ when
    is_i(arg) =>
    aux_inpfil(i, argv, res)
| _ when
    is_input(arg) =>
    aux_inpfil(i, argv, res)
| _ when
    is_input_eq(arg) =>
    aux_inpfil_eq(i, argv, res)
//
| _ when
    is_o(arg) =>
    aux_outfil(i, argv, res)
| _ when
    is_output(arg) =>
    aux_outfil(i, argv, res)
| _ when
    is_output_eq(arg) =>
    aux_outfil_eq(i, argv, res)
//
| _ when
    (arg = "-h") => let
    val res =
    cons_vt(CAhelp(arg), res)
  in
    aux(i+1, argv, res)
  end // end of [rest-of-kind]
| _ when
    (arg = "--help") => let
    val res =
    cons_vt(CAhelp(arg), res)
  in
    aux(i+1, argv, res)
  end // end of [rest-of-kind]    
//
| _(* rest *) => let
    val res =
    cons_vt(CAgitem(arg), res)
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
  var arg = argv[i]
  val opt =
    argv_getopt_at(n, argv, i+1)
  val res =
    list_vt_cons(CAnsharp(arg, opt), res)
  // end of [val]
in
  aux(i+2, argv, res)  
end // end of [aux_nsharp]
and
aux_nsharp_eq
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
//
  var arg = argv[i]
  val opt = aftereq_get_arg(arg)
  val res =
    list_vt_cons(CAnsharp(arg, opt), res)
  // end of [val]
in
  aux(i+1, argv, res)  
end // end of [aux_nsharp_eq]
//
and
aux_inpfil
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
  var arg = argv[i]
  val opt =
    argv_getopt_at(n, argv, i+1)
  val res =
    list_vt_cons(CAinpfil(arg, opt), res)
  // end of [val]
in
  aux(i+2, argv, res)  
end // end of [aux_inpfil]
and
aux_inpfil_eq
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
//
  var arg = argv[i]
  val opt = aftereq_get_arg(arg)
  val res =
    list_vt_cons(CAinpfil(arg, opt), res)
  // end of [val]
in
  aux(i+1, argv, res)  
end // end of [aux_inpfil_eq]
//
and
aux_outfil
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
  var arg = argv[i]
  val opt =
    argv_getopt_at(n, argv, i+1)
  val res =
    list_vt_cons(CAoutfil(arg, opt), res)
  // end of [val]
in
  aux(i+2, argv, res)  
end // end of [aux_outfil]
and
aux_outfil_eq
  {i:nat | i < n}
(
  i: int(i)
, argv: !argv(n), res: commarglst_vt
) : commarglst_vt = let
//
  var arg = argv[i]
  val opt = aftereq_get_arg(arg)
  val res =
    list_vt_cons(CAoutfil(arg, opt), res)
  // end of [val]
in
  aux(i+1, argv, res)  
end // end of [aux_outfil_eq]
//
val
arg0 = CAgitem(argv[0])
//
val res =
  aux(1, argv, list_vt_sing(arg0))
//
in
  list0_of_list_vt(list_vt_reverse(res))
end // end of [commarglst_parse]

end // end of [local]

(* ****** ****** *)
//
extern
fun{}
fprint_commarg_
  (FILEref, arg: commarg): void
//
(* ****** ****** *)

#ifdef
CODEGEN2
#then
#codegen2
(
"fprint", commarg, fprint_commarg_
)
#else
//
#include
"./atexting_fprint_commarg.hats"
//
implement
fprint_val<commarg> = fprint_commarg
//
implement
fprint_commarg(out, x) = fprint_commarg_<>(out, x)
implement
fprint_commarglst
  (out, xs) =
  fprint_list_sep<commarg>(out, $UN.cast{List0(commarg)}(xs), ", ")
//
#endif // #ifdef

(* ****** ****** *)

(* end of [atexting_commarg.dats] *)
