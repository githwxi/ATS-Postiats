(* ****** ****** *)
//
// HX-2014-09
//
(* ****** ****** *)
//
// Question:
// How are the values of
// an enumerative datatype
// represented in ATS/Posiats?
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define ATS_MAINATSFLAG 1
#define ATS_DYNLOADNAME "my_dynload"
//
#include
"{$LIBATSCC2JS}/staloadall.hats"
//
(* ****** ****** *)

datatype abc =  A | B | C

%{^
var A;
var B;
var C;
%}
extvar "A" = A
extvar "B" = B
extvar "C" = C

%{$
my_dynload(); alert("A = " + A); alert("B = " + B); alert("C = " + C)
%} // ...

(* ****** ****** *)

(* end of [qa-list-370.dats] *)
