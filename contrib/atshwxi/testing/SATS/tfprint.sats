(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype

(* ****** ****** *)

fun{}
tfprint__out (): FILEref

fun{a:t0p}
tfprint (x: a): void
fun{} tfprint_newline (): void

(* ****** ****** *)

fun{}
tfprint_list__sep (): string
fun{}
tfprint_list__beg (): string
fun{}
tfprint_list__end (): string

fun{a:t0p}
tfprint_list (xs: List (a)): void

(* ****** ****** *)

fun{}
tfprint_array__sep (): string
fun{}
tfprint_array__beg (): string
fun{}
tfprint_array__end (): string

fun{a:t0p}
tfprint_array
  {n:int} (A: &(@[a][n]), n: size_t n): void
// end of [tfprint_array]
fun{a:t0p}
tfprint_arrayptr
  {n:int} (A: !arrayptr (a, n), n: size_t n): void
// end of [tfprint_arrayptr]
fun{a:t0p}
tfprint_arrayref
  {n:int} (A: arrayref (a, n), n: size_t n): void
// end of [tfprint_arrayref]

(* ****** ****** *)

(* end of [tfprint.sats] *)
