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

fun
fact_ref
(n: int): int = let
//
val i = ref<int>(0)
val r = ref<int>(1)
//
fun loop(): void =
  if !i < n then (!i := !i+1; !r := !r * !i; loop())
//
in
  let val () = loop() in !r end
end (* end of [fact_ref] *)

val () = println! ("fact_ref(10) = ", fact_ref(10))

(* ****** ****** *)

implement main0() = () // a dummy for [main]

(* ****** ****** *)

(* end of [lecture08.dats] *)
