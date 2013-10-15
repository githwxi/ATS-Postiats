(* ****** ****** *)
//
// HX-2013-07
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

datatype
coroutine
  (i:t@ype, o:t@ype) =
  Coroutine(i, o) of coroutine_clo (i, o)
where
coroutine_clo
  (i:t@ype, o:t@ype) = i -<cloref1> (o, coroutine (i, o))

extern
fun{i,o:t@ype}
co_run (co: coroutine(i, o), x: i): (o, coroutine(i, o))
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
  Coroutine (lam _ => (n, int_from (n+1)))
//  
(* ****** ****** *)
  
implement
main0(argc, argv) = let
  val crt = int_from (5)
  val res = co_run ( crt, 0 )
  val () = println! ("result from coroutine : ", res.0)
  val res = co_run ( res.1, res.0 )
  val () = println! ("result from coroutine : ", res.0)
  val res = co_run ( res.1, res.0 )
  val () = println! ("result from coroutine : ", res.0)
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [qa-list-43.dats] *)
