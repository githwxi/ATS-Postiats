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
#staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
#define
MYATSCCDEF_key "##myatsccdef="
//
(*
HX-2017-04-22:
This is the default used by [myatscc]
*)
//
#define
MYATSCCDEF_def
"patscc \
-D_GNU_SOURCE \
-DATS_MEMALLOC_LIBC -o $fname($1) $1"
//
(* ****** ****** *)
//
abstype loc_type = ptr
typedef loc_t = loc_type
//
(* ****** ****** *)
//
fun
loc_t_left(loc_t): int
fun
loc_t_right(loc_t): int
//
overload .left with loc_t_left
overload .right with loc_t_right
//
(* ****** ****** *)
//
fun
loc_t_make
  (p0: int, p1: int): loc_t
//
fun
loc_t_combine
  (x1: loc_t, x2: loc_t): loc_t
//
overload + with loc_t_combine
//
(* ****** ****** *)
//
fun
print_loc_t: loc_t -> void
and
prerr_loc_t: loc_t -> void
//
fun
fprint_loc_t: fprint_type(loc_t)
//
overload print with print_loc_t
overload prerr with prerr_loc_t
overload fprint with fprint_loc_t
//
(* ****** ****** *)
//
datatype
token_node =
//
| TOKeof of ()
//
| TOKide of string
//
| TOKint of ( int )
//
| TOKspchr of char
//
| TOKname_i of int
| TOKname_s of string
| TOKstring of string
//
where token = $rec
{
  token_loc= loc_t
, token_node= token_node
} (* end of [where] *)
//
typedef tokenlst = List0(token)
vtypedef tokenlst_vt = List0_vt(token)
//
(* ****** ****** *)
//
fun
token_eof(): token
//
(* ****** ****** *)
//
fun
token_make_ide
(
p0: int, p1: int, ide: string
) : token
//
fun
token_make_int
  (p0: int, p1: int, int: int): token
//
fun
token_make_spchr
  (p0: int, chr: char): token
//
(* ****** ****** *)
//
fun
print_token: token -> void
and
prerr_token: token -> void
//
fun
fprint_token: fprint_type(token)
//
overload print with print_token
overload prerr with prerr_token
overload fprint with fprint_token
//
(* ****** ****** *)
//
fun
string_tokenize(inp: string): tokenlst
//
(* ****** ****** *)

fun
tokenlst_tokenize(ts: List(token)): tokenlst

(* ****** ****** *)
//
datatype
myexp_node =
//
| EXPtok of token
//
| EXPname of (token)
//
| EXPfcall of (token, myexplst)
//
where
myexp = $rec
{
  myexp_loc=loc_t
, myexp_node=myexp_node
}
and myexplst = List0(myexp)
//
(* ****** ****** *)
//
fun
myexp_tok(token): myexp
fun
myexp_name(token): myexp
//
(* ****** ****** *)
//
fun
print_myexp: myexp -> void
and
prerr_myexp: myexp -> void
//
fun
fprint_myexp: fprint_type(myexp)
fun
fprint_myexplst: fprint_type(List(myexp))
//
overload print with print_myexp
overload prerr with prerr_myexp
overload fprint with fprint_myexp
overload fprint with fprint_myexplst of 10
//
(* ****** ****** *)
//
fun
myexpseq_parse(tokenlst): myexplst
//
(* ****** ****** *)
//
fun
the_name_i_env_get
  ((*void*)): list0(gvalue)
fun
the_name_i_env_initset
  (xs: list0(gvalue)): void
//
fun
the_name_i_env_initize
  {n:pos}
  (argc: int(n), argv: !argv(n)): void
//
(* ****** ****** *)
//
abstype
myexpfun_type = ptr
//
typedef
myexpfun = myexpfun_type
//
local
//
assume
myexpfun_type =
  (List(gvalue)) -<cloref1> gvalue
//
in
  // nothing
end // end of [local]
//
(* ****** ****** *)
//
fun
the_myexpfun_map_insert
  (name: string, fdef: myexpfun): void
//
fun
the_myexpfun_map_initize((*void*)): void
//
(* ****** ****** *)
//
fun
myexp_stringize(myexp): string
fun
myexpseq_stringize(list0(myexp)): string
//
(* ****** ****** *)
//
fun
myatscc_getdef((*void*)): string
fun
myatscc_evaldef((*void*)): string
//
fun
myatscc_main
  {n:pos}
  (argc: int(n), argv: !argv(n)): int
//
(* ****** ****** *)

(* end of [myatscc.sats] *)
