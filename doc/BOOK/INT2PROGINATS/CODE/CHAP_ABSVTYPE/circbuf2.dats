(* ****** ****** *)
//
// An Array-based implementation of circular buffer 
//
(* ****** ****** *)

(*
** Copyright (C) 2011 Hongwei Xi, Boston University
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Time: November, 2011
*)

(* ****** ****** *)
//
// HX-2014-03-03: ported to ATS2
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./circbuf.sats"

(* ****** ****** *)

typedef
cbuf_struct = @{
  p_beg= ptr // the start location of the array
, m=size_t // the maximal capacity of the buffer (m > 0)
, n=size_t // the current size of the buffer (0 <= n <= m)
, f=size_t // the total number of removed elements
} // end of [cbuf_struct]

(* ****** ****** *)

absvtype
cbufObj_minus_struct (a:viewt@ype, m:int, n:int, l:addr)

(* ****** ****** *)

extern
castfn
cbufObj_takeout_struct
  {a:vt@ype}{m,n:int}
(
  buf: !cbufObj (a, m, n) >> cbufObj_minus_struct (a, m, n, l)
) : #[l:addr] (cbuf_struct @ l | ptr l)

extern
praxi
cbufObj_addback_struct
  {a:vt@ype}{m,n:int}{l:addr}
(
  pfat: cbuf_struct @ l
| buf: !cbufObj_minus_struct (a, m, n, l) >> cbufObj (a, m, n)
) : void // end of [cbufObj_addback_struct]

(* ****** ****** *)

implement{a}
cbufObj_get_cap
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val m = p->m
  prval () = cbufObj_addback_struct (pfat | buf)
in
  $UN.cast{size_t(m)}(m)
end // end of [circbuf_get_cap]

(* ****** ****** *)

implement{a}
cbufObj_get_size
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val n = p->n
  prval () = cbufObj_addback_struct (pfat | buf)
in
  $UN.cast{size_t(n)}(n)
end // end of [circbuf_get_size]

(* ****** ****** *)

implement{a}
cbufObj_is_empty
  {m,n} (buf) = cbufObj_get_size (buf) = 0
// end of [cbufObj_is_empty]

implement{a}
cbufObj_isnot_empty
  {m,n} (buf) = cbufObj_get_size (buf) > 0
// end of [cbufObj_isnot_empty]

(* ****** ****** *)

implement{a}
cbufObj_is_full
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val m = p->m and n = p->n
  prval () = cbufObj_addback_struct (pfat | buf)
in
  $UN.cast{bool(m==n)}(m = n)
end // end of [cbufObj_is_full]

implement{a}
cbufObj_isnot_full
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val m = p->m and n = p->n
  prval () = cbufObj_addback_struct (pfat | buf)
in
  $UN.cast{bool(m > n)}(m > n)
end // end of [cbufObj_isnot_full]

(* ****** ****** *)

implement{a}
cbufObj_new{m} (m) = let
  val (pf1, pf1gc | parr) = array_ptr_alloc<a> (m)
  val (pf2, pf2gc | pbuf) = ptr_alloc<cbuf_struct> ()
  val () = pbuf->p_beg := parr
  val () = pbuf->m := m
  val () = pbuf->n := i2sz(0)
  val () = pbuf->f := i2sz(0)
in
  $UN.castvwtp0{cbufObj(a,m,0)}((pf1, pf1gc, pf2, pf2gc | pbuf))
end // end [cbufObj_new]

(* ****** ****** *)

implement
cbufObj_free (buf) = let
//
val (pfat | p) =
  cbufObj_takeout_struct (buf)
val () =
__free (p->p_beg) where
{
  extern fun __free (p: ptr): void = "atspre_mfree_gc"
} (* end of [where] *) // end of [val]
prval () = cbufObj_addback_struct (pfat | buf)
//
val () = __free (buf) where
{
  extern fun __free {vt:vtype} (x: vt): void = "atspre_mfree_gc"
} (* end of [where] *) // end of [val]
//
in
  // nothing
end // end of [cbufObj_free]

(* ****** ****** *)

implement
cbufObj_clear
  {a}{m,n} (buf) = let
//
val (pfat | p) = cbufObj_takeout_struct (buf)
val () = p->n := i2sz(0)
prval () = cbufObj_addback_struct (pfat | buf)
prval () =
__assert (buf) where
{
  extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, 0)): void
} (* end of [where] *) // end of [prval]
in
  // nothing
end // end of [cbufObj_clear]

(* ****** ****** *)

(*
fun{a:t@ype}
cbufObj_insert
  {m,n:int | n < m} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1), x: a
) : void // end of [cbufObj_insert]
*)
implement{a}
cbufObj_insert
  {m,n} (buf, x) = {
//
  prval () = lemma_cbufObj_param (buf)
//
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val n = p->n and f = p->f
  val ofs = g0uint_mod_size (f+n, p->m)
  val p_ofs = ptr_add<a> (p->p_beg, ofs)
  val () = $UN.ptr0_set<a> (p_ofs, x)
  val () = p->n := succ (n)
  prval () = cbufObj_addback_struct (pfat | buf)
  prval () =
  __assert (buf) where
  {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1)): void
  } (* end of [where] *) // end of [prval]
} // end of [cbufObj_insert]

(* ****** ****** *)

(*
fun{a:t@ype}
cbufObj_remove
  {m,n:int | n > 0} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)
) : a // end of [cbufObj_remove]
*)
implement{a}
cbufObj_remove
  {m,n} (buf) = x where
{
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val f = p->f
  val n = p->n and f = p->f
  val ofs = g0uint_mod_size (f, p->m)
  val p_ofs = ptr_add<a> (p->p_beg, ofs)
  val x = $UN.ptr0_get<a> (p_ofs)
  val () = p->n := pred (n)
  val () = p->f := succ (f)
  prval () = cbufObj_addback_struct (pfat | buf)
  prval () =
  __assert (buf) where {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)): void
  } (* end of [where] *) // end of [prval]
} (* end of [cbufObj_remove] *)

(* ****** ****** *)

implement
main0 () =
{
//
val buf = cbufObj_new (i2sz(2))
//
val () = cbufObj_insert<int> (buf, 1)
val () = cbufObj_insert<int> (buf, 2)
//
val () = cbufObj_clear{int} (buf)
//
val () = cbufObj_insert<int> (buf, 1)
val () = cbufObj_insert<int> (buf, 2)
//
val x = cbufObj_remove<int> (buf)
val () = println! ("x(1) = ", x)
//
val () = cbufObj_insert<int> (buf, 3)
//
val x = cbufObj_remove<int> (buf)
val () = println! ("x(2) = ", x)
val x = cbufObj_remove<int> (buf)
val () = println! ("x(3) = ", x)
//
val () = cbufObj_insert<int> (buf, 4)
val x = cbufObj_remove<int> (buf)
val () = println! ("x(4) = ", x)
//
val ((*freed*)) = cbufObj_free (buf)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [circbuf2.dats] *)
