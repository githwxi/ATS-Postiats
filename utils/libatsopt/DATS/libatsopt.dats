(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

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

staload "./../SATS/libatsopt.sats"

(* ****** ****** *)

implement
patsopt_tcats_string
  (stadyn, inp) = let
//
val
d0cs =
parse_from_string_toplevel(stadyn, inp)
//
val () = fprint_d0eclist(stdout_ref, d0cs)
//
val d1cs =
  $TRANS1.d0eclist_tr_errck (d0cs)
// end of [val]
//
val () = $TRANS1.trans1_finalize ()
//
val () = fprint_d1eclist(stdout_ref, d1cs)
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

(* end of [libatsopt.dats] *)
