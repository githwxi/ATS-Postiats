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

staload "libats/SATS/hashtable_linprb.sats"
staload _(*anon*) = "libats/DATS/hashtable_linprb.dats"

(* ****** ****** *)

staload "pats_symmap.sats"

(* ****** ****** *)

%{^
ATSinline()
ats_ulint_type
hashint_jenkin32 (
  ats_uint_type x
) {
  uint32_t a = x ;
  a = (a+0x7ed55d16) + (a<<12);
  a = (a^0xc761c23c) ^ (a>>19);
  a = (a+0x165667b1) + (a<<5);
  a = (a+0xd3a2646c) ^ (a<<9);
  a = (a+0xfd7046c5) + (a<<3);
  a = (a^0xb55a4f09) ^ (a>>16);
  return a;
} // end of [hashint_jenkin32]
%}
extern
fun hashint_jenkin32
  (x: uint):<> ulint = "mac#hashint_jenkin32"
(* end of [hashint_jenkin32] *)

(* ****** ****** *)
//
typedef key = uint
typedef itm = ptr
typedef keyitm = @(key, itm)
assume
symmap_vtype (itm:type) = HASHTBLptr1 (key, ptr)
//
val hash0 = $UN.cast{hash(key)} (null)
val eqfn0 = $UN.cast{eqfn(key)} (null)
//
implement
hash_key<key> (x, _) = hashint_jenkin32 (x)
implement
equal_key_key<key> (x1, x2, _) = (x1 = x2)
//
implement
keyitem_nullify<keyitm>
  (ki) = () where {
  viewtypedef keyitm = (key, itm)
  extern prfun __assert (ki: &keyitm? >> keyitm): void
  prval () = __assert (ki)
  val () = ki.0 := 0u
  prval () = Opt_some (ki)
} (* end of [keyitem_nullify] *)
//
implement
keyitem_isnot_null<keyitm> (ki) = let
  prval () = __assert (ki) where {
    extern prfun __assert (x: &(Opt keyitm) >> keyitm):<> void
  } // end of [prval]
  val res = (ki.0 > 0u)
  val [b:bool] res = bool1_of_bool (res)
  prval () = __assert (ki) where {
    extern prfun __assert (x: &keyitm >> opt (keyitm, b)):<> void
  } // end of [prval]
in
  res
end // end of [keyitem_isnot_null]
//
(* ****** ****** *)

#define HASHTBLSZ 97

implement
symmap_make_nil () =
  hashtbl_make_hint<key,itm> (hash0, eqfn0, HASHTBLSZ)
// end of [symmap_make_nil]

implement
symmap_free (map) = hashtbl_free (map)

(* ****** ****** *)

implement
symmap_search
  {a} (map, sym) = let
  val k = $SYM.symbol_get_stamp (sym)
  var res: itm?
  val found = hashtbl_search (map, k, res)
in
  if found then let
    prval () = opt_unsome {itm} (res)
    val res = $UN.cast{a} (res) in Some_vt (res)
  end else let
    prval () = opt_unnone {itm} (res) in None_vt ()
  end (* end of [if] *)
end // end of [symmap_search]

implement
symmap_insert
  {a} (map, sym, i) = {
  val k = $SYM.symbol_get_stamp (sym)
  val i: itm = $UN.cast{itm} (i)
  var res: itm
  val _exist = hashtbl_insert (map, k, i, res)
  prval () = opt_clear (res)
} // end of [symmap_insert]

(* ****** ****** *)

implement
symmap_joinwth
  {a} (map1, map2) = let
//
fun loop
  {n:nat} .<n>.
(
  map: !symmap (a), kis: list_vt (keyitm, n)
) :<> void = let
in
//
case+ kis of
| list_vt_cons
    (!p_ki, kis1) => let
    var res: itm
    val _exist = hashtbl_insert (map, p_ki->0, p_ki->1, res)
    prval () = opt_clear (res)
    val () = free@ {keyitm} {0} (kis)
  in
    loop (map, kis1)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [loop]
//
val kis = hashtbl_listize_free<key,itm> (map2)
//
in
  loop (map1, kis)
end // end of [symmap_joinwth]

(* ****** ****** *)

implement
fprint_symmap{a}
  (out, map, f) = let
  var !p_clo = @lam (
    pf: !unit_v | k: key, i: &itm
  ) : void =<clo>
    $effmask_all (fprint (out, k); fprint (out, " -> "); f (out, $UN.cast{a}(i)); fprint_newline (out))
  prval pfu = unit_v ()
  val () = hashtbl_foreach_vclo (pfu | map, !p_clo)
  prval unit_v () = pfu
in
  // nothing
end // end of [fprint_symmap]

(* ****** ****** *)

(* end of [pats_symmap_htlinprb.hats] *)
