(* ****** ****** *)
//
// For testing libatscc2pl
//
(* ****** ****** *)
//
#include "./../staloadall.hats"
//
(* ****** ****** *)
//
#define
ATS_MAINATSFLAG 1
#define
ATS_DYNLOADNAME "test03_dynload"
//
#define ATS_STATIC_PREFIX "_test03_"
//
(* ****** ****** *)
//
val A =
  PLarray_pair{int}(0, 1)
//
val () = println! ("length(A) = ", length(A))
//
val A2 = PLarray_copy (A)
//
val () = A2[0] := A2[0] * 2
val () = A2[1] := A2[1] * 2
//
val () = println! ("A[0] = ", A[0])
val () = println! ("A[1] = ", A[1])
val () = println! ("A2[0] = ", A2[0])
val () = println! ("A2[1] = ", A2[1])
//
val _ = A2.push(2)
val _ = A2.push(3)
val () = println! ("PLarray_pop(A2) = ", PLarray_pop(A2))
val () = println! ("PLarray_pop(A2) = ", PLarray_pop(A2))
val () = println! ("length(A2) = ", length(A2))
//
(* ****** ****** *)

%{$
######
test03_dynload();
######
%} // end of [%{$]

(* ****** ****** *)

%{^
#######
require "./../output/libatscc2pl_all.pl";
#######
%} (* end of [%{^] *)

(* ****** ****** *)

(* end of [test03.dats] *)
