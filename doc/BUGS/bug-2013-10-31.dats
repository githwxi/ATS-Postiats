(*
** Bug in handling llam
*)
(*
** Source: reported by Alex Ren
*)

(* ****** ****** *)
(*
** Status: Fixed by HX-2013-10-31
*)
(* ****** ****** *)

absvtype VT

extern
fun fwork (x: VT): void
extern
fun fwork2 (x: !VT): void

extern
fun foo (x: VT): void
extern
fun foo2 (f: () -<lincloptr1> void): void

(* ****** ****** *)
//
// HX:
// the following code should typecheck
//
implement foo (x) = foo2 (llam () => fwork (x))
//
(* ****** ****** *)
(*
//
// HX:
// the following code should not typecheck
//
implement foo (x) = foo2 (llam () => fwork2 (x))
//
*)
(* ****** ****** *)

(* end of [bug-2013-10-31.dats] *)
