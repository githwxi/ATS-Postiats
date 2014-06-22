(*
** Implementing the doublet game
*)

(* ****** ****** *)
//
staload UN =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/strarr.sats"
//
(* ****** ****** *)

staload "./doublet.sats"

(* ****** ****** *)
//
extern
fun
word_get_friends_at
  (w0: word, i: size_t): List0_vt (word)
//
(* ****** ****** *)

implement
word_get_friends_at
  (w0, i0) = let
//
vtypedef res = List0_vt (word)
//
val n0 = length (w0)
val c0 = strarr_get_at (w0, i0)
//
fun aux1
(
  c: char, res: res
) : res =
  if c < c0 then let
    val w = w where
    {
      val f =
      lam (i: size_t)
        : char =<cloref1> if i != i0 then w0[i] else c
      val w = strarr_tabulate (n0, f)
      val () = cloptr_free ($UN.castvwtp0{cloptr(void)}(f))
    }
    val res = aux1 (int2char0(char2int0(c)+1), res)
  in
    if word_is_legal(w) then list_vt_cons (w, res) else res
  end else res // end of [if]
//
fun aux2
(
  c: char, res: res
) : res =
  if c > c0 then let
    val w = w where
    {
      val f =
      lam (i: size_t)
        : char =<cloref1> if i != i0 then w0[i] else c
      val w = strarr_tabulate (n0, f)
      val () = cloptr_free ($UN.castvwtp0{cloptr(void)}(f))
    }
    val ans = word_is_legal (w)
    val res =
    (
      if word_is_legal(w) then list_vt_cons (w, res) else res
    ) : res // end of [val]
  in
    aux2 (int2char0(char2int0(c)-1), res)
  end else (res) // end of [if]
//
in
  aux1 ('a', aux2 ('z', list_vt_nil(*void*)))
end // end of [word_get_friends_at]

(* ****** ****** *)

implement
word_get_friends
  (w0) = let
//
val n0 = length (w0)
val n0 = g1ofg0 (n0)
val wss =
list_tabulate_cloref<wordlst_vt>
  (sz2i(n0), lam (i) => word_get_friends_at (w0, i2sz(i)))
//
in
  list_vt_concat (wss)
end // end of [word_get_friends]

(* ****** ****** *)

(* end of [doublet_word.dats] *)
