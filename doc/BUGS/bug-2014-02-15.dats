(*
** Bug in computing
** closure environment
** for template instantiations
*)
(* ****** ****** *)
//
// Reported by HX-2014-02-15
//
(* ****** ****** *)

(*
//
The cause seems to be here:
//
pats_ccomp_ccompenv.dats
ccompenv_addlst_flabsetenv_ifmap
//
*)

(* ****** ****** *)

(*
** Status:
** HX-2014-02-16:
** It seems that fixing this bug can be highly involved
** and risky. However, the bug can be readily circumvented.
** So I see no need to fix it for now.
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

extern
fun{}
myfoo$fopr (i: int): int
extern fun{} myfoo (): int

(* ****** ****** *)

extern
fun{} mybar (n: int): int

implement{
} mybar (n) = let
//
fn fopr (i: int): int = n + i
(*
fn{} fopr (i: int): int = n + i // circumvent the bug
*)
//
implement
myfoo$fopr<> (i) = fopr(i)
//
implement{} myfoo () = myfoo$fopr<> (0)
//
in
  myfoo<> ()
end // end of [mybar]

(* ****** ****** *)

implement
main0 () =
{
//
val x = mybar<> (0)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [bug-2014-02-15.dats] *)
