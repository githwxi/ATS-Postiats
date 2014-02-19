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
** At-Views
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: September, 2011
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{a:t@ype}
ptr_get0 {l:addr} (pf: a @ l | p: ptr l): (a @ l | a)

extern
fun{a:t@ype}
ptr_set0 {l:addr} (pf: a? @ l | p: ptr l, x: a): (a @ l | void)

fn{a:t@ype}
swap0 {l1,l2:addr} (
  pf1: a @ l1, pf2: a @ l2 | p1: ptr l1, p2: ptr l2
) : (a @ l1, a @ l2 | void) = let
  val (pf1 | tmp1) = ptr_get0<a> (pf1 | p1)
  val (pf2 | tmp2) = ptr_get0<a> (pf2 | p2)
  val (pf1 | ()) = ptr_set0<a> (pf1 | p1, tmp2)
  val (pf2 | ()) = ptr_set0<a> (pf2 | p2, tmp1)
in
  (pf1, pf2 | ())
end // end of [swap0]

(* ****** ****** *)

extern
fun{a:t@ype}
ptr_get1 {l:addr} (pf: !a @ l >> a @ l | p: ptr l): a

extern
fun{a:t@ype}
ptr_set1 {l:addr} (pf: !a? @ l >> a @ l | p: ptr l, x: a): void

(* ****** ****** *)

implement{a} ptr_get1 (pf | p) = !p
implement{a} ptr_set1 (pf | p, x) = !p := x

(* ****** ****** *)

fn{a:t@ype}
swap1 {l1,l2:addr}
(
  pf1: !a @ l1, pf2: !a @ l2 | p1: ptr l1, p2: ptr l2
) : void = let
  val tmp = ptr_get1<a> (pf1 | p1)
  val () = ptr_set1<a> (pf1 | p1, ptr_get1<a> (pf2 | p2))
  val () = ptr_set1<a> (pf2 | p2, tmp)
in
  // nothing
end // end of [swap1]

(* ****** ****** *)

fn{a:t@ype}
swap1 {l1,l2:addr}
(
  pf1: !a @ l1, pf2: !a @ l2 | p1: ptr l1, p2: ptr l2
) : void = let
  val tmp = !p1 in !p1 := !p2; !p2 := tmp
end // end of [swap1]

(* ****** ****** *)

viewtypedef tptr (a:t@ype, l:addr) = (a @ l | ptr l)

fn getinc
  {l:addr} {n:nat} (
  cnt: !tptr (int(n), l) >> tptr (int(n+1), l)
) : int(n) = n where {
  val n = ptr_get1<int(n)> (cnt.0 | cnt.1)
  val () = ptr_set1<int(n+1)> (cnt.0 | cnt.1, n+1)
} // end of [getinc]

(* ****** ****** *)

viewtypedef cloptr
  (a:t@ype, b:t@ype, l:addr) =
  [env:t@ype] (((&env, a) -> b, env) @ l | ptr l)
// end of [cloptr]

(* ****** ****** *)

fun{
a:t@ype}{b:t@ype
} cloptr_app {l:addr}
(
  pclo: !cloptr (a, b, l), x: a
) : b = let
  val p = pclo.1
  prval pf = pclo.0 // takeout pf: ((&env, a) -> b, env) @ l
  val res = !p.0 (!p.1, x)
  prval () = pclo.0 := pf // return pf
in
  res
end // end of [cloptr]

(* ****** ****** *)

fn{
a:t@ype
} swap2
(
  x1: &a, x2: &a
) : void = let
  val tmp = x1 in x1 := x2; x2 := tmp
end // end of [swap2]

fn{a:t@ype}
swap1 {l1,l2:addr}
(
  pf1: !a @ l1, pf2: !a @ l2 | p1: ptr l1, p2: ptr l2
) : void = swap2 (!p1, !p2)

(* ****** ****** *)

fn foo (): void = let
  var x0: int // view@ (x0): int? @ x0
  val () = x0 := 0 // view@ (x0): int(0) @ x0
  var x1: int = 1 // view@ (x1): int(1) @ x1
//
// [with] is a keyword in ATS
//
  var y: int with pfy // pfy is an alias of view@ (y): int? @ y
  val () = y := 2 // pfy = view@ (y): int(2) @ y
  var z: int with pfz = 3 // pfz is an alias of view@ (z): int(3) @ z
in
  // nothing
end // end of [f]

(* ****** ****** *)

fn fact {n:nat}
  (n: int n): int = let
  fun loop {n:nat} {l:addr} .<n>.
    (pf: !int @ l | n: int n, res: ptr l): void =
    if n > 0 then let
      val () = !res := n * !res in loop (pf | n-1, res)
    end // end of [if]
  // end of [loop]
  var res: int with pf = 1
  val () = loop (pf | n, addr@res) // &res: the pointer to res
in
  res
end // end of [fact]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [atview.dats] *)
