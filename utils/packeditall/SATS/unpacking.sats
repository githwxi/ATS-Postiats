(*
** HX-2013-12-31:
** unpacking a packed file into a list of files
*)

(* ****** ****** *)

fun unpack_test_sep{n:int}
  (arrayref(char, n), n: size_t n): bool

(* ****** ****** *)

fun unpack_many_fileref (inp: FILEref): int(*err*)

(* ****** ****** *)

(* end of [unpacking.sats] *)
