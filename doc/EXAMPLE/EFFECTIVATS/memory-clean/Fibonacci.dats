(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fn fibseq() =
  (fix f(n0:int, n1: int): stream(int) =>
    $delay(stream_cons(n0, f(n1, n0+n1))))(1, 1)
//
(* ****** ****** *)
//
implement
main0() = fprint_stream(stdout_ref, fibseq(), 10)
//
(* ****** ****** *)

(* end of [Fibonacci.dats] *)
