(* ****** ****** *)
//
// HX-2017-02-01:
//
// Generic Divide-Conquer
//
(* ****** ****** *)
//
#staload
DivideConquer =
"./DATS/DivideConquer.dats"
//
(* ****** ****** *)
//
#ifdef
DIVIDECONQUER_MEMO
#staload
DivideConquer_memo =
"./DATS/DivideConquer_memo.dats"
#endif // #ifdef(DIVIDECONQUER_MEMO)
//
(* ****** ****** *)
//
#ifdef
DIVIDECONQUER_CONT
#staload
DivideConquer_cont =
"./DATS/DivideConquer_cont.dats"
#endif // #ifdef(DIVIDECONQUER_CONT)
//
(* ****** ****** *)

(* end of [mylibies.hats] *)
