(*
** for highlighting/xreferencing ATS2 code
*)

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

staload "utils/atsyntax/SATS/pats2xhtml.sats"

(* ****** ****** *)

viewtypedef
charlst_vt = List_vt (char)

implement
fileref2charlst (inp) = let
//
fun loop (
  inp: FILEref
, res: &charlst_vt? >> charlst_vt
) : void = let
  val i = $STDIO.fgetc0_err (inp)
in
  if (i != EOF) then let
    val c = char_of_int (i)
    val () = res :=
      list_vt_cons {char}{0} (c, ?)
    val+ list_vt_cons (_, !p_res) = res
    val () = loop (inp, !p_res)
    prval () = fold@ (res)
  in
    // nothing
  end else
    res := list_vt_nil ()
  // end of [if]
end // end of [loop]
//
var res: charlst_vt
val () = loop (inp, res)
//
in
  res
end // end of [fileref2charlst]

(* ****** ****** *)

(* end of [pats2xhtml.dats] *)
