(* ****** ****** *)
//
// For testing libatscc2php
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_STATIC_PREFIX "_test03_"
#define
ATS_DYNLOADNAME "test03_dynload"
//
(* ****** ****** *)
//
#include "./../staloadall.hats"
//
(* ****** ****** *)

%{$
test03_dynload();
%} (* end of [%{$] *)

(* ****** ****** *)

%{^
include "./../output/libatscc2php_all.php";
%} (* end of [%{^] *)

(* ****** ****** *)
//
val () = println! ("sqrt(2) = ", sqrt(2.0))
val () = println! ("cbrt(2) = ", cbrt(2.0))
val () = println! ("(2.0)^10 = ", pow(2.0, 10))
val () = println! ("(2.0)^10 = ", pow(2.0, 10.0))
val () = println! ("exp(10.0) = ", exp(10.0))
val () = println! ("log(exp(10.0)) = ", log(exp(10.0)))
val () = println! ("log(exp(10.0)) = ", log(exp(10.0), sqrt(exp(1))))
//
(* ****** ****** *)

(* end of [test03.dats] *)