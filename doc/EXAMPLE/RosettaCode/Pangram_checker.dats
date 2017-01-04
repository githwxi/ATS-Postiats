(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: Somewhere in January, 2017
//
(* ****** ****** *)
(*
//
A pangram is a sentence that contains all the letters of the
English alphabet at least once.
//
For example: The quick brown fox jumps over the lazy dog.
//
Task
//
Write a function or method to check a sentence to see if it is a
pangram (or not) and show its use.
//
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
fun
letter_check
(
cs: string, c0: char
) : bool = cs.exists()(lam(c) => c0 = c)
//
(* ****** ****** *)

fun
Pangram_check
  (text: string): bool = let
//
val
alphabet = "abcdefghijklmnopqrstuvwxyz"
val
((*void*)) = assertloc(length(alphabet) = 26)
//
in
  alphabet.forall()(lam(c) => letter_check(text, c) || letter_check(text, toupper(c)))
end // end of [Pangram_check]

(* ****** ****** *)

implement
main0 () =
{
//
val
text0 = "The quick brown fox jumps over the lazy dog."
//
val-true = Pangram_check(text0)
val-false = Pangram_check("This is not a pangram sentence.")
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [Pangram_checker.dats] *)
