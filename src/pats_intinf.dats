(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-20?? Hongwei Xi, Boston University
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
// Start Time: May, 2011
//
(* ****** ****** *)

staload "libc/SATS/gmp.sats"

(* ****** ****** *)

staload "pats_intinf.sats"

(* ****** ****** *)

assume intinf_type = ref (mpz_vt)

(* ****** ****** *)

implement
intinf_make_string (rep) = let
  val @(pfgc, pfat | p) = ptr_alloc_tsz {mpz_vt} (sizeof<mpz_vt>)
  prval () = free_gc_elim (pfgc)
  val () = mpz_init_set_str_exn (!p, rep, 10(*base*))
in
  ref_make_view_ptr (pfat | p)
end // end of [intinf_make_string]

(* ****** ****** *)

val () = intinf_initialize () where {
  extern fun intinf_initialize (): void = "atsopt_intinf_initialize"
} // end of [val]

(* ****** ****** *)

%{$
//
// This is necessary to prevent memory leak
//
static
void* atsopt_intinf_malloc
  (size_t sz) { return ATS_MALLOC (sz) ; }
// end of [atsopt_intinf_malloc]

static
void atsopt_intinf_free
  (void* ptr, size_t sz) { ATS_FREE (ptr) ; return ; }
// end of [atsopt_intinf_free]

static
void* atsopt_intinf_realloc (
  void* ptr, size_t sz_old, size_t sz_new
) {
  return ATS_REALLOC (ptr, sz_new) ;
} // end of [atsopt_intinf_realloc]

ats_void_type
atsopt_intinf_initialize
  (/*argumentless*/) {
  mp_set_memory_functions (
    &atsopt_intinf_malloc, &atsopt_intinf_realloc, &atsopt_intinf_free
  ) ; // end of [mp_set_memory_functions]
  return ;
} // end of [atsopt_intinf_initialize]

%} // end of [%{$]

(* ****** ****** *)

(* end of [pats_intinf.sats] *)
