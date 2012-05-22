(*
** Some functions for traversing aggregates
*)

(* ****** ****** *)

fun{a:t0p}
foreach_list__fwork (x: a): void
fun{a:t0p}
foreach_list {n:int} (xs: List (a)): void

fun{a:t0p}
iforeach_list__fwork (i: size_t, x: a): void
fun{a:t0p}
iforeach_list {n:int} (xs: List (a)): void

(* ****** ****** *)

fun{a:vt0p}
foreach_list_vt__fwork (x: &a): void
fun{a:vt0p}
foreach_list_vt {n:int} (xs: !List_vt (a)): void

fun{a:vt0p}
iforeach_list_vt__fwork (i: size_t, x: &a): void
fun{a:vt0p}
iforeach_list_vt {n:int} (xs: !List_vt (a)): void

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

(* end of [foreach.sats] *)