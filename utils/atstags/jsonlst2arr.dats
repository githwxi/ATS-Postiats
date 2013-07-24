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

staload "json-c/SATS/json.sats"
staload _ = "json-c/DATS/json.dats"

(* ****** ****** *)

datatype
commarg =
  | CAinput of ()
  | CAoutput of stropt
  | CAdelim of stropt
  | CAgitem of string
// end of [commarg]

(* ****** ****** *)

vtypedef commarglst = List0 (commarg)
vtypedef commarglst_vt = List0_vt (commarg)

(* ****** ****** *)

macdef
unsome (opt) = stropt_unsome (,(opt))
macdef
issome (opt) = stropt_is_some (,(opt))

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
//
extern
fun jsonlst2arr_commline
  {n:int} (argc: int n, argv: !argv(n)): commarglst
// 
(* ****** ****** *)

local

typedef ca = commarg

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
| _ when (str0="-i") =>
    aux1_input (n, argv, i, res)
| _ when (str0="--input") =>
    aux1_input (n, argv, i, res)
//
| _ when (str0="-o") =>
    aux1_output (n, argv, i+1, res)
| _ when (str0="--output") =>
    aux1_output (n, argv, i+1, res)
//
| _ when (str0="--delim") =>
    aux1_delim (n, argv, i+1, res)
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

and aux1_input
  {n:int}
  {i:nat | i < n}
  .<3*(n-i)+0>.
(
  n: int n
, argv: !argv(n)
, i: int i
, res: commarglst_vt
) : commarglst_vt = let
  val res =
    list_vt_cons{ca}(CAinput(), res)
  // end of [val]
in
  aux0 (n, argv, i+1, res)
end // end of [aux1_input]

and aux1_output
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
  val res = list_vt_cons{ca}(CAoutput(opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_output]

and aux1_delim
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
  val res = list_vt_cons{ca}(CAdelim(opt), res)
in
  if i < n then aux0 (n, argv, i+1, res) else res
end // end of [aux1_delim]

in (* in of [local] *)

implement
jsonlst2arr_commline
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
end // end of [jsonlst2arr_commline]

end // end of [local]

(* ****** ****** *)

extern
fun jsonlst2arr_exec (cas: commarglst): void

(* ****** ****** *)

typedef
param = @{
, out= stropt
, inplst= stringlst
, delim= stropt
, nexec= int
} (* end of [param] *)

implement
jsonlst2arr_exec (cas) = let
//
fun auxexec
(
  param: &param
) : void = let
//
val out = param.out
val inplst = param.inplst
val () = param.inplst := list_nil ()
val delim = param.delim
val nexec = param.nexec
val () = param.nexec := nexec + 1
//
val () = println! ("auxexec: out= ", out)
val () = println! ("auxexec: inplst= ", inplst)
val () = println! ("auxexec: delim= ", delim)
val () = println! ("auxexec: nexec= ", nexec)
//
in
end // end of [auxexec]
//
fun auxlst
(
  param: &param, cas0: commarglst
) : void = let
in
//
case+ cas0 of
| list_cons
    (ca, cas) =>
  (
    case+ ca of
    | CAinput() => auxlst_input (param, cas)
    | CAoutput(opt) => let
        val () = param.out := opt in auxlst (param, cas)
      end // end of [CAoutput]
    | CAdelim(opt) => let
        val () = param.delim := opt in auxlst (param, cas)
      end // end of [CAoutput]
    | CAgitem(str) => auxlst (param, cas)
  )
| list_nil () => auxexec (param)
//
end // end of [auxlst]
//
and auxlst_input
(
  param: &param, cas0: commarglst
) : void = let
in
//
case+ cas0 of
| list_cons
    (ca, cas) =>
  (
    case+ ca of
    | CAgitem (str) => let
        val () =
        param.inplst :=
          list_cons{string}(str, param.inplst)
        // end of [val]
      in
        auxlst_input (param, cas)
      end // end of [CAgitem]
    | _ => let
        val () = auxexec (param) in auxlst (param, cas0)
      end // end of [auxlst_input]
  )
| list_nil () => auxexec (param)
//
end // end of [auxlst_input]
//
var param: param
val () = param.out := stropt_none ()
val () = param.inplst := list_nil ()
val () = param.delim := stropt_none ()
val () = param.nexec := 0
//
in
  auxlst (param, cas)
end // end of [jsonlst2arr_exec]

(* ****** ****** *)

implement
main0 (argc, argv) =
{
//
var status: int = 0
//
val cas =
  jsonlst2arr_commline (argc, argv)
val ((*void*)) = jsonlst2arr_exec (cas)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [jsonlst2arr.dats] *)
