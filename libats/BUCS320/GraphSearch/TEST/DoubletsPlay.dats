(*
For testing GraphSearh_bfs
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
#include
"share/HATS\
/atspre_staload_libats_ML.hats"

(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)

staload "./../DATS/GraphSearch.dats"
staload "./../DATS/GraphSearch_bfs.dats"

(* ****** ****** *)

local

typedef
key = string and itm = int

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)
//
extern
fun
theWords_map_search(string): bool
//
(* ****** ****** *)

local

val
opt =
fileref_open_opt
(
 "/usr/share/dict/words", file_mode_r
) (* end of [val] *)
val-~Some_vt(filr) = opt
//
val
theWords =
myhashtbl_make_nil(128*1024)
//
val ws =
  streamize_fileref_line(filr)
val () =
(
  ws
).foreach()
  (lam w =>theWords.insert_any(w, 0))
//
(*
val ((*void*)) =
  println! ("theWords.size() = ", theWords.size())
*)
//
in (* in-of-local *)

implement
theWords_map_search(w) =
(
case+
theWords.search(w) of
  | ~Some_vt _ => true | ~None_vt _ => false
)

end // end of [local]

(* ****** ****** *)
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
char_get_rest
(
$UN.cast{natLt(NAB)}(c-'a')
)
).map(TYPE{string(n)})
  (lam x => string_fset_at(s0, i2sz(i), ckastloc_charNZ(x)))
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
assume nodelst = stream_vt(node)

(* ****** ****** *)
//
implement
{}(*tmp*)
theSearchStore_insert_lst(nxs) =
(
nxs
).foreach()(lam nx => theSearchStore_insert(nx))
//
(* ****** ****** *)

implement
node_get_neighbors<>
  (nx0) = let
//
val-cons0(w, _) = nx0
val ws = word_get_neighbors(w)
//
in
//
ws.map(TYPE{node})(lam w => cons0(w, nx0))
//
end // end of [node_get_neighbors]

(* ****** ****** *)
//
extern
fun
Doublets_play
(
  w1: string, w2: string
) : Option(list0(string))
//
(* ****** ****** *)

implement
Doublets_play
  (w1, w2) = res[] where
{
//
val
res =
ref<Option(list0(string))>(None)
//
val
theMarked = myhashtbl_make_nil(1024)
//
implement
node_mark<>(nx) =
{
//
  val-
  cons0(w, _) = nx
  val-~None_vt() = theMarked.insert(w, 0)
//
}
//
implement
node_is_marked<>(nx) = let
//
  val-
  cons0(w, _) = nx
//
  val opt = theMarked.search(w)
//
in
//
case+ opt of
  | ~Some_vt _ => true | ~None_vt _ => false
//
end // end of [node_is_marked]
//
implement
process_node<>
  (nx) = let
  val-cons0(w, _) = nx
in
  if w = w2 then (res[] := Some(nx); false) else true
end // end of [process_node]
//
val nx = list0_sing(w1)
//
val
store =
qlistref_make_nil()
val () =
qlistref_insert(store, nx)
//
val () = GraphSearch_bfs(store)
//
} (* end of [Doublets_play] *)

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
| None() =>
    println!
    (
      "[", w1, "] and [", w2, "] are not a doublet!"
    )
| Some(ws) =>
    println!
    (
      "[", w1, "] and [", w2, "] form a doublet: ", list0_reverse(ws)
    )
//
end // end of [Doublets_play]

(* ****** ****** *)

(* end of [DoubletsPlay.dats] *)
