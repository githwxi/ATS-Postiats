(* ****** ****** *)
//
// HX-2014-08:
// A running example
// from ATS2 to Python3
//
(* ****** ****** *)
//
#define
LIBATSCC2PY3_targetloc
"$PATSHOME\
/contrib/libatscc2py3/ATS2-0.3.2"
//
(* ****** ****** *)
//
#include
"{$LIBATSCC2PY3}/staloadall.hats"
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "refcount_dynload"
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

val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())
val () = println! ("refcount() = ", refcount())

(* ****** ****** *)

%{^
import sys
######
from libatscc2py3_all import *
######
sys.setrecursionlimit(1000000)
######
%} // end of [%{^]

(* ****** ****** *)

%{$
refcount_dynload()
%} // end of [%{$]

(* ****** ****** *)

(* end of [refcount.dats] *)
