(* ****** ****** *)
//
// For testing libatscc2scm
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "test02_dynload"
//
#define ATS_STATIC_PREFIX "_test02_"
//
(* ****** ****** *)
//
#include
"./../staloadall.hats"
//
(* ****** ****** *)

#define :: list_cons

(* ****** ****** *)

val xs =
(
  0 :: 1 :: 2 :: 3 :: 4 :: 5 :: 6 :: 7 :: 8 :: 9 :: nil()
) : List0 (int)

(* ****** ****** *)

val () = println! ("xs = ", xs)

(* ****** ****** *)

val ys = xs + xs
val () = println! ("xs+xs = ", ys)

(* ****** ****** *)

val zs = list_sort(ys)
val () = println! ("sort(xs+xs) = ", zs)

(* ****** ****** *)

%{$
;;
(test02_dynload);
;;
%} (* end of [%{$] *)

(* ****** ****** *)

(* end of [test02.dats] *)
