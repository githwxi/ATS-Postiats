(*
For Effective ATS
*)

(* ****** ****** *)

#include
"share/atspre_staload.hats"

(* ****** ****** *)

implement main0() = ()

(* ****** ****** *)

local
//
val
opt =
fileref_open_opt
(
 "/usr/share/dict/words", file_mode_r
) (* end of [val] *)
val-~Some_vt(filr) = opt
//
in

val
theWords = streamize_fileref_line(filr)

end // end of [local]

(* ****** ****** *)

(*
val theVowel = 'a'
val theLetters = "acfilnu"
*)
(*
val theVowel = 'o'
val theLetters = "omynegb"
*)
val theVowel = 'i'
val theLetters = "fradict"

(* ****** ****** *)

val
theWords =
stream_vt_map_fun<Strptr1><string>(theWords, lam(x) => strptr2string(x))

(* ****** ****** *)

val
theWords =
stream_vt_filter<string>(theWords) where
{
implement
stream_vt_filter$pred<string>(cs) = strlen(cs) >= 4
}

(* ****** ****** *)

val
theWords =
stream_vt_filter<string>(theWords) where
{
implement
stream_vt_filter$pred<string>(cs) = strchr(g1ofg0(cs), theVowel) >= 0
}

(* ****** ****** *)

val
theWords =
stream_vt_filter<string>(theWords) where
{
implement
stream_vt_filter$pred<string>(cs) = strspn(g1ofg0(cs), theLetters) >= strlen(cs)
}

(* ****** ****** *)

val nword =
stream_vt_foreach<string>(theWords) where
{
implement
stream_vt_foreach$fwork<string><void>(cs, env) = println!(cs)
}

(* ****** ****** *)

(* end of [words_search.dats] *)
