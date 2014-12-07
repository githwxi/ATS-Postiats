(*
**
** An example on templates
**
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
extern
fun
my_fprint_floatlst
(
  out: FILEref, n: intGte(0), xs: List0(double)
) : void // end-of-function
//
(* ****** ****** *)

implement
my_fprint_floatlst
  (out, n, xs) = let
//
var buf = @[byte][16]()
val ((*void*)) =
  $extfcall(void, "snprintf", buf, 16, "%%.%if", n)
val fmt = $UNSAFE.cast{string}(addr@buf)
//
implement
fprint_val<double>
  (out, x) = $extfcall(void, "fprintf", out, fmt, x)
//
in
  fprint_list (out, xs)
end // end of [my_fprint_floatlst]

(* ****** ****** *)

val xs =
$list{double}(0.111111, 0.222222, 0.333333)

(* ****** ****** *)

val () = my_fprint_floatlst (stdout_ref, 0, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 1, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 2, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 3, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 4, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 5, xs)
val () = fprintln! (stdout_ref)
val () = my_fprint_floatlst (stdout_ref, 6, xs)
val () = fprintln! (stdout_ref)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [qa-list-2014-12-07.dats] *)
