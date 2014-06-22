(*
** Implementing the doublet game
*)

(* ****** ****** *)

staload
"libats/ML/SATS/basis.sats"

(* ****** ****** *)

typedef word = strarr
typedef wordlst = List0 (word)
vtypedef wordlst_vt = List0_vt (word)

(* ****** ****** *)

fun word_is_legal (word): bool

(* ****** ****** *)

fun word_get_friends (word): List0_vt (word)

(* ****** ****** *)

(* end of [doublet.sats] *)
