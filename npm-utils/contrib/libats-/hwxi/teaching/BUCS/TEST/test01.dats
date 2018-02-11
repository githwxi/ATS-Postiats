(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
STDLIB =
"libats/libc/SATS/stdlib.sats"
//
(* ****** ****** *)

#include "./../DATS/BUCS520.dats"

(* ****** ****** *)

implement
main0(argc, argv) =
{
//
val-
~Some_vt
 (date) =
 shell_eval("date", nil())
//
val ((*void*)) = print!(date)
val ((*freed*)) = strptr_free(date)
//
} (* end of [main0] *)
  
(* ****** ****** *)

(* end of [test01.dats] *)
