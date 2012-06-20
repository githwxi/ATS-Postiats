(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)

fun{}
tprint__out (): FILEref

fun{a:t0p}
tprint (x: a): void
fun{} tprint_newline (): void

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
  {n:int} (A: &(@[a][n]), n: size_t n): void
// end of [tprint_array]
fun{a:t0p}
tprint_arrayptr
  {n:int} (A: !arrayptr (a, n), n: size_t n): void
// end of [tprint_arrayptr]
fun{a:t0p}
tprint_arrayref
  {n:int} (A: arrayref (a, n), n: size_t n): void
// end of [tprint_arrayref]

(* ****** ****** *)

(* end of [tprint.sats] *)
