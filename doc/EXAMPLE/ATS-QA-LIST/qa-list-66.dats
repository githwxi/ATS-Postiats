(* ****** ****** *)
//
// HX-2013-08
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

absvtype
vector3_vtype (a:t@ype) = ptr
vtypedef vector3 (a:t0p) = vector3_vtype (a)

(* ****** ****** *)

extern
fun{a:t@ype}
vector3_create
  (x: a, y: a, z: a): vector3(a)
extern
fun{a:t@ype}
vector3_destroy (vec: vector3(a)): void

extern
fun{a:t@ype}
fprint_vector3 (out: FILEref, vec: !vector3(a)): void
overload fprint with fprint_vector3

(* ****** ****** *)

local

assume
vector3_vtype (a:t0p) = arrayptr (a, 3)

in (* in of [local] *)

implement{a}
vector3_create(x,y,z) =
  (arrayptr)$arrpsz{a}(x,y,z)
implement{a}
vector3_destroy(vec) = arrayptr_free{a} (vec)

implement{a}
fprint_vector3 (out, vec) = fprint (out, vec, i2sz(3))

end // end of [local]

(* ****** ****** *)

implement
main0() = let
//
val out = stdout_ref
//
val vec = vector3_create<int>(3,2,1)
//
val ((*void*)) = fprintln! (out, "vec = ", vec)
//
in
  vector3_destroy<int> (vec)
end // end of [main0]

(* ****** ****** *)

(* end of [qa-list-66.dats] *)
