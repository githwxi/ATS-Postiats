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
(* Start time: the 21st of July, 2016 *)

(* ****** ****** *)
//
#include
"share\
/atspre_define.hats"
//
#include
"share\
/atspre_staload.hats"
//
#include
"share/HATS\
/atslib_staload_libc.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload $TIME // opening TIME

(* ****** ****** *)
//
staload
"utils/atexting/SATS/atexting.sats"
//
(* ****** ****** *)

local

vtypedef
res_vt = List0_vt(atext)

fun
atext2id
(
  txt: atext
) : string =
(
case+
txt.atext_node
of
| TEXTtoken(tok) => token_strngfy(tok)
| _(*rest-of-TEXT*) => "__unrecognized__"
)

fun
token2int
(tok: token): int =
g0string2int_int(token_strngfy(tok))

fun
atext2int
(txt: atext): int =
(
case+
txt.atext_node
of
| TEXTtoken(tok) => token2int(tok)
| TEXTstring(rep) => g0string2int_int(rep)
| _(*rest-of-TEXT*) => (0)
)
fun
atext2int_eval
(txt: atext): int = let
//
val txt2 =
(
case+
txt.atext_node
of // case+
| TEXTdefname _ =>
  atext_defname_eval(txt)
| TEXTfuncall _ =>
  atext_funcall_eval(txt)
| _(*rest-of-TEXT*) => txt
) : atext // end of [val]
//
in
  atext2int(txt2)
end // end of [atext2int_eval]

fun
unquote
(txt0: atext): atext =
(
//
case+
txt0.atext_node
of // case+
| TEXTsquote(txts) =>
    atext_make_list(txt0.atext_loc, txts)
| TEXTdquote(tok, txts) =>
    atext_make_list(txt0.atext_loc, txts)
| _(* non-text-quote *) => txt0
//
) (* end of [unquote] *)

fun
__auxmain__
(
  i: int, n0: int
, loc: loc_t, id: string
, body: atext, res: res_vt
) : res_vt =
(
if
(i < n0)
then let
//
val rep = g0int2string(i)
val rep = strptr2string(rep)
val rep = atext_make_string(loc, rep)
//
val def = TEXTDEFval(rep)
val
(pfpush | ()) =
the_atextstk_push1(id, def)
//
val body_i = unquote(atext_eval(body))
//
val ((*popped*)) =
  the_atextstk_pop1(pfpush | (*void*))
//
val res = list_vt_cons(body_i, res)
//
in
//
__auxmain__(i+1, n0, loc, id, body, res)
//
end // end of [then]
else res // end of [else]
) (* end of [__auxmain__] *)

fun
__int_foreach__
(
  loc: loc_t, xs: atextlst
) : atext = let
//
val-cons0(x0, xs) = xs
val id = atext2id(x0)
//
val-cons0(x1, xs) = xs
val n0 = atext2int_eval(x1)
//
val-cons0(x2, xs) = xs
//
val res = list_vt_nil()
val res = __auxmain__(0, n0, loc, id, x2, res)
val res = list_vt_reverse(res)
val res = list0_of_list_vt(res)
in
  atext_make_list(loc, res)
end // end of [__int_foreach__]

in (* in-of-local *)

val () =
the_atextmap_insert
( "int_foreach"
, TEXTDEFfun(lam(loc, xs) => __int_foreach__(loc, xs))
) (* the_atextdef_insert *)

end // end of [local]

(* ****** ****** *)

(* end of [atexting_textdef_foreach.dats] *)
