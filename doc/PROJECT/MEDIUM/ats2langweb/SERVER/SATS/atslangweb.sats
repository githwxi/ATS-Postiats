(*
//
// For server-side actions
//
*)

(* ****** ****** *)
//
#define ATS_PACKNAME "atslangweb"
#define ATS_EXTERN_PREFIX "atslangweb__"
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
absvtype tmpfile
//
fun tmpfile_unlink (tmpfile): bool
//
fun tmpfile2string (fname: !tmpfile): string
//
fun tmpfile_make_nil (pfx: string): tmpfile
fun tmpfile_make_string (pfx: string, content: string): tmpfile
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
  (!tmpfile(*inp*), !tmpfile(*log*)): string
fun{}
patsopt_ccats_command
  (!tmpfile(*inp*), !tmpfile(*out*), !tmpfile(*log*)): string
//
(* ****** ****** *)
//
fun{}
patsopt_tcats_code (ptext: string): compres
fun{}
patsopt_tcats_file (fname: !tmpfile): compres
//
fun{}
patsopt_ccats_code (ptext: string): compres
fun{}
patsopt_ccats_code (fname: !tmpfile): compres
//
(* ****** ****** *)
//
fun{}
patsopt_ccats_continue (fname: !tmpfile): compres
fun{}
patsopt_ccats_continue_code (ptext: string): compres
fun{}
patsopt_ccats_continue_file (fname: !tmpfile): compres
//
(* ****** ****** *)

(* end of [atslangweb.sats] *)
