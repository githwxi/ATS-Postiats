(*
** Syntax-hiliting ATS code
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

staload
STDLIB =
"libats/libc/SATS/stdlib.sats"

(* ****** ****** *)

#define BUFSZ 1024

(* ****** ****** *)

typedef charptr = $extype"char*"

(* ****** ****** *)
//
#define MVF "mv -f"
//
#define
MYTEXTING "./../MYTEXT/bin/mytexting"
//
(* ****** ****** *)

fun
process_one
(
  inp: string
) : void = let
//
var buf = @[byte][BUFSZ]()
//
val inp = $UN.cast{charptr}(inp)
val bufp = $UN.cast{charptr}(addr@buf)
//
val
_(*int*) =
$extfcall
( int
, "snprintf"
, bufp, BUFSZ, "%s %s %s.bak", MVF, inp, inp
) (* $extfcall *)
val () =
  fprintln! (stdout_ref, $UN.cast{string}(bufp))
val () =
  ignoret($STDLIB.system($UN.cast{string}(bufp)))
//
val
_(*int*) =
$extfcall
( int
, "snprintf"
, bufp, BUFSZ
, "%s -ns 12 --output %s --input %s.bak"
, MYTEXTING, inp, inp
) (* $extfcall *)
val () =
  fprintln! (stdout_ref, $UN.cast{string}(bufp))
val () =
  ignoret($STDLIB.system($UN.cast{string}(bufp)))
//
in
  // nothing
end // end of [process_one]

(* ****** ****** *)

implement
main0{n}
(
  argc, argv
) = let
//
val argv1 =
ptr_succ<string> ($UN.castvwtp1{ptr}(argv))
//
implement(env)
array_foreach$fwork<string><env> (x, env) = process_one(x)
//
in
  ignoret(arrayref_foreach($UN.castvwtp1{arrayref(string,n-1)}(argv1), i2sz(argc-1)))
end (* end of [main0] *)

(* ****** ****** *)

(* end of [synhilit.dats] *)
