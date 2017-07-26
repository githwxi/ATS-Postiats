(* ****** ****** *)
//
// For testing libatscc2php
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_STATIC_PREFIX "_test02_"
#define
ATS_DYNLOADNAME "test02_dynload"
//
(* ****** ****** *)

#define :: list_cons

(* ****** ****** *)
//
#include "./../staloadall.hats"
//
(* ****** ****** *)

%{$
test02_dynload();
%} (* end of [%{$] *)

(* ****** ****** *)

%{^
include "./../output/libatscc2php_all.php";
%} (* end of [%{^] *)

(* ****** ****** *)

val xs =
(
  0 :: 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: 8 :: 9 :: nil()
) : List0 (int)

(* ****** ****** *)

val () = println! ("xs = ", xs)
val () = println! ("xs + xs = ", xs + xs)

(* ****** ****** *)

(* end of [test02.dats] *)
