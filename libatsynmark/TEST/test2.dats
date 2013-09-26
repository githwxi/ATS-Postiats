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

staload _ = "prelude/DATS/list.dats"
staload _ = "prelude/DATS/list_vt.dats"

(* ****** ****** *)
//
staload
"libatsynmark/SATS/libatsynmark.sats"
//
(* ****** ****** *)

dynload "libatsynmark/dynloadall.dats"

(* ****** ****** *)

implement
main (argc, argv) = let
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
var stadyn: int = 1
val () = (
  if argc >= 2 then (
    case+ argv.[1] of
    | "-s" => stadyn := 0
    | "-d" => stadyn := 1
    | "--static" => stadyn := 0
    | "--dynamic" => stadyn := 1
    | _ => ()
  ) // end of [if]
) : void // end of [val]
//
val toks = fileref_get_tokenlst (stdin_ref)
val psms = listize_token2psynmark (toks)
val () = list_vt_free (toks)
val () = loop (psms)
//
val psms = fileref_get_psynmarklst (stadyn, stdin_ref)
val () = loop (psms)
//
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test2.dats] *)
