(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, ATS Trustful Software, Inc.
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
//
// Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Start Time: April, 2011
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/linmap_avltree.sats"
staload _(*anon*) = "libats/DATS/linmap_avltree.dats"

(* ****** ****** *)

staload "pats_symmap.sats"

(* ****** ****** *)
//
typedef key = uint
//
assume
symmap_vtype (itm:type) = map (key, itm)

(* ****** ****** *)
//
val cmp0 = $UN.cast{cmp(key)} (null)
//
implement
compare_key_key<key> (x1, x2, _) = compare_uint_uint (x1, x2)
//
(* ****** ****** *)

implement symmap_make_nil () = linmap_make_nil<> ()
implement symmap_free {itm} (map) = linmap_free<key,itm> (map)

(* ****** ****** *)

implement
symmap_search
  {itm} (map, sym) = let
  val k = $SYM.symbol_get_stamp (sym)
  var res: itm?
  val found = linmap_search (map, k, cmp0, res)
in
  if found then let
    prval () = opt_unsome {itm} (res) in Some_vt (res)
  end else let
    prval () = opt_unnone {itm} (res) in None_vt ()
  end (* end of [if] *)
end // end of [symmap_search]

(* ****** ****** *)

implement
symmap_insert
  {itm} (map, sym, i) = {
  val k = $SYM.symbol_get_stamp (sym)
  var res: itm
  val _exist = linmap_insert (map, k, i, cmp0, res)
  prval () = opt_clear (res)
} // end of [symmap_insert]

(* ****** ****** *)

implement
symmap_joinwth
  {itm} (map1, map2) = let
//
typedef keyitm = (key, itm)
//
fun loop
  {n:nat} .<n>.
(
  map: &symmap (itm), kis: list_vt (keyitm, n)
) :<> void = let
in
//
case+ kis of
| list_vt_cons
    (!p_ki, kis1) => let
    var res: itm
    val _exist =
      linmap_insert<key,itm> (map, p_ki->0, p_ki->1, cmp0, res)
    prval () = opt_clear (res)
    val () = free@ {keyitm} {0} (kis)
  in
    loop (map, kis1)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loop]
//
val kis = linmap_listize_free<key,itm> (map2)
//
in
  loop (map1, kis)
end // end of [symmap_joinwth]

(* ****** ****** *)

implement
fprint_symmap{itm} (out, map, f) = let
  var !p_clo = @lam (pf: !unit_v | k: key, i: &itm): void =<clo>
    $effmask_all (fprint (out, k); fprint (out, " -> "); f (out, i); fprint_newline (out))
  prval pfu = unit_v ()
  val () = linmap_foreach_vclo (pfu | map, !p_clo)
  prval unit_v () = pfu
in
  // nothing
end // end of [fprint_symmap]

(* ****** ****** *)

(* end of [pats_symmap_avltree.hats] *)
