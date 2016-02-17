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
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)

implement
atext_defname_eval
  (x0) = let
//
val loc = x0.atext_loc
//
val-
TEXTdefname
  (tok0, tok1) = x0.atext_node
//
val
name = token_strngfy(tok1)
//
val
def0 = the_atextdef_search(name)
//
in
//
case+
def0
of // case+
//
| TEXTDEFval(txt) => txt
//
| TEXTDEFnil() => let
    val errmsg =
      string_append3("##undefined(", name, ")")
    // end of [val]
  in
    atext_make_errmsg(loc, errmsg)
  end // end of [TEXTDEFnil]
| TEXTDEFfun _ => let
    val errmsg =
      string_append3("##ill-defined(", name, ")")
    // end of [val]
  in
    atext_make_errmsg(loc, errmsg)
  end // end of [TEXTDEFfun]
//
end // end of [atext_defname_eval]

(* ****** ****** *)

implement
atext_funcall_eval
  (x0) = let
//
val loc = x0.atext_loc
//
val-
TEXTfuncall
  (tok0, tok1, args) = x0.atext_node
//
val
name = token_strngfy(tok1)
//
val
def0 = the_atextdef_search(name)
//
in
//
case+
def0
of // case+
| TEXTDEFfun(ftxt) => ftxt(loc, args)
//
| TEXTDEFnil() => let
    val errmsg =
      string_append3("##undefined(", name, ")")
    // end of [val]
  in
    atext_make_errmsg(loc, errmsg)
  end // end of [TEXTDEFnil]
| TEXTDEFval _ => let
    val errmsg =
      string_append3("##ill-defined(", name, ")")
    // end of [val]
  in
    atext_make_errmsg(loc, errmsg)
  end // end of [TEXTDEFval]
//
end // end of [atext_defname_eval]

(* ****** ****** *)

(* end of [atexting_topeval.dats] *)
