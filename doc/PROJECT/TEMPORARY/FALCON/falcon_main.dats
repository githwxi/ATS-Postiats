(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/cstream/SATS/cstream.sats"
staload
"{$LIBATSHWXI}/cstream/SATS/cstream_tokener.sats"
//
staload _ = "libats/DATS/stringbuf.dats"
staload _ = "{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
(* ****** ****** *)
  
staload "./falcon.sats"
staload "./falcon_position.dats"
staload "./falcon_tokener.dats"
staload "./falcon_parser.dats"

(* ****** ****** *)

dynload "./falcon.sats"
dynload "./falcon_symbol.dats"
dynload "./falcon_position.dats"
dynload "./falcon_tokener.dats"
dynload "./falcon_genes.dats"
dynload "./falcon_parser.dats"

(* ****** ****** *)

implement
main0 () =
{
//
val (
) = println! ("Hello from [FALCON]!")
//
val out = stdout_ref
//
val opt =
fileref_open_opt ("./DATA/rec2.grRulesLop", file_mode_r)
val-~Some_vt(inp) = opt
//
val cs0 = cstream_make_fileref (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val () =
println! ("the_symtbl_count(bef) = ", the_symtbl_count ())
//
val gxs = parse_main (t2knr)
val () = fprint! (out, "gxs =\n")
val () = fprint_list_sep (out, gxs, "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "|gxs| = ", list_length(gxs))
val ((*freed*)) = tokener2_free (t2knr)
//
val () =
println! ("the_symtbl_count(aft) = ", the_symtbl_count ())
//
val () =
print ("pos(final) = ")
val () =
fprint_the_position (out)
val () = print_newline ()
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [falcon_main.dats] *)
