(*
** Some tostring-related code
*)

(* ****** ****** *)

sortdef t0p = t@ype and vt0p = viewt@ype

(* ****** ****** *)

fun{a:vt0p}
tostring_with_fprint_val (x: !a): Stropt0
fun{a:vt0p}
tostring_with_fprint_ref (x: &a): Stropt0

(* ****** ****** *)

fun{a:vt0p}
tostrptr_with_fprint_val (x: !a): Strptr0
fun{a:vt0p}
tostrptr_with_fprint_ref (x: &a): Strptr0

(* ****** ****** *)

(* end of [tostring.sats] *)
