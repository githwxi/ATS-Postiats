(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** compilation command:
**   atscc -fomit-frame-pointer -O3 fannkuch-redux.dats -o fannkuch-redux
*)

(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-11-15
//
(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

abst@ype
usi (n:int) = $extype"atstype_usi"
abst@ype
usiLte (n:int) = $extype"atstype_usi"

(* ****** ****** *)

(*
typedef usi = [n:nat] usi (n)
typedef usiLte (n:int) = [i:nat | i <= n] usi (i)
*)

extern
castfn u2i {i:nat} (x: usi (i)):<> int (i)
extern
castfn i2u {i:nat} (x: int (i)):<> usi (i)

(* ****** ****** *)

extern
castfn u2iLte {n:nat} (x: usiLte (n)):<> natLte (n)
extern
castfn i2uLte {n:nat} (x: natLte (n)):<> usiLte (n)

(* ****** ****** *)

typedef
iarr (n:int) = arrayref (usiLte n, n+1)

(* ****** ****** *)

fun iarr{n:nat}
  (n: size_t(n)): iarr (n) =
  arrayref_make_elt<usiLte(n)> (succ(n), i2uLte{n}(0))
// end of [iarr]

(* ****** ****** *)

%{^
//
typedef
atstype_uint atstype_usi ; // HX: seems the best
//
// HX: it is really difficult to beat [memcpy] :)
ATSinline()
atsvoid_t0ype
iarr_copy (
  atstype_ptr src
, atstype_ptr dst
, atstype_int bsz
) {
  memcpy (dst, src, (bsz+1)*sizeof(atstype_usi)) ; return ;
} // end of iarr_copy
%} // end of [%{^]
extern fun iarr_copy {n:nat}
  (src: iarr n, dst: iarr n, n: int n): void = "iarr_copy"
// end of [iarr_copy]

(* ****** ****** *)
//
fun fprint_iarr{n:nat}
(
  out: FILEref, A: iarr n, n: int n
) : void = {
  var i: intGte 1 = 1
  val () =
  while (i <= n)
    (fprint_int (out, u2iLte(A[i])); i := i+1)
  // end of [val]
  val () = fprint_char (out, '\n')
} (* end of [fprint_iarr] *)
//
macdef
print_iarr (A, n) = fprint_iarr (stdout_ref, ,(A), ,(n))
//
(* ****** ****** *)
//
%{^
int thePermCnt = 0;
int thePermCnt_get () { return thePermCnt ; }
void thePermCnt_inc () {
  thePermCnt += 1 ; if (thePermCnt == 1048576) thePermCnt = 0; return ;
}
int theCheckSum = 0;
int theCheckSum_get () { return theCheckSum ; }
void theCheckSum_add (atstype_int x) { theCheckSum += x ; return ; }
%} // end of [%{^]
//
extern fun thePermCnt_get (): int = "thePermCnt_get"
extern fun thePermCnt_inc (): void = "thePermCnt_inc"
extern fun theCheckSum_get (): int = "theCheckSum_get"
extern fun theCheckSum_add (x: int): void = "theCheckSum_add"
//
(* ****** ****** *)

fun perm_rotate
  {n,i:int | 1 <= i; i <= n}
  (P: iarr n, i: int i): void = () where {
  var k: intGte 1 = 1; var k1: int?; val P1 = P[1]
  val () = while (k < i) (k1 := k+1; P[k] := P[k1]; k := k1)
  val () = P[i] := P1
} (* end of [perm_rotate] *)

fun perm_next
  {n,i:int | 1 <= i; i <= n} (
  C: iarr n, P: iarr n, n: int n, i: int i
) : natLte (n+1) = let
  val x = u2iLte(C[i])
  val x1 = x-1
  val () = perm_rotate{n,i} (P, i)
in
  case+ 0 of
  | _ when x1 > 0 => (C[i] := i2uLte{n}(x1); i)
  | _ (* x1 = 0 *) => let
      val () = C[i] := i2uLte{n}(i); val i1 = i + 1
    in
      if i1 <= n then perm_next (C, P, n, i1) else i1
    end
end (* end of [perm_next] *)

(* ****** ****** *)

fun fannkuch_count{n:int | n >= 2}
  (C: iarr n, P: iarr n, S: iarr n, n: int n, max: int): int = let
  fun rev0
    {l,u:int | 1 <= l; l <= u+1; u <= n}
    (S: iarr n, l: int l, u: int u): void = if (l < u) then let
      val tmp = S[u] in S[u] := S[l]; S[l] := tmp; rev0 (S, l+1, u-1)
    end
  fn fannkuch_rev1
    {u:int | 1 < u; u <= n} (S: iarr n, u: int u): void = let
    val tmp = u2iLte(S[u]) in
    S[u] := S[1]; S[1] := i2uLte{n}(tmp); if tmp <> 1 then rev0 (S, 2, u-1)
  end // end of [fannkuch_rev1]
  var max: int = max
  val () =
  if u2iLte(P[1]) <> 1 then let
    var cnt: int = 0
    val () = iarr_copy (P, S, n)
    var S1: natLte n = u2iLte(S[1])
    val () = while (S1 > 1)
    (
      cnt := cnt + 1; fannkuch_rev1 (S, S1); S1 := u2iLte(S[1])
    ) (* end of [val] *)
    val () = if max < cnt then max := cnt
    val thePermCnt = thePermCnt_get ()
    val () = if thePermCnt mod 2 = 0
      then theCheckSum_add (cnt) else theCheckSum_add (~cnt)
    // end of [val]
  in
    // nothing
  end // end of [val]
  val n1 = perm_next (C, P, n, 2)
  val () = thePermCnt_inc ()
in
  if n1 <= n then fannkuch_count (C, P, S, n, max) else max
end (* end of [fannkuch] *)

fun
iarr_init{n:nat}
(
  A: iarr n, n: int n
) : void = let
  var i: intGte 1 = 1
in
  while (i <= n) (A[i] := i2uLte{n}(i); i := i+1)
end // end of [iarr_init]

(* ****** ****** *)

implement
main0 (argc, argv) = let
  val () = assert (argc >= 2)
  val [n:int] n = g1ofg0(g0string2int(argv[1]))
  val () = assertloc (n >= 2)
  val nsz = i2sz (n)
  val C = iarr nsz; val () = iarr_init (C, n)
  val P = iarr nsz; val () = iarr_init (P, n)
  val () = iarr_init (C, n); val () = iarr_init (P, n); val S = iarr nsz
  val ans = fannkuch_count (C, P, S, n, 0)
  val _ = $extfcall (int, "printf", "%i\n", theCheckSum_get())
  val _ = $extfcall (int, "printf", "Pfannkuchen(%i) = %i\n", n, ans)
in
  // nothing
end (* end of [main0] *)

(* ****** ****** *)

(* end of [fannkuch-redux.dats] *)
