(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#define
ATS_PACKNAME"CATS-PARSEMIT"
//
(* ****** ****** *)

#staload "./catsparse.sats" // opened

(* ****** ****** *)
//
fun
typedef_insert(name: symbol, def: tyrec): void
//
fun
typedef_search_opt (name: symbol): Option_vt (tyrec)
//
(* ****** ****** *)

(* end of [catsparse_typedef.sats] *)
