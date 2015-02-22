(*
** Bug causing infinite recursion
** during the process of code emission.
*)

(* ****** ****** *)

(*
** Source: Reported by HX-2015-02-22
*)

(* ****** ****** *)
//
// HX: Typechecking results in a core dump!
//
(* ****** ****** *)

extern
fun
imul{m,n:nat} (int(m), int(n)): int(m*n)

(* ****** ****** *)

implement
imul{m,n}(m, n) =
(
if
m = 0
then let
//
prval
EQINT() =
eqint_make{m,0}()
//
in
  0
end // end of [then]
else let
//
val m2 = half(m)
val r2 = m - 2*m2
//
in
//
if
r2 = 0
then let
//
prval
EQINT() =
eqint_make{m,2*(m/2)}()
//
in
  imul(m2, n+n)
end // end of [then]
else m*n
end // end of [else]
) (* end of [imul] *)

(* ****** ****** *)

(* end of [bug-2015-02-22.dats] *)
