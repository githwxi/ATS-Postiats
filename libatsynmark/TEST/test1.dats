(*
** Obtaining all the tokens from STDIN
**
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
** Start Time: June 5, 2012
*)

(* ****** ****** *)
//
// HX: printing out all the tokens from the STDIN
//
(* ****** ****** *)
//
staload
"libatsynmark/SATS/libatsynmark.sats"
//
(* ****** ****** *)

dynload "libatsynmark/dynloadall.dats"

(* ****** ****** *)

implement
main () = let
//
fun loop (
  xs: tokenlst_vt
) : void = let
  val out = stdout_ref
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val loc = token_get_loc (x)
      val () = fprint_token (out, x)
      val () = fprint_location (out, loc)
      val () = fprint_newline (out)
    in
      loop (xs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
end // end of [loop]
//
val xs = fileref_get_tokenlst (stdin_ref)
//
in
  loop (xs)
end // end of [main]

(* ****** ****** *)

(* end of [test1.dats] *)
