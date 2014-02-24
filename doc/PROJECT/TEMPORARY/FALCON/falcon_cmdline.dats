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
  
(* ****** ****** *)

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
//
// BB-2014-02-22:
// For now just include default output as
// currently used by MATLAB scripts.
//
implement
fprint_val<expvar>
  (out, x) = fprint! (out, x.gexp, "\t", x.gvar)
//
(* ****** ****** *)

implement 
main0 (argc, argv) = 
{
//
val out = stdout_ref
//
val () = assertloc(argc = 3)
val expInFi = argv[1]
val rulesInFi = argv[2]
//
val opt =
fileref_open_opt (expInFi, file_mode_r)
val-~Some_vt(inp) = opt
//
val (emap, smap) = gmeanvar_initize(inp)
val ((*void*)) = fileref_close (inp)
//
val opt =
fileref_open_opt (rulesInFi, file_mode_r)
val-~Some_vt(inp) = opt
//
val gxs = parse_fileref (inp)
val ((*void*)) = fileref_close (inp)
//
val grcnfs =
grexplst_cnfize(gxs)
//
val expvars =
grcnflst_minmean_stdev (grcnfs, emap, smap)
//
val () = fprint_list_vt_sep (out, expvars, "\n")
//
val ((*freed*)) = list_vt_free (expvars)
val ((*freed*)) = grcnflst_free (grcnfs)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [falcon_cmdline.dats] *)
