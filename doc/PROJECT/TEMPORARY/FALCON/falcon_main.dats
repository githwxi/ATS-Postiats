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
staload "./falcon_parser.dats"
staload "./falcon_cnfize.dats"
staload "./falcon_cnfize_ifnot.dats"

(* ****** ****** *)

dynload "./falcon.sats"
dynload "./falcon_symbol.dats"
dynload "./falcon_position.dats"
dynload "./falcon_tokener.dats"
dynload "./falcon_genes.dats"
dynload "./falcon_parser.dats"
dynload "./falcon_cnfize.dats"
dynload "./falcon_cnfize_ifnot.dats"
dynload "./falcon_expvar.dats"
dynload "./falcon_gmeanvar.dats"
dynload "./falcon_algorithm1.dats"

(* ****** ****** *)

(*
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
fileref_open_opt ("./DATA/K562.csv", file_mode_r)
val-~Some_vt(inp) = opt
val () = gmeanvar_initize (inp)
val ((*void*)) = fileref_close (inp)
//
} (* end of [main0] *)
*)

(* ****** ****** *)

(*
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
//
} (* end of [main0] *)
*)

(* ****** ****** *)
  
(*
implement
main0 () =
{
//
val (
) = println! ("Hello from [FALCON]!")
//
val out = stdout_ref
//
val g1 = gene_make_name ("g1")
val g2 = gene_make_name ("g2")
val g3 = gene_make_name ("g3")
val g4 = gene_make_name ("g4")
val g5 = gene_make_name ("g5")
val g6 = gene_make_name ("g6")
val g7 = gene_make_name ("g7")
val g8 = gene_make_name ("g8")
//
val gx1 = GRgene(g1)
val gx2 = GRgene(g2)
val gx3 = GRgene(g3)
val gx4 = GRgene(g4)
val gx5 = GRgene(g5)
val gx6 = GRgene(g6)
val gx7 = GRgene(g7)
val gx8 = GRgene(g8)
//
val gx123 = GRconj($list{grexp}(gx1, gx2, gx3))
val gx2345 = GRconj($list{grexp}(gx2, gx3, gx4, gx5))
//
val gxall = GRdisj($list{grexp}(gx123, gx2345)) 
//
val grcnf = grexp_cnfize (gxall)
//
//
val () = fprint (out, "grexp = ")
val () = fprint_grexp (out, gxall)
val () = fprint_newline (out)
//
val () = fprint (out, "grcnf = ")
val () = fprint_grcnf (out, grcnf)
val () = fprint_newline (out)
val () = fprintln! (out, "|grcnf| = ", length(grcnf))
//
val ((*void*)) = grcnf_free (grcnf)
//
} (* end of [main0] *)
*)

(* ****** ****** *)
  
implement
fprint_val<expvar> = fprint_expvar
  
(* ****** ****** *)

extern
fun
falcon_rules_data_skipped
(
  rule_file: string, data_file: string, skipped: ruleset
) : void // end of [falcon_rules_data_skipped]

(* ****** ****** *)

implement
falcon_rules_data_skipped
(
  rule_file, data_file, skipped
) =
{
//
val out = stdout_ref
//
val opt =
fileref_open_opt (data_file, file_mode_r)
val-~Some_vt(inp) = opt
//
val (emap, smap) = gmeanvar_initize(inp)
//
val opt =
fileref_open_opt (rule_file, file_mode_r)
val-~Some_vt(inp) = opt
//
(*
val () =
println! ("the_symtbl_count(bef) = ", the_symtbl_count ())
*)
//
val gxs = parse_fileref (inp)
val ((*void*)) = fileref_close (inp)
//
val () = fprint! (out, "gxs =\n")
val () = fprint_list_sep (out, gxs, "\n")
val () = fprint_newline (out)
val () = fprintln! (out, "|gxs| = ", list_length(gxs))
//
(*
val () =
println! ("the_symtbl_count(aft) = ", the_symtbl_count ())
*)
//
val () = print ("pos(final) = ")
val () = fprint_the_position (out)
val () = print_newline ((*void*))
//
val grcnfs =
grexplst_cnfize_ifnot (gxs, skipped)
//
val expvars =
grcnflst_minmean_stdev (grcnfs, emap, smap)
//
val ((*freed*)) = grcnflst_free (grcnfs)
//
val () = fprintln! (out, "enzyme abundance =")
val () = fprint_list_vt_sep (out, expvars, "\n")
val () = fprintln! (out)
//
val ((*freed*)) = list_vt_free (expvars)
//
} (* end of [falcon_rules_data_skipped] *)

implement
main0 () =
{
//
val out = stdout_ref
//
val skipped = ruleset_make_nil ()
//
val () = fprintln! (out, "Testing Human")
val () = falcon_rules_data_skipped ("./DATA/rec2.grRulesLop", "./DATA/K562.csv", skipped)
//
(*
val () = fprintln! (out, "Testing Yeast 7.11")
val () = falcon_rules_data_skipped ("./DATA/y711_grRules", "/dev/null", skipped)
*)
//
(*
val () = fprintln! (out, "Testing E. coli iJO1366")
val () = falcon_rules_data_skipped ("./DATA/iJO1366_grRules", "/dev/null", skipped)
*)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [falcon_main.dats] *)
