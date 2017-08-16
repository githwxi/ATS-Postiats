(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)

#include "./../../MYLIB/mylib.dats"

(* ****** ****** *)

extern fun html(): void
extern fun head(): void
extern fun body(): void
extern fun multable(): void

(* ****** ****** *)

implement
html() =
{
//
val () = println! ("<html>")
val () = head()
val () = body()
val () = println! ("</html>")
//
} (* end of [html] *)

(* ****** ****** *)

implement
head() =
{
val () =
println! ("<head>")
//
val () =
println!
("<meta charset=\"utf-8\">")
//
val () =
println! ("</head>")
//
} (* end of [head] *)

(* ****** ****** *)

implement
body() =
{
val () =
println! ("<body>")
//
val () =
println!
("\
<center>
<h1>Multiplication Table</h1>
</center>
")
val () = multable()
//
val () =
println! ("</body>")
//
} (* end of [body] *)

(* ****** ****** *)

local

abst@ype myint = int

fun
print_myint
(mi: myint): void = let
//
val mi = $UNSAFE.cast{int}(mi)
//
in
  print!(mi/10, mi%10)
end // end of [print_myint]

overload print with print_myint

in (* in-of-local *)

fun
auxrows
(n: int): void =
(n).foreach()
(
lam(n) =>
let
val
n1 = n + 1
in
//
if
(n1%2 = 0) then
print("<tr style=\"background:#c0c0c0\">\n");
if
(n1%2 > 0) then
print("<tr style=\"background:#ffffff\">\n");
//
(n1).foreach()
(
lam(i) =>
let
val i1 = i+1
in
//
print!("<td>", i1, " x ", n1, " = ", $UNSAFE.cast{myint}(i1*n1), "</td>\n");
//
end
); print("</tr>\n")
//
end
) (* end of [auxrows] *)

end // end of [local]

(* ****** ****** *)

implement
multable() =
{
val () =
println! ("<center>")
//
val () =
println! ("<table>")
val () = auxrows( 9 )
val () =
println! ("</table>")
//
val () =
println! ("</center>")
}

(* ****** ****** *)
//
implement
main0() = () where
{
//
val () =
println!
("<!DOCTYPE html>")
//
val () = html()
//
} (* end of [main0] *)
//
(* ****** ****** *)

(* end of [multable.dats] *)
