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
// Author: Hongwei Xi (gmhwxi AT gmail DOT com)
// Start Time: October, 2012
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

staload "./pats_basics.sats"

(* ****** ****** *)

staload
STAMP = "./pats_stamp.sats"
typedef stamp = $STAMP.stamp

staload
LOC = "./pats_location.sats"
typedef location = $LOC.location

(* ****** ****** *)

staload "./pats_histaexp.sats"

(* ****** ****** *)

staload "./pats_ccomp.sats"

(* ****** ****** *)

local

typedef tmpvar = '{
  tmpvar_loc= location
, tmpvar_type= hisexp
, tmpvar_ret= int (* return status *)
, tmpvar_topknd= int (* 0/1 : local/top(static) *)
, tmpvar_alias= primvalopt // it is address of the [tmp]
, tmpvar_origin= Option (ptr), tmpvar_suffix= int // copy indication
, tmpvar_stamp= stamp (* unicity *)
} // end of [tmpvar]

assume tmpvar_type = tmpvar
extern typedef "tmpvar_t" = tmpvar

in // in of [local]

implement
tmpvar_make
  (loc, hse) = let
  val stamp = $STMP.tmpvar_stamp_make () in '{
  tmpvar_loc= loc
, tmpvar_type= hse
, tmpvar_ret= 0
, tmpvar_topknd= 0 (*local*)
, tmpvar_alias= None () // HX: tmpvar is not an alias
, tmpvar_origin= None (), tmpvar_suffix= 0 // HX: copy indication
, tmpvar_stamp= stamp
} end // end of [tmpvar_make]

(* ****** ****** *)

implement
tmpvar_get_loc (tmp) = tmp.tmpvar_loc

implement
tmpvar_get_type (tmp) = tmp.tmpvar_type

implement
tmpvar_get_topknd (tmp) = tmp.tmpvar_topknd

implement
tmpvar_get_alias (tmp) = tmp.tmpvar_alias

implement
tmpvar_get_origin (tmp) =
  $UN.cast{tmpvaropt} (tmp.tmpvar_origin)
implement
tmpvar_get_suffix (tmp) = tmp.tmpvar_suffix

implement
tmpvar_get_stamp (tmp) = tmp.tmpvar_stamp

(* ****** ****** *)

implement
eq_tmpvar_tmpvar (tmp1, tmp2) =
  $STMP.eq_stamp_stamp (tmp1.tmpvar_stamp, tmp2.tmpvar_stamp)
// end of [eq_tmpvar_tmpvar]

implement
compare_tmpvar_tmpvar (tmp1, tmp2) =
  $STMP.compare_stamp_stamp (tmp1.tmpvar_stamp, tmp2.tmpvar_stamp)
// end of [compare_tmpvar_tmpvar]

(* ****** ****** *)

implement
fprint_tmpvar
  (out, tmp) = () where {
  val () = fprint_string (out, "tmp(")
  val () = $STMP.fprint_stamp (out, tmp.tmpvar_stamp)
  val () = fprint_string (out, ")")
} // end of [fprint_tmpvar]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

local

extern
fun tmpvar_set_ret
  (tmp: tmpvar, ret: int): void = "patsopt_tmpvar_set_ret"
// end of [tmpvar_set_ret]

in // in of [local]

implement
tmpvar_make_ret
  (loc, hse) = tmp where {
  val tmp = tmpvar_make (loc, hse)
  val () = tmpvar_set_ret (tmp, 1(*ret*))
} // end of [tmpvar_make_ret]

end // end of [local]

(* ****** ****** *)

local

extern
fun tmpvar_set_origin (
  tmp: tmpvar, opt: tmpvaropt
) : void  = "patsopt_tmpvar_set_origin"
extern
fun tmpvar_set_suffix
  (tmp: tmpvar, sfx: int): void = "patsopt_tmpvar_set_suffix"
// end of [tmpvar_set_suffix]

in // in of [local]

implement
tmpvar_subst
  (sub, tmp, sfx) = let
  val loc = tmpvar_get_loc (tmp)
  val hse = tmpvar_get_type (tmp)
  val hse = hisexp_subst (sub, hse)
  val tmp2 = tmpvar_make (loc, hse)
  val () =
    tmpvar_set_origin (tmp2, Some (tmp))
  // end of [val]
  val () = tmpvar_set_suffix (tmp2, sfx)
in
  tmp2
end // end of [tmpvar_subst]

end // end of [local]

(* ****** ****** *)

implement
tmpvarlst_subst
  (sub, tmplst, sfx) = let
//
fun loop (
  sub: !stasub
, xs: tmpvarlst, sfx: int, ys: tmpvarlst_vt
) : tmpvarlst_vt = let
//
in
//
case+ xs of
| list_cons
    (x, xs) => let
    val y = tmpvar_subst (sub, x, sfx)
  in
    loop (sub, xs, sfx, list_vt_cons (y, ys))
  end // end of [list_cons]
| list_nil () => ys
//
end // end of [loop]
//
val tmplst2 =
  loop (sub, tmplst, sfx, list_vt_nil)
val tmplst2 = list_vt_reverse (tmplst2)
//
in
  list_of_list_vt (tmplst2)
end // end of [tmpvarlst_subst]

(* ****** ****** *)

local

staload
LS = "libats/SATS/linset_avltree.sats"
staload _ = "libats/DATS/linset_avltree.dats"

val cmp = lam (
  tmp1: tmpvar, tmp2: tmpvar
) : int =<cloref>
  compare_tmpvar_tmpvar (tmp1, tmp2)
// end of [val]

assume tmpvarset_vtype = $LS.set (tmpvar)

in // in of [local]

implement
tmpvarset_vt_nil () = $LS.linset_make_nil ()

implement
tmpvarset_vt_free (xs) = $LS.linset_free (xs)

implement
tmpvarset_vt_add
  (xs, x) = xs where {
  var xs = xs
  val _(*replaced*) = $LS.linset_insert (xs, x, cmp)
} // end of [tmpvarset_vt_add]

implement
tmpvarset_vt_listize (xs) = $LS.linset_listize (xs)
implement
tmpvarset_vt_listize_free (xs) = $LS.linset_listize_free (xs)

end // end of [local]

(* ****** ****** *)

%{$

ats_void_type
patsopt_tmpvar_set_ret
  (ats_ptr_type tmp, ats_int_type ret) {
  ((tmpvar_t)tmp)->atslab_tmpvar_ret = ret ; return ;
} // end of [patsopt_tmpvar_set_ret]

ats_void_type
patsopt_tmpvar_set_alias
  (ats_ptr_type tmp, ats_ptr_type opt) {
  ((tmpvar_t)tmp)->atslab_tmpvar_alias = opt ; return ;
} // end of [patsopt_tmpvar_set_alias]

ats_void_type
patsopt_tmpvar_set_origin
  (ats_ptr_type tmp, ats_ptr_type opt) {
  ((tmpvar_t)tmp)->atslab_tmpvar_origin = opt ; return ;
} // end of [patsopt_tmpvar_set_origin]

ats_void_type
patsopt_tmpvar_set_suffix
  (ats_ptr_type tmp, ats_int_type sfx) {
  ((tmpvar_t)tmp)->atslab_tmpvar_suffix = sfx ; return ;
} // end of [patsopt_tmpvar_set_suffix]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_ccomp_tmpvar.dats] *)
