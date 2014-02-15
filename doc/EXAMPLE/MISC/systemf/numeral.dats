//
// BU CAS CS 520: Principles of Programing Languages
// Instructor: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
// Time: Fall 2005
//
(* ****** ****** *)
//
// Some examples in System F
// By Hongwei Xi (November 2, 2005)
//
(* ****** ****** *)
//
// HX-2010-08-12:
// This code is updated to compile and run under ATS-0.2.1. Voila!
//
(* ****** ****** *)
//
// HX-2012-11-26: ported to ATS/Postiats
//
(* ****** ****** *)

typedef
tpair (a: type, b: type) = '(a, b)
stadef * = tpair

(* ****** ****** *)

fn pair_get_fst {X,Y:type} (xy: X * Y):<> X = xy.0
fn pair_get_snd {X,Y:type} (xy: X * Y):<> Y = xy.1

(* ****** ****** *)
//
// Implementing Church numerals in System F
//
(* ****** ****** *)

typedef
cfun (a: type, b: type) = a -<cloref0> b

typedef nat_f =
  {X:type} cfun (cfun (X, X), cfun (X, X))
// end of [nat_f]

typedef nat2_f = nat_f * nat_f
typedef fnat_f = cfun (nat_f, nat_f)

(* ****** ****** *)

val Z = (lam s => lam z => z): nat_f
val S = lam (n: nat_f): nat_f =<cloref0> lam s => lam z => n(s)(s(z))

(* ****** ****** *)

val _0f = Z
val _1f = S(_0f)
val _2f = S(_1f)
val _3f = S(_2f)
val _4f = S(_3f)
val _5f = S(_4f)

(* ****** ****** *)

fn add (m: nat_f, n: nat_f):<> nat_f = m (S) (n)
fn mul (m: nat_f, n: nat_f):<> nat_f = m {nat_f} (n S) (Z)
fn pow (m: nat_f, n: nat_f):<> nat_f = n {fnat_f} (m {nat_f}) (S) (Z)

(* ****** ****** *)

fn pred (
  n: nat_f
) :<> nat_f = let
  typedef X = nat2_f
  val z = '(_0f, _0f)
  val s = lam (nn: X) =<cloref0> let val n = nn.0 in '(S n, n) end
  val '(_, res) = n {X} (s) (z)
in
   res
end // end of [pred]

(* ****** ****** *)

fn fact (
  n: nat_f
) :<> nat_f = let
  typedef X = nat2_f
  val z = '(_1f, _1f)
  val s =
    lam (xy: X) =<cloref0>
    let val x = xy.0 and y = xy.1 in '(S x, mul (x, y)) end
  // end of [val]
in
  pair_get_snd (n {X} (s) (z))
end // end of [fact]

(* ****** ****** *)

fun fib (
  n: nat_f
) : nat_f = let
  typedef X = nat2_f
  val z: X = '(_0f, _1f)
  val s = lam (xy: X) =<cloref0> '(xy.1, add (xy.0, xy.1))
in
  pair_get_fst (n {X} (s) (z))
end // end of [fib]

(* ****** ****** *)

fn ack (
  m: nat_f
) :<> fnat_f = let
  typedef X = fnat_f
  val helper =
    lam (f: X) =<cloref0>
    lam (n: nat_f) =<cloref0> f (n {nat_f} (f) (_1f))
  // end of [val]
in
  m {X} (helper) (S)
end // end of [ack]

(* ****** ****** *)

implement main () = 0 where { }

(* ****** ****** *)

(* end of [numeral.dats] *)
