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
// Start Time: March, 2011
//
(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "pats_utils.sats"

(* ****** ****** *)

local

fun
llint_make_string_sgn
  {n,i:nat | i <= n} (
  sgn: int, rep: string (n), i: size_t i
) : llint =
  if string_isnot_at_end (rep, i) then let
    val c0 = rep[i]
  in
    case+ c0 of
    | '0' => (
        if string_isnot_at_end (rep, i+1) then let
          val i = i+1
          val c0 = rep[i]
        in
          if (c0 = 'X' orelse c0 = 'x') then
            llint_make_string_sgn_base (sgn, 16(*base*), rep, i+1)
          else
            llint_make_string_sgn_base (sgn, 8(*base*), rep, i)
          // end of [if]
        end else 0ll (* end of [if] *)
      ) // end of ['0']
    | _ => llint_make_string_sgn_base (sgn, 10(*base*), rep, i)
  end else 0ll (* end of [if] *)
// end of [llint_make_string_sgn]

and
llint_make_string_sgn_base
  {n,i:nat | i <= n} (
  sgn: int, base: intBtw (2,36+1), rep: string (n), i: size_t i
) : llint = let
//
extern fun substring
  {n,i:nat | i <= n}
  (x: string n, i: size_t i): string (n-i) = "mac#atspre_padd_int"
//
in
  (llint_of)sgn * $STDLIB.strtoll_errnul (substring (rep, i), base)
end // end of [llint_make_string_sgn_base]

in // in of [local]

implement
llint_make_string
  (rep) = let
  var sgn: int = 1
  val [n0:int] rep = string1_of_string (rep)
in
  if string_isnot_empty (rep) then let
    val c0 = rep[0]
  in
    case+ c0 of
    | '+' => llint_make_string_sgn ( 1(*sgn*), rep, 1)
    | '~' => llint_make_string_sgn (~1(*sgn*), rep, 1)
    | '-' => llint_make_string_sgn (~1(*sgn*), rep, 1)
    | _ => llint_make_string_sgn (1(*sgn*), rep, 0)
  end else 0ll // end of [if]
end // end of [llint_make_string]

end // end of [local]

(* ****** ****** *)

implement{a}
fprintlst (
  out, xs, sep, fprint
) = let
  fun aux (
    xs: List a, i: int
  ) :<cloref1> void =
    case+ xs of
    | list_cons (x, xs) => let
        val () = if i > 0 then fprint_string (out, sep)
        val () = fprint (out, x)
      in
         aux (xs, i+1)
      end // end of [list_cons]
    | list_nil () => () // end of [list_nil]
  // end of [aux]
in
  aux (xs, 0)
end // end of [fprintlst]

(* ****** ****** *)

implement{a}
fprintopt (
  out, opt, fprint
) = case+ opt of
  | Some x => let
      val () = fprint_string (out, "Some(")
      val () = fprint (out, x)
      val () = fprint_string (out, ")")
    in
      // nothing
    end // end of [Some]
  | None () => fprint_string (out, "None()")
// end of [fprintopt]

(* ****** ****** *)

local
//
staload Q = "libats/SATS/linqueue_arr.sats"
//
staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "libats/DATS/linqueue_arr.dats"
staload _(*anon*) = "libats/ngc/DATS/deque_arr.dats"
//
in

implement
queue_get_strptr1
  (q, st, ln) = let
  val [l:addr]
    (pfgc, pfarr | p) = malloc_gc (ln+1)
  // end of [val]
  prval (pf1, fpf2) =
   __assert (pfarr) where {
   extern prfun __assert {k:nat} (
     pfarr: b0ytes(k+1) @ l
   ) : (
     @[uchar?][k] @ l, @[uchar][k] @ l -<lin,prf> bytes(k+1) @ l
   ) (* end of [_assert] *)
  } // end of [prval]
  val () = $Q.queue_copyout<uchar> (q, st, ln, !p)
  prval () = pfarr := fpf2 (pf1)
  val () = bytes_strbuf_trans (pfarr | p, ln)
in
  strptr_of_strbuf @(pfgc, pfarr | p)
end // end of [queue_get_strptr1]

end // end of [local]

(* ****** ****** *)

(* end of [pats_utils.dats] *)
