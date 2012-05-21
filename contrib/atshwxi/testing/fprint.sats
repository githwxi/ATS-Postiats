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
fprint_list0_sep (
  out: FILEref, xs: list0 (a), sep: string
) : void // end of [fprint_list0_sep]

macdef
fprint_list0
  (out, xs) = fprint_list0_sep (,(out), ,(xs), ", ")
// end of [fprint_list0]

(* ****** ****** *)

fun{a:t0p}
fprint_list_sep (
  out: FILEref, xs: List (a), sep: string
) : void // end of [fprint_list_sep]

macdef
fprint_list
  (out, xs) = fprint_list_sep (,(out), ,(xs), ", ")
// end of [fprint_list]

(* ****** ****** *)

fun{a:vt0p}
fprint_list_vt_sep (
  out: FILEref, xs: !List_vt (a), sep: string
) : void // end of [fprint_list_sep]

macdef
fprint_list_vt
  (out, xs) = fprint_list_vt_sep (,(out), ,(xs), ", ")
// end of [fprint_list_vt]

(* ****** ****** *)

fun{a:t0p}
fprint_listlist_sep (
  out: FILEref, xs: List (List (a)), sep1: string, sep2: string
) : void // end of [fprint_listlist_sep]

(* ****** ****** *)

fun{a:vt0p}
fprint_array_sep
  {n:int} (
  out: FILEref
, A: &(@[a][n]), n: size_t n, sep: string
) : void // end of [fprint_array_sep]

macdef
fprint_array
  (out, A, n) = fprint_array_sep (,(out), ,(A), ,(n), ", ")
// end of [fprint_array]

(* ****** ****** *)

fun{a:vt0p}
fprint_arrayptr_sep
  {l:addr}{n:int} (
  out: FILEref
, A: !arrayptr (a, l, n), n: size_t n, sep: string
) : void // end of [fprint_arrayptr_sep]

macdef
fprint_arrayptr
  (out, A, n) = fprint_arrayptr_sep (,(out), ,(A), ,(n), ", ")
// end of [fprint_arrayptr]

(* ****** ****** *)

fun{a:vt0p}
fprint_arrszref_sep (
  out: FILEref, A: arrszref (a), sep: string
) : void // end of [fprint_arrszref_sep]

macdef
fprint_arrszref
  (out, A) = fprint_arrszref_sep (,(out), ,(A), ", ")
// end of [fprint_arrszref]

(* ****** ****** *)

(* end of [fprint.sats] *)
