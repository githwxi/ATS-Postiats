(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun fact (n: int): int
implement
fact (n) = if n > 0 then n * fact(n-1) else 1

(* ****** ****** *)

local
extern
fun __fprintf
  : (FILEref, string(*fmt*), int, int) -> int = "mac#fprintf"
in (* in of [local] *)
//
val N = 12
val _ = __fprintf (stdout_ref, "fact(%i) = %i\n", N, fact(N))
//
end // end of [local]

(* ****** ****** *)

val N = 12
val _ = $extfcall(int, "fprintf", stdout_ref, "fact(%i) = %i\n", N, fact(N))

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [extfcall.dats] *)
