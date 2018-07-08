(* ****** ****** *)
//
// For testing libatscc2php
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_STATIC_PREFIX "_test01_"
#define
ATS_DYNLOADNAME "test01_dynload"
//
(* ****** ****** *)
//
#include "./../staloadall.hats"
//
(* ****** ****** *)

%{$
test01_dynload();
%} (* end of [%{$] *)

(* ****** ****** *)

%{^
include "./../output/libatscc2php_all.php";
%} (* end of [%{^] *)

(* ****** ****** *)
//
val () =
repeat(3, $delay(println!("Hello, world!")))
val () =
(3).foreach()(lam(i) =<cloref1> println!(i, ": Hello, world!"))
//
(* ****** ****** *)

(* end of [test01.dats] *)
