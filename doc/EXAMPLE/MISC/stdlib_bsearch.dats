(*
** HX-2013:
** The following code is largely adapted from
** the Linux Programmer's manual for bsearch
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

staload "libats/libc/SATS/stdlib.sats"

(* ****** ****** *)

%{^
typedef
struct mi
{
  int nr;
  char *name;
} mi_t ;
mi_t months[] = {
  { 1, "jan" }, { 2, "feb" }, { 3, "mar" }, { 4, "apr" },
  { 5, "may" }, { 6, "jun" }, { 7, "jul" }, { 8, "aug" },
  { 9, "sep" }, {10, "oct" }, {11, "nov" }, {12, "dec" }
} ;
                                                                     
#define nr_of_months (sizeof(months)/sizeof(struct mi))
%}

(* ****** ****** *)

typedef mi =
  $extype_struct "mi_t" of { nr= int, name= string }
// end of [typedef]

(* ****** ****** *)

stacst N: int
val months = $extval (arrayref (mi, N), "months")
val nr_of_months = $extval (int(N), "nr_of_months")
val () = assertloc (nr_of_months = 12)

(* ****** ****** *)

fn mi_init (
  mi: &mi? >> _
, nr: int, name: string
) :<!wrt> void = (
  mi.nr := nr; mi.name := name
)

fn cmpref_mi_mi
  (x: &mi, y: &mi):<> int = compare (x.name, y.name)
// end of [cmpref_mi_mi]

fun name2nr
  (name: string): void = let
//
var key: mi
val () = mi_init (key, 0, name)
val asz = g1int2uint(nr_of_months)
val pres = let
  val (vbox pf | p) = arrayref_get_viewptr (months)
in
  bsearch {mi}{N} (key, !p, asz, sizeof<mi>, cmpref_mi_mi)
end // end of [val]
//
in
//
if pres > 0 then let
  val (pf, fpf | p) = $UN.ptr1_vtake {mi} (pres)
  val () = println! (pres->name, ": month #", pres->nr)
  prval () = fpf (pf)
in
  // nothing
end else let
  val () = println! (key.name, ": unknown month")
in
  // nothing
end // end of [if]
//
end // end of [name2nr]

(* ****** ****** *)
//
// How to test:
// ./stdlib_bsearch.exe jan feb mar apr may jun jul aug sep oct nov dec
//
(* ****** ****** *)

implement
main {n} (
  argc, argv
) = 0 where {
val asz = g1int2uint(nr_of_months)
val () = let
  val (vbox pf | p) = arrayref_get_viewptr (months)
in
  qsort {mi}{N} (!p, asz, sizeof<mi>, cmpref_mi_mi) // HX: quicksorting
end // end of [val]
//
val (
) = let
//
fun loop
(
  argc: int n, argv: !argv(n), i: natLte(n)
) : void = let
in
  if argc > i then
    (name2nr (argv[i]); loop (argc, argv, i+1))
  else () // end of [if]
end // end of [loop]
//
in
  loop (argc, argv, 1)
end // end of [val]
//
} // end of [main]

(* ****** ****** *)

(* end of [stdlib_bsearch.dats] *)
