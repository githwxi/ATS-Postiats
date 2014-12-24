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

macdef U0 = $UN.cast{uintptr}(0)
macdef U1 = $UN.cast{uintptr}(1)
macdef U_1 = $UN.cast{uintptr}(~1)

(* ****** ****** *)

macdef
uintptr_p_inc(p) = ptr_succ<uintptr> (,(p))
macdef
uintptr_p_get(p) = $UN.ptr0_get<uintptr> (,(p))
macdef
uintptr_p_set(p, x) = $UN.ptr0_set<uintptr> (,(p), ,(x))

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
case+ 0 of
| _ when wsz=16 => 4
| _ when wsz=32 => 5
| _ when wsz=64 => 6
| _ (* unsupported *) => let val () = assertloc(false) in 0 end
//
end // end of [let]
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
val asz =
  $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
in
//
$UN.castvwtp0{bitvecptr(n)}
  (arrayptr_make_elt<uintptr> (i2sz(asz), U0))
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
val asz =
  $UN.cast{intGte(0)}((nbit + wsz - 1) >> log)
//
val extra =
  $UN.cast{intGte(0)}((asz << log) - nbit)
//
val vec =
$UN.castvwtp0{bitvecptr(n)}
  (arrayptr_make_elt<uintptr> (i2sz(asz), U_1))
//
val () =
if extra > 0
  then $UN.ptr0_set_at<uintptr>(ptrcast(vec), asz-1, U_1 >> extra)
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
bitvec_get_at
  (vec, i) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
//
val j = (i >> log)
val k = i - (j << log)
val k = $UN.cast{intGte(0)}(k)
//
val w =
  $UN.ptr0_get_at<uintptr> (addr@vec, j)
//
in
  $UN.cast{bit}((w >> k) land U1)
end // end of [bitvec_get_at]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_set_at
  (vec, i, b) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
//
val j = (i >> log)
val k = i - (j << log)
val k = $UN.cast{intGte(0)}(k)
//
val p = ptr_add<uintptr> (addr@vec, j)
//
val m = U1 << k
val w = uintptr_p_get (p)
//
in
//
if
b > 0
then uintptr_p_set (p, w lor m)
else uintptr_p_set (p, w land ~m)
//
end // end of [bitvec_set_at]

(* ****** ****** *)

implement
{}(*tmp*)
bitvec_flip_at
  (vec, i) = let
//
val wsz = bitvec_get_wordsize ()
val log = bitvec_get_wordsize_log ()
//
val j = (i >> log)
val k = i - (j << log)
val k = $UN.cast{intGte(0)}(k)
//
val p = ptr_add<uintptr> (addr@vec, j)
//
val m = U1 << k
val w = uintptr_p_get (p)
//
in
  uintptr_p_set (p, w lxor m)
end // end of [bitvec_flip_at]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_get_at
  {l}{n}
  (bvp, i) = bit where
{
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val bit = bitvec_get_at (!p, i)
prval ((*void*)) = fpf (pf)
//
} (* end of [bitvecptr_get_at] *)

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_set_at
  {l}{n}
  (bvp, i, bit) =
{
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val bit = bitvec_set_at (!p, i, bit)
prval ((*void*)) = fpf (pf)
//
} (* end of [bitvecptr_set_at] *)

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_flip_at
  {l}{n}
  (bvp, i) =
{
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val bit = bitvec_flip_at (!p, i)
prval ((*void*)) = fpf (pf)
//
} (* end of [bitvecptr_flip_at] *)

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
//
if
n > 0
then let
//
val i =
  uintptr_p_get (p)
//
in
  if i = U0
    then loop (uintptr_p_inc (p), n-1) else false
  // end of [if]
end // end of [then]
else true // end of [else]
//
) (* end of [loop] *)
//
in
  loop (addr@vec, asz)
end // end of [bitvec_is_none]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_is_none
  {l}{n}
  (bvp, nbit) = ans where
{
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val ans = bitvec_is_none (!p, nbit)
prval ((*void*)) = fpf (pf)
//
} (* end of [bitvecptr_is_none] *)

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
//
if
n > 1
then let
  val i = uintptr_p_get (p)
in
  if i = U_1 then loop (uintptr_p_inc (p), n-1) else false
end // end of [then]
else true // end of [else]
//
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
  $UN.ptr0_get_at<uintptr> (addr@vec, asz-1) = (U_1 >> extra)
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
bitvecptr_is_full
  {l}{n}
  (bvp, nbit) = ans where
{
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val ans = bitvec_is_full (!p, nbit)
prval ((*void*)) = fpf (pf)
//
} (* end of [bitvecptr_is_full] *)

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
  val i1 = uintptr_p_get (p1)
  and i2 = uintptr_p_get (p2)
in
  if i1 = i2
    then let
      val p1 = uintptr_p_inc (p1)
      and p2 = uintptr_p_inc (p2)
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
  val i2 = uintptr_p_get (p2)
  val () = uintptr_p_set (p1, i2)
  val p1 = uintptr_p_inc (p1)
  and p2 = uintptr_p_inc (p2)
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
  val i = uintptr_p_get (p)
  val () = uintptr_p_set (p, lnot(i))
in
  loop (uintptr_p_inc (p), n - 1)
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
  val i = uintptr_p_get (pz)
  val i2 = lnot(i) land (U_1 >> extra)
  val () = uintptr_p_set (pz, i2)
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
  {l}{n}
  (bvp, nbit) = let
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
  val i1 = uintptr_p_get (p1)
  val i2 = uintptr_p_get (p2)
  val () = uintptr_p_set (p1, i1 lor i2)
  val p1 = uintptr_p_inc (p1)
  and p2 = uintptr_p_inc (p2)
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
  val i1 = uintptr_p_get (p1)
  val i2 = uintptr_p_get (p2)
  val () = uintptr_p_set (p1, i1 lxor i2)
  val p1 = uintptr_p_inc (p1)
  and p2 = uintptr_p_inc (p2)
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
  val i1 = uintptr_p_get (p1)
  val i2 = uintptr_p_get (p2)
  val () = uintptr_p_set (p1, i1 land i2)
  val p1 = uintptr_p_inc (p1)
  and p2 = uintptr_p_inc (p2)
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
  {l1,l2}{n}
  (bvp1, bvp2, nbit) = let
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
  {l1,l2}{n}
  (bvp1, bvp2, nbit) = let
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
  w: uintptr, n: int
) : void =
(
//
if
n > 0
then let
//
val b = $UN.cast{uint}(w land U1)
//
in
  fprint_uint(out, b); loop (w >> 1, n - 1)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
in
  loop (w, bitvec_get_wordsize())
end // end of [fprint_bitvec$word]

(* ****** ****** *)

implement
{}(*tmp*)
fprint_bitvec
  (out, vec, nbit) = let
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
  {l}{n}
  (out, bvp, nbit) = let
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
  loop1 (p, i+1, nbit-1, w lor (U1 << i2), i2+1)
) (* end of [else] *)
//
end // end of [then]
else (uintptr_p_set (p, w))
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
  loop1 (p, i, wsz, U0, 0)
//
in
  loop2 (uintptr_p_inc (p), i + wsz, nbit - wsz)
end // end of [then]
else (
  loop1 (p, i, nbit, U0, 0)
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

implement
{}(*tmp*)
bitvec_foreach
  (vec, nbit) = let
  var env: void = ()
in
  bitvec_foreach_env<void> (vec, nbit, env)
end // end of [bitvec_foreach]

(* ****** ****** *)

implement
{env}(*tmp*)
bitvec_foreach_env
  (vec, nbit, env) = let
//
val wsz = bitvec_get_wordsize ()
//
fun
loop
(
  p: ptr, nbit: intGt(0), env: &env
) : void = let
//
var w = uintptr_p_get(p)
//
in
//
if
nbit > wsz
then let
val () =
  bitvec_foreach$fwork<env> (w, wsz, env)
//
in
  loop (uintptr_p_inc(p), nbit - wsz, env)
end // end of [then]
else bitvec_foreach$fwork<env> (w, nbit, env)
//
end (* end of [loop] *)
//
in
//
if nbit > 0 then loop (addr@vec, nbit, env) else ()
//
end // end of [bitvec_foreach_env]

(* ****** ****** *)

implement(env)
bitvec_foreach$fwork<env>
  (w, n, env) = let
//
fun loop
(
  w: uintptr, n: int, env: &env >> _
) : void =
(
//
if
n > 0
then let
//
val b = $UN.cast{bit}(w land U1)
val () = bitvec_foreach$fworkbit(b, env)
//
val wsz = bitvec_get_wordsize()
//
in
  loop (w >> 1, n - 1, env)
end // end of [then]
else () // end of [else]
//
) (* end of [loop] *)
//
val wsz = bitvec_get_wordsize()
//
in
  if n <= wsz then loop (w, n, env) else loop (w, wsz, env)
end // end of [bitvec_foreach$fwork]

(* ****** ****** *)

implement
{}(*tmp*)
bitvecptr_foreach
  (bvp, nbit) = let
  var env: void = ()
in
  bitvecptr_foreach_env<void> (bvp, nbit, env)
end // end of [bitvecptr_foreach]

(* ****** ****** *)

implement
{env}(*tmp*)
bitvecptr_foreach_env
  {l}{n}
  (bvp, nbit, env) = let
//
val (pf, fpf | p) =
  $UN.ptr_vtake{bitvec(n)}(ptrcast(bvp))
val ((*void*)) = bitvec_foreach_env (!p, nbit, env)
prval ((*void*)) = fpf (pf)
//
in
  // nothing
end // end of [bitvecptr_foreach_env]

(* ****** ****** *)

(* end of [bitvec.dats] *)
