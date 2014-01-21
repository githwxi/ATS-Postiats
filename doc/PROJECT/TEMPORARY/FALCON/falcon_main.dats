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
val buf = tokener_make_cstream (cs0)
//
val () =
println! ("the_symtbl_count(bef) = ", the_symtbl_count ())
//
var tok: token =
  my_tokener_get_token (buf)
val () =
while (true)
{
(*
val () = fprintln! (stdout_ref, "tok = ", tok)
*)
val () =
(
case+ tok of
| TOKeof () => $break | _ => tok := my_tokener_get_token (buf)
) : void // end of [val]
} (* end of [while] *)
//
val ((*freed*)) = tokener_free (buf)
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
