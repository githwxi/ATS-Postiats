//
// Array of fixed size as field in a record
//
// Author: Artyom Shalkhakov (Mar, 2015)
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
staload _ = "prelude/DATS/array.dats"
//
(* ****** ****** *)
//
typedef vec_t (a:t@ype, n:int) = @{V= @[a][n] }
typedef vec3_t = vec_t (float, 3)
//
typedef entity = @{
  origin= vec3_t,
  angles= vec3_t
}
//
(* ****** ****** *)

fun{a:t@ype}
vec3_make (v: &vec_t (INV(a), 3)? >> _, px: a, py: a, pz: a): void = {
//
fun
aux (v: &(@[INV(a)][3])? >> _, x: a, y: a, z: a): void = {
//
prval pf_arr = view@(v)
var pv = addr@(v)
//
prval (pf1_at, pf1_arr) = array_v_uncons {a?} (pf_arr)
val () = ptr_set<a> (pf1_at | pv, x)
//
val () = pv := ptr1_succ<a> (pv)
prval (pf2_at, pf2_arr) = array_v_uncons {a?} (pf1_arr)
val () = ptr_set<a> (pf2_at | pv, y)
//
val () = pv := ptr1_succ<a> (pv)
prval (pf3_at, pf3_arr) = array_v_uncons {a?} (pf2_arr)
val () = ptr_set<a> (pf3_at | pv, z)
//
#define :: array_v_cons
//
prval pf3_nil = array_v_unnil_nil (pf3_arr)
prval () = view@(v) := pf1_at :: pf2_at :: pf3_at :: pf3_nil
//
} (* end of [aux] *)
//
val () = aux (v.V, px, py, pz)
//
} (* end of [vec3_make] *)

(* ****** ****** *)

implement main0 () = {
//
var b: entity
//
val () = array_initize_elt (b.angles.V, i2sz(3), 0.0f)
val () = vec3_make<float> (b.origin, 0.5f, 0.0f, 1.0f)
//
val () = b.origin.V.[0] := 10.0f * b.origin.V.[0]
val () = b.origin.V.[1] := 4.0f
val () = b.origin.V.[2] := 180.0f
//
val () = println!("origin: ")
val () = print_float (b.origin.V.[0])
val () = print_newline ()
val () = print_float (b.origin.V.[1])
val () = print_newline ()
val () = print_float (b.origin.V.[2])
val () = print_newline ()
//
val () = println!("angles: ")
val () = print_float (b.angles.V.[0])
val () = print_newline ()
val () = print_float (b.angles.V.[1])
val () = print_newline ()
val () = print_float (b.angles.V.[2])
val () = print_newline ()
//
} (* end of [main0] *)
