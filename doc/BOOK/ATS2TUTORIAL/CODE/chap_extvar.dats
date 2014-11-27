(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
int foo = 0;
%}
val x0 = $extval(int, "foo")
val () = assertloc (x0 = 0)
val p_foo = $extval(ptr, "&foo")
val () = $UNSAFE.ptr0_set<int> (p_foo, x0 + 1)
val x1 = $extval(int, "foo")
val () = assertloc (x1 = 1)

(* ****** ****** *)

val () = $UNSAFE.ptr0_set<int> (p_foo, 0)

(* ****** ****** *)

val x0 = $extval(int, "foo")
val () = assertloc (x0 = 0)
//
extvar "foo" = x0 + 1
(*
extern var "foo" = x0 + 1
*)
//
val x1 = $extval(int, "foo")
val () = assertloc (x1 = 1)

(* ****** ****** *)

%{^
struct{int first; int second;} foo2;
%}
extvar "foo2.first" = 1
extvar "foo2.second" = 2
val () = assertloc ($extval(int, "foo2.first") + $extval(int, "foo2.second") = 3)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [chap_extvar.dats] *)
