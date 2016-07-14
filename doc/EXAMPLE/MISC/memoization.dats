(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Time: the 13th of July, 2016
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
#include
"share/HATS/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
extern
fun
{a,b:t0p}
memo : (a -<cloref1> b) -> (a -<cloref1> b)
//
(* ****** ****** *)
//
extern
fun{}
fib(n: int): int
//
(* ****** ****** *)
//
extern
fun{}
fib_rec(n: int): int
//
implement
{}(*tmp*)
fib_rec = fib<>
//  
(* ****** ****** *)
//
implement
{}(*tmp*)
fib(n) =
if n >= 2
  then (fib_rec(n-1) + fib_rec(n-2)) % 1000000 else n
// end of [if]
//
(* ****** ****** *)
//
extern
val
fib_memo
  : (int) -<cloref1> int
//
implement
{}(*tmp*)
fib_rec(n) = fib_memo(n)
//
(* ****** ****** *)

local

staload FM = "libats/ML/SATS/funmap.sats"
staload _(*anon*) = "libats/ML/DATS/funmap.dats"    
staload _(*anon*) = "libats/DATS/funmap_avltree.dats"
        
implement(key)
$FM.compare_key_key<key>(x, y) = gcompare_val_val<key> (x, y)
            
in

implement
{a,b}
memo(f) = let
//
typedef key = a and itm = b
typedef map = $FM.map(key,itm)
val M = ref<map> ($FM.funmap_nil<>())
//
in
// 
(
lam a =<cloref1> 
  case+ $FM.funmap_search(!M, a) of 
  | ~Some_vt b => b
  | ~None_vt _ => b where
    {
      val b = f a 
      val-~None_vt() = let
        val (vbox pf | t) = ref_get_viewptr(M)
      in
        $effmask_ref($FM.funmap_insert(!t, a, b))
      end
    }
)
//
end // end of [memo]

end // end of [local]

(* ****** ****** *)

implement
fib_memo = memo<int,int>(lam(n) => fib(n))

(* ****** ****** *)

implement
main0() =
{
  val N = 1000
  val () = println! ("fib(", N, ") = ", fib(N))
}

(* ****** ****** *)

(* end of [memoization.dats] *)
