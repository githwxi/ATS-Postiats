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

#define
ATS_PACKNAME "ATEXTING"

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
//
(* ****** ****** *)
//
staload
DA =
"libats/SATS/dynarray.sats"
//
stadef dynarray = $DA.dynarray
//
(* ****** ****** *)
//
staload
SBF =
"libats/SATS/stringbuf.sats"
//
stadef stringbuf = $SBF.stringbuf
//
(* ****** ****** *)
//
staload
CS0 =
"{$LIBATSHWXI}\
/cstream/SATS/cstream.sats"
//
vtypedef cstream = $CS0.cstream
//
(* ****** ****** *)
//
abstype
filename_type = ptr
typedef
filename = filename_type
typedef fil_t = filename
//
val filename_dummy : fil_t
val filename_stdin : fil_t
//
fun
filename_make(path: string): fil_t
//
fun
fprint_filename : fprint_type(fil_t)
//
overload fprint with fprint_filename
//
(* ****** ****** *)
//
fun the_filename_get((*void*)): fil_t
//
fun the_filename_pop((*void*)): fil_t
fun the_filename_push(fil: fil_t): void
//
(* ****** ****** *)
//
typedef
position =
@{
, pos_ntot= int
, pos_nrow= int
, pos_ncol= int
} (* end of [position] *)
//
fun
fprint_position
(
  out: FILEref, pos: &position
) : void // end-of-function
//
overload fprint with fprint_position
//
fun position_byrow(&position >> _): void
//
fun position_incby_1(&position >> _): void
fun position_incby_n(&position >> _, n: intGte(0)): void
fun position_decby_n(&position >> _, n: intGte(0)): void
//
overload .incby with position_incby_1
overload .incby with position_incby_n
//
overload .decby with position_decby_n
//
(* ****** ****** *)

fun position_incby_char(&position >> _, c: int): void

(* ****** ****** *)
//
abstype
location_type = ptr
typedef
location = location_type
typedef loc_t = location
//
val location_dummy : loc_t
//
fun
fprint_location : fprint_type(loc_t)
//
overload fprint with fprint_location
//
fun
fprint_locrange : fprint_type(loc_t)
//
(* ****** ****** *)
//
fun
location_is_atlnbeg(loc: loc_t): bool
//
(* ****** ****** *)
//
fun
location_make_pos_pos
  (pos1: &position, pos2: &position): loc_t
fun
location_make_fil_pos_pos
  (fil: fil_t, pos1: &position, pos2: &position): loc_t
//
(* ****** ****** *)

fun location_leftmost(loc0: loc_t): loc_t
fun location_rightmost(loc0: loc_t): loc_t

(* ****** ****** *)
//
fun
location_combine (loc1: loc_t, loc2: loc_t): loc_t
//
(* ****** ****** *)
//
datatype
token_node =
//
| TOKeol of ()
| TOKeof of ()
//
| TOKint of (string)
//
| TOKide of (string)
//
| TOKspchr of (int)
| TOKbslash of (int)
//
| TOKspace of (string)
//
| TOKsharp of (string)
//
| TOKsquote of ()
| TOKdquote of (string)
//
| TOKcode_beg of (string)
| TOKcode_end of (string)
//
where
token = $rec{
  token_loc= loc_t
, token_node= token_node
} (* end of [token] *)
//
and tokenlst = list0(token)
//
(* ****** ****** *)
//
typedef tnode = token_node
typedef tokenopt = Option(token)
//
(* ****** ****** *)
//
fun token_get_loc(token): loc_t
//
fun token_make(loc_t, tnode): token
//
(* ****** ****** *)

fun token_is_eof(tok: token): bool

(* ****** ****** *)
//
fun the_nsharp_get((*void*)): int
fun the_nsharp_set(nsharp: int): void
//
fun token_is_nsharp(tok: token): bool
//
(* ****** ****** *)

fun token_is_code_beg(tok: token): bool
fun token_is_code_end(tok: token): bool

(* ****** ****** *)

fun token_is_atlnbeg(tok: token): bool

(* ****** ****** *)
//
fun
fprint_token : fprint_type(token)
fun
fprint_tnode : fprint_type(tnode)
fun
fprint_tokenlst : fprint_type(tokenlst)
//
overload fprint with fprint_token
overload fprint with fprint_tokenlst
//
(* ****** ****** *)
//
vtypedef
_lexbuf_vt0ype =
@{
//
lexbuf_ntot= int
,
lexbuf_nrow= int
,
lexbuf_ncol= int
//
,
lexbuf_nspace= int
//
,
//
lexbuf_cstream= cstream
//
,
lexbuf_nback= int
,
lexbuf_stringbuf= stringbuf
//
} // end of [_lexbuf_vt0ype]

(* ****** ****** *)
//
absvt@ype
lexbuf_vt0ype = _lexbuf_vt0ype
//
vtypedef lexbuf = lexbuf_vt0ype
//
(* ****** ****** *)
//
fun
lexbuf_initize_string
(
  buf: &lexbuf? >> _, inp: string
) : void // end-of-function
//
fun
lexbuf_initize_fileref
(
  buf: &lexbuf? >> _, inp: FILEref
) : void // end-of-function
//
(* ****** ****** *)

fun
lexbuf_uninitize(buf: &lexbuf >> _?): void

(* ****** ****** *)
//
fun
lexbuf_get_position
(
  buf: &RD(lexbuf), pos: &position? >> _
) : void // end-of-function
//
fun
lexbuf_set_position
(
  buf: &lexbuf >> _, pos0: &RD(position)
) : void // end-of-function

(* ****** ****** *)
//
fun
lexbuf_set_nback(buf: &lexbuf, nb: int): void
fun
lexbuf_incby_nback(buf: &lexbuf, nb: int): void
//
(* ****** ****** *)
//
fun
lexbuf_get_nspace (buf: &lexbuf): int
fun
lexbuf_set_nspace (buf: &lexbuf, n: int): void
//
(* ****** ****** *)
//
fun
lexbuf_remove
  (buf: &lexbuf >> _, nchr: intGte(0)): void
//
fun lexbuf_remove_all (buf: &lexbuf >> _): void
//
(* ****** ****** *)
//
fun
lexbuf_takeout
  (buf: &lexbuf >> _, nchr: intGte(0)): Strptr1
//
(* ****** ****** *)
//
fun
lexbuf_get_char (buf: &lexbuf >> _): int
//
(* ****** ****** *)
//
fun
lexbuf_get_token (buf: &lexbuf >> _): token
//
(* ****** ****** *)
//
fun
lexbufpos_get_location(buf: &lexbuf, pos: &position) : loc_t
//
fun
lexbuf_getbyrow_location(buf: &lexbuf): loc_t
fun
lexbuf_getincby_location(buf: &lexbuf, nchr: intGte(0)): loc_t
//
(* ****** ****** *)
//
fun
lexing_INTEGER(buf: &lexbuf): token
//
fun
lexing_IDENT_alp(buf: &lexbuf): token
//
(* ****** ****** *)

vtypedef
_tokbuf_vt0ype =
@{
//
  tokbuf_tkbf= dynarray(token)
, tokbuf_ntok= size_t, tokbuf_lxbf= lexbuf
//
} (* end of [_tokbuf_vt0ype] *)

(* ****** ****** *)
//
absvt@ype
tokbuf_vt0ype = _tokbuf_vt0ype
//
vtypedef tokbuf = tokbuf_vt0ype
//
(* ****** ****** *)
//
fun
tokbuf_initize_string
  (buf: &tokbuf? >> _, inp: string): void
fun
tokbuf_initize_fileref
  (buf: &tokbuf? >> _, inp: FILEref): void
//
(* ****** ****** *)

fun tokbuf_reset (buf: &tokbuf >> _): void

(* ****** ****** *)

fun tokbuf_uninitize (buf: &tokbuf >> _?): void

(* ****** ****** *)
//
fun
tokbuf_get_ntok (buf: &tokbuf >> _): size_t
fun
tokbuf_set_ntok (buf: &tokbuf >> _, ntok: size_t): void
//
(* ****** ****** *)

fun
tokbuf_incby_1 (buf: &tokbuf >> _): void
fun
tokbuf_incby_n (buf: &tokbuf >> _, n: size_t): void
fun
tokbuf_decby_n (buf: &tokbuf >> _, n: size_t): void

(* ****** ****** *)
//
fun
tokbuf_get_token (buf: &tokbuf >> _): token
//
fun
tokbuf_getinc_token (buf: &tokbuf >> _): token
//
(* ****** ****** *)
//
fun
tokbuf_get_location (buf: &tokbuf >> _): loc_t
//
(* ****** ****** *)
//
datatype
atext_node =
//
| TEXTnil of ()
//
| TEXTtoken of token
//
(*
| TEXTchar of (char)
*)
//
| TEXTstring of (string)
//
| TEXTerrmsg of (string)
//
| TEXTlist of (atextlst)
//
| TEXTsquote of (atextlst)
| TEXTdquote of (token(*dquote*), atextlst)
//
| TEXTextcode of (token(*beg*), atextlst, token(*end*))
//
| TEXTdefname of (token(*sharp*), token(*name*))
//
| TEXTfuncall of (token(*sharp*), token(*name*), atextlst(*arg*))
//
where
atext = $rec{
  atext_loc= loc_t
, atext_node= atext_node
} (* end of [atext] *)
//
and atextlst = list0(atext)
//
(* ****** ****** *)

typedef atextopt = Option(atext)

(* ****** ****** *)
//
fun
atext_make
(
  loc: loc_t, node: atext_node
) : atext // end-of-function
//
fun
atext_make_nil(loc_t): atext
//
fun
atext_make_token(tok: token): atext
//
fun
atext_make_list(loc_t, xs: atextlst): atext
//
fun
atext_make_string(loc_t, str: string): atext
//
fun
atext_make_errmsg(loc_t, msg: string): atext
//
fun
atext_make_squote(loc_t, xs: atextlst): atext
fun
atext_make_dquote(loc_t, token, xs: atextlst): atext
//
(* ****** ****** *)
//
fun
fprint_atext : fprint_type(atext)
fun
fprint_atextlst : fprint_type(atextlst)
//
overload fprint with fprint_atext
overload fprint with fprint_atextlst of 10
//
(* ****** ****** *)
//
fun
token_strngfy(tok: token): string
fun
atext_strngfy(txt: atext): string
fun
atextlst_strngfy(txts: atextlst): string
//
(* ****** ****** *)
//
fun
token_topeval(out: FILEref, tok: token): void
//
fun
atext_topeval(out: FILEref, txt: atext): void
fun
atextlst_topeval(out: FILEref, txts: atextlst): void
//
(* ****** ****** *)
//
datatype
parerr_node =
//
| PARERR_SQUOTE of loc_t
| PARERR_DQUOTE of loc_t
| PARERR_FUNARG of loc_t
| PARERR_EXTCODE of loc_t
//
typedef
parerr = $rec{
  parerr_loc= loc_t, parerr_node= parerr_node
} (* end of [parerr] *)
//
typedef parerrlst = list0(parerr)
//
(* ****** ****** *)
//
fun
parerr_make
  (loc: loc_t, node: parerr_node): parerr
//
(* ****** ****** *)
//
fun fprint_parerr : fprint_type(parerr)
fun fprint_parerrlst : fprint_type(parerrlst)
//
overload fprint with fprint_parerr
overload fprint with fprint_parerrlst
//
(* ****** ****** *)
//
fun
the_parerrlst_clear(): void
//
fun
the_parerrlst_length(): intGte(0)
//
fun
the_parerrlst_insert(parerr): void
fun
the_parerrlst_insert2(loc_t, parerr_node): void
//
fun
the_parerrlst_pop_all((*void*)): List0_vt(parerr)
//
fun
the_parerrlst_print_free((*void*)): int(*nerr*)
//
(* ****** ****** *)
//
fun
parsing_atext0(buf: &tokbuf >> _): atext
fun
parsing_atext1(buf: &tokbuf >> _): atext
//
fun
parsing_atext_top(buf: &tokbuf >> _): atext
//
(* ****** ****** *)
//
fun
parsing_toplevel(buf: &tokbuf >> _): atextlst
//
(* ****** ****** *)
//
fun
parsing_from_stdin((*void*)): atextlst
fun
parsing_from_filename(path: string): atextlst
//
fun
parsing_from_fileref(infil: FILEref): atextlst
//
(* ****** ****** *)
//
datatype
atextdef =
| TEXTDEFnil of ()
| TEXTDEFval of (atext)
| TEXTDEFfun of
    ((loc_t, atextlst) -<cloref1> atext)
  // TEXTDEFfun
//
(* ****** ****** *)
//
fun
fprint_atextdef
  (FILEref, def0: atextdef): void
//
(* ****** ****** *)
//
fun
atext_eval(txt: atext): atext
fun
atextlst_eval(txts: atextlst): atextlst
//
fun
atext_defname_eval(txt: atext): atext
fun
atext_funcall_eval(txt: atext): atext
//  
(* ****** ****** *)
//
// HX-2016-07-21:
// Only map-search
//
fun
the_atextdef_search
  (name: string): atextdef
//
// HX-2016-07-21:
// (stack+map)-search
//
fun
the_atextdef_search2
  (name: string): atextdef
//
(* ****** ****** *)
//
absview
the_atextstk_v(int)
//
fun
the_atextstk_pop1
(
  the_atextstk_v(1) | (*void*)
) : void
fun
the_atextstk_push1
(
  k0: string, itm: atextdef
) : (the_atextstk_v(1) | void)
//
fun
the_atextstk_search
  (name: string): atextdef
//
(* ****** ****** *)
//
fun
the_atextmap_insert
  (k0: string, def: atextdef) : void
//
fun
the_atextmap_insert_fstring
  (k0: string, fstr: (atextlst) -> string): void
//
(* ****** ****** *)
//
fun
the_atextmap_remove(k0: string): void
//
fun
the_atextmap_search(k0: string): atextdef
//
(* ****** ****** *)
//
// For command-lines
//
(* ****** ****** *)
//
datatype
commarg =
//
  | CAhelp of string
//
  | CAgitem of string
//
  | CAnsharp of (string, option0(string))
//
  | CAinpfil of (string, option0(string))
//
  | CAoutfil of (string, option0(string))
//
(* ****** ****** *)
//
typedef
commarglst = list0(commarg)
//
(* ****** ****** *)
//
fun
fprint_commarg : fprint_type(commarg)
fun
fprint_commarglst : fprint_type(commarglst)
//
overload fprint with fprint_commarg
overload fprint with fprint_commarglst
//
(* ****** ****** *)
//
fun
commarglst_parse
  {n:int | n > 0}
  (n: int(n), argv: !argv(n)): commarglst
//
(* ****** ****** *)

(* end of [atexting.sats] *)
