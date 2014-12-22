(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
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
// HX-2014-12:
// ported to ATS/Postitats from ATS/Anairiats
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "libats/SATS/bitvec.sats"

(* ****** ****** *)
//
implement
{}(*tmp*)
bitvec_get_wordsize
(
// argumentless
) = $UN.cast{intGt(0)}(8*sz2i(sizeof<ptr>))
//
implement
{}(*tmp*)
bitvec_get_wordsize_log
(
// argumentless
) = $effmask_all (
let
  val wsz = bitvec_get_wordsize()
in
//
if
(wsz=32)
then (5)
else
(
if (wsz=64)
  then 6 else let val () = assertloc(false) in 0 end
// end of [if]
) (* end of [else] *)
//
end // end of [let] // end of [bitvec_get_wordsize_log]
) (* end of [$effmask_all] *)
//
(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_make_none
  {n}(nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
in
//
$UN.castvwtp0{bitvecptr(n)}
  (arrayptr_make_elt<uintptr> (i2sz(asz), $UN.cast{uintptr}(0)))
//
end // end of [bitvecptr_make_none]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_make_full
  {n}(nbit) = vec where
{
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
val extra = $UN.cast{intGte(0)}((asz << log) - nbit)
//
val vec =
$UN.castvwtp0{bitvecptr(n)}
  (arrayptr_make_elt<uintptr> (i2sz(asz), $UN.cast{uintptr}(~1)))
//
val () =
if extra > 0
  then $UN.ptr0_set_at<uintptr>(ptrcast(vec), asz-1, $UN.cast{uintptr}(~1) >> extra)
// end of [if]
//
} (* end of [bitvecptr_make_full] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
bitvecptr_free (vec) =
  arrayptr_free($UN.castvwtp0{arrayptr(intptr,0)}(vec))
//
(* ****** ****** *)

implement
{}(*tmp*)
bitvec_is_none
  (vec, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p: ptr, n: int(n)
) :<> bool =
(
  if n > 0 then let
    val i = $UN.ptr0_get<uintptr> (p)
  in
    if i = $UN.cast{uintptr}(0)
      then loop (ptr_succ<uintptr> (p), n-1) else false
    // end of [if]
  end else true // end of [if]
) (* end of [loop] *)
//
in
  loop (addr@vec, asz)
end // end of [bitvec_is_none]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_is_full
  (vec, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p: ptr, n: int(n)
) :<> bool =
(
  if n > 1 then let
    val i = $UN.ptr0_get<uintptr> (p)
  in
    if i = $UN.cast{uintptr}(~1)
      then loop (ptr_succ<uintptr> (p), n-1) else false
    // end of [if]
  end else true // end of [if]
) (* end of [loop] *)
//
in
//
if
nbit > 0
then (
//
if
loop (addr@vec, asz)
then let
  val extra =
    $UN.cast{intGte(0)}((asz << log) - nbit)
  // end of [val]
in
  $UN.ptr0_get_at<uintptr> (addr@vec, asz-1) = ($UN.cast{uintptr}(~1) >> extra)
end // end of [then]
else false // end of [else]
//
) (* end of [then] *)
else true // end of [else]
//
end // end of [bitvec_is_full]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_equal
  (vec1, vec2, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p1: ptr, p2: ptr, n: int(n)
) :<> bool =
(
//
if
n > 0
then let
  val i1 = $UN.ptr0_get<uintptr> (p1)
  and i2 = $UN.ptr0_get<uintptr> (p2)
in
  if i1 = i2
    then let
      val p1 = ptr_succ<uintptr> (p1)
      and p2 = ptr_succ<uintptr> (p2)
    in
      loop (p1, p2, n-1)
    end // end of [then]
    else false // end of [else]
  // end of [if]
end else true // end of [if]
//
) (* end of [loop] *)
//
in
  loop (addr@vec1, addr@vec2, asz)
end // end of [bitvec_equal]

(* ****** ****** *)
//
implement
{}(*tmp*)
bitvec_notequal
  (vec1, vec2, nbit) = not(bitvec_equal(vec1, vec2, nbit))
//
(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_equal
  {l1,l2}{n}
  (bvp1, bvp2, nbit) = ans where
{
//
val (pf1, fpf1 | p1) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp1))
and (pf2, fpf2 | p2) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp2))
val ans = bitvec_equal (!p1, !p2, nbit)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
} (* end of [bitvecptr_equal] *)

(* ****** ****** *)
//
implement
{}(*tmp*)
bitvecptr_notequal
  (bvp1, bvp2, nbit) =
  not(bitvecptr_equal(bvp1, bvp2, nbit))
//
(* ****** ****** *)

implement
{}(*tmp*)
bitvec_copy
  (vec1, vec2, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p1: ptr, p2: ptr, n: int(n)
) :<!wrt> void =
(
//
if
n > 0
then let
  val i2 = $UN.ptr0_get<uintptr> (p2)
  val () = $UN.ptr0_set<uintptr> (p1, i2)
  val p1 = ptr_succ<uintptr> (p1)
  and p2 = ptr_succ<uintptr> (p2)
in
  loop (p1, p2, n-1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (addr@vec1, addr@vec2, asz)
end // end of [bitvec_copy]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_lnot
  (vec, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
  (p: ptr, n: int(n)):<!wrt> ptr =
(
//
if
n > 1
then let
  val i = $UN.ptr0_get<uintptr> (p)
  val () = $UN.ptr0_set<uintptr> (p, lnot(i))
in
  loop (ptr_succ<uintptr> (p), n - 1)
end // end of [then]
else p // end of [else]
//
) (* end of [loop] *)
//
in
//
if
nbit > 0
then let
  val pz = loop (addr@vec, asz)
  val extra =
    $UN.cast{intGte(0)}((asz << log) - nbit)
  // end of [val]
  val i = $UN.ptr0_get<uintptr> (pz)
  val i2 = lnot(i) land ($UN.cast{uintptr}(~1) >> extra)
  val () = $UN.ptr0_set<uintptr> (pz, i2)
in
  // nothing
end // end of [then]
else () // end of [else]
//
end // end of [bitvec_lnot]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_lnot
  {l}{n}(bvp, nbit) = let
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val ((*void*)) = bitvec_lnot (!p, nbit)
prval ((*void*)) = fpf (pf)
//
in
  // nothing
end // end of [bitvecptr_lnot]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_lor
  (vec1, vec2, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p1: ptr, p2: ptr, n: int(n)
) :<!wrt> void =
(
//
if
n > 0
then let
  val i1 = $UN.ptr0_get<uintptr> (p1)
  val i2 = $UN.ptr0_get<uintptr> (p2)
  val () = $UN.ptr0_set<uintptr> (p1, i1 lor i2)
  val p1 = ptr_succ<uintptr> (p1)
  and p2 = ptr_succ<uintptr> (p2)
in
  loop (p1, p2, n-1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (addr@vec1, addr@vec2, asz)
end // end of [bitvec_lor]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_lxor
  (vec1, vec2, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p1: ptr, p2: ptr, n: int(n)
) :<!wrt> void =
(
//
if
n > 0
then let
  val i1 = $UN.ptr0_get<uintptr> (p1)
  val i2 = $UN.ptr0_get<uintptr> (p2)
  val () = $UN.ptr0_set<uintptr> (p1, i1 lxor i2)
  val p1 = ptr_succ<uintptr> (p1)
  and p2 = ptr_succ<uintptr> (p2)
in
  loop (p1, p2, n-1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (addr@vec1, addr@vec2, asz)
end // end of [bitvec_lxor]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_land
  (vec1, vec2, nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
fun
loop{n:nat} .<n>.
(
  p1: ptr, p2: ptr, n: int(n)
) :<!wrt> void =
(
//
if
n > 0
then let
  val i1 = $UN.ptr0_get<uintptr> (p1)
  val i2 = $UN.ptr0_get<uintptr> (p2)
  val () = $UN.ptr0_set<uintptr> (p1, i1 land i2)
  val p1 = ptr_succ<uintptr> (p1)
  and p2 = ptr_succ<uintptr> (p2)
in
  loop (p1, p2, n-1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (addr@vec1, addr@vec2, asz)
end // end of [bitvec_land]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_lor
  {l1,l2}{n}(bvp1, bvp2, nbit) = let
//
val (pf1, fpf1 | p1) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp1))
and (pf2, fpf2 | p2) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp2))
val ((*void*)) = bitvec_lor (!p1, !p2, nbit)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end // end of [bitvecptr_lor]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_lxor
  {l1,l2}{n}(bvp1, bvp2, nbit) = let
//
val (pf1, fpf1 | p1) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp1))
and (pf2, fpf2 | p2) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp2))
val ((*void*)) = bitvec_lxor (!p1, !p2, nbit)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end // end of [bitvecptr_lxor]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_land
  {l1,l2}{n}(bvp1, bvp2, nbit) = let
//
val (pf1, fpf1 | p1) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp1))
and (pf2, fpf2 | p2) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp2))
val ((*void*)) = bitvec_land (!p1, !p2, nbit)
//
prval () = fpf1 (pf1) and () = fpf2 (pf2)
//
in
  // nothing
end // end of [bitvecptr_land]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_bitvec$word
  (out, w) = let
//
fun
loop
(
  w: uintptr, _1: uintptr, n: int
) : void =
(
//
if
n > 0
then let
//
val b =
  $UN.cast{uint}(w land _1)
//
in
  fprint_uint(out, b); loop (w >> 1, _1, n - 1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (w, $UN.cast{uintptr}(1), bitvec_get_wordsize())
end // end of [fprint_bitvec]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_bitvec
  (out, vec, nbit) = let
//
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
prval [n:int] EQINT() = eqint_make_gint (asz)
//
implement
fprint_val<uintptr> (out, x) = fprint_bitvec$word<> (out, x)
//
implement fprint_array$sep<> (out) = ()
//
in
//
fprint_arrayref
(
  out, $UN.castvwtp1{arrayref(uintptr,n)}(addr@vec), i2sz(asz)
) (* fprint_arrayref *)
//
end // end of [fprint_bitvec]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_bitvecptr
  {n}(out, bvp, nbit) = let
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val ((*void*)) = fprint_bitvec (out, !p, nbit)
prval ((*void*)) = fpf (pf)
//
in
  // nothing
end // end of [fprint_bitvecptr]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_tabulate
  {n}(nbit) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
val asz = $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
val bvp = arrayptr_make_uninitized<uintptr> (i2sz(asz))
//
fun
loop1
(
  p: ptr
, i: intGte(0)
, nbit: intGte(0)
, w: uintptr, i2: intGte(0)
) : void = (
//
if
nbit > 0
then let
//
val b = bitvec_tabulate$fopr(i)
//
in
//
if
b = 0
then (
  loop1 (p, i+1, nbit-1, w, i2+1)
) (* end of [then] *)
else (
  loop1 (p, i+1, nbit-1, w lor ($UN.cast{uintptr}(1) << i2), i2+1)
) (* end of [else] *)
//
end // end of [then]
else ($UN.ptr0_set<uintptr> (p, w))
//
) (* end of [loop1] *)
//
fun
loop2
(
  p: ptr, i: intGte(0), nbit: intGt(0)
) : void =
(
if
nbit > wsz
then let
//
val () =
  loop1 (p, i, wsz, $UN.cast{uintptr}(0), 0)
//
in
  loop2 (ptr_succ<uintptr> (p), i + wsz, nbit - wsz)
end // end of [then]
else (
  loop1 (p, i, nbit, $UN.cast{uintptr}(0), 0)
) (* end of [else] *)
//
) (* end of [loop2] *)
//
val () =
if nbit > 0
  then loop2 (ptrcast(bvp), 0, nbit)
// end of [if]
//
in
  $UN.castvwtp0{bitvecptr(n)}(bvp)
end // end of [bitvecptr_tabulate]

(* ****** ****** *)

(* end of [bitvec.dats] *)
