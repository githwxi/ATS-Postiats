(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

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

datatype abc =
  | cons1 of int | cons2 of (int, double)

(* ****** ****** *)

extern
vtypedef
"cons2_node" = cons2_pstruct(int, double)
vtypedef cons2_node_ = $extype"cons2_node_"

(* ****** ****** *)

%{
cons2_node
cons2_make
(
  int i, double d
) {
  cons2_node p ;
  p = ATS_MALLOC(sizeof(cons2_node_)) ;
  p->contag = 1 ;
  p->atslab__0 = i ;
  p->atslab__1 = d ;
  return p ;
} /* end of [cons2_make] */
%}

(* ****** ****** *)

extern
fun cons2_make (int, double): abc = "mac#"
val-cons2 (1, 2.34) = cons2_make (1, 2.34)

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
