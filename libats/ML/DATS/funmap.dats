(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2010-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Start time: August, 2013 *)

(* ****** ****** *)
//
// HX-2012-12:
// the map implementation is based on AVL trees
//
(* ****** ****** *)
//
staload FM =
"libats/SATS/funmap_avltree.sats"
//
(* ****** ****** *)

staload "libats/ML/SATS/list0.sats"

(* ****** ****** *)

staload "libats/ML/SATS/funmap.sats"

(* ****** ****** *)
//
assume
map_type(key, itm) = $FM.map (key, itm)
//
(* ****** ****** *)

implement{a}
compare_key_key = gcompare_val_val<a>
implement{a}
$FM.compare_key_key = compare_key_key<a>

(* ****** ****** *)

implement
{}(*tmp*)
funmap_nil() = $FM.funmap_nil<>()
implement
{}(*tmp*)
funmap_make_nil() = $FM.funmap_make_nil<>()

(* ****** ****** *)

implement
{}(*tmp*)
funmap_is_nil(map) = $FM.funmap_is_nil<>(map)
implement
{}(*tmp*)
funmap_isnot_nil(map) = $FM.funmap_isnot_nil<>(map)

(* ****** ****** *)
//
implement
{key,itm}
funmap_size
  (map) = $FM.funmap_size<key,itm>(map)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_search
  (map, k) =
  $FM.funmap_search_opt<key,itm>(map, k)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_insert
  (map, k, x) =
  $FM.funmap_insert_opt<key,itm>(map, k, x)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_takeout
  (map, k) =
  $FM.funmap_takeout_opt<key,itm>(map, k)
//
(* ****** ****** *)
//
implement
{key,itm}
funmap_remove
  (map, k) = $FM.funmap_remove<key,itm>(map, k)
//
(* ****** ****** *)

implement
{key,itm}
fprint_funmap
  (out, map) = let
//
implement
$FM.fprint_funmap$sep<> = fprint_funmap$sep<>
implement
$FM.fprint_funmap$mapto<> = fprint_funmap$mapto<>
//
val () = $FM.fprint_funmap<key,itm>(out, map)
//
in
  // nothing
end // end of [fprint_funmap]

(* ****** ****** *)

implement{}
fprint_funmap$sep(out) = fprint(out, "; ")
implement{}
fprint_funmap$mapto(out) = fprint(out, "->")

(* ****** ****** *)

implement
{key,itm}
funmap_foreach_cloref
  (map, fwork) = () where
{
//
var env: void = ((*void*))
//
implement
(env)(*tmp*)
$FM.funmap_foreach$fwork<key,itm><env>
  (k, x, env) = fwork(k, x)
//
val ((*void*)) =
$FM.funmap_foreach_env<key,itm><void>(map, env)
//
} (* end of [funmap_foreach_cloref] *)

(* ****** ****** *)
//
implement
{key,itm}
funmap_listize
  (map) =
(
$effmask_wrt
(
list0_of_list_vt
  ($FM.funmap_listize<key,itm>(map))
)
) (* end of [funmap_listize] *)
//
(* ****** ****** *)

implement
{key,itm}
funmap_streamize
  (map) =
(
$effmask_wrt
  ($FM.funmap_streamize<key,itm>(map))
) (* end of [funmap_streamize] *)

(* ****** ****** *)
//
implement
{key,itm}
funmap_make_module
  ((*void*)) = $rec
{
//
nil = funmap_nil{key,itm}
,
size = funmap_size<key,itm>
,
is_nil = funmap_is_nil{key,itm}
,
isnot_nil = funmap_isnot_nil{key,itm}
,
search = funmap_search<key,itm>
,
insert = funmap_insert<key,itm>
,
remove = funmap_remove<key,itm>
,
takeout = funmap_takeout<key,itm>
,
listize = funmap_listize<key,itm>
,
streamiize = funmap_streamize<key,itm>
//
} (* end of [funmap_make_module] *)
//
(* ****** ****** *)

(* end of [funmap.dats] *)
