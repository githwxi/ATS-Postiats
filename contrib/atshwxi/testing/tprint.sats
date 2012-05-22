(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)

fun{}
tprint__out (): FILEref

fun{a:t0p} tprint (x: a): void

(* ****** ****** *)

fun{a:t0p}
tprint_list0 (xs: list0 (a)): void

(* ****** ****** *)

fun{}
tprint_list__sep (): string
fun{}
tprint_list__beg (): string
fun{}
tprint_list__end (): string

fun{a:t0p}
tprint_list (xs: List (a)): void

(* ****** ****** *)

fun{}
tprint_array__sep (): string
fun{}
tprint_array__beg (): string
fun{}
tprint_array__end (): string

fun{a:t0p}
tprint_array
  {n:int}
  (A: &(@[a][n]), n: size_t n): void
// end of [tprint_array]

fun{a:t0p}
tprint_arrayptr
  {l:addr}{n:int}
  (A: !arrayptr (a, l, n), n: size_t n): void
// end of [tprint_arrayptr]

(* ****** ****** *)

(* end of [tprint.sats] *)
