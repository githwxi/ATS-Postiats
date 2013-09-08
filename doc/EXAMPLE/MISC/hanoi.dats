(*
//
// Implementing the Hanoi Tower problem
//
// The code was first written by Hongwei Xi in the summer of 2004
// The code is ported to ATS2 by Hongwei Xi on the last day of May, 2012
//
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
abstype
post_type (n:int) = ptr // for posts
typedef post (n:int) = post_type (n)
//
(* ****** ****** *)

extern
fun post_make {sz:pos} (sz: int sz): post (sz)
extern
fun post_initize {sz:nat} (p: post (sz), sz: int sz): void

(* ****** ****** *)

extern
fun post_get_at
  {sz:int} (p: post (sz), i: natLt sz): natLte (sz)
overload [] with post_get_at
extern
fun post_set_at
  {sz:int} (p: post (sz), i: natLt sz, x: natLte (sz)): void
overload [] with post_set_at

(* ****** ****** *)

fun
showpiece
  {sz:int}
(
  sz: int sz, n: natLte sz
) : void = let
//
fun loop
{
  i:nat | i <= 2*sz
} .<2*sz-i>.
(
  i: int (i)
) :<cloref1> void = let
in
//
if i < (sz-n) then
(
  print ' '; loop (i + 1)
) else if i < (sz+n-1) then
(
  print 'O'; loop (i + 1)
) else if i < (sz + sz) then
(
  print ' '; loop (i + 1)
) // end of [if]
//
end // end of [loop]
//
in
  loop (0)
end // end of [showpiece]

(* ****** ****** *)

fun play
  {sz:pos} .<>.
  (sz: int sz): void = let
//
//
val lp = post_make (sz)
val mp = post_make (sz)
val rp = post_make (sz)
//
fun showposts
  .<>. (
  (*argumentless*)
) :<cloref1> void = let
//
fun loop
  {i:nat | i <= sz} (
  i: int i
) :<cloref1> void = let
in
  if sz > i then begin
    showpiece (sz, lp[i]);
    showpiece (sz, mp[i]);
    showpiece (sz, rp[i]);
    print_newline (); 
    loop (i + 1)
  end else begin
    print_newline ()
  end // end of [if]
end // end of [loop]
//
in
  loop (0)
end // end of [showposts]
//
val () = post_initize (lp, sz)
//
viewtypedef post = post (sz)
//
fun move
{
  n,s,p,p':nat
| p <= sz &&
  p' <= sz &&
  s + p + p' == sz + sz &&
  n > 0 &&
  s + n <= sz &&
  n <= p &&
  n <= p'
} .<n>. (
  n: int n
, src: post, s: int s,
  post: post, p: int p
, post': post, p': int p'
) :<cloref1> void = (
  if n = 1 then (
    post[p-1] := src[s]; src[s] := 0; showposts ()
  ) else (
    move (
      n-1, src, s, post', p', post, p
    ) ; // end of [move]
    post[p-1] := src[s+n-1]; src[s+n-1] := 0; showposts ();
    move (
      n-1, post', p' - n + 1, post, p - 1, src, s + n
    ) ; // end of [move]
  ) (* end of [if] *)
) (* end of [move] *)
//
in
//
  showposts ();
  move (sz, lp, 0, rp, sz, mp, sz);
  print ("This round of play has finished.");
  print_newline ();
//
end // end of [play]

(* ****** ****** *)

implement
main (
  argc, argv
) = let
  val () = play (4) in 0(*normalexit*)
end // end of [main]

(* ****** ****** *)

local

typedef
T (n:int) = natLte n
assume
post_type (n:int) = arrayref (T(n), n)

in // in of [local]

implement
post_make {sz} (sz) =
  arrayref_make_elt (g1int2uint(sz), 0)
// end of [post_make]

implement
post_initize
  {sz} (p, sz) = let
//
fun loop {
  i:nat | i <= sz
} .<sz-i>. (
  i: int i
) :<cloref1> void =
  if i < sz then let
    val i1 = succ(i) in arrayref_set_at (p, i, i1) ; loop (i1)
  end // end of [if]
//
in
  loop (0)
end // end of [post_initize]

implement
post_get_at (p, i) = arrayref_get_at (p, i)
implement
post_set_at (p, i, x) = arrayref_set_at (p, i, x)

end // end of [local]

(* ****** ****** *)

(* end of [hanoi.dats] *)
