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
//
val gx1 = GRgene(g1)
val gx2 = GRgene(g2)
val gx3 = GRgene(g3)
val gx4 = GRgene(g4)
val gx5 = GRgene(g5)
//
val gx12 = GRconj($list{grexp}(gx1, gx2))
val gx345 = GRconj($list{grexp}(gx3, gx4, gx5))
//
val gxall = GRdisj($list{grexp}(gx12, gx345)) 
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

(* ****** ****** *)

(* end of [falcon_main.dats] *)
