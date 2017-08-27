(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#define :: list0_cons

(* ****** ****** *)

macdef
list0_sing(x) =
list0_cons(,(x), list0_nil())

(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

implement
fprint_val<int> = fprint_int
implement
fprint_val<string> = fprint_string

(* ****** ****** *)
//
val r0 = ref<int>(0)
val () = println! (!r0)
val () = (!r0 := !r0 + 1)
val () = println! (!r0)
val () = (!r0 := !r0 + 2)
val () = println! (!r0)
//
val r1 = ref<int>(0)
val () = println! (r1[])
val () = (r1[] := r1[] + 1)
val () = println! (r1[])
val () = (r1[] := r1[] + 2)
val () = println! (r1[])
//
(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture08.dats] *)
