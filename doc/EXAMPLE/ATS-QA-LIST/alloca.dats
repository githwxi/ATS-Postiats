(*
** Some safety support for alloca
*)

(* ****** ****** *)

%{^
#include <alloca.h>
%}

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun alloca
  {dummy:addr}{n:int}
(
  pf: void@dummy | n: size_t (n)
) : [l:addr] (bytes(n) @ l, bytes(n) @ l -> void@dummy | ptr (l)) = "mac#alloca"
//
(* ****** ****** *)

fun foo() = let
//
var dummy: void = ()
val (pfat, fpf | p) = alloca (view@dummy | i2sz(1024))
prval () = view@dummy := fpf (pfat)
//
in
  // nothing
end // end of [foo]
  
(* ****** ****** *)

implement
main0 () =
{
val () = foo ()
} (* end of [main0] *)

(* ****** ****** *)

(* end of [alloca.dats] *)
