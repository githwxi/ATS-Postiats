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
** Example: Functional Random-Access Lists
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: Feburary, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/list.dats"
staload _(*anon*) = "prelude/DATS/list_vt.dats"

(* ****** ****** *)

typedef pt (a:t@ype) = '(a, a)

(* ****** ****** *)

datatype
ralist (a:t@ype+, n:int) =
  | RAnil (a, 0)
  | {n:pos} RAevn (a, 2*n) of ralist (pt a, n)
  | {n:nat} RAodd (a, 2*n+1) of (a, ralist (pt a, n))
// end of [ralist]

(* ****** ****** *)

val _ = RAodd(1, RAevn(RAodd( '( '(2, 3), '(4, 5) ), RAnil())))

(* ****** ****** *)

fun{a:t@ype}
ralist_length // O(log(n))-time
  {n:nat} .<n>.
  (xs: ralist (a, n)): int n =
  case+ xs of
  | RAnil () => 0
  | RAevn xxs => 2 * ralist_length<pt(a)> (xxs)
  | RAodd (_, xxs) => 2 * ralist_length<pt(a)> (xxs) + 1
// end of [ralist_length]

(* ****** ****** *)

fun{a:t@ype}
ralist_cons // O(log(n))-time
  {n:nat} .<n>.
  (x0: a, xs: ralist (a, n)): ralist (a, n+1) =
  case+ xs of
  | RAnil () => RAodd (x0, RAnil)
  | RAevn (xxs) => RAodd (x0, xxs)
  | RAodd (x1, xxs) =>
      RAevn (ralist_cons<pt(a)> ( '(x0, x1), xxs ))
    // end of [RAodd]
// end of [ralist_cons]

(* ****** ****** *)

fun{a:t@ype}
ralist_uncons // O(log(n))-time
  {n:pos} .<n>.
  (xs: ralist (a, n)): (a, ralist (a, n-1)) =
  case+ xs of
  | RAevn (xxs) => let
      val (xx, xxs) = ralist_uncons<pt(a)> (xxs)
    in
      (xx.0, RAodd (xx.1, xxs))
    end // end of [RAevn]
  | RAodd (x, xxs) => (case+ xxs of
(*
// Note =>> for enforcing sequentiality in typechecking:
*)
      RAnil () => (x, RAnil) | _ =>> (x, RAevn (xxs))
    ) // end of [RAodd]
// end of [ralist_uncons]

(* ****** ****** *)

fun{a:t@ype}
ralist_lookup // O(log(n))-time
  {n:int} {i:nat | i < n} .<n>.
  (xs: ralist (a, n), i: int i): a =
  case+ xs of
  | RAevn xxs => let
      val i2 = i / 2
      val lr = i - 2 * i2
      val xx = ralist_lookup<pt(a)> (xxs, i2)
    in
      if lr = 0 then xx.0 else xx.1
    end // end of [RAevn]
  | RAodd (x, xxs) =>
      if i > 0 then let
        val i1 = i - 1
        val i2 = i1 / 2
        val lr = i1 - 2 * i2
        val xx = ralist_lookup<pt(a)> (xxs, i2)
      in
        if lr = 0 then xx.0 else xx.1
      end else x
    // end of [RAodd]
// end of [ralist_lookup]

(* ****** ****** *)

fun{a:t@ype}
ralist_update // O(log(n))-time
  {n:int} {i:nat | i < n} .<n>. (
    xs: ralist (a, n), i: int i, x0: a
  ) : ralist (a, n) = let
//
  fun{a:t@ype} fupdate
    {n:int} {i:nat | i < n} .<n,1>. (
      xs: ralist (a, n), i: int i, f: a -<cloref1> a
    ) : ralist (a, n) =
    case+ xs of
    | RAevn xxs =>
        RAevn (fupdate2 (xxs, i, f))
    | RAodd (x, xxs) =>
        if i > 0 then
          RAodd (x, fupdate2 (xxs, i-1, f))
        else RAodd (f(x), xxs)
   (* end of [fupdate] *)
//   
   and fupdate2
     {n2:int} {i:nat | i < n2+n2} .<2*n2,0>. (
       xxs: ralist (pt(a), n2), i: int i, f: a -<cloref1> a
     ) : ralist (pt(a), n2) = let
     val i2 = i / 2
     val lr = i - 2 * i2
     val f2 = (
       if lr = 0 then
         lam xx => '(f(xx.0), xx.1)
       else
         lam xx => '(xx.0, f(xx.1))
     ) : pt(a) -<cloref1> pt(a)
   in
     fupdate<pt(a)> (xxs, i2, f2)
   end // end of [fupdate2]
//
in
  fupdate (xs, i, lam _ => x0)
end // end of [ralist_update]

(* ****** ****** *)

fun{a:t@ype}
list2ralist {n:nat}
  (xs: list (a, n)): ralist (a, n) = let
  fun loop {i,j:nat} (
    xs: list (a, i), res: ralist (a, j)
  ) : ralist (a, i+j) =
    case+ xs of
    | list_cons (x, xs) => loop (xs, ralist_cons (x, res))
    | list_nil () => res
  // end of [loop]
in
  loop (xs, RAnil)
end // end of [list2ralist]

(* ****** ****** *)

fun{a:t@ype}
ralist2list {n:nat}
  (xs: ralist (a, n)): list_vt (a, n) = let
  fun loop {i,j:nat} (
    xs: ralist (a, i), res: list_vt (a, j)
  ) : list_vt (a, i+j) = case+ xs of
    | RAnil () => res
    | _ =>> let
        val xxs = ralist_uncons (xs) in
        loop (xxs.1, list_vt_cons (xxs.0, res))
      end  // end of [_]
  // end of [loop]
in
  loop (xs, list_vt_nil)
end // end of [ralist2list]

(* ****** ****** *)

staload "libc/SATS/random.sats"

staload "contrib/testing/SATS/randgen.sats"
staload _(*anon*) = "contrib/testing/DATS/randgen.dats"
staload "contrib/testing/SATS/fprint.sats"
staload _(*anon*) = "contrib/testing/DATS/fprint.dats"

(* ****** ****** *)

typedef T = double
implement randgen<T> () = drand48 ()
implement fprint_elt<T> (out, x) = fprintf (out, "%.2f", @(x))

(* ****** ****** *)

implement
main () = () where {
//
  val _err = srand48_with_gettimeofday ()
  val () = assertloc (_err = 0)
//
  #define N 10
  val xs = list_randgen<T> (N)
  val () = list_fprint_elt<T> (stdout_ref, xs, " >> ")
  val () = print_newline ()
  val rxs = list2ralist<T> (xs)
//
  val () = assertloc (ralist_length (rxs) = N)
//
  val I = randint (N)
  val x_I = list_nth (xs, I)
  val rx_I = ralist_lookup (rxs, N-1-I)
  val () = assertloc (x_I = rx_I)
//
  val I = randint (N)
  val x0 = randgen<T> ()
  val rx0 = ralist_lookup (ralist_update (rxs, I, x0), I)
(*
  val () = println! ("x0 = ", x0, " and rx0 = ", rx0)
*)
  val () = assertloc (x0 = rx0)
//
  val ys = ralist2list<T> (rxs)
  val () = list_vt_fprint_elt<T> (stdout_ref, ys, " >> ")
  val () = print_newline ()
  val () = list_vt_free (ys)
} // end of [main]

(* ****** ****** *)

(* end of [ralist.dats] *)
