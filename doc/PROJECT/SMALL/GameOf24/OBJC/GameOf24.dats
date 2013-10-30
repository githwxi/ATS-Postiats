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
fun OBJC_GameOf24_play24
  (n1: int, n2: int, n3: int, n4: int): void = "ext#"
// end of [OBJC_GameOf24_play24]

(* ****** ****** *)

implement
OBJC_GameOf24_play24
(
  n1, n2, n3, n4
) = let
//
val out = stdout_ref
val res = play24 (n1, n2, n3, n4)
val (
) = fprintln! (out, "play24(", n1, ", ", n2, ", ", n3, ", ", n4, "):")
//
in
//
case+ res of
| list_cons _ =>
  (
    fpprint_cardlst (out, res); fprint_newline (out)
  )
| list_nil () => 
  {
    val () = fprintln! (out, "There is NO solution.")
  }
//
end // end of [OBJC_GameOf24_play24]

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
