(*
** For writing ATS code
** that translates into Perl
*)

(* ****** ****** *)
//
// HX-2014-08:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2plpre_"
//
(* ****** ****** *)

staload "./../basics_pl.sats"

(* ****** ****** *)
//
(*
val STDIN : PLfilr = "mac#"
val STDOUT : PLfilr = "mac#"
val STDERR : PLfilr = "mac#"
*)
macdef STDIN = $extval (PLfilr, "STDIN")
macdef STDOUT = $extval (PLfilr, "STDOUT")
macdef STDERR = $extval (PLfilr, "STDERR")
//
(* ****** ****** *)

(* end of [filebas.sats] *)
