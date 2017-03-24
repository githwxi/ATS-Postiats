(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: August, 2013 *)

(* ****** ****** *)
//
// HX: shared by hashtbl_chain
// HX: shared by hashtbl_linprb
//
(* ****** ****** *)

(*
implement
{key}(*tmp*)
hash_key = ghash_val_val<key>
*)

(* ****** ****** *)

implement
{key}(*tmp*)
equal_key_key = gequal_val_val<key>

(* ****** ****** *)
//
// HX: 31 and 37 are top choices
//
implement
hash_key<string> (str) =
  string_hash_multiplier (31UL, 618033989UL, str)
(*
implement
hash_key<string> (str) =
  string_hash_multiplier (31UL, 61803398875UL, str)
*)
//
(* ****** ****** *)

implement{}
hashtbl$recapacitize () = 1 // HX: default: resizable

(* ****** ****** *)

implement
{key,itm}
hashtbl_search
  (t, k0, res) = let
//
val p =
  hashtbl_search_ref<key,itm>(t, k0)
//
in
//
if
(cptr2ptr(p) > 0)
then let
//
  val
  (pf, fpf | p) =
  $UN.cptr_vtake(p)
//
  val () = res := !p
  prval () = fpf (pf)
  prval () = opt_some {itm} (res)
in
  true
end else let
  prval () = opt_none {itm} (res)
in
  false
end // end of [if]
//
end // end of [hashtbl_search]

(* ****** ****** *)

implement
{key,itm}
hashtbl_search_opt
  (tbl, k0) = let
//
var res: itm?
val ans =
  hashtbl_search<key,itm>
    (tbl, k0, res)
//
in
//
if
ans
then let
  prval () = opt_unsome{itm}(res)
in
  Some_vt{itm}(res)
end else let
  prval () = opt_unnone{itm}(res)
in
  None_vt{itm}((*void*))
end // end of [if]
//
end // end of [hashtbl_search_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_insert_opt
  (tbl, k0, x0) = let
//
var res: itm?
val ans =
  hashtbl_insert<key,itm>
    (tbl, k0, x0, res)
//
in
//
if
ans
then let
  prval () = opt_unsome{itm}(res)
in
  Some_vt{itm}(res)
end else let
  prval () = opt_unnone{itm}(res)
in
  None_vt{itm}((*void*))
end // end of [if]
//
end // end of [hashtbl_insert_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_takeout_opt
  (tbl, k0) = let
//
var res: itm?
val ans =
  hashtbl_takeout<key,itm>
    (tbl, k0, res)
//
in
//
if
ans
then let
  prval () = opt_unsome{itm}(res)
in
  Some_vt{itm}(res)
end else let
  prval () = opt_unnone{itm}(res)
in
  None_vt{itm}((*void*))
end // end of [if]
//
end // end of [hashtbl_takeout_opt]

(* ****** ****** *)

implement
{key,itm}
hashtbl_remove
  (tbl, k0) = let
//
var res: itm
val takeout =
  hashtbl_takeout<key,itm>(tbl, k0, res)
prval () = opt_clear (res)
//
in
  takeout(*removed*)
end // end of [hashtbl_remove]

(* ****** ****** *)

implement
{key,itm}
hashtbl_exchange
  (tbl, k0, x0) = let
//
val p_x1 =
  hashtbl_search_ref<key,itm>(tbl, k0)
//
val p_x1 = cptr2ptr(p_x1)
//
in
//
if isneqz(p_x1)
  then ($UN.ptr1_exch<itm>(p_x1, x0); true) else false
//
end // end of [hashtbl_exchange]

(* ****** ****** *)

implement
{key,itm}
fprint_hashtbl
  (out, tbl) = let
//
implement
hashtbl_foreach$fwork<key,itm><int>
  (k, x, env) = {
  val () =
  if env > 0
    then fprint_hashtbl$sep<>(out)
  // end of [if]
  val () = env := env + 1
  val () = fprint_val<key> (out, k)
  val () = fprint_hashtbl$mapto<>(out)
  val () = fprint_val<itm> (out, x)
} (* end of [hashtbl_foreach$fwork] *)
//
var env: int = 0
//
in
  hashtbl_foreach_env<key,itm><int> (tbl, env)
end // end of [fprint_hashtbl]

(* ****** ****** *)

implement{}
fprint_hashtbl$sep (out) = fprint (out, "; ")
implement{}
fprint_hashtbl$mapto (out) = fprint (out, "->")

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach
  (tbl) = let
  var env: void = () in
  hashtbl_foreach_env<key,itm><void> (tbl, env)
end // end of [hashtbl_foreach]

(* ****** ****** *)

implement
{key,itm}
hashtbl_foreach_cloref
  (tbl, fwork) = let
//
implement
{key,itm}{env}
hashtbl_foreach$fwork
  (k, x, env) = let
//
typedef
fwork_t =
  (key, &itm >> _) -<cloref1> void
//
in
  $UN.cast{fwork_t}(fwork)(k, x)
end // end of [hashtbl_foreach$fwork]
//
in
  hashtbl_foreach<key,itm>(tbl)
end // end of [hashtbl_foreach_cloref]

(* ****** ****** *)

implement
{key,itm}
hashtbl_listize
  (tbl) = let
//
vtypedef ki2 = @(key, itm)
//
implement
hashtbl_flistize$fopr<key,itm><ki2> (k, x) = @(k, x)
//
in
  hashtbl_flistize<key,itm><ki2> (tbl)
end // end of [hashtbl_listize]

(* ****** ****** *)
//
implement
{key,itm}
streamize_hashtbl(tbl) =
  streamize_list_vt_elt<@(key,itm)>(hashtbl_listize(tbl))
//
(* ****** ****** *)

local

staload Q = "libats/SATS/qlist.sats"

in (* in of [local] *)

implement
{key,itm}
hashtbl_listize1
  (tbl) = let
//
vtypedef ki = @(key, itm)
vtypedef tenv = $Q.qstruct (ki)
//
implement(env)
hashtbl_foreach$fwork<key,itm><env>
  (k, x, env) = let
//
val (
  pf, fpf | p
) = $UN.ptr_vtake{tenv}(addr@(env))
val () = $Q.qstruct_insert<ki> (env, @(k, x))
prval () = fpf (pf)
//
in
  // nothing
end // end of [hashtbl_foreach$fwork]
//
var env: $Q.qstruct
val () = $Q.qstruct_initize{ki}(env)
val () = $effmask_all (hashtbl_foreach_env<key,itm><tenv> (tbl, env))
val res = $Q.qstruct_takeout_list (env)
prval () = $Q.qstruct_uninitize{ki}(env)
//
prval () = lemma_list_vt_param (res)
//
in
  res
end // end of [hashtbl_listize1]

end // end of [local]

(* ****** ****** *)

(* end of [hashtbl.hats] *)
