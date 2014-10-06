(* ****** ****** *)
//
// HX-2014-10-05
//
// Templates based on macros in C
//
(* ****** ****** *)

%{^
#undef ATSextfcall
#define ATSextfcall(f, xs) f xs
#define foo(x) ((x) >> 1)
%} // end of [%{^]

(* ****** ****** *)
//
extern
fun
{tk:tk}
foo_tmp: g0int(tk) -> g0int(tk)
//
implement
{tk}(*tmp*)
foo_tmp (x) = $extfcall (g0int(tk), "foo", x)
//
(* ****** ****** *)

implement
main0 () =
{
  val I = 23
  val () = println! ("foo<int>(", I, ") = ", foo_tmp(I))
  val L = 23L
  val () = println! ("foo<lint>(", L, ") = ", foo_tmp(L))
  val LL = 23LL
  val () = println! ("foo<llint>(", LL, ") = ", foo_tmp(LL))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-387.dats] *)
