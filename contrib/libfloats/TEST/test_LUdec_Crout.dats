// 
// BB: in-place LU decomposition
//     for square matrices.
//
extern
fun{a:t0p}
LUdec_Crout
  {n:int}{ld:int}
( 
  M: &GMC(a, n, n, ld), n:int, ld:int
) : [l:addr] (array_v (a, l, n), mfree_gc_v (l) | ptr l)
//
// BB note: need to return other information as well later
