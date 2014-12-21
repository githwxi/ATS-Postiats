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
bitvec_get_wordsize() =
  8 * $extval(intGt(0), "sizeof(atstype_ptr)")
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

(* end of [bitvec.dats] *)
