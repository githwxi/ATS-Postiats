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
fn fibseq()  =
  (fix f(n0:int, n1: int): stream_vt(int) =>
    $ldelay(stream_vt_cons(n0, f(n1, n0+n1))))(1, 1)
//
(* ****** ****** *)
//
implement
main0() = stream_vt_fprint(fibseq(), stdout_ref, 10)
//
(* ****** ****** *)

(* end of [Fibonacci_vt.dats] *)
