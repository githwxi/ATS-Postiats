(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

fun{a:vt0p}
randgen (): a // for random generation

(* ****** ****** *)

fun{a:vt0p}
randgen_list {n:nat} (n: int n): list_vt (a, n)

(* ****** ****** *)

fun{a:vt0p}
randgen_array
  {n:int}
  (A: &(@[a?][n]) >> @[a][n], n: size_t n) : void
// end of [randgen_array]

fun{a:vt0p}
randgen_arrayptr
  {n:int} (n: size_t n): [l:addr] arrayptr (a, l, n)
// end of [randgen_arrayptr]

(* ****** ****** *)

(* end of [randgen.sats] *)
