(*
//
// For use in Effective ATS
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
//
*)

(* ****** ****** *)

%{^

#define NM 3
int used[NM] ;
typedef
struct{ void* _[2]; } block_t;
block_t smem[NM];

void
atsruntime_mfree_user(void *p) {
/*
  fprintf(stderr, "atsruntime_mfree_user: p = %p\n", p);  
*/
  void *p0 = &smem[0];
  used[((char*)p - (char*)p0)/sizeof(block_t)] = 0;
}

void*
atsruntime_malloc_user(size_t bsz) {
/*
  fprintf(stderr, "atsruntime_malloc_user: bsz = %d\n", (int)bsz);  
*/
  int i;
  for (i = 0; i < NM; i += 1)
  {
    if (used[i] == 0) { used[i] = 1; return &smem[i]; }
  }
  return 0;
}

%} // end of [%{^]

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
fn fibseq_vt()  =
  (fix f(n0:int, n1: int): stream_vt(int) =>
    $ldelay(stream_vt_cons(n0, f(n1, (n0+n1)%1000))))(0, 1)
//
(* ****** ****** *)

val fib10 = stream_vt_nth_exn(fibseq_vt(), 10)
val fib1M = stream_vt_nth_exn(fibseq_vt(), 1000000)

(* ****** ****** *)
//
implement
main0() =
{
  #define N 1000000
  val ((*void*)) = println! ("fib(", N, ") % 1000 = ", stream_vt_nth_exn(fibseq_vt(), N))
}
//
(* ****** ****** *)

(* end of [Fibonacci_vt.dats] *)
