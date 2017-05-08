(* ****** ****** *)
//
// HX-2013-04-03:
// this example illustrates an idea for
// addressing integer arithmetic overflow
//
(* ****** ****** *)

stacst INTMIN : int and INTMAX : int
stadef isintb (i:int): bool = (INTMIN <= i && i <= INTMAX)

(* ****** ****** *)

abst@ype intb(i: int) = int // bounded integers

(* ****** ****** *)
  
extern
praxi
lemma_INTMINMAX
(
// argmentless
) : [INTMIN < ~0X7FFF ; INTMAX >= 0x7FFF] void

(* ****** ****** *)

extern
castfn
intb2int{i:int}(i: intb i): int(i)
extern
castfn
int2intb{i:int | isintb(i)} (i: int(i)): intb(i)

(* ****** ****** *)

extern
praxi
lemma_intb_param{i: int}(i: intb i): [isintb(i)] void

extern
fun
add_intb_intb
  {i,j:int | isintb(i+j)}
  (i: intb (i), j: intb (j)):<> intb (i+j)
overload + with add_intb_intb

extern
fun
sub_intb_intb
  {i,j:int | isintb(i-j)}
  (i: intb (i), j: intb (j)):<> intb (i-j)
overload - with sub_intb_intb

extern
fun
half_intb {i:nat}(i: intb (i)):<> intb (ndiv(i,2))
overload half with half_intb

extern
fun
lt_intb_intb{i,j:int}(i: intb i, j: intb j):<> bool (i < j)
overload < with lt_intb_intb

(* ****** ****** *)

extern
fun{a:t@ype}
bsearch{n:nat}
(
  A: &(@[a][n]), n: intb n, x0: &a, cmp: (&a, &a) -> int
) : bool // end of [bsearch]

implement
{a}
bsearch{n}
  (A, n, x0, cmp) = let
//
#define i2b int2intb
//
prval () = lemma_INTMINMAX()
prval () = lemma_intb_param(n)
//
fun
loop
{ l,r:nat
| l <= r
; r <= n} .<r-l>.
(
  A: &(@[a][n]), x0: &a, l: intb l, r: intb r
) :<cloref1> bool = let
in
//
if l < r then let
  val m = l + half(r - l)
(*
//
// HX: typechecking fails
// if the next line replaces the above one
// as arith overflow may potentially occur
//
  val m = (l + r) / 2
*)
  val m2 = intb2int (m)
  val sgn = cmp (x0, A.[m2])
in
  if sgn < 0 then loop (A, x0, l, m)
  else if sgn > 0 then loop (A, x0, m+i2b(1), r)
  else true (*found*)
end else false (*~found*)
//
end // end of [loop]
//
in
  loop (A, x0, i2b(0), n)
end // end of [bsearch]

(* ****** ****** *)

implement main((*void*)) = 0

(* ****** ****** *)

(* end of [arith_overflow.dats] *)
