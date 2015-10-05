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
//
(* ****** ****** *)
//
staload "src/pats_staexp2.sats"
staload "src/pats_stacst2.sats"
staload "src/pats_dynexp2.sats"
//
staload
TRANS2 = "src/pats_trans2.sats"
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

implement
patsopt_tcats_string
  (stadyn, inp) = let
//
val fil = $FIL.filename_string
//
val
d0cs =
parse_from_string_toplevel(stadyn, inp)
//
val () = fprint_d0eclist(stdout_ref, d0cs)
//
val
(pf|()) = PATSHOME_set()
val
PATSHOME = PATSHOME_get(pf|(*none*))
//
val () =
$FIL.the_prepathlst_push(PATSHOME)
//
val () = the_prelude_load(PATSHOME)
//
val () = $FIL.the_filenamelst_ppush(fil)
//
val d1cs = $TRANS1.d0eclist_tr_errck(d0cs)
//
val () = $TRANS1.trans1_finalize((*void*))
//
val () = fprint_d1eclist(stdout_ref, d1cs)
//
val d2cs = $TRANS2.d1eclist_tr_errck (d1cs)
//
val () = fprint_d2eclist(stdout_ref, d2cs)
//
in
//
  TCATSRESstdout("patsopt_tcats_string")
//
end // end of [patsopt_tcats_string]

(* ****** ****** *)

implement
patsopt_ccats_string
  (stadyn, inp) = let
//
val
d0cs =
parse_from_string_toplevel(stadyn, inp)
//
val () = fprint_d0eclist(stdout_ref, d0cs)
//
in
//
  CCATSRESstdout("patsopt_ccats_string")
//
end // end of [patsopt_ccats_string]

(* ****** ****** *)

(* end of [libatsopt_ext.dats] *)
