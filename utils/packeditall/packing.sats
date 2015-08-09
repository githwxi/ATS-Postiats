(*
** HX-2013-12-31:
** packing a list of files into one
*)

(* ****** ****** *)

fun pack_fprint_sep (FILEref): void

(* ****** ****** *)

fun pack_sing_fileref
  (out: FILEref, inp: FILEref): int(*err*)
// end of [pack_sing_fileref]

(* ****** ****** *)

fun pack_sing_filename
  (out: FILEref, fname: string): int(*err*)
// end of [pack_sing_filename]

(* ****** ****** *)

(* end of [packing.sats] *)
