(* ****** ****** *)
//
// For chaining words based on
// their occurrences in a given file
//
(* ****** ****** *)
//
// HX-2014-06
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
staload UN = $UNSAFE
//
(* ****** ****** *)
//
staload "libats/SATS/qlist.sats"
staload _ = "libats/DATS/qlist.dats"
//
(* ****** ****** *)
//
staload "libats/SATS/hashfun.sats"
//
(* ****** ****** *)
//
typedef word = string
//
typedef wordlst = List0 (word)
typedef wordlst(n:int) = list(word, n)
vtypedef wordlst_vt(n:int) = list_vt(word, n)
//
vtypedef wordque(n:int) = qlist(word, n)
//
(* ****** ****** *)

extern
fun
wordque_insert_list
  {n0:int}{n:int}
(
  wq: !wordque(n0) >> wordque(n0+n), ws: wordlst(n)
) : void // end of [wordque_insert_list]

(* ****** ****** *)

implement
wordque_insert_list
  (wq, ws) =
(
  case+ ws of
  | nil () => ()
  | cons (w, ws) => let
      val () = qlist_insert (wq, w) in wordque_insert_list (wq, ws)
    end // end of [cons]
)

(* ****** ****** *)

extern
fun{}
word_get (): stropt
implement
word_get<> () = let
//
implement
fileref_get_word$isalpha<>
  (letter) = not(isspace(letter))
//
in
//
strptr2stropt (fileref_get_word (stdin_ref))
//
end // end of [word_get]

(* ****** ****** *)
//
extern
fun
stringlst_hash
  (xs: List0(string)): ulint
//
(* ****** ****** *)

implement
stringlst_hash (xs) = let
//
fun loop
(
  K: ulint, H: ulint, xs: List0(string)
) : ulint =
(
case+ xs of
| list_nil () => H
| list_cons (x, xs) => let
    val H = string_hash_multiplier (K, H, x)
  in
    loop (K, H, xs)
  end // end of [list_cons]
)
//
in
  loop (33ul(*K*), 31415926536ul(*H0*), xs)
end // end of [stringlst_hash]

(* ****** ****** *)

abstype wordmap_type = ptr
typedef wordmap = wordmap_type

(* ****** ****** *)

extern
fun wordmap_make_nil (): wordmap

(* ****** ****** *)

extern
fun
wordmap_find
  {n:int | n > 0}
(
  map: wordmap, ws: wordlst(n)
) : wordlst // end-of-fun

(* ****** ****** *)

extern
fun
wordmap_insert
  {n:int | n > 0}
(
  map: wordmap, ws: wordlst(n), w: word
) : wordmap // end of [wordmap_insert]

(* ****** ****** *)

extern
fun{}
fprint_wordmap
(
  out: FILEref, map: wordmap
) : void // end of [fprint_wordmap]
//
overload fprint with fprint_wordmap
//
(* ****** ****** *)

local
//
typedef key = list0(word)
typedef itm = list0(word)
//
assume
wordmap_type = hashtbl (key, itm)
//
implement
hash_key<key> (k) =
  $effmask_all (stringlst_hash (g1ofg0(k)))
//
implement
equal_key_key<key>
  (k1, k2) = list_equal<string> (g1ofg0(k1), g1ofg0(k2))
//
in (* in-of-local *)

implement
wordmap_make_nil
(
// argumentless
) = hashtbl_make_nil (i2sz(4096))

implement
wordmap_find
  (map, ws) = let
//
val ws = g0ofg1_list (ws)
val res = hashtbl_search_ref (map, ws)
val isnot = cptr_isnot_null (res)
//
in
//
if isnot
  then g1ofg0($UN.cptr_get(res)) else list_nil((*void*))
//
end // end of [wordmap_find]

implement
wordmap_insert
  (map, ws, w) = let
//
val ws = g0ofg1_list (ws)
val res = hashtbl_search_ref (map, ws)
val isnot = cptr_isnot_null (res)
//
in
//
if
isnot
then let
  val ws = $UN.cptr_get (res)
  val () = $UN.cptr_set (res, cons0 (w, ws))
in
  map
end // end of [then]
else let
  val () = hashtbl_insert_any (map, ws, list0_sing (w))
in
  map
end // end of [else]
//
end // end of [wordmap_insert]

implement
{}(*tmp*)
fprint_wordmap (out, map) = fprint_hashtbl (out, map)

end // end of [local]

(* ****** ****** *)

extern
fun{}
wordmap_build{n:pos}(ws: wordlst(n)): wordmap

(* ****** ****** *)

implement
{}(*tmp*)
wordmap_build
  {n}(ws0) = let
//
fun loop
(
  map: wordmap, wq: qlist(word, n)
) : wordmap = let
//
val opt = word_get ()
val issome = stropt_is_some (opt)
//
in
//
if
issome
then let
  val w = stropt_unsome (opt)
  val ws = qlist_takeout_list (wq)
  val ws = list_vt2t (ws)
  val map = wordmap_insert (map, ws, w)
  val+list_cons (_, ws) = ws
  val () = wordque_insert_list (wq, ws)
  val () = qlist_insert<word> (wq, w)
in
  loop (map, wq)
end // end of [then]
else let
  val () =
    free (qlist_takeout_list (wq))
  val () = qlist_free_nil{word} (wq) in (map)
end // end of [else]
//
end // end of [loop]
//
val map = wordmap_make_nil ()
val wq0 = qlist_make_nil{word}()
val ((*void*)) = wordque_insert_list (wq0, ws0)
//
in
  loop (map, wq0)
end // end of [wordmap_build]

(* ****** ****** *)
//
staload
STDLIB = "libats/libc/SATS/stdlib.sats"
//
extern
fun
wordlst_choose
  {n:pos}(ws: wordlst(n), n: int(n)): word
//
implement
wordlst_choose
  {n} (ws, n) = let
  val x = $STDLIB.random()
  val i = $UN.cast{natLt(n)}(x mod $UN.cast2lint(n))
in
  list_get_at (ws, i)
end // end of [wordlst_choose]
//
(* ****** ****** *)
//
extern
fun
wordmap_nchoose{n:pos}
  (map: wordmap, ws0: wordlst(n), N: int): void
//
(* ****** ****** *)

implement
wordmap_nchoose
  {n}(map, ws0, N) = let
//
fun loop
(
  ws: wordlst_vt(n), i: int
) : void =
(
if
(i > 0)
then let
  typedef key = list0(word)
  typedef itm = list0(word)
  val ws_itm =
    wordmap_find (map, $UN.list_vt2t(ws))
  val n = length (ws_itm)
//
  val () = assertloc (n > 0)
  val w_chosen = wordlst_choose (ws_itm, n)
  val () = fprint! (stdout_ref, ' ', w_chosen)
//
  val+~list_vt_cons (_, ws) = ws
  val ws = list_vt_extend (ws, w_chosen)
in
  loop (ws, pred(i))
end // end of [then]
else list_vt_free (ws)
)
//
in
  loop (list_copy (ws0), N)
end // end of [wordmap_nchoose]

(* ****** ****** *)

implement
main0 () = () where
{
//
val ws0 =
  $list{word}("", "")
//
val map = wordmap_build (ws0)
//
(*
local
implement
fprint_hashtbl$sep<> = fprint_newline
implement
fprint_hashtbl$mapto<> (out) = fprint (out, " => ")
in (*in-of-local*)
val () = fprintln! (stdout_ref, "map = ", map)
end // end of [local]
*)
//
val ws1 =
  $list{word}("", "")
val () = fprint_list_sep (stdout_ref, ws1, " ")
val () = wordmap_nchoose (map, ws1, 250)
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [word-chain.dats] *)
