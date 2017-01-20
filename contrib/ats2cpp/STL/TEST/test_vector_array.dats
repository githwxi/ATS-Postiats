(* ****** ****** *)
//
// HX-2016-12:
// For testing
// STL/vector_array
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

%{^
//
#include \
"pats_ccomp_runtime.c"
//
%} // end of [%{^]

(* ****** ****** *)
//
#staload
"./../DATS/vector_array.dats"
//
(* ****** ****** *)

extern
fun
mytest(): void = "mac#"
//
implement
mytest() =
{
//
val A0 =
array_make_elt<int>(i2sz(3), 0)
//
val-() = A0[1] := 1
val-() = A0[2] := 2
//
val-(0) = A0[0]
val-(1) = A0[1]
val-(2) = A0[2]
//
val-(3) = sz2i(length(A0))
//
val ((*freed*)) = array_free(A0)
//
} (* end of [mytest] *)

(* ****** ****** *)
//
%{$
//
#include <iostream>
//
int
main(int argc, int argv)
{
//
std::cout << "Hello from [test_vector_array]!" << std::endl;
//
mytest();
//
return 0;
//
} /* end of [main0] */
//
%} // end of [%{^]
//
(* ****** ****** *)

(* end of [test_vector_array.dats] *)
