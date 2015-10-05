(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
staload
FIL = "src/pats_filename.sats"
//
(* ****** ****** *)
//
staload "src/pats_syntax.sats"
//
staload "src/pats_parsing.sats"
//
(* ****** ****** *)
//
staload "src/pats_staexp1.sats"
staload "src/pats_dynexp1.sats"
//
staload
TRANS1 = "src/pats_trans1.sats"
staload
TRENV1 = "src/pats_trans1_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_staexp2.sats"
staload "src/pats_stacst2.sats"
staload "src/pats_dynexp2.sats"
//
staload
TRANS2 = "src/pats_trans2.sats"
staload
TRENV2 = "src/pats_trans2_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_dynexp3.sats"
//
staload
TRANS3 = "src/pats_trans3.sats"
staload
TRENV3 = "src/pats_trans3_env.sats"
//
(* ****** ****** *)
//
staload "src/pats_histaexp.sats"
staload "src/pats_hidynexp.sats"
//
staload
TYER = "src/pats_typerase.sats"
//
staload CCOMP = "src/pats_ccomp.sats"
//
(* ****** ****** *)

staload "./../SATS/libatsopt_ext.sats"

(* ****** ****** *)
//
%{^
//
extern void patsopt_PATSHOME_set() ;
extern char *patsopt_PATSHOME_get() ;
//
%} // end of [{^]
//
implement
PATSHOME_set() = let
  extern
  fun set (): void = "mac#patsopt_PATSHOME_set"
  val () = set((*void*))
  prval pf = __assert() where
  {
    extern prfun __assert(): PATSHOME_set_p  
  } (* end of [prval] *)
in
  (pf | ((*void*)))
end // end of [PATSHOME_set]
//
implement
PATSHOME_get
(
  pf | (*none*)
) = let
//
val opt = get () where
{
extern
fun
get
(
// argumentless
) : Stropt = "mac#patsopt_PATSHOME_get"
} (* end of [where] *)
val issome = stropt_is_some (opt)
//
in
  if issome
    then stropt_unsome(opt) else "$(PATSHOME)"
  // end of [if]
end // end of [PATSHOME_get]
//
(* ****** ****** *)
//
extern
fun
patsopt_tcats_d3eclist
  (stadyn: int, inp: string): d3eclist
//
implement
patsopt_tcats_d3eclist
  (stadyn, inp) = let
//
val fil = $FIL.filename_string
//
val
d0cs =
parse_from_string_toplevel(stadyn, inp)
//
val
(pf|()) = PATSHOME_set()
val
PATSHOME = PATSHOME_get(pf|(*none*))
//
val () =
  $FIL.the_prepathlst_push(PATSHOME)
val () =
  $TRENV1.the_trans1_env_initialize()
val () =
  $TRENV2.the_trans2_env_initialize()
//
val () = the_prelude_load(PATSHOME)
//
val () = $FIL.the_filenamelst_ppush(fil)
//
val d1cs = $TRANS1.d0eclist_tr_errck(d0cs)
//
val () = $TRANS1.trans1_finalize((*void*))
//
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
val () =
  $TRENV3.the_trans3_env_initialize()
//
val d3cs = $TRANS3.d2eclist_tr_errck(d2cs)
//
(*
val () = fprint_d0eclist(stdout_ref, d0cs)
val () = fprint_d1eclist(stdout_ref, d1cs)
val () = fprint_d2eclist(stdout_ref, d2cs)
val () = fprint_d3eclist(stdout_ref, d3cs)
*)
//
in
//
  d3cs
//
end // end of [patsopt_tcats_d3eclst]

(* ****** ****** *)

implement
patsopt_ccats_string
  (stadyn, inp) = let
//
val out = stdout_ref
val infil = $FIL.filename_string
//
val
d3cs = patsopt_tcats_d3eclist(stadyn, inp)
//
val hids =
  $TYER.d3eclist_tyer_errck (d3cs)
val ((*void*)) =
  $CCOMP.ccomp_main (out, stadyn, infil, hids)
//
in
//
  CCATSRESstdout("patsopt_ccats_string: ...")
//
end // end of [patsopt_ccats_string]

(* ****** ****** *)

(* end of [libatsopt_ext.dats] *)
