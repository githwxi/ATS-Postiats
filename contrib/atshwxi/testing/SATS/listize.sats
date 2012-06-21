(*
** Some functions for generating lists
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

fun
listize_int {n:nat} (n: int n):<> list_vt (int, n)

fun{a:vt0p}
listize_fun_int__fwork (n: int): a
fun{a:vt0p}
listize_fun_int {n:nat} (n: int n):<> list_vt (a, n)

(* ****** ****** *)

fun{a:t0p}
listize_list {n:int} (xs: list (a, n)): list_vt (a, n)
fun{a:vt0p}
listize_list_vt {n:int} (xs: !list_vt (a, n)): list_vt (a, n)

(* ****** ****** *)

(* end of [listize.sats] *)
