(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** compilation command:
**   patscc -O3 -fomit-frame-pointer fannkuch.dats -o fannkuch
*)

(* ****** ****** *)
//
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

typedef
iarr (n:int) = arrayref (int, n+1)

(* ****** ****** *)

macdef iarr (n) = arrayref_make_elt (succ(,(n)), 0)

(* ****** ****** *)

%{^
//
// HX: it is really difficult to beat [memcpy] :)
//
ATSinline()
atsvoid_t0ype iarr_copy
  (atstype_ptr src, atstype_ptr dst, atstype_int n) {
  memcpy ((int*)dst+1, (int*)src+1,  n * sizeof(atstype_int)) ;
  return ;
} // end of iarr_copy
%} // end of [%{^]

extern fun iarr_copy {n:nat}
  (src: iarr n, dst: iarr n, n: int n): void = "iarr_copy"
// end of [iarr_copy]

(* ****** ****** *)

fn fprint_iarr {n:nat}
  (out: FILEref, A: iarr n, n: int n): void = () where {
  var i: intGte 1 = 1
  val () = while (i <= n) (fprint_int (out, A[i]); i := i+1)
  val () = fprint_char (out, '\n')
} (* end of [fprint_iarr] *)

macdef
print_iarr (A, n) = fprint_iarr (stdout_ref, ,(A), ,(n))

(* ****** ****** *)

fun perm_rotate
  {n,i:int | 1 <= i; i <= n}
  (P: iarr n, i: int i): void =
{
  var k: intGte 1 = 1; var k1: int?; val P1 = P[1]
  val () = while (k < i) (k1 := k+1; P[k] := P[k1]; k := k1)
  val () = P[i] := P1
} (* end of [perm_rotate] *)

(* ****** ****** *)

fun perm_next
  {n,i:int | 1 <= i; i <= n}
(
  C: iarr n, P: iarr n, n: int n, i: int i
) : natLte (n+1) = let
  val x = C[i]; val x1 = x-1; val () = perm_rotate{n,i} (P, i)
in
  case+ 0 of
  | _ when x1 > 0 =>
      (C[i] := x1; i)
  | _ (* x1 = 0 *) => let
      val () = C[i] := i; val i1 = i + 1
    in
      if i1 <= n then perm_next (C, P, n, i1) else i1
    end // end of [_]
end (* end of [perm_next] *)

(* ****** ****** *)

fun fannkuch_count
  {n:int | n >= 2}
(
  C: iarr n, P: iarr n, S: iarr n, n: int n, max: int
) : int = let
  fun rev0
    {l,u:int | 1 <= l; l <= u+1; u <= n}
    (S: iarr n, l: int l, u: int u): void = if (l < u) then let
      val tmp = S[u] in S[u] := S[l]; S[l] := tmp; rev0 (S, l+1, u-1)
    end
  fn fannkuch_rev1
    {u:int | 1 < u; u <= n} (S: iarr n, u: int u): void = let
    val tmp = S[u] in
    S[u] := S[1]; S[1] := tmp; if tmp <> 1 then rev0 (S, 2, u-1)
  end // end of [fannkuch_rev1]
  var max: int = max
  val () =
  (
    if P[1] = 1 then () else
    if P[n] = n then () else let
      var cnt: int = 0
      val () = iarr_copy (P, S, n)
      var S1: int = S[1]
      val () =
      while (S1 > 1) (
        cnt := cnt + 1;
        fannkuch_rev1 (S, $UN.cast{intBtwe(2,n)}(S1)); S1 := S[1]
      ) (* end of [val] *)
    in
      if max < cnt then max := cnt
    end (* end of [if] *)
  ) : void // end of [val]
in
  if perm_next (C, P, n, 2) <= n then fannkuch_count (C, P, S, n, max) else max
end (* end of [fannkuch] *)

fun iarr_init {n:nat} (A: iarr n, n: int n): void =
  let var i: intGte 1 = 1 in while (i <= n) (A[i] := i; i := i+1) end
// end of [iarr_init]

(* ****** ****** *)

#define NPRINT 30

(* ****** ****** *)

implement
main0 (argc, argv) = let
  val () = assert (argc >= 2)
  val [n:int] n = g1string2int(argv[1])
  val () = assert (n >= 2)
  val nsz = i2sz(n)
  val C = iarr nsz; val () = iarr_init (C, n)
  val P = iarr nsz; val () = iarr_init (P, n)
  val () = if NPRINT > 0 then print_iarr (P, n)
  var times: int = 1; val () = while (times < NPRINT) let
    val _ = perm_next (C, P, n, 2) in print_iarr (P, n); times := times + 1
  end // end of [val]
  val () = iarr_init (C, n); val () = iarr_init (P, n); val S = iarr nsz
  val ans = fannkuch_count (C, P, S, n, 0)
in
  ignoret($extfcall(int, "printf", "Pfannkuchen(%i) = %i\n", n, ans))
end (* end of [main] *)

(* ****** ****** *)

(* end of [fannkuch.dats] *)
