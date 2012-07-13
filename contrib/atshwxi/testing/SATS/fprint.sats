(*
** Some print functions to faciliate testing
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

(*
//
// atshwxi:
// it is declared in prelude/basic_dyn.sats
//
fun{a:vt0p}
fprint_elt (out: FILEref, x: !INV(a)): void
*)

(* ****** ****** *)

fun{a:t0p}
fprint_listlist_sep (
  out: FILEref, xs: List (List (a)), sep1: string, sep2: string
) : void // end of [fprint_listlist_sep]

(* ****** ****** *)

staload
IT = "prelude/SATS/iterator.sats"
stadef iterator = $IT.iterator_5

fun{
knd:tk
}{x:vt0p
} fprint_iterator_sep
  {kpm:tk}{f,r:int} (
  out: FILEref
, itr: !iterator (knd, kpm, x, f, r) >> iterator (knd, kpm, x, f+r, 0)
, sep: string
) : void // end of [fprint_iterator_sep]

(* ****** ****** *)

(* end of [fprint.sats] *)
