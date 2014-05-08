(*
** Bug in template instantiation
*)
(* ****** ****** *)
//
// Reported by HX-2013-10?
//
(* ****** ****** *)
//
// Status: fixed by HX-2014-05-05
//
(* ****** ****** *)

(*
** Compiling embedded template instantiation
** caused the following line in pats_ccomp_subst to fail:
**
    val-~Some_vt(pmv) = ccompenv_find_vbindmapall (env, d2v)
**
** The bug was first noted when HX tried to compile the following
** file: doc/EXAMPLE/INTRO/fprintlst2.dats
**
** The bug is due to vbindmapall being based on d2varmap_vt.
** The fix introduces d2varmaplst_vt in pats_dynexp2_dvar and bases
** vbindmapall on it.
**
*)

(* ****** ****** *)

(* end of [bug-2014-05-05.dats] *)
