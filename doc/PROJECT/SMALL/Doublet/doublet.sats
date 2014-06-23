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
//
fun doublet_search 
  (src: word, dst: word): Option_vt (list0(word))
//
(* ****** ****** *)

(* end of [doublet.sats] *)
