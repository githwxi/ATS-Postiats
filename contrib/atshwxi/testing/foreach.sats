(*
** Some functions for traversing aggregates
*)

(* ****** ****** *)

fun{}
foreach_int__fwork (i: int): void
fun{} foreach_int (n: Nat): void

fun{}
foreach_size__fwork (i: size_t): void
fun{} foreach_size (n: Size): void

(* ****** ****** *)

fun{a:t0p}
foreach_list__fwork (x: a): void
fun{a:t0p}
foreach_list (xs: List (a)): void

fun{a:t0p}
iforeach_list__fwork (i: size_t, x: a): void
fun{a:t0p}
iforeach_list (xs: List (a)): void

(* ****** ****** *)

fun{a:vt0p}
foreach_list_vt__fwork (x: &a): void
fun{a:vt0p}
foreach_list_vt (xs: !List_vt (a)): void

fun{a:vt0p}
iforeach_list_vt__fwork (i: size_t, x: &a): void
fun{a:vt0p}
iforeach_list_vt (xs: !List_vt (a)): void

(* ****** ****** *)

fun{a:vt0p}
foreach_array__fwork (x: &a): void
fun{a:vt0p}
foreach_array
  {n:int} (A: &(@[a][n]), asz: size_t n) : void
// end of [foreach_array]

fun{a:vt0p}
iforeach_array__fwork (i: size_t, x: &a): void
fun{a:vt0p}
iforeach_array
  {n:int} (A: &(@[a][n]), asz: size_t n) : void
// end of [iforeach_array]

(* ****** ****** *)

fun{a:vt0p}
initialize_array__fwork (i: size_t, x: &a? >> a): void
fun{a:vt0p}
initialize_array
  {n:int} (A: &(@[a?][n]) >> @[a][n], asz: size_t n) : void
// end of [initalize_array]

fun{a:vt0p}
uninitialize_array__fwork (x: &a >> a?): void
fun{a:vt0p}
uninitialize_array
  {n:int} (A: &(@[a][n]) >> @[a?][n], asz: size_t n) : void
// end of [uninitalize_array]

(* ****** ****** *)

sortdef tk = tkind

(* ****** ****** *)

fun{x:vt0p}
foreach_fiterator__fwork (x: x): void
fun{
knd:tk}{x:vt0p
} foreach_fiterator
  {kpm:tk} {f,r:int} (
  itr: !iterator (knd, kpm, x, f, r) >> iterator (knd, kpm, x, f+r, 0)
) : void // end of [foreach_fiterator]

(* ****** ****** *)

fun{x:vt0p}
foreach_literator__fwork (x: &x): void
fun{
knd:tk}{x:vt0p
} foreach_literator
  {kpm:tk} {f,r:int} (
  itr: !iterator (knd, kpm, x, f, r) >> iterator (knd, kpm, x, f+r, 0)
) : void // end of [foreach_literator]

(* ****** ****** *)

(* end of [foreach.sats] *)
