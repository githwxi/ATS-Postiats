(*
** for testing [prelude/list]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

val () =
{
val x0 = 0
val x1 = 1
val xs = nil{int}()
val xs = cons{int}(x0, cons{int}(x1, xs))
val+cons (x, xs) = xs
val () = assertloc (x = x0)
val+cons (x, xs) = xs
val () = assertloc (x = x1)
val+nil () = xs
} (* end of [val] *)

(* ****** ****** *)

val () =
{
#define N 10
val out = stdout_ref
//
val xs = list_make_intrange (0, N)
val xs = list_vt2t{int}(xs)
//
val () = fprintln! (out, "xs = ", xs)
//
local
implement
list_map$fwork<int><int> (x) = x + x
in
val ys = list_map<int><int> (xs)
end // end of [local]
val ys = list_vt2t{int}(ys)
//
local
//
implement
fprint_list$sep<>
  (out) = fprint_string (out, "; ")
//
in
val () = fprintln! (out, "ys = ", ys)
end // end of [local]
//
val rys = list_reverse (ys)
val rys = list_vt2t{int}(rys)
val () = fprintln! (out, "rys = ", rys)
//
val xsys = list_concat<int> (cons{List(int)}(xs, cons{List(int)}(ys, nil)))
val xsys = list_vt2t{int}(xsys)
val () = fprintln! (out, "xsys = ", xsys)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_list.dats] *)
