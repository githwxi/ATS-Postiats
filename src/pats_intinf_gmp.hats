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
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: May, 2011
//
(* ****** ****** *)
//
staload
ATSPRE = "./pats_atspre.dats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UT = "./pats_utils.sats"
staload _(*anon*) = "./pats_utils.dats"

(* ****** ****** *)

staload "libc/SATS/gmp.sats"
staload "./pats_intinf.sats"

(* ****** ****** *)

assume intinf_type = ref (mpz_vt)

(* ****** ****** *)

implement
intinf_make_int (i) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc)
  val () = mpz_init_set_int (!p, i)
in
  ref_make_view_ptr (pfat | p)
end // end of [intinf_make_int]

implement
intinf_make_size (sz) = let
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc)
  val sz = ulint_of_size (sz)
  val () = mpz_init_set_ulint (!p, sz)
in
  ref_make_view_ptr (pfat | p)
end // end of [intinf_make_size]

(* ****** ****** *)
(*
** HX: [rep] is unsigned!
*)
implement
intinf_make_string (rep) = let
  val rep = string1_of_string (rep)
in
//
if string_is_atend (rep, 0) then intinf_make_int (0)
else let
  val c0 = rep[0]
in
  if c0 = '0' then (
    if string_is_atend (rep, 1) then intinf_make_int (0)
    else let
      val c1 = rep[1]
    in
      if (c1 != 'x' andalso c1 != 'X') then
        intinf_make_base_string_ofs (8, rep, 1)
      else
        intinf_make_base_string_ofs (16, rep, 2)
      // end of [if]
    end
  ) else
    intinf_make_base_string_ofs (10, rep, 0)
  // end of [if]
end // end of [if]
//
end // end of [intinf_make_string]

(* ****** ****** *)

implement
intinf_make_base_string_ofs
  (base, rep, ofs) = let
  val rep =
    __cast (rep) where {
    extern castfn __cast (x: string): ptr
  }
  val rep_ofs =
    __cast (rep + ofs) where {
    extern castfn __cast (x: ptr): string
  }
  val (pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc)
  val () = mpz_init_set_str_exn (!p, rep_ofs, base)
in
  ref_make_view_ptr (pfat | p)
end // end of [intinf_make_base_string_ofs]

(* ****** ****** *)

implement
fprint_intinf (out, x) = let
  val (vbox pf_mpz | p) = ref_get_view_ptr (x)
in
  $effmask_ref (fprint0_mpz (out, !p))
end // end of [fprint_intinf]

(* ****** ****** *)

implement
intinf_get_int (x) =
  $effmask_ref (let
  val (vbox pf_mpz | p) = ref_get_view_ptr (x)
in
  mpz_get_int (!p)
end) // end of [intinf_get_int]
 
(* ****** ****** *)

implement
lt_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) < 0
// end of [lt_intinf_int]

implement
lte_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) <= 0
// end of [lte_intinf_int]

implement
gt_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) > 0
// end of [gt_intinf_int]

implement
gte_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) >= 0
// end of [gte_intinf_int]

(* ****** ****** *)

implement
eq_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) = 0
// end of [eq_intinf_int]

implement
eq_int_intinf (x1, x2) =
  compare_intinf_int (x2, x1) = 0
// end of [eq_int_intinf]

implement
eq_intinf_intinf (x1, x2) =
  compare_intinf_intinf (x1, x2) = 0
// end of [eq_intinf_intinf]

(* ****** ****** *)

implement
neq_intinf_int (x1, x2) =
  compare_intinf_int (x1, x2) != 0
// end of [neq_intinf_int]

implement
neq_int_intinf (x1, x2) =
  compare_intinf_int (x2, x1) != 0
// end of [neq_int_intinf]

implement
neq_intinf_intinf (x1, x2) =
  compare_intinf_intinf (x1, x2) != 0
// end of [neq_intinf_intinf]

(* ****** ****** *)

implement
compare_intinf_int
  (x1, x2) = $effmask_ref let
  val (vbox pf_mpz | p1) = ref_get_view_ptr (x1)
in
  mpz_cmp_int (!p1, x2)
end // end of [compare_intinf_int]

implement
compare_intinf_intinf
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf_mpz | p1) = ref_get_view_ptr (x1)
in
  $effmask_ref (let
  val (vbox pf_mpz | p2) = ref_get_view_ptr (x2)
in
  mpz_cmp_mpz (!p1, !p2)
end) end) // end of [compare_intinf_intinf]

(* ****** ****** *)

implement
neg_intinf
  (x) = $effmask_ref let
  val (vbox pf | p) = ref_get_view_ptr (x)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p)
  val () = mpz_neg1 (!p_res)
in
  ref_make_view_ptr (pfat_res | p_res)
end // end of [neg_intinf]

(* ****** ****** *)

implement
add_intinf_int
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf1 | p1) = ref_get_view_ptr (x1)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p1)
  val () = mpz_add (!p_res, x2)
in
  ref_make_view_ptr (pfat_res | p_res)
end) // end of [add_intinf_int]

implement
add_int_intinf (x1, x2) = add_intinf_int (x2, x1)

implement
add_intinf_intinf
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf1 | p1) = ref_get_view_ptr (x1)
in
  $effmask_ref (let
  val (vbox pf2 | p2) = ref_get_view_ptr (x2)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p1)
  val () = mpz_add (!p_res, !p2)
in
  ref_make_view_ptr (pfat_res | p_res)
end) end) // end of [add_intinf_intinf]

(* ****** ****** *)

implement
sub_intinf_intinf
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf1 | p1) = ref_get_view_ptr (x1)
in
  $effmask_ref (let
  val (vbox pf2 | p2) = ref_get_view_ptr (x2)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p1)
  val () = mpz_sub (!p_res, !p2)
in
  ref_make_view_ptr (pfat_res | p_res)
end) end) // end of [sub_intinf_intinf]

(* ****** ****** *)

implement
mul_intinf_int
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf1 | p1) = ref_get_view_ptr (x1)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p1)
  val () = mpz_mul (!p_res, x2)
in
  ref_make_view_ptr (pfat_res | p_res)
end) // end of [mul_intinf_int]

implement
mul_int_intinf (x1, x2) = mul_intinf_int (x2, x1)

implement
mul_intinf_intinf
  (x1, x2) =
  $effmask_ref (let
  val (vbox pf1 | p1) = ref_get_view_ptr (x1)
in
  $effmask_ref (let
  val (vbox pf2 | p2) = ref_get_view_ptr (x2)
  val (pfgc_res, pfat_res | p_res) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc_res)
  val () = mpz_init_set_mpz (!p_res, !p1)
  val () = mpz_mul (!p_res, !p2)
in
  ref_make_view_ptr (pfat_res | p_res)
end) end) // end of [mul_intinf_intinf]

(* ****** ****** *)

local
//
staload
"libats/SATS/funset_listord.sats"
staload _(*anon*) =
"libats/DATS/funset_listord.dats"
//
fn cmp (
  x1: intinf, x2: intinf
) :<cloref> int =
  compare_intinf_intinf (x1, x2)
//
assume intinfset_type = set (intinf)
//
in (*in-of-local*)

implement
intinfset_sing (x) = funset_make_sing (x)

implement
intinfset_is_member
  (xs, x) = funset_is_member (xs, x, cmp)
// end of [val]

implement
intinfset_add
  (xs, x) = xs where
{
  var xs = xs
  val _(*exist*) = funset_insert (xs, x, cmp)
} (* end of [val] *)

implement
intinfset_listize (xs) = funset_listize (xs)

end // end of [local]

(* ****** ****** *)

implement
fprint_intinfset
  (out, xs) = {
  val xs = intinfset_listize (xs)
  val () = $UT.fprintlst
    (out, $UN.castvwtp1{intinflst}(xs), ", ", fprint_intinf)
  val () = list_vt_free (xs)
} (* end of [fprint_intinfset] *)

(* ****** ****** *)

val () =
intinf_initialize () where
{
//
extern
fun intinf_initialize (): void = "patsopt_intinf_initialize"
//
} (* end of [where] *) // end of [val]

(* ****** ****** *)

%{$
//
// This is necessary to prevent memory leak
//
static
void* patsopt_intinf_malloc
  (size_t sz) { return ATS_MALLOC (sz) ; }
// end of [patsopt_intinf_malloc]

static
void patsopt_intinf_free
  (void* ptr, size_t sz) { ATS_FREE (ptr) ; return ; }
// end of [patsopt_intinf_free]

static
void* patsopt_intinf_realloc (
  void* ptr, size_t sz_old, size_t sz_new
) {
  return ATS_REALLOC (ptr, sz_new) ;
} // end of [patsopt_intinf_realloc]

ats_void_type
patsopt_intinf_initialize
  (/*argumentless*/) {
  mp_set_memory_functions (
    &patsopt_intinf_malloc, &patsopt_intinf_realloc, &patsopt_intinf_free
  ) ; // end of [mp_set_memory_functions]
  return ;
} // end of [patsopt_intinf_initialize]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_intinf_gmp.hats] *)
