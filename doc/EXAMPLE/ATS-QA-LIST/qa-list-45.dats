(* ****** ****** *)
//
// HX-2013-07
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

datavtype
toto_vt =
| Titi of (string)
| {n:nat}
  Totos of (arrayptr (toto_vt, n), size_t n)
// end of [toto_vt]

(* ****** ****** *)

vtypedef toto = toto_vt

(* ****** ****** *)
//
// HX-2013-07:
// initialization involving linear
// values is almost always a real pain!
//
extern
fun make_totos
  (t1: toto, t2: toto, t3: toto): arrayptr (toto, 3)
implement
make_totos
  (t1, t2, t3) = let
//
val asz = i2sz (3)
val (pf, pfgc | p) = array_ptr_alloc<toto> (asz)
//
val p1 = p
prval (pf1, pf) = array_v_uncons (pf)
val () = ptr_set<toto> (pf1 | p1, t1)
val p2 = ptr_succ<toto> (p1)
prval (pf2, pf) = array_v_uncons (pf)
val () = ptr_set<toto> (pf2 | p2, t2)
val p3 = ptr_succ<toto> (p2)
prval (pf3, pf) = array_v_uncons (pf)
val () = ptr_set<toto> (pf3 | p3, t3)
//
prval pf = array_v_unnil_nil{toto?,toto}(pf)
//
prval pf = array_v_cons (pf1, array_v_cons (pf2, array_v_cons (pf3, pf)))
//
in
  arrayptr_encode (pf, pfgc | p)
end // end of [make_totos]

(* ****** ****** *)

extern
fun printfree_toto (t: toto): void
implement
printfree_toto (t) = let
in
//
case+ t of
| ~Titi (s) => println! ("-> ", s)
| ~Totos (A, n) => let
    implement
    array_uninitize$clear<toto> (i, t) = printfree_toto (t)
  in
    arrayptr_freelin (A, n)
  end
//
end // end of [printfree_toto]

(* ****** ****** *)

extern
fun test_toto (): void

implement test_toto() = let
  val A = make_totos(Titi("hello"), Titi("world"), Titi("!"))
  val totos = Totos (A, i2sz(3))
in
  printfree_toto (totos)
end

implement main0 (argc, argv) =  test_toto()

(* ****** ****** *)

(* end of [qa-list-45.dats] *)
