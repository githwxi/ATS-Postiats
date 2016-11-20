(*
For Effective ATS
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./GraphSearch.dats"
staload "./GraphSearch_bfs.dats"

(* ****** ****** *)
//
extern
fun
theWords_map_search(string): bool
//
extern
fun // HX: implemented
word_get_neighbors(word: string): stream_vt(string)
//
(* ****** ****** *)

#define NAB 26

(* ****** ****** *)

fun
char_get_rest
(
c0: natLt(NAB)
) : stream_vt(char) = let
//
val a = char2int0('a')
//
in
(
(
(
(
NAB
).stream_vt_map
  (TYPE{int})(lam i => i)
).filter()(lam i => c0 != i)
).map(TYPE{char})(lam i => int2char0(a+i))
)
end // end of [char_get_rest]

(* ****** ****** *)
//
extern
fun
string_fset_at
  {n:int}
  {i:nat | i < n}
  (string(n), int(i), char): string(n)
//
implement
string_fset_at
  (s0, i, c) = let
  val s1 = string1_copy(s0)
  val () = s1[i] := ckastloc_charNZ(c)
in
  strnptr2string(s1)
end // end of [string_fset_at]
//
(* ****** ****** *)

local

fun
string_replace_one
  {n:int}{i:nat | i < n}
(
s0: string(n), i: int(i)
) : stream_vt(string(n)) = let
  val c = s0[i]
in
(
char_get_rest($UN.cast{natLt(NAB)}(c-'a'))
).map(TYPE{string(n)})(lam x => string_fset_at(s0, i, x))
end // end of [string_replace_one]

fun
string_replace_all
  {n:int}
(
s0: string(n)
) : stream_vt(string(n)) = let
//
prval() = lemma_string_param(s0)
//
in
//
stream_vt_concat
(
(
sz2i
(
  length(s0)
)
).stream_vt_map
  (TYPE{stream_vt(string(n))})(lam i => string_replace_one(s0, i))
) (* stream_vt_concat *)
//
end // end of [string_replace_all]

in
//
implement
word_get_neighbors(w0) =
(
  string_replace_all(w0)
).filter()(lam w => theWords_map_search(w)) where { val w0 = g1ofg0(w0) }
// end of [word_get_neighbors]
//
end // end of [local]

(* ****** ****** *)

assume node = list0(string)

(* ****** ****** *)

implement
{}(*tmp*)
node_get_neighbors
  (nx0) = let
//
val-cons0(w, _) = nx0
val ws = word_get_neighbors(w)
//
in
//
g0ofg1
(
stream2list_vt
(
  ws.map(TYPE{node})(lam w => cons0(w, nx0))
) (* stream2list_vt *)
) (* g0ofg1 *)
//
end // end of [node_get_neighbors]

(* ****** ****** *)
//
extern
fun
Doublets_play
(
  w1: string, w2: string
) : Option_vt(list0(string))
//
(* ****** ****** *)

implement
main0
(
  argc, argv
) = let
//
val () =
assertloc(argc >= 3)
//
val w1 = argv[1]
and w2 = argv[2]
//
val
opt = Doublets_play(w1, w2)
//
in
//
case+ opt of
| ~None_vt() =>
    println!
    (
      "[", w1, "] and [", w2, "] are not a doublet!"
    )
| ~Some_vt(ws) =>
    println!
    (
      "[", w1, "] and [", w2, "] does form a doublet: "
    )
//
end // end of [Doublets_play]

(* ****** ****** *)

(* end of [Doublets.dats] *)
