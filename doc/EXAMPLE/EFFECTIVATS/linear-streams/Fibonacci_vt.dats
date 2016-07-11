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

int B[3] = {0, 0, 0} ;
struct{ void* _[3]; } M[4];

void
atsruntime_mfree_user(void *p) {
/*
  fprintf(stderr, "atsruntime_free_user: p = %p\n", p);  
*/
  if (p == &M[0]) B[0] = 0;
  if (p == &M[1]) B[1] = 0;
  if (p == &M[2]) B[2] = 0;
}

void*
atsruntime_malloc_user(size_t bsz) {
/*
  fprintf(stderr, "atsruntime_malloc_user: bsz = %d\n", (int)bsz);  
*/
  if (B[0] == 0) { B[0] = 1; return &M[0]; }
  if (B[1] == 0) { B[1] = 1; return &M[1]; }
  if (B[2] == 0) { B[2] = 1; return &M[2]; }
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
fn fibseq()  =
  (fix f(n0:int, n1: int): stream_vt(int) =>
    $ldelay(stream_vt_cons(n0, f(n1, (n0+n1)%1000))))(0, 1)
//
(* ****** ****** *)
//
implement
main0() =
{
  #define N 1000000
  val ((*void*)) = println! ("fib(", N, ") % 1000 = ", stream_vt_nth_exn(fibseq(), N))
}
//
(* ****** ****** *)

(* end of [Fibonacci_vt.dats] *)
