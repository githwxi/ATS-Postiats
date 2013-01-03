(*
** Some functions for left-folding aggregates
*)

(* ****** ****** *)

fun{res:vt0p}
foldleft_int$fwork
  (acc: res, i: int): res
fun{res:vt0p}
foldleft_int (n: Nat, ini: res): res

(* ****** ****** *)

fun{
x:t0p}{res:vt0p
} foldleft_list$fwork (acc: res, x: x): res
fun{
x:t0p}{res:vt0p
} foldleft_list (xs: List (x), ini: res): res

(* ****** ****** *)

fun{
x:vt0p}{res:vt0p
} foldleft_list_vt$fwork (acc: res, x: &x): res
fun{
x:vt0p}{res:vt0p
} foldleft_list_vt (xs: !List_vt (x), ini: res): res

(* ****** ****** *)

fun{
a:vt0p}{res:vt0p
} foldleft_array$fwork (acc: res, x: &a): res
fun{
a:vt0p}{res:vt0p
} foldleft_array
  {n:int} (A: &(@[a][n]), n: size_t n, ini: res): res
// end of [foldleft_array]

(* ****** ****** *)

(* end of [foldleft.sats] *)
