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
, m=size_t // the maximal capacity of the buffer (m > 0)
, n=size_t // the current size of the buffer (0 <= n <= m)
, f=size_t // the total number of removed elements
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
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val m = p->m
  prval () = cbufObj_addback_struct (pfat | buf)
  extern castfn __cast (m: size_t): size_t (m)
in
  __cast (m)
end // end of [circbuf_get_cap]

(* ****** ****** *)

implement{a}
cbufObj_get_size {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val n = p->n
  prval () = cbufObj_addback_struct (pfat | buf)
  extern castfn __cast (n: size_t): size_t (n)
in
  __cast (n)
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
  extern castfn __cast (x: bool): bool (m==n)
in
  __cast (m = n)
end // end of [cbufObj_is_full]

implement{a}
cbufObj_isnot_full
  {m,n} (buf) = let
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val m = p->m and n = p->n
  prval () = cbufObj_addback_struct (pfat | buf)
  extern castfn __cast (x: bool): bool (n < m)
in
  __cast (n < m)
end // end of [cbufObj_isnot_full]

(* ****** ****** *)

implement{a}
cbufObj_new {m} (m) = let
  val (pfgc1, pfarr | parr) = array_ptr_alloc<a> (m)
  val (pfgc2, pfbuf | pbuf) = ptr_alloc<cbuf_struct> ()
  val () = pbuf->p_beg := parr
  val () = pbuf->m := m
  val () = pbuf->n := (size_of_int1)0
  val () = pbuf->f := (size_of_int1)0
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
  val () = p->n := (size_of_int1)0
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
//
  prval () = cbufObj_param_lemma (buf)
//
  val (pfat | p) = cbufObj_takeout_struct (buf)
  val n = p->n and f = p->f
  val ofs = mod_size_size (f+n, p->m) * sizeof<a>
  val () = $UN.ptr0_set<a> (p->p_beg+ofs, x)
  val () = p->n := n + 1
  prval () = cbufObj_addback_struct (pfat | buf)
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
  val f = p->f
  val n = p->n and f = p->f
  val ofs = mod_size_size (f, p->m) * sizeof<a>
  val x = $UN.ptr0_get<a> (p->p_beg+ofs)
  val () = p->n := n - 1
  val () = p->f := f + 1
  prval () = cbufObj_addback_struct (pfat | buf)
  prval () = __assert (buf) where {
    extern praxi __assert (buf: !cbufObj (a, m, n) >> cbufObj (a, m, n-1)): void
  } // end of [prval]
} // end of [cbufObj_remove]

(* ****** ****** *)

implement
main () = () where {
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
} // end of [val]

(* ****** ****** *)

(* end of [circbuf2.dats] *)
