(*
** Bug in datatype declaration
*)

(* ***** ****** *)
//
// Reported by BB-2014-05-17
//
(* ****** ****** *)
//
// Status: fixed by HX-2014-05-17
//
(* ***** ****** *)

datatype test () = TEST of ()

(* ***** ****** *)

(*
This example triggers the following failure:
//
The 1st translation (fixity) of [/home/hwxi/research/Postiats/git/doc/BUGS/bug-2014-05-17.dats] is successfully completed!
exit(ATS): /home/hwxi/research/Postiats/git/src/pats_trans2_staexp.dats: 65342(line=2598, offs=9) -- 65370(line=2598, offs=37): match failure.
exec(patsopt --typecheck --dynamic /home/hwxi/research/Postiats/git/doc/BUGS/bug-2014-05-17.dats) = 256
//
*)

(* ***** ****** *)

(* end of [bug-2014-05-17.dats] *)
