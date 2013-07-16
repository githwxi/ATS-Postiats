(* ****** ****** *)
//
// HX-2013-07
//
(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

datatype
coroutine
  (i:t@ype, o:t@ype) =
  Coroutine(i, o) of coroutine_clo (i, o)
where
coroutine_clo (i:t@ype, o:t@ype) = i -<cloref1> (o, coroutine (i,o))

extern
fun{i,o:t@ype}
co_run(co: coroutine(i, o), x: i): (o, coroutine(i, o))
// end of [co_run]

implement
{i,o}(*tmp*)
co_run(co, x) = let
  val+Coroutine (f) = co
  val f = f : coroutine_clo (i, o)
in
  f (x)
end // end of [co_fun]

(* ****** ****** *)
//
fun int_from
  (n:int): coroutine(int, int) =
  Coroutine (lam x => (n, int_from (n+1)))
//  
(* ****** ****** *)
  
implement
main0(argc, argv) = let
  val res = co_run ( int_from 5, 0 )
in
  println! ("result from coroutine : ", res.0)
end // end of [main0]

(* ****** ****** *)

(* end of [qa-list-43.dats] *)
