(* ****** ****** *)
(*
** for testing
** [libats/ML/UNITYPE]
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
(* ****** ****** *)

#staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
#staload
"libats/ML/UNITYPE/funarray.dats"
#dynload
"libats/ML/UNITYPE/funarray.dats"
//
(* ****** ****** *)
//
#staload
"libats/ML/UNITYPE/hashtblref.dats"
#dynload
"libats/ML/UNITYPE/hashtblref.dats"
//
(* ****** ****** *)
//
val xs =
g0ofg1
(
$list{string}("a","b","c")
) (* val *)
val xs =
list0_map
(xs, lam(x) => GVstring(x))
//
val xs =
farray_make_list{gvalue}(xs)
//
val () =
(
print!
("xs =\n");
(xs).foreach()(lam(x) => print!(x, ";"));
println!();
)
val () = println! ("xs[0] = ", xs[0])
val () = println! ("xs[1] = ", xs[1])
val () = println! ("xs[2] = ", xs[2])
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

implement main0 () = ()

(* ****** ****** *)

(* end of [libats_ML_UNITYPE_all.dats] *)
