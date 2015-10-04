(*
//
// For [libatsopt]
//
*)

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
patsopt_tcats_string(sourse: string): tcatsres
fun
patsopt_ccats_string(source: string): ccatsres
//
(* ****** ****** *)

(* end of [libatsopt.sats] *)
