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
"./../SATS/atexting.sats"
//
(* ****** ****** *)

local
//
val the_nsharp_ref = ref<int>(0)
//
in (* in-of-local *)
//
implement
the_nsharp_get() = the_nsharp_ref[]
implement
the_nsharp_set(ns) = the_nsharp_ref[] := ns
//
end // end of [local]

(* ****** ****** *)

staload
FIL = {
//
#include
"share/\
atspre_define.hats"
//
staload
"./../SATS/atexting.sats"
//
typedef T = fil_t
//
#include"\
{$LIBATSHWXI}\
/globals/HATS/gstacklst.hats"
//
implement
the_filename_get
  ((*void*)) = get_top_exn()
//
implement
the_filename_pop() = pop_exn()
implement
the_filename_push(fil) = push(fil)
//
} (* end of [staload] *)

(* ****** ****** *)

staload
PARERR = {
//
#include
"share/\
atspre_define.hats"
//
staload
"./../SATS/atexting.sats"
//
typedef T = parerr
//
staload
"prelude/DATS/list_vt.dats"
//
#include"\
{$LIBATSHWXI}\
/globals/HATS/gstacklst.hats"
//
(* ****** ****** *)
//
implement
the_parerrlst_clear() =
  list_vt_free<T>(pop_all((*void*)))
//
(* ****** ****** *)
//
implement
the_parerrlst_length() = get_size()
//
(* ****** ****** *)
//
implement
the_parerrlst_insert(err) = push(err)
//
(* ****** ****** *)
//
implement
the_parerrlst_pop_all((*void*)) = pop_all()
//
(* ****** ****** *)
//
} (* end of [staload] *)

(* ****** ****** *)

staload
TEXTDEF = {

(* ****** ****** *)
//
staload
"./../SATS/atexting.sats"
//
(* ****** ****** *)

local

typedef
key = string and itm = atextdef

implement
fprint_val<atextdef> = fprint_atextdef

in (* in-of-local *)
//
#include
"libats/ML/HATS/myhashtblref.hats"
//
end // end of [local]

implement
fprint_atextdef
  (out, def0) = (
//
case+ def0 of
| TEXTDEFnil() => fprint(out, "TEXTDEFnil()")
| TEXTDEFval _ => fprint(out, "TEXTDEFval(...)")
| TEXTDEFfun _ => fprint(out, "TEXTDEFfun(...)")
//
) (* end of [fprint_atextdef] *)

local
//
val
the_atextdef_map =
  myhashtbl_make_nil(1024)
//
in (* in-of-local *)

implement
the_atextdef_search
  (name) = let
//
val
opt =
the_atextdef_map.search(name)
//
in
//
case+ opt of
| ~Some_vt(def0) => def0
| ~None_vt((*void*)) => TEXTDEFnil()
//
end // end of [the_atextdef_search]

implement
the_atextdef_insert
  (name, def0) = let
//
val
opt =
the_atextdef_map.insert(name, def0)
//
in
//
case opt of
| ~None_vt() => () | ~Some_vt _ => ()
//
end // end of [the_atextdef_insert]

implement
the_atextdef_insert_strfun
  (name, fstr) = (
//
the_atextdef_insert
( name
, TEXTDEFfun
  (
    lam(loc, xs) =>
      atext_make_string(loc, fstr(xs))
    // end of [lam]
  )
) (* the_atextdef_insert *)
//
) (* the_atextdef_insert_strfun *)

end // end of [local]

} (* end of [staload] *)

(* ****** ****** *)

(* end of [atexting_global.dats] *)
