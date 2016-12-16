(*
For Effective ATS
*)

(* ****** ****** *)
//
staload
"libats/ML/SATS/basis.sats"
staload
"libats/ML/SATS/list0.sats"
//
(* ****** ****** *)

abstype node = ptr
typedef nodelst = list0(node)

(* ****** ****** *)
//
extern
fun{}
node_mark(node): void
extern
fun{}
node_unmark(node): void
//
extern
fun{}
node_is_marked(node): bool
overload
.is_marked with node_is_marked
//
(* ****** ****** *)
//
extern
fun{}
node_get_neighbors(nx: node): nodelst
//
(* ****** ****** *)
//
extern
fun{}
process_node(nx: node): bool
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_insert(node): void
extern
fun{}
theSearchStore_insert_lst(nodelst): void
//
(* ****** ****** *)
//
extern
fun{}
theSearchStore_choose((*void*)): Option_vt(node)
//
(* ****** ****** *)
//
extern
fun{}
GraphSearch(): void
//
(* ****** ****** *)

implement
{}(*tmp*)
GraphSearch
  ((*void*)) = let
//
fun
search
(
// argless
): void = let
//
val
opt = theSearchStore_choose()
//
in
//
case+ opt of
| ~None_vt() => ()
| ~Some_vt(nx) => let
    val cont = process_node(nx)
  in
    if cont
      then let
        val nxs =
          node_get_neighbors(nx)
        // end of [val]
      in
        theSearchStore_insert_lst(nxs); search((*void*))
      end // end of [then]
    // end of [if]
  end (* end of [Some_vt] *)
//
end (* end of [search] *)
//
in
  search((*void*))
end // end of [GraphSearch]

(* ****** ****** *)

(* end of [GraphSearch.dats] *)
