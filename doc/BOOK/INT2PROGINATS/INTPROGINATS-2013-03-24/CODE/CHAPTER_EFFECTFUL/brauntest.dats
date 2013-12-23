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
** Example: Testing for Braun Trees
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list0.dats"

(* ****** ****** *)

datatype tree (a:t@ype) =
  | tree_nil (a) of ()
  | tree_cons (a) of (a, tree(a)(*left*), tree(a)(*right*))
// end of [tree]

(* ****** ****** *)

fun{a:t@ype}
size (t: tree a): int = case+ t of
  | tree_nil () => 0
  | tree_cons (_, tl, tr) => 1 + size(tl) + size(tr)
// end of [size]

(* ****** ****** *)

fun{a:t@ype}
brauntest0 (t: tree a): bool = case+ t of
  | tree_nil () => true
  | tree_cons (_, tl, tr) => let
      val cond1 = brauntest0(tl) andalso brauntest0(tr)
    in
      if cond1 then let
        val df = size(tl) - size(tr) in (df = 0) orelse (df = 1)
      end else false
    end // end of [tree_cons]
// end of [brauntest0]

(* ****** ****** *)

fun{a:t@ype}
brauntest1 (t: tree a): bool = let
  exception Negative of ()
  fun aux (t: tree a): int = case+ t of
    | tree_nil () => 0
    | tree_cons (_, tl, tr) => let
        val szl = aux (tl) and szr = aux (tr)
        val df = szl - szr
      in
        if df = 0 orelse df = 1 then 1+szl+szr else $raise Negative()
      end // end of [tree_cons]
   // end of [aux]
in
  try let
    val _ = aux (t)
  in
    true // [t] is a Braun tree if no exception
  end with
    ~Negative() => false // [t] is not a Braun tree
  // end of [try]
end // end of [brauntest1]

(* ****** ****** *)

(*
** [list2bt] turns a list intto a Braun tree
*)
fun{a:t@ype}
list2bt (xs: list0 a): tree (a) = let
  fun aux (xs: list0 a, n: int): tree (a) =
    if n > 0 then
      split (xs, n, n/2, list0_nil)
    else tree_nil ()
  and split (
    xs: list0 a, n: int, i: int, xsf: list0 a
  ) : tree a =
    if i > 0 then let
      val- list0_cons (x, xs) = xs
    in
      split (xs, n, i-1, list0_cons (x, xsf))
    end else let
      val- list0_cons (x, xs) = xs
    in
      tree_cons (x, aux (xsf, n/2), aux (xs, n-1-n/2))
    end // end of [split]
in
  aux (xs, list0_length<a> (xs))
end // end of [list2bt]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement randgen<T> () = drand48 ()

(* ****** ****** *)

implement
main () = () where {
  #define N1 57
  val xs = list2bt (list0_randgen<T> (N1))
  val () = assertloc (brauntest0 (xs))
  #define N2 1000
  val xs = list2bt (list0_randgen<T> (N2))
  val () = assertloc (brauntest1 (xs))
} // end of [main]

(* ****** ****** *)

(* end of [brauntest.dats] *)
