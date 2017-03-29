(* ****** ****** *)
//
// HX-2017-03-28:
//
// For streamizing graphs
//
(* ****** ****** *)
//
#staload
GraphStreamize = "./DATS/GraphStreamize.dats"
//
(* ****** ****** *)
//
#ifdef
GRAPHSTREAMIZE_BFS
#then
#staload
GraphStreamize_bfs = "./DATS/GraphStreamize_bfs.dats"
#endif // #ifdef(GRAPHSTREAMIZE_BFS)
//
(* ****** ****** *)
//
#ifdef
GRAPHSTREAMIZE_DFS
#then
#staload
GraphStreamize_dfs = "./DATS/GraphStreamize_dfs.dats"
#endif // #ifdef(GRAPHSTREAMIZE_DFS)
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
