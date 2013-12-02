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
val toks = fileref_get_tokenlst (stdin_ref)
//
in
  loop (toks)
end // end of [main]

(* ****** ****** *)

(* end of [test01.dats] *)
