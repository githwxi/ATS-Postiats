(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
val tup_flat = @("a", "b")
val tup_boxed = $tup("a", "b")
//
val-"a" = tup_flat.0 and "b" = tup_flat.1
val-"a" = tup_boxed.0 and "b" = tup_boxed.1
//
(* ****** ****** *)
//
abstype point = ptr
//
extern
fun
point_make
  (x: double, y: double): point
//
extern
fun point_get_x (p: point): double
and point_get_y (p: point): double
//
extern
fun point_set_x (p: point, x: double): void
and point_set_y (p: point, x: double): void
//
(* ****** ****** *)

local
//
typedef
point_rep = @{
  x= double, y= double
} (* end of [point_t] *)

assume point = ref(point_rep)
//
in (* end of [local] *)

implement
point_make (x, y) = ref<point_rep>(@{x=x, y=y})

implement
point_get_x (p) = let
  val (vbox pf | p) = ref_get_viewptr (p) in p->x
end // end of [point_get_x]

implement
point_get_y (p) = let
  val (vbox pf | p) = ref_get_viewptr (p) in p->y
end // end of [point_get_y]

implement
point_set_x (p, x) = let
  val (vbox pf | p) = ref_get_viewptr (p) in p->x := x
end // end of [point_set_x]

implement
point_set_y (p, y) = let
  val (vbox pf | p) = ref_get_viewptr (p) in p->y := y
end // end of [point_set_y]

end // end of [local]

(* ****** ****** *)
//
extern
fun print_point (point): void
//
overload print with print_point
//
(* ****** ****** *)

symintr .x .y
overload .x with point_get_x
overload .x with point_set_x
overload .y with point_get_y
overload .y with point_set_y

(* ****** ****** *)
//
implement
print_point (p) =
  print! ("(x=", p.x, ", y=", p.y, ")")
//
(* ****** ****** *)
//
val p0 = point_make (1.0, 2.0)
//
val x0 = p0.x // point_get_x (p0)
and y0 = p0.y // point_get_y (p0)
val () = println! ("p0 = ", p0) // x=1 / y=2
//
val () = p0.x := y0 // point_set_x (p0, y0)
and () = p0.y := x0 // point_set_x (p0, x0)
val () = println! ("p0 = ", p0) // x=2 / y=1
//
(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_dotoverld.dats] *)
