(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to PHP
//
(* ****** ****** *)
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME\
/contrib/libatscc2php/ATS2-0.3.2"
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "refcount_dynload"
//
#define
ATS_STATIC_PREFIX "refcount__"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PHP}/staloadall.hats"
//
(* ****** ****** *)
//
extern
fun
refcount : () -> int = "mac#refcount"
//
local
//
val theCount = ref{int}(0)
//
in
//
implement
refcount () = let
  val n = theCount[]; val () = theCount[] := n+1 in n
end // end of [refcount]
//
end // end of [local]

(* ****** ****** *)
//
extern
fun
refcount_test (): void = "mac#refcount_test"
//
implement
refcount_test () =
{
//
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
//
} (* end of [refcount_test] *)

(* ****** ****** *)

(* end of [refcount.dats] *)
