(*
//
// For [libatsopt]
//
*)

(* ****** ****** *)

#define ATS_STALOADFLAG 0

(* ****** ****** *)
//
absprop
PATSHOME_set_p
//
fun
PATSHOME_set
(
// argumentless
) : (PATSHOME_set_p | void)
//
fun
PATSHOME_get
  (pf: PATSHOME_set_p | (*void*)) : string
//
(* ****** ****** *)
//
fun
the_prelude_load
(
  PATSHOME: string
) : void
  = "ext#libatsopt_the_prelude_load"
fun
the_prelude_load_if
(
  PATSHOME: string, flag: &int
) : void
  = "ext#libatsopt_the_prelude_load_if"
//
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

(* end of [libatsopt_ext.sats] *)
