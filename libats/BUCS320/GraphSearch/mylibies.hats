(* ****** ****** *)
//
// HX-2017-01-28:
//
// Generic Graph Search
// Depth-first and Breath-first
//
(* ****** ****** *)
//
staload GS = "./DATS/GraphSearch.dats"
//
(* ****** ****** *)
//
#ifdef
GRAPHSEARCH_BFS
staload GS_bfs = "./DATS/GraphSearch_bfs.dats"
#endif // #ifdef(GraphSearch_bfs)
//
(* ****** ****** *)
//
#ifdef
GRAPHSEARCH_DFS
staload GS_dfs = "./DATS/GraphSearch_dfs.dats"
#endif // #ifdef(GraphSearch_dfs)
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
