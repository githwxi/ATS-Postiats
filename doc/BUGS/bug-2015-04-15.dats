(*
** Bug causing erroneous
** compilation for a statically allocated array
*)

(* ****** ****** *)

(*
** Source:
** Reported by shlevy-2015-04-15
*)

(* ****** ****** *)

(*
** Status: It is fixed by HX-2015-04-16
*)

(* ****** ****** *)

(*
exit(ATS): /home/hwxi/research/Postiats/git/src/pats_typerase_dynexp.dats: 18567(line=820, offs=9) -- 18619(line=820, offs=61): match failure.
*)

(* ****** ****** *)

fun
foo (): void = let
  val buf_sz = i2sz(10)
  var buf = @[byte][buf_sz]()
in () end

(* ****** ****** *)

(* end of [bug-2015-04-15.dats] *)
