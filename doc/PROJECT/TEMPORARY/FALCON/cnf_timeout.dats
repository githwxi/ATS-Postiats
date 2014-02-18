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

staload "./falcon.sats"
staload "./falcon_symbol.dats"
staload "./falcon_position.dats"
staload "./falcon_tokener.dats"
staload "./falcon_genes.dats"
staload "./falcon_parser.dats"
staload "./falcon_cnfize.dats"
staload "./falcon_gmeanvar.dats"
staload "./falcon_algorithm1.dats"

(* ****** ****** *)

dynload "./falcon.sats"
dynload "./falcon_symbol.dats"
dynload "./falcon_position.dats"
dynload "./falcon_tokener.dats"
dynload "./falcon_genes.dats"
dynload "./falcon_parser.dats"
dynload "./falcon_cnfize.dats"
dynload "./falcon_gmeanvar.dats"
dynload "./falcon_algorithm1.dats"

(* ****** ****** *)

extern
fun cnf_timeout(rule_file: string, data_file:string, excepts: &badcnfs): void
//
implement
cnf_timeout (rule_file, data_file, excepts) =
{
//
val out = stdout_ref
//
val opt =
fileref_open_opt (rule_file, file_mode_r)
val-~Some_vt(inp) = opt
//
val () =
println! ("the_symtbl_count(bef) = ", the_symtbl_count ())
//
val gxs =
  parse_fileref (inp)
//
val () = fileref_close (inp)
//
val () = fprint! (out, "gxs =\n")
val () = fprint_list_sep (out, gxs, "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "|gxs| = ", list_length(gxs))
//
val () =
println! ("the_symtbl_count(aft) = ", the_symtbl_count ())
//
val () = print ("pos(final) = ")
val () = fprint_the_position (out)
val () = print_newline ((*void*))
val rec2cnfs = grexplst_cnfize_except(gxs, excepts)
val () = grcnflst_free(rec2cnfs)
} (* end of [cnf_timeout] *)


implement
main0 () =
{
//
val out = stdout_ref
//
var nobadcnf: badcnfs = badcnfs_make_nil()
//
val () = fprint! (out, "Testing Human\n")
val () = cnf_timeout ("./DATA/rec2.grRulesLop", "/dev/null", nobadcnf)
//
val () = badcnfs_free(nobadcnf)
} (* end of [main0] *)

(* ****** ****** *)

(* end of [cnf_timeout.dats] *)
