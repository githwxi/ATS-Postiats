//
// Some code for testing the API in ATS for pcre
//

(* ****** ****** *)

staload "./../SATS/pcre.sats"

(* ****** ****** *)

val () =
{
//
val () =
println! ("The pcre version is ", pcre_version ())
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test00.dats] *)
