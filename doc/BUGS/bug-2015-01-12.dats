(*
** Bug causing erroneous handling of
** the linear proof asssociated with a variable
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2015-01-12
*)

(* ****** ****** *)

(*
** Status: HX-2015-01-12: fixed
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

(*
fun foo () = let
//
var x: int = 12345
//
in
  llam () =<lincloptr1> (2 * x)
end // end of [foo]
*)

(* ****** ****** *)

(*
fun foo2 () = let
//
extern
fun
ptr_get{l:addr}(pf: !int@l | p: ptr(l)): int
//
var x: int = 12345
prval pf = view@x; val p = addr@x
//
val res = llam (): int =<cloptr1> (2 * !p)
//
in
  res
end // end of [foo2]
*)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2015-01-12.dats] *)
