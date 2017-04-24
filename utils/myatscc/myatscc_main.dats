(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2017 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: April, 2017 *)
(* Authoremail: gmhwxiATgmailDOTcom *)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#staload UN = $UNSAFE

(* ****** ****** *)

#staload "./myatscc.sats"

(* ****** ****** *)
//
#dynload "./myatscc_loc_t.dats"
#dynload "./myatscc_lexer.dats"
#dynload "./myatscc_parser.dats"
#dynload "./myatscc_evaler.dats"
//
(* ****** ****** *)

fun
comarg_parse
(
  arg: string
) : int = let
//
fun
aux
(
 p: ptr, r: int
) : int = let
  val c = $UN.ptr0_get<char>(p)
in
//
if
isneqz(c)
then (
if c = '-'
  then aux(ptr0_succ<char>(p), r+1) else r
// end of [if]
) else (r)
// end of [if]
end // end of [aux]
//
in
  aux(string2ptr(arg), 0)
end // end of [comarg_parse]

(* ****** ****** *)
//
implement
the_name_i_env_initize
  {n}(argc, argv) = let
//
vtypedef
res = List0_vt(gvalue)
//
fun
loop
{i:nat | i <= n}
(
 i: int(i), argv: !argv(n), res: res
) : res =
(
if
(i < argc)
then let
  val arg = argv[i]
in
  if comarg_parse(arg) = 0
    then let
      val arg = GVstring(arg)
      val res = cons_vt(arg, res)
    in
      loop(i+1, argv, res)
    end // end of [then]
    else loop(i+1, argv, res)
end // end of [then]
else res (* end of [else] *)
)
//
val arg = GVstring(argv[0])
val res = list_vt_sing(arg)
val res = loop(1, argv, res)
//
in
//
the_name_i_env_initset
  (list0_of_list_vt(list_vt_reverse(res)))
//
end // end of [the_name_i_env_initize]
//
(* ****** ****** *)

implement
main0(argc, argv) = () where
{
//
val () =
println! ("Hello from [myatscc]!")
//
val
myatsccdef = MYATSCCDEF
//
val toks =
  string_tokenize(myatsccdef)
//
val exps =
  myexpseq_parse(tokenlst_tokenize(toks))
//
val exps = g0ofg1_list(exps)
//
(*
val ((*void*)) =
exps.foreach()(lam(exp) => println!(exp, ":", exp.myexp_loc))
*)
//
val ((*void*)) =
  the_myexpfun_map_initize()
val ((*void*)) =
  the_name_i_env_initize(argc, argv)
//
val ((*void*)) = println! (myexpseq_stringize(exps))
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [myatscc_main.dats] *)
