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
//
// Implementing generic trees in System F
//
(* ****** ****** *)

typedef
tpair (a: type, b: type) = '(a, b)
stadef * = tpair

fn pair_get_fst {X,Y:type} (xy: X * Y):<> X = xy.0
fn pair_get_snd {X,Y:type} (xy: X * Y):<> Y = xy.1

(* ****** ****** *)

typedef
gtree_f (A: type) =
  {X:type} (X, (A -<cloref0> X) -<cloref0> X) -<cloref0> X
// end of [gtree_f]

(* ****** ****** *)

val E =
  lam {A:type}: gtree_f(A) => lam (e, b) => e
val B = lam {A:type}
  (f: A -<cloref0> gtree_f(A)): gtree_f(A) =<cloref0> lam (e, b) => b (lam x => f (x) (e, b))
// end of [B]

(* ****** ****** *)

abstype int
extern val _0 : int
extern val _1 : int
extern fun succ : int -<> int
extern fun _add : (int, int) -<> int
extern fun _igt : (int, int) -<> bool
extern fun _ieq : (int, int) -<> bool
extern fun _max : (int, int) -<> int

(* ****** ****** *)

typedef A = int
typedef btree_f = gtree_f (A)

(* ****** ****** *)

fn btree_size (t: btree_f):<> int = let
  typedef X = int
  val e = _0
  val b = lam (f: (A -<cloref0> X)): X =<cloref0> succ (f _1 \_add f _0)
in
  t {X} (e, b)
end // end of [btree_size]

fn btree_height (t: btree_f):<> int = let
  typedef X = int
  val e = _0
  val b = lam (f: (A -<cloref0> X)): X =<cloref0> succ (f _1 \_max f _0)
in
  t {X} (e, b)
end // end of [btree_height]

(* ****** ****** *)

fn btree_isperfect
  (t0: btree_f):<> bool = let
  typedef X = Option int
  val e = (Some _0): X
  val b = lam (
    f: A -<cloref0> X
  ) : X =<cloref0>
    case+ (f _0, f _1) of
    | (Some h1, Some h2) =>
        if h1 \_ieq h2 then Some (succ h1) else None
    | (_, _) => None
  // end of [val]
in
   case+ t0{X}(e, b) of None () => false | Some _ => true
end // end of [btree_isperfect]

(* ****** ****** *)

fn btree_left
  (t: btree_f):<> btree_f = let
  typedef X = btree_f * btree_f
  val e = '(E, E): X
  val b = lam
    (f: (A -<cloref0> X)): X =<cloref0> let
    val '(t1, _) = f (_1); val '(t2, _) = f (_0)
    val f1 = lam (x: A): btree_f =<cloref0> if x \_igt _0 then t1 else t2
  in
    '(B {A} (f1), t2)
  end // end of [val]
in
  pair_get_snd (t {X} (e, b))
end // end of [left_child_tree]

fn btree_right
  (t: btree_f):<> btree_f = let
  typedef X = btree_f * btree_f
  val e = '(E, E): X
  val b = lam
    (f: (A -<cloref0> X)): X =<cloref0> let
    val '(t1, _) = f (_1); val '(t2, _) = f (_0)
    val f1 = lam (x: A): btree_f =<cloref0> if x \_igt _0 then t1 else t2
  in
    '(B {A} (f1), t1)
  end // end of [val]
in
  pair_get_snd (t {X} (e, b))
end // end of [right_child_tree]

(* ****** ****** *)

implement main () = 0 where { }

(* ****** ****** *)

(* end of [gtree.dats] *)
