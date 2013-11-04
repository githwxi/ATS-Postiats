(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

typedef Cint = $extype"int"
typedef Clint = $extype"long int"
typedef Cllint = $extype"long long int"
typedef Cint2 = $extype"struct{ int x; int y; }"

(* ****** ****** *)

macdef NULL = $extval(ptr, "0")
macdef stdin_ref = $extval(FILEref, "stdin")
macdef stdout_ref = $extval(FILEref, "stdout")

(* ****** ****** *)

%{^
extern
int
myatoi(void *x) { return atoi((const char*)x) ; }
extern
long int
myatol(void *x) { return atol((const char*)x) ; }
extern
double
myatof(void *x) { return atof((const char*)x) ; }
%} // end of [%{^]
macdef myatoi = $extval(string -> int, "myatoi")
macdef myatol = $extval(string -> lint, "myatol")
macdef myatof = $extval(string -> double, "myatof")

(* ****** ****** *)

implement
main0 {n} (argc, argv) =
{
//
val () = loop (1, argv) where
{
fun loop (i: natLte(n), argv: !argv(n)): void =
  if i < argc then
    (println! ("argv(", i, ") = ", myatoi(argv[i])); loop (i+1, argv))
  else ((*void*)) // end of [if]
}
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [misc.dats] *)
