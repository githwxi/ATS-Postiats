(*
** A simple implementation of
** Game-of-24 in ATS for use in Objective-C
*)

(* ****** ****** *)
//
// HX: no dynloading
//
#define ATS_DYNLOADFLAG 0
//
(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)
//
local
#include "../GameOf24_card.dats"
in (*nothing*) end
//
local
#include "../GameOf24_cardset.dats"
in (*nothing*) end
//
local
#include "../GameOf24_solve.dats"
in (*nothing*) end
//
(* ****** ****** *)

staload "../GameOf24.sats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
// HX-2013-08:
// [play24] is declared in Java class [GameOf24]
//
extern
fun
OBJC_GameOf24_play24
(
  n1: int, n2: int
, n3: int, n4: int
, nsol: &int? >> int(n)
) : #[n:nat] arrayptr(Strptr1, n) = "ext#"
//
extern
fun
OBJC_GameOf24_free{n:int}
  (arrayptr(Strptr1, n), size_t n): void = "ext#"
//
(* ****** ****** *)

implement
OBJC_GameOf24_play24
(
  n1, n2, n3, n4, nsol
) = let
//
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val nres = list_length (res)
val ((*void*)) = nsol := nres
//
val A =
  arrayptr_make_uninitized<string> (i2sz(nres))
val _(*nsol*) =
  stringize_cardlst_save (res, ptrcast(A), nsol)
//
prval
[n:int]
EQINT () = g1int_get_index (nres)
//
in
  $UN.castvwtp0{arrayptr(Strptr1,n)}(A)
end // end of [OBJC_GameOf24_play24]

(* ****** ****** *)

implement
OBJC_GameOf24_free
  (A, n) = let
//
implement{a}
array_uninitize$clear
  (i, x) = strptr_free ($UN.castvwtp0{Strptr1}(x))
//
in
  arrayptr_freelin (A, n)
end // end of [OBJC_GameOf24_free]

(* ****** ****** *)

%{$
//
// HX: This is ATS runtime:
//
#include "pats_ccomp_runtime.c"
#include "pats_ccomp_runtime2_dats.c"
#include "pats_ccomp_runtime_memalloc.c"
#include "pats_ccomp_runtime_trywith.c"
%}

(* ****** ****** *)

(* end of [GameOf24.dats] *)
