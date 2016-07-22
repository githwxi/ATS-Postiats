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

implement
fprint_val<atextdef> = fprint_atextdef

(* ****** ****** *)

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

(* ****** ****** *)
//
implement
the_atextdef_search
  (k0) =
(
  the_atextmap_search(k0)
)
//
(* ****** ****** *)

implement
the_atextdef_search2
  (k0) = let
//
val def =
  the_atextstk_search(k0)
//
in
//
case+ def of
| TEXTDEFnil() =>
  the_atextdef_search(k0)
| _(*non-TEXTDEFnil*) => def
//
end // end of [the_atextdef_search2]

(* ****** ****** *)

local
//
typedef
key = string
and
itm = atextdef
//
vtypedef
keyitmlst_vt =
  List0_vt@(key, itm)
//
typedef
mystack = ref(keyitmlst_vt)
//
val
the_atextstk =
  ref<keyitmlst_vt>(list_vt_nil)
//
assume
the_atextstk_v(n:int) = unit_v
//
in (* in-of-local *)
//
implement
the_atextstk_pop1
  (pf | (*void*)) = () where
{
//
prval unit_v() = pf
//
val
(vbox pf | p0) =
ref_get_viewptr(the_atextstk)
//
val-
~list_vt_cons(_, kxs) = !p0
val ((*void*)) = (!p0 := kxs)
//
} (* end of [the_atextstk_pop] *)
//
implement
the_atextstk_push1
  (k, x) = (unit_v | ()) where
{
//
val
(vbox pf | p0) =
ref_get_viewptr(the_atextstk)
//
val kxs = !p0
val ((*void*)) =
  (!p0 := list_vt_cons((k, x), kxs))
//
} (* end of [the_atextstk_pop] *)
//
implement
the_atextstk_search
  (k0) = let
//
fun
loop
(
  kxs: !keyitmlst_vt
) : itm =
(
case+ kxs of
| list_vt_nil
    () => TEXTDEFnil()
  // list_vt_nil
| @list_vt_cons(kx, kxs_) =>
  (
    if k0 = kx.0
      then let val res = kx.1 in fold@(kxs); res end
      else (
        let val res = loop(kxs_) in fold@(kxs); res end
      ) (* else *)
    // end of [if]
  ) (* end of [list_vt_cons] *)
)
//
val
(vbox pf | p0) =
ref_get_viewptr(the_atextstk)
//
in
  $effmask_ref(loop(!p0))
end // end of [the_atextstk_search]
//
end // end of [local]

(* ****** ****** *)

local

typedef
key = string and itm = atextdef

in (* in-of-local *)
//
#include "libats/ML/HATS/myhashtblref.hats"
//
end // end of [local]

(* ****** ****** *)

local
//
val
the_atextmap =
  myhashtbl_make_nil(1024)
//
in (* in-of-local *)

implement
the_atextmap_search
  (k0) = let
//
val
opt =
the_atextmap.search(k0)
//
in
//
case+ opt of
| ~Some_vt(def0) => def0
| ~None_vt((*void*)) => TEXTDEFnil()
//
end // end of [the_atextdef_search]

implement
the_atextmap_insert
  (k0, def0) = let
//
val
opt =
the_atextmap.insert(k0, def0)
//
in
//
case opt of
| ~None_vt() => () | ~Some_vt _ => ()
//
end // end of [the_atextmap_insert]

implement
the_atextmap_insert_fstring
  (k0, fstr) = (
//
the_atextmap_insert
( k0
, TEXTDEFfun
  (
    lam(loc, xs) =>
      atext_make_string(loc, fstr(xs))
    // end of [lam]
  )
) (* the_atextmap_insert *)
//
) (* the_atextmap_insert_fstring *)

end // end of [local]

} (* end of [staload] *)

(* ****** ****** *)

(* end of [atexting_global.dats] *)
