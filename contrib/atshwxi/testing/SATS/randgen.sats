(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

fun{a:vt0p}
randgen_val (): a // for ranval generation
fun{a:vt0p}
randgen_ref (x: &a? >> a): void // for randval initialization

(* ****** ****** *)

fun randint {n:pos} (n: int n): natLt (n)

(* ****** ****** *)

fun{a:vt0p}
randgen_list {n:nat} (n: int n): list_vt (a, n)

(* ****** ****** *)

fun{a:vt0p}
randgen_arrayptr {n:int} (n: size_t n): arrayptr (a, n)

(* ****** ****** *)

(* end of [randgen.sats] *)
