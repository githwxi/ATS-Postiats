(* ****** ****** *)
//
// HX-2013-11-10:
// dot-notation is not
// supported for call-by-reference
//
(* ****** ****** *)

abst@ype int2 = (int, int)

(* ****** ****** *)

extern
fun int2_get_fst (x: &int2): int
extern
fun int2_get_snd (x: &int2): int

(* ****** ****** *)

symintr .fst .snd
overload .fst with int2_get_fst
overload .snd with int2_get_snd

(* ****** ****** *)

fun foo (x: &int2): int = x.fst + x.snd

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [bug-2013-11-10.dats] *)
