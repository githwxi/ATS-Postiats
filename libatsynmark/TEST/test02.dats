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
"./../SATS/libatsynmark.sats"
//
(* ****** ****** *)

dynload "./../dynloadall.dats"

(* ****** ****** *)

fun fileref_get_tokenlst
  (inp: FILEref): tokenlst_vt = let
//
val cs = char_list_vt_make_file (inp)
//
val lbf = lexbufobj_make_charlst_vt (cs)
//
val toks = lexbufobj_get_tokenlst (lbf)
//
val ((*void*)) = lexbufobj_free (lbf) 
//
in
  toks
end // end of [fileref_get_tokenlst]

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
val inp = stdin_ref
val toks = fileref_get_tokenlst (inp)
val psms = listize_token2psynmark (toks)
val () = list_vt_free (toks)
val () = loop (psms)
//
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [test02.dats] *)
