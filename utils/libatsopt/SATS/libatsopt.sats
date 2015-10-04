(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)

#define ATS_STALOADFLAG 0

(* ****** ****** *)
//
datatype
tcatsres =
  | TCATSRESstdout of string
  | TCATSRESstderr of string
//
datatype
ccatsres =
  | CCATSRESstdout of string
  | CCATSRESstderr of string
//
(* ****** ****** *)
//
fun
patsopt_tcats_string
  (stadyn: int, source: string): tcatsres
fun
patsopt_ccats_string
  (stadyn: int, source: string): ccatsres
//
(* ****** ****** *)

(* end of [libatsopt.sats] *)
