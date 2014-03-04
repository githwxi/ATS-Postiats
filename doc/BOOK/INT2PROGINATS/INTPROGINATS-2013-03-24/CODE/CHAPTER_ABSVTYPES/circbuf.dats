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
** Array-based implementation of circular buffer 
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: November, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "prelude/DATS/pointer.dats"

(* ****** ****** *)

staload "circbuf.sats"

(* ****** ****** *)

typedef
cbuf_struct = @{
  p_beg= ptr // the start location of the array
, p_end= ptr // the finish location of the array
, p_frst= ptr // the start location of the used segment
, p_last= ptr // the start location of the unused segment
} // end of [cbuf_struct]

(* ****** ****** *)

absviewtype
cbufObj_minus_struct (a:viewt@ype, m:int, n:int, l:addr)

(* ****** ****** *)

extern
castfn
cbufObj_takeout_struct
  {a:viewt@ype} {m,n:int} (
  buf: !cbufObj (a, m, n) >> cbufObj_minus_struct (a, m, n, l)
) : #[l:addr] (cbuf_struct @ l | ptr l)

extern
praxi
cbufObj_addback_struct
  {a:viewt@ype} {m,n:int} {l:addr} (
  pfat: cbuf_struct @ l
| buf: !cbufObj_minus_struct (a, m, n, l) >> cbufObj (a, m, n)
) : void // end of [cbufObj_addback_struct]

(* ****** ****** *)

implement{a}
cbufObj_get_cap {m,n} (buf) = let
//
  prval () = cbufObj_param_lemma (buf)
//
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p1 = (ptr1_of_ptr)p->p_beg
  and p2 = (ptr1_of_ptr)p->p_end
  val m1sz = pdiff (p2, p1)
  prval () = cbufObj_addback_struct (pfat | buf)
  extern fun szdiv {x:int} (
    x: ptrdiff_t(x), y: size_t
  ) : size_t (m+1) = "mac#atspre_div_size_size"
in
  szdiv (m1sz, sizeof<a>) - 1
end // end of [circbuf_get_cap]

(* ****** ****** *)

implement{a}
cbufObj_get_size {m,n} (buf) = let
//
  prval () = cbufObj_param_lemma (buf)
//
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p1 = (ptr1_of_ptr)p->p_frst
  and p2 = (ptr1_of_ptr)p->p_last
  prval () = cbufObj_addback_struct (pfat | buf)
in
//
if p1 <= p2 then let
  val nsz = pdiff (p2, p1)
  extern fun szdiv {x:int} (
    x: ptrdiff_t(x), y: size_t
  ) : size_t (n) = "mac#atspre_div_size_size"
in
  szdiv (nsz, sizeof<a>)
end else let
  val n1sz = pdiff (p1, p2)
  extern fun szdiv {x:int} (
    x: ptrdiff_t(x), y: size_t
  ) : size_t (m+1-n) = "mac#atspre_div_size_size"
  val n1 = szdiv (n1sz, sizeof<a>)
in
  cbufObj_get_cap {m,n} (buf) + 1 - n1
end // end of [if]
//
end // end of [circbuf_get_size]

(* ****** ****** *)

fun{a:viewt@ype}
cpadd (pb: ptr, pe: ptr, p: ptr): ptr = let
  val p1 = p + sizeof<a> in if p1 < pe then p1 else pb
end // end of [cpadd]

(* ****** ****** *)

implement{a}
cbufObj_is_empty
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p1 = p->p_frst
  and p2 = p->p_last
  prval () = cbufObj_addback_struct (pfat | buf)
  extern fun cpeq (p1: ptr, p2: ptr): bool (n==0) = "mac#atspre_peq"
in
  cpeq (p1, p2)
end // end of [cbufObj_is_empty]

implement{a}
cbufObj_isnot_empty
  {m,n} (buf) = let
  prval () = cbufObj_param_lemma (buf)
in
  ~cbufObj_is_empty (buf)
end // end of [cbufObj_isnot_empty]

(* ****** ****** *)

implement{a}
cbufObj_is_full
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p1 = p->p_frst and p2 = p->p_last
  val p2_next = cpadd<a> (p->p_beg, p->p_last, p2)
  prval () = cbufObj_addback_struct (pfat | buf)
  extern fun cpeq (p1: ptr, p2: ptr): bool (m==n) = "mac#atspre_peq"
in
  cpeq (p1, p2_next)
end // end of [cbufObj_is_full]

implement{a}
cbufObj_isnot_full
  {m,n} (buf) = let
  prval () = cbufObj_param_lemma (buf)
in
  ~cbufObj_is_full (buf)
end // end of [cbufObj_isnot_full]

(* ****** ****** *)

implement{a}
cbufObj_new {m} (m) = let
  val m1 = m + 1
  val (pfgc1, pfarr | parr) = array_ptr_alloc<a> (m1)
  val (pfgc2, pfbuf | pbuf) = ptr_alloc<cbuf_struct> ()
  val () = pbuf->p_beg := parr
  val () = pbuf->p_end := parr + m1 * sizeof<a>
  val () = pbuf->p_frst := parr
  val () = pbuf->p_last := parr
  extern castfn ofptr {v1,v2,v3,v4:view}
    (pf1:v1, pf2:v2, pf3:v2, pf4: v4 | p: ptr): cbufObj (a, m, 0)
  // end of [ofptr]
in
  ofptr (pfgc1, pfarr, pfgc2, pfbuf | pbuf)
end // end [cbufObj_new]

implement
cbufObj_free (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val () = __free (p->p_beg) where {
    extern fun __free (p: ptr): void = "ats_free_gc"
  } // end of [val]
  prval () = cbufObj_addback_struct (pfat | buf)
  val () = __free (buf) where {
    extern fun __free {vt:viewtype} (x: vt): void = "ats_free_gc"
  } // end of [val]
in
  // nothing
end // end of [cbufObj_free]

(* ****** ****** *)

implement
cbufObj_clear_type
  {a} {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p_beg = p->p_beg
  val () = p->p_frst := p_beg
  val () = p->p_last := p_beg
  prval () = cbufObj_addback_struct (pfat | buf)
  prval () = __assert (buf) where {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, 0)): void
  } // end of [prval]
in
  // nothing
end // end of [cbufObj_clear_type]

(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"
staload _(*anon*) = "prelude/DATS/unsafe.dats"

(*
fun{a:t@ype}
cbufObj_insert
  {m,n:int | n < m} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1), x: a
) : void // end of [cbufObj_insert]
*)
implement{a}
cbufObj_insert {m,n} (buf, x) = {
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p_last = p->p_last
  val () = p->p_last := cpadd<a> (p->p_beg, p->p_end, p_last)
  prval () = cbufObj_addback_struct (pfat | buf)
  val () = $UN.ptr0_set<a> (p_last, x)
  prval () = __assert (buf) where {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n+1)): void
  } // end of [prval]
} // end of [cbufObj_insert]

(*
fun{a:t@ype}
cbufObj_remove
  {m,n:int | n > 0} (
  buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)
) : a // end of [cbufObj_remove]
*)
implement{a}
cbufObj_remove {m,n} (buf) = x where {
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val p_frst = p->p_frst
  val () = p->p_frst := cpadd<a> (p->p_beg, p->p_end, p_frst)
  prval () = cbufObj_addback_struct (pfat | buf)
  val x = $UN.ptr0_get<a> (p_frst)
  prval () = __assert (buf) where {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)): void
  } // end of [prval]
} // end of [cbufObj_remove]

(* ****** ****** *)

implement
main () = () where
{
  val buf = cbufObj_new (2)
//
  val () = cbufObj_insert<int> (buf, 1)
  val () = cbufObj_insert<int> (buf, 2)
  val () = cbufObj_clear_type {int} (buf)
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
  val () = cbufObj_free (buf)
} (* end of [main] *)

(* ****** ****** *)

(* end of [circbuf.dats] *)
