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
staload "libats/ML/SATS/dynarray.sats"
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
staload _ = "prelude/DATS/integer_long.dats"
staload _ = "prelude/DATS/integer_size.dats"
//
staload _ = "prelude/DATS/string.dats"
//
staload _ = "prelude/DATS/reference.dats"
//
staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"
//
staload _ = "prelude/DATS/option.dats"
staload _ = "prelude/DATS/option_vt.dats"
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
staload _(*anon*) = "libats/DATS/dynarray.dats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
//
staload _(*anon*) = "libats/ML/DATS/list0.dats"
staload _(*anon*) = "libats/ML/DATS/array0.dats"
staload _(*anon*) = "libats/ML/DATS/dynarray.dats"
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
//
| GVnil() => fprint! (out, "GVnil(", ")")
//
| GVint(i) => fprint! (out, "GVint(", i, ")")
//
| GVptr(p) => fprint! (out, "GVptr(", p, ")")
//
| GVbool(b) => fprint! (out, "GVbool(", b, ")")
| GVchar(c) => fprint! (out, "GVchar(", c, ")")
//
| GVfloat(x) => fprint! (out, "GVfloat(", x, ")")
| GVstring(x) => fprint! (out, "GVstring(", x, ")")
//
| GVref(r) => fprint! (out, "GVref(", "...", ")")
//
| GVlist(xs) => fprint! (out, "GVlist(", xs, ")")
//
| GVarray(xs) => fprint! (out, "GVarray(", "...", ")")
//
| GVdynarr(xs) => fprint! (out, "GVdynarr(", "...", ")")
//
| GVhashtbl(kxs) => fprint! (out, "GVhashtbl(", "...", ")")
//
| GVfunclo_fun _ => fprint! (out, "GVfunclo_fun(", "...", ")")
| GVfunclo_clo _ => fprint! (out, "GVfunclo_clo(", "...", ")")
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
fprint_gvdynarr
  (out, xs) = let
//
implement
fprint_val<gvalue> = fprint_gvalue
//
in
  fprint_dynarray_sep<gvalue>(out, xs, ", ")
end // end of [fprint_gvdynarr]

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
gvalue_nil() = GVnil()
//
implement
gvalue_int(i) = GVint(i)
//
implement
gvalue_ptr(p) = GVptr(p)
//
implement
gvalue_bool(x) = GVbool(x)
implement
gvalue_char(x) = GVchar(x)
//
implement
gvalue_float(x) = GVfloat(x)
implement
gvalue_string(x) = GVstring(x)
//
(* ****** ****** *)
//
implement
gvalue_ref(r) = GVref(r)
//
implement
gvalue_list(xs) = GVlist(xs)
//
implement
gvalue_array(xs) = GVarray(xs)
//
implement
gvalue_hashtbl(kxs) = GVhashtbl(kxs)
//
(* ****** ****** *)
//
implement
gvref_make_elt
  (x0) = ref_make_elt<gvalue>(x0)
//
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

typedef elt = gvalue

in (* in-of-local *)

implement
gvdynarr_make_nil
  (cap) = let
(*
val () =
  println! ("gvdynarr_make_nil")
*)
in
//
dynarray_make_nil<elt>(i2sz(cap))
//
end // end of [gvdynarr_make_nil]

(* ****** ****** *)

implement
gvdynarr_get_at
  (DA, i) = let
//
val p0 =
  dynarray_getref_at(DA, i2sz(i))
//
in
//
if isneqz(p0)
  then $UN.cptr_get<elt>(p0) else GVnil()
//
end // end of [gvdynarr_get_at]

implement
gvdynarr_set_at
  (DA, i, x) = let
//
val p0 =
  dynarray_getref_at(DA, i2sz(i))
//
in
//
if isneqz(p0)
  then $UN.cptr_set<elt>(p0, x) else ((*void*))
//
end // end of [gvdynarr_set_at]

(* ****** ****** *)

implement
gvdynarr_insert_atbeg
  (DA, x0) = let
//
val opt =
  dynarray_insert_atbeg<elt>(DA, x0)
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(x0) =>
  (
    let val () = assertloc(false) in (*void*) end
  ) (* end of [Some_vt] *)
//  
end // end of [gvdynarr_insert_atbeg]

implement
gvdynarr_insert_atend
  (DA, x0) = let
//
val opt =
  dynarray_insert_atend<elt>(DA, x0)
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(x0) =>
  let val () = assertloc(false) in (*void*) end
//  
end // end of [gvdynarr_insert_atend]

(* ****** ****** *)

implement
gvdynarr_listize0(DA) = dynarray_listize0<elt>(DA)
implement
gvdynarr_listize1(DA) = dynarray_listize1<elt>(DA)

(* ****** ****** *)

end // end of [local]

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
  println! ("gvhashtbl_make_nil")
*)
in
  hashtbl_make_nil<key,itm>(i2sz(cap))
end // end of [gvhashtbl_make_nil]

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
//
case+ opt of ~None_vt() => GVnil() | ~Some_vt(x1) => x1
//
end // end of [gvhashtbl_set_atkey]

(* ****** ****** *)

implement
gvhashtbl_pop_atkey
  (tbl, k) = let
(*
//
val () =
  println! (gvhashtbl_pop_atkey)
//
*)
//
in
//
case+ tbl[k] of
| GVnil() => GVnil()
| GVlist(xs) =>
  (
    case+ xs of
    | list0_nil() => GVnil()
    | list0_cons(x, xs) =>
        (tbl[k] := GVlist(xs); x)
      // end of [list0_cons]
  )
| _(*non-list*) => let
    val () =
    prerrln!
      ("gvhashtbl_pop_atkey")
    // end of [val]
    val () = assertloc(false) in GVnil(*void*)
  end // end of [_]
//
end // end of [gvhashtbl_push_atkey]

(* ****** ****** *)

implement
gvhashtbl_push_atkey
  (tbl, k, x) = let
(*
//
val () =
  println! (gvhashtbl_push_atkey)
//
*)
//
in
//
case+ tbl[k] of
| GVnil() =>
  tbl[k] := GVlist(list0_sing(x))
| GVlist(xs) =>
  tbl[k] := GVlist(list0_cons(x, xs))
| _(*non-list*) => let
    val () =
    prerrln!
      ("gvhashtbl_push_atkey")
    // end of [val]
    val () = assertloc(false) in (*void*)
  end // end of [_]
//
end // end of [gvhashtbl_push_atkey]

(* ****** ****** *)
//
implement
gvhashtbl_foreach_cloref
  (tbl, fwork) =
  hashtbl_foreach_cloref<key,itm>(tbl, fwork)
//
implement
gvhashtbl_foreach_method(tbl) =
  lam (fwork) => hashtbl_foreach_cloref<key,itm>(tbl, fwork)
//
(* ****** ****** *)
//
implement
gvhashtbl_listize1(tbl) = hashtbl_listize1<key,itm>(tbl)
//
(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [gvalue.dats] *)
