(*
** Obtaining postion-synmarks from STDIN
**
** Author: Hongwei Xi (gmhwxi AT gmail DOT com)
** Start Time: June 5, 2012
*)

(* ****** ****** *)
//
// HX: this example shows how to get position-synmarks
//
(* ****** ****** *)

staload
"libatsyntax/SATS/libatsyntax.sats"
// end of [staload]

(* ****** ****** *)

dynload "libatsyntax/dynloadall.dats"

(* ****** ****** *)

implement
main () = let
//
fun loop (
  xs: psynmarklst_vt
) : void = let
  val out = stdout_ref
in
  case+ xs of
  | ~list_vt_cons
      (x, xs) => let
      val () =
        fprint_psynmark (out, x)
      val () = fprint_newline (out)
    in
      loop (xs)
    end // end of [list_vt_cons]
  | ~list_vt_nil () => ()
end // end of [loop]
//
val xs = fileref_get_psynmarklst (1(*dyn*), stdin_ref)
//
in
  loop (xs)
end // end of [main]

(* ****** ****** *)

(* end of [test2.dats] *)
