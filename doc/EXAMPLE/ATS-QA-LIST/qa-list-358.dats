(* ****** ****** *)
//
// HX-2014-08-31
//
// Constructing an existentially quantified expression
//
(* ****** ****** *)

absview filedes (int)

(* ****** ****** *)

absview errno_obligation

(* ****** ****** *)

extern
praxi
require_errno_check (): errno_obligation

(* ****** ****** *)
//
extern
fun close {fd: nat} (filedes fd | int fd):
  [res:int | res <= 0] (option_v(errno_obligation, 0 > res) | int res)
//
(* ****** ****** *)

implement
close{fd}(prf | fd) = let
//
val res =
$extfcall (intLte(0), "close", fd)
prval () = __free (prf) where
{
  extern praxi __free (filedes(fd)): void
}
//
in
//
if
res = 0
then (None_v () | res)
else let
  prval e_obl = require_errno_check ()
in
  (Some_v e_obl | res)
end // end of [else]
//
end // end of [close]

(* ****** ****** *)

implement main () = 0

(* ****** ****** *)

(* end of [qa-list_358.dats] *)
