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
** Dataview for strings
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: December 31, 2015
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
dataview
strbuf_v(addr, int) =
  | {l:addr}
    strbuf_v_nil(l, 0) of (char(0) @ l)
  | {l:addr}{n:nat}
    strbuf_v_cons(l, n+1) of
      (charNZ @ l, strbuf_v(l+sizeof(char), n))
    // end of [strbuf_v_cons]
//
(* ****** ****** *)

vtypedef strptr(l:addr, n:int) = (strbuf_v(l, n) | ptr(l))

(* ****** ****** *)

extern
prfun
strbuf_v_getfst
  {l:addr}{n:int}
(
  pf: strbuf_v(l, n)
) : [
  c:int | (c==0 && n==0) || (c != 0 && n > 0)
] (char(c) @ l, char(c) @ l -<lin,prf> strbuf_v(l, n))

(* ****** ****** *)

primplmnt
strbuf_v_getfst
  (pf) =
(
case+ pf of
| strbuf_v_nil(pf_at) => #[.. | (pf_at, llam(pf_at) => strbuf_v_nil(pf_at))]
| strbuf_v_cons(pf_at, pf2) => #[.. | (pf_at, llam(pf_at) => strbuf_v_cons(pf_at, pf2))]
)

(* ****** ****** *)
//
fun
strptr_is_nil
  {l:addr}{n:int}
(
  str: !strptr(l, n)
) : bool(n==0) = let
//
  prval
  (pf_at, fpf) =
    strbuf_v_getfst(str.0)
  // prval
  val c0 = !(str.1)
  prval () = str.0 := fpf(pf_at)
in
  iseqz(c0) // testing whether [c0] is null
end // end of [strptr_is_nil]
//
(* ****** ****** *)

fun
strptr_length
  {l:addr}{n:int}
(
  str: !strptr(l, n)
) : size_t(n) = let
//
fun
loop
{l:addr}
{i,j:int}
(
  pf: !strbuf_v(l, i)
| p0: ptr(l), j: size_t(j)
) : size_t(i+j) = let
//
prval
[c:int]
(pf_at, fpf) = strbuf_v_getfst(pf)
//
val c0 = !p0
//
prval ((*return*)) = pf := fpf(pf_at)
//
in
//
if
iseqz(c0)
then j
else res where
{
  prval
  strbuf_v_cons(pf_at, pf2) = pf
  val res = loop(pf2 | ptr_succ<char>(p0), succ(j))
  prval ((*folded*)) = pf := strbuf_v_cons(pf_at, pf2)
} (* end of [else] *)
//
end // end of [loop]
//
in
  loop(str.0 | str.1, i2sz(0))
end // end of [strptr_length]  

(* ****** ****** *)

(* end of [strbuf.dats] *)
