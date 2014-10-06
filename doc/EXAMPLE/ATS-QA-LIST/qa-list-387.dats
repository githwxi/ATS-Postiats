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

extern
fun{tk:tk} foo: g0int (tk) -> g0int(tk)

implement
{tk}(*tmp*)
foo (x) = $extfcall (g0int(tk), "foo", x)

(* ****** ****** *)

implement
main0 () =
{
  val I = 16
  val () = println! ("foo<int>(", I, ") = ", foo(I))
  val L = 16L
  val () = println! ("foo<lint>(", L, ") = ", foo(L))
  val LL = 16LL
  val () = println! ("foo<llint>(", LL, ") = ", foo(LL))
} (* end of [main0] *)

(* ****** ****** *)

(* end of [qa-list-387.dats] *)
