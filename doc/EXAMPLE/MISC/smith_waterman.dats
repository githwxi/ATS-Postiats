(*
**
** An implementation of
** the Smith-Waterman algorithm
**
*)
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

%{^
//
typedef
struct {
  int nrow, ncol; int *matrix;
} dptbl_struct ;
//
typedef dptbl_struct *dptbl ;
//
%}
absvtype dptbl (m:int, n:int) = ptr

(* ****** ****** *)

extern
fun dptbl_make {m,n:nat} (m: int m, n: int n): dptbl (m, n) = "sta#"

(* ****** ****** *)

extern
fun dptbl_get {m,n:int}
  (tbl: !dptbl (m, n), x: natLt (m), y: natLt (n)): intGte (0) = "ext#"
overload [] with dptbl_get

extern
fun dptbl_set {m,n:int}
  (tbl: !dptbl (m, n), x: natLt (m), y: natLt (n), v: intGte (0)): void = "ext#"
overload [] with dptbl_set

(* ****** ****** *)

%{^
#define MATCH 0
#define DELETION 1
#define INSERTION 2
#define MISMATCH 3
%}
abst@ype oper = int
macdef MATCH = $extval (oper, "MATCH")
macdef DELETION = $extval (oper, "DELETION")
macdef INSERTION = $extval (oper, "INSERTION")
macdef MISMATCH = $extval (oper, "MISMATCH")
macdef MATCH_WT = 2
macdef DELETION_WT = ~1
macdef INSERTION_WT = ~1
macdef MISMATCH_WT = ~1000000

(* ****** ****** *)

extern fun max_of_int4 : (int, int, int, int) -<fun> int

(* ****** ****** *)

extern
fun SWalign {m,n:int}
  (str1: string m, str2: string n): dptbl (m+1, n+1)
// end of [fun]

(* ****** ****** *)

extern
fun string_tail {m:pos} (str: string (m)): string (m-1)

(* ****** ****** *)

implement
SWalign {m,n}
  (str1, str2) = let
//
val m = string_length (str1)
val n = string_length (str2)
//
val m = g1uint2int (m)
val n = g1uint2int (n)
//
fnx loop
  {i:pos} (
  tbl: !dptbl (m+1, n+1), i: int i, str1: string (m-i+1)
) : void = let
in
  if i <= m then loop2 (tbl, i, 1, str1, str2, str1[0]) else ()
end // end of [loop]

and loop2
  {i,j:pos | i <= m}
(
  tbl: !dptbl (m+1, n+1)
, i: int i, j: int j, str1: string(m-i+1), str2: string(n-j+1), a: char
) : void = let
in
//
if j <= n then let
  val b = str2[0]
  val score = (
    if (a = b) then MATCH_WT else MISMATCH_WT
  ) : int // end of [val]
  val max =
    max_of_int4 (
    0, tbl[i-1,j-1]+score, tbl[i,j-1]+INSERTION_WT, tbl[i-1,j]+DELETION_WT
  ) : int // end of [val]
  val max = $UN.cast{intGte(0)}(max)
  val () = tbl[i,j] := max
in
  loop2 (tbl, i, j+1, str1, string_tail (str2), a)
end else loop (tbl, i+1, string_tail (str1))
//
end // end of [loop2]
//
val tbl =
  dptbl_make (m+1, n+1)
//
val () = loop (tbl, 1, str1)
//
in
  tbl
end // end of [SWalign]

(* ****** ****** *)

%{$

ATSinline()
dptbl dptbl_make
(
  int m, int n
) {
  dptbl p = ATS_MALLOC (sizeof(dptbl_struct)) ;
  assert (p != NULL);
  p->matrix = ATS_CALLOC (m * n, sizeof(int)) ;
  assert (p->matrix != NULL) ;
  return p ;
} // end of [dptbl_make]

static
int *dptbl_getref (dptbl tbl, int x, int y) ;

ATSextern()
int dptbl_get
(
  dptbl tbl, int x, int y
) {
  int *p = dptbl_getref (tbl, x, y) ; return *p ;
} // end of [dptbl_get]

ATSextern()
void dptbl_set
(
  dptbl m, int x, int y, int v
) {
  int *p = dptbl_getref (tbl, x, y) ; *p = v ; return ;
} // end of [dptbl_set]

ATSinline()
int *dptbl_getref
(
  dptbl tbl, int x, int y
) {
  return (&tbl->matrix[x * tbl->ncol + y]) ;
} // end of [dptbl_getref]

%}

(* ****** ****** *)

(* end of [smith_waterman.dats] *)
