(*
** closure compilation bug
*)

(* ****** ****** *)

(*
** Status: Fixed by Hongwei Xi
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define :: stream_cons
#define cons stream_cons
#define nil stream_nil

(* ****** ****** *)

typedef int2 = (int, int)

(* ****** ****** *)

extern
fun
foo (x: int): int

(* ****** ****** *)
//
// HX: closure environment
// for [bar] was computed incorrectly
// this bug was first triggered by some
// code of a student (Li DongQi) taking
// CS520, Fall 2013.
//
implement
foo (x) = let
//
fun fapp (): int = x
fun fapp2 (): int = fapp ()
fun aux (): int = let
  fun bar (): int = fapp2 () in bar ()
end (* end of [aux] *)
//
in
  aux ()
end // end of [foo]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2013-10-09.dats] *)
