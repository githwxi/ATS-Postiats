(*
//
// For invoking [patsopt]
//
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
//
(* ****** ****** *)
//
#define
ATS_EXTERN_PREFIX "atslangweb_"
//
(* ****** ****** *)
//
// HX: implemented in CATS/basics_cats.php
//
fun fname_dats_c (fname: string): string = "mac#%"
fun fname_dats_js (fname: string): string = "mac#%"
fun fname_dats_php (fname: string): string = "mac#%"
//
(* ****** ****** *)
//
fun exec_retval (command: string): int(*ret*) = "mac#%"
//
(* ****** ****** *)
//
datatype compres =
//
// HX-2014-09:
// the order must be maintained!!!
//
  | COMPRES0_succ of (string(*target*)) // success
  | COMPRES1_fail of (string(*target*)) // failure1
  | COMPRES2_fail of (string(*source*), string(*errmsg*)) // failure2
//
(* ****** ****** *)
//
fun{}
patsopt_command (): string
//
fun{}
patsopt_tcats_command
  (string(*inp*), string(*stderr*)): string
fun{}
patsopt_ccats_command
  (string(*inp*), string(*out*), string(*stderr*)): string
//
(* ****** ****** *)
//
fun{}
patsopt_tcats_file (fname: string): compres
fun{}
patsopt_tcats_code (ptext: string): compres
//
fun{}
patsopt_ccats_code (fname: string): compres
fun{}
patsopt_ccats_code (ptext: string): compres
//
(* ****** ****** *)
//
fun{}
patsopt_ccats_continue (fname: string): compres
fun{}
patsopt_ccats_continue_file (fname: string): compres
fun{}
patsopt_ccats_continue_code (ptext: string): compres
//
(* ****** ****** *)

(* end of [atslangweb_utils.sats] *)
