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

#define \
NM 100
int used[NM];
int nused = 0;
int nused_max = 0;
typedef
struct{ void* _[3]; } block_t;
block_t smem[NM];

void
atsruntime_mfree_user(void *p) {
/*
  fprintf(stderr, "atsruntime_mfree_user: p = %p\n", p);  
  fprintf(stderr, "atsruntime_malloc_user: nused = %d\n", nused);
  fprintf(stderr, "atsruntime_malloc_user: nused_max = %d\n", nused_max);
*/
  void *p0 = &smem[0];
  used[((char*)p - (char*)p0)/sizeof(block_t)] = 0; nused--;
}

void*
atsruntime_malloc_user(size_t bsz) {
/*
  fprintf(stderr, "atsruntime_malloc_user: bsz = %lu\n", bsz);  
  fprintf(stderr, "atsruntime_malloc_user: nused = %d\n", nused);
  fprintf(stderr, "atsruntime_malloc_user: nused_max = %d\n", nused_max);
*/
  int i;
  for (i = 0; i < NM; i += 1)
  {
    if (used[i] == 0)
    {
      used[i] = 1; nused++; if (nused > nused_max) nused_max++; return &smem[i];
    }
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
extern
fun
qsolve_vt
{n:nat}
(
  n: int(n)
) : stream_vt(list_vt(int, n))
//
(* ****** ****** *)

#define N 8

(* ****** ****** *)

implement
qsolve_vt{n}(n) =
(
if
n = 0
then
$ldelay
stream_vt_cons
(
  list_vt_nil
, stream_vt_make_nil()
) (* end of [then] *)
else let
//
fun
test
{ i:int
| 0 < i; i <= n
} .<n-i>.
(
  x: int
, i: int(i), xs: !list_vt(int, n-i)
) :<> bool =
(
case+ xs of
| list_vt_nil() => true
| list_vt_cons(x1, xs) =>
    if (x != x1 && abs(x-x1) != i)
      then test(x, i+1, xs) else false
  // end of [list_cons]
)
//
fun
extend
{x:nat | x <= N} .<N-x>.
(
  x: int(x), xs: list_vt(int, n-1)
) :<!wrt> stream_vt(list_vt(int, n)) = $ldelay
(
//
(
if x < N then (
  if test(x, 1, xs)
    then
    stream_vt_cons
    (
      list_vt_cons(x, list_vt_copy(xs))
    , extend(x+1, xs)
    )
    else !(extend(x+1, xs))
  // end of [if]
) else (list_vt_free(xs); stream_vt_nil(*void*))
) : stream_vt_con(list_vt(int, n))
//
,
//
list_vt_free(xs) // it is called when the stream is freed
//
)  (* end of [extend] *)
//
in
//
stream_vt_concat
(
  stream_vt_map_fun(qsolve_vt(n-1), lam(xs) => extend(0, xs))
) (* end of [stream_vt_concat] *)
//
end // end of [else]
//
) (* end of [qsolve_vt] *)

(* ****** ****** *)
//
implement
main0(argc, argv) =
{
//
  val n0 = N
//
  val nsol = loop(qsolve_vt(n0)) where
  { 
    fun
    loop(xs: stream_vt(List_vt(int))): int =
      (case+ !xs of ~stream_vt_nil() => 0 | ~stream_vt_cons(xs, xss) => (list_vt_free(xs); 1 + loop(xss)))
  }
  val ((*void*)) =
    println! ("The number of solutions equals ", nsol)
  // end of [val]
}
//
(* ****** ****** *)

(* end of [QueensPuzzle_vt.dats] *)
