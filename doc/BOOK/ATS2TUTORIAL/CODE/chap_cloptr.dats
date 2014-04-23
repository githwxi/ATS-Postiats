(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

(*
extern
fun{
a:t@ype}{b:t@ype
} list_map_cloref{n:int}
  (xs: list (a, n), f: (a) -<cloref> b): list_vt (b, n)
*)
extern
fun{
a:t@ype}{b:t@ype
} list_map_cloptr{n:int}
  (xs: list (a, n), f: !(a) -<cloptr> b): list_vt (b, n)

(* ****** ****** *)

implement
{a}{b}(*tmp*)
list_map_cloptr (xs, f) =
list_map_cloref<a><b> (xs, $UNSAFE.castvwtp1{(a)-<cloref>b}(f))

(* ****** ****** *)

fun foo{n:int}
(
  x0: int, xs: list (int, n)
) : list_vt (int, n) = res where
{
//
val f = lam (x: int): int =<cloptr> x0 + x
val res = list_map_cloptr (xs, f)
val () = cloptr_free ($UNSAFE.castvwtp0{cloptr(void)}(f))
//
} (* end of [foo] *)

(* ****** ****** *)

val xs =
$list{int}(0, 1, 2, 3, 4)
val () = println! ("xs = ", xs)
val ys = foo (5, xs)
val () = println! ("ys = ", ys)
val () = list_vt_free (ys)

(* ****** ****** *)

fun
acker(m:int, n:int): int =
(
  case+ (m, n) of
  | (0, _) => n + 1
  | (m, 0) => acker (m-1, 1)
  | (_, _) => acker (m-1, acker (m, n-1))
) (* end of [acker] *)

fun acker2 (m:int) (n:int): int = acker (m, n)
fun acker3 (m:int) = lam (n:int): int =<cloptr1> acker (m, n)

(* ****** ****** *)

val () = println! ("acker2(3)(4) = ", acker2(3)(4))
val () = println! ("acker3(3)(4) = ", acker3(3)(4))

(* ****** ****** *)

(*
//
// HX-2014-03: this one works, too!
//
fun acker (m:int) =
(
fix f (n:int): int =<cloptr1>
  if m > 0 then (if n > 0 then acker(m-1)(f(n-1)) else acker(m-1)(1)) else n+1
) (* end of [acker] *)
//
val () = println! ("acker(3)(3) = ", acker(3)(3))
//
*)

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_cloptr.dats] *)
