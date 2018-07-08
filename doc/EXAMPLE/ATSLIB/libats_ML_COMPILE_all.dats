(* ****** ****** *)
(*
** for testing
** [libats/ML/COMPILE]
*)
(* ****** ****** *)
//
// Author: Hongwei Xi
// Start time: October, 2017
// Authoremail: gmhwxiATgmailDOTcom
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share\
/atspre_staload_libats_ML.hats"
//
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
#include
"libats/ML/COMPILE/mylibies.hats"
//
(* ****** ****** *)

val cs = "abcde"
val CS = "ABCDE"
val () = assertloc(toupper(cs) = CS)
val () = assertloc(tolower(CS) = cs)

(* ****** ****** *)
//
var m0 =
funmap_nil{gvalue}()
val-
~None_vt() =
(m0).insert("a", GVint(0))
val-
~None_vt() =
(m0).insert("b", GVint(1))
val-
~None_vt() =
(m0).insert("c", GVint(2))
//
val () =
(m0).foreach()
(lam(k, x) => println! (k, " -> ", x))
//
(* ****** ****** *)
//
val-true = (m0).remove("a")
val-true = (m0).remove("b")
val-false = (m0).remove("z")
//
val () =
(m0).foreach()
(lam(k, x) => println! (k, " -> ", x))
//
(* ****** ****** *)
//
val xs =
g0ofg1
(
$list{string}("a","b","c")
) (* val *)
//
val xs =
farray_make_list{string}(xs)
//
val () =
(
print!
("xs =\n");
(xs).iforeach()
(lam(i, x) => println!(i, " -> ", x))
)
val () =
(
print!
("xs =\n");
println!
(
(
xs
).ifoldleft
(
TYPE{string}
)
( ""
, lam(r, i, x) => r + itoa(i) + x)
)
)
//
val () =
println! ("xs[0] = ", xs[0])
val () =
println! ("xs[1] = ", xs[1])
val () =
println! ("xs[2] = ", xs[2])
val () =
try
println! ("xs[3] = ", xs[3])
with
~FarraySubscriptExn
 (
   // argless
 ) => println!("FarraySubscriptExn")
//
(* ****** ****** *)
//
val kxs =
hashtbl_make_nil{gvalue}(16)
//
val-
~None_vt() = (kxs).insert("0", GVint(0))
val-
~None_vt() = (kxs).insert("1", GVint(1))
val-
~None_vt() = (kxs).insert("2", GVint(2))
//
(*
val ((*void*)) = println!("kxs = ", kxs)
*)
//
val ((*void*)) =
(
kxs
).foreach
(
)
(
lam(k, x) => println! (k, " -> ", x)
)
//
val-
~Some_vt
(GVint(0)) = (kxs).insert("0", GVint(10))
val-
~Some_vt
(GVint(1)) = (kxs).insert("1", GVint(11))
val-
~Some_vt
(GVint(2)) = (kxs).insert("2", GVint(12))
//
val ((*void*)) =
(
kxs
).foreach
(
)
(
lam(k, x) => println! (k, " -> ", x)
)
//
val kxs = listize1(kxs)
val ((*void*)) = println! ("kxs = ", kxs)
//
(* ****** ****** *)

implement main0((*void*)) = ((*void*))

(* ****** ****** *)

(* end of [libats_ML_COMPILE_all.dats] *)
