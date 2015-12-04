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
(* Authoremail:
   gmhwxiATgmailDOTcom *)
(* Start time: December, 2015 *)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0
  
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload "libats/ML/SATS/basis.sats"
//
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"
staload "libats/ML/SATS/hashtblref.sats"
//
staload "libats/ML/SATS/gvalue.sats"
//
(* ****** ****** *)
//
staload _ = "prelude/DATS/basics.dats"
//
staload _ = "prelude/DATS/integer.dats"
staload _ = "prelude/DATS/pointer.dats"
//
staload _ = "prelude/DATS/string.dats"
//
staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"
//
staload _ = "prelude/DATS/array.dats"
staload _ = "prelude/DATS/arrayptr.dats"
staload _ = "prelude/DATS/arrayref.dats"
//
staload _ = "prelude/DATS/gorder.dats"
staload _ = "prelude/DATS/gnumber.dats"
//
staload _(*UN*) = "prelude/DATS/unsafe.dats"
//
(* ****** ****** *)
//
staload _(*anon*) = "libats/DATS/qlist.dats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
//
staload _(*anon*) = "libats/ML/DATS/list0.dats"
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)
//
implement
print_gvalue(x0) =
  fprint_gvalue(stdout_ref, x0)
//
implement
prerr_gvalue(x0) =
  fprint_gvalue(stderr_ref, x0)
//
(* ****** ****** *)

implement
fprint_gvalue
  (out, gv0) = let
(*
// fprint_gvalue: enter
*)
in
//
case+ gv0 of
| GVnil() => fprint! (out, "GVnil(", ")")
//
| GVint(i) => fprint! (out, "GVint(", i, ")")
//
| GVbool(b) => fprint! (out, "GVbool(", b, ")")
| GVchar(c) => fprint! (out, "GVchar(", c, ")")
//
| GVfloat(x) => fprint! (out, "GVfloat(", x, ")")
| GVstring(x) => fprint! (out, "GVstring(", x, ")")
//
| GVlist(xs) => fprint! (out, "GVlist(", xs, ")")
//
| GVarray(xs) => fprint! (out, "GVarray(", xs, ")")
//
| GVhashtbl(kxs) => fprint! (out, "GVhashtbl(", kxs, ")")
//
end // end of [fprint_gvalue]

(* ****** ****** *)

implement
fprint_gvlist
  (out, xs) = let
//
implement
fprint_val<gvalue> = fprint_gvalue
//
in
  fprint_list0_sep<gvalue>(out, xs, ", ")
end // end of [fprint_gvlist]

(* ****** ****** *)

implement
fprint_gvarray
  (out, xs) = let
//
implement
fprint_val<gvalue> = fprint_gvalue
//
in
  fprint_array0_sep<gvalue>(out, xs, ", ")
end // end of [fprint_gvarray]

(* ****** ****** *)

implement
fprint_gvhashtbl
  (out, kxs) = let
//
implement
fprint_val<gvalue> = fprint_gvalue
//
in
  fprint_hashtbl_sep_mapto<string,gvalue>(out, kxs, "; ", "->")
end // end of [fprint_gvhashtbl]

(* ****** ****** *)

implement
fprint_val<gvalue> = fprint_gvalue

(* ****** ****** *)
//
implement
gvarray_make_nil
  (asz) =
(
  array0_make_elt(i2sz(asz), GVnil())
)
//
(* ****** ****** *)

local
//
typedef key = string
typedef itm = gvalue
//
in (* in-of-local *)

implement
gvhashtbl_make_nil
  (cap) = let
(*
val () =
  println! ("ghashtbl_make_nil")
*)
in
  hashtbl_make_nil<key,itm>(i2sz(cap))
end // end of [ghashtbl_make_nil]

implement
gvhashtbl_get_atkey
  (tbl, k0) = let
//
val cp = hashtbl_search_ref(tbl, k0)
//
in
  if isneqz(cp) then $UN.cptr_get(cp) else GVnil()
end // end of [gvhashtbl_get_atkey]

implement
gvhashtbl_set_atkey
  (tbl, k0, x0) = let
//
val opt = hashtbl_insert(tbl, k0, x0)
//
in
  case+ opt of ~None_vt() => () | ~Some_vt _ => ()
end // end of [gvhashtbl_set_atkey]

implement
gvhashtbl_exch_atkey
  (tbl, k0, x0) = let
//
val opt = hashtbl_insert(tbl, k0, x0)
//
in
  case+ opt of ~None_vt() => GVnil() | ~Some_vt x1 => x1
end // end of [gvhashtbl_set_atkey]

end // end of [local]

(* ****** ****** *)

(* end of [gvalue.dats] *)
