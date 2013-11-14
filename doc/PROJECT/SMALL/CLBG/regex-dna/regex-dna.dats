(*
** The Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** regex-dna benchmark using PCRE
**
** compilation command:
**   atscc -O3 -fomit-frame-pointer -o regex-dna regex-dna.dats -lpcre
*)

(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-11-13
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

%{^
#include <pcre.h>
%}

(* ****** ****** *)

viewdef
bytes_v (n:int, l:addr) = bytes(n) @ l

(* ****** ****** *)
//
%{^
ATSinline()
atstype_ptr malloc_atm (atstype_int n) { return malloc (n) ; }
ATSinline()
atsvoid_t0ype free_atm (atstype_ptr p) { free (p) ; return ; }
%}
//
extern
fun malloc_atm {n:nat}
  (n: int n): [l:addr] @(bytes_v (n, l) | ptr l) = "ext#"
extern
fun free_atm
  {n:int}{l:addr} (pf: bytes_v (n, l) | p: ptr l): void = "ext#"
//
(* ****** ****** *)

viewdef
block_v (sz:int, l:addr) = bytes_v (sz, l)
datavtype blocklst (int) =
  | blocklst_nil (0) of ()
  | {n:nat}{sz:nat}{l:addr}
    blocklst_cons (n+1) of (block_v (sz, l) | int sz, ptr l, blocklst n)
viewtypedef blocklst = [n:nat] blocklst (n)

(* ****** ****** *)
//
extern
vtypedef
"blocklst_cons_pstruct" = blocklst_cons_pstruct (void | int, ptr, blocklst)
//
(* ****** ****** *)

extern
fun fread_stdin_block
  {sz:nat}{l:addr}
  (pf: !block_v (sz, l) | sz: int sz, p: ptr l): natLte sz = "ext#"

(* ****** ****** *)

%{$

atstype_int
fread_stdin_block (
  atstype_int sz0, atstype_ptr p0
) {
  char *p ; int nread, sz ;
  p = p0; sz = sz0 ;
  while (sz > 0) {
    nread = fread (p, 1, sz, stdin) ;
    if (nread > 0) { p += nread ; sz -= nread ; continue ; }
    if (feof (stdin)) break ;
  }
  return (sz0 - sz) ;
} /* end of [fread_stdin_block] */

%} // end of [%{$]

(* ****** ****** *)

fun
fread_stdin_blocklst
  {sz:nat}
(
  sz: int sz, tot: &int
) : blocklst = let
//
fun loop {tot:addr}
(
  pf_tot: !int @ tot |
  sz: int sz, p_tot: ptr tot, res: &blocklst? >> blocklst
) : void = let
  val (pf | p) = malloc_atm (sz)
  val n = fread_stdin_block (pf | sz, p)
  val () = !p_tot := !p_tot + n
  val () = (res := blocklst_cons {0} (pf | sz, p, _))
  val+blocklst_cons (_ | _, _, res1) = res
in
  if n < sz then begin
    res1 := blocklst_nil (); fold@ res
  end else begin
    loop (pf_tot | sz, p_tot, res1); fold@ res
  end // end of [if]
//
end // end of [loop]
//
var res: blocklst
val () = loop (view@ tot | sz, addr@tot, res)
//
in
  res
end // end of [fread_stdin_blocklst]

(* ****** ****** *)

extern
fun blocklst_concat_and_free{n:nat}
  (n: int n, blks: blocklst): [l:addr] @(bytes_v (n, l) | ptr l) = "ext#"

(* ****** ****** *)

%{$

atstype_ptr
blocklst_concat_and_free
  (atstype_int tot, atstype_ptr blks) {
  char *res0, *res, *p_blk ;
  int lft, sz ; blocklst_cons_pstruct blks_nxt ;

  lft = tot ; res0 = res = malloc_atm (tot) ;

  while (blks) {
    sz = ((blocklst_cons_pstruct)blks)->atslab__1 ;
    p_blk = ((blocklst_cons_pstruct)blks)->atslab__2 ;
    if (sz < lft) {
      memcpy (res, p_blk, sz) ;
    } else {
      memcpy (res, p_blk, lft) ; lft = 0 ; break ;
    }
    res += sz ; lft -= sz ;
    blks_nxt = ((blocklst_cons_pstruct)blks)->atslab__3 ;
    free_atm (p_blk) ; ATS_MFREE (blks) ;
    blks = blks_nxt ;
  }
  return res0 ;
}

%} // end of [{%$]

(* ****** ****** *)

%{$

atstype_int
count_pattern_match
  (atstype_int nsrc, atstype_ptr src, atstype_ptr pat) {
  int count ;
  pcre *re; pcre_extra *re_ex ; const char *re_e ;
  int err, re_eo, m[3], pos ;

  re = pcre_compile
    ((char*)pat, PCRE_CASELESS, &re_e, &re_eo, NULL) ;
  if (!re) exit (1) ;
  re_ex = pcre_study (re, 0, &re_e);  

  for (count = 0, pos = 0 ; ; ) {
    err = pcre_exec (re, re_ex, (char*)src, nsrc, pos, 0, m, 3) ;
    if (err < 0) break ; count += 1 ; pos = m[1] ;
  }
  return count ;
} /* end of [count_pattern_match] */

%} // end of [%{$]

(* ****** ****** *)
//
extern
fun
count_pattern_match
  {n:nat}{l:addr}
  (pf: !bytes_v (n, l) | n: int n, p: ptr l, pat: string): int = "ext#"
//
(* ****** ****** *)

#define variants_length 9
val variants =
  (arrayref)$arrpsz{string}
(
  "agggtaaa|tttaccct"
, "[cgt]gggtaaa|tttaccc[acg]"
, "a[act]ggtaaa|tttacc[agt]t"
, "ag[act]gtaaa|tttac[agt]ct"
, "agg[act]taaa|ttta[agt]cct"
, "aggg[acg]aaa|ttt[cgt]ccct"
, "agggt[cgt]aa|tt[acg]accct"
, "agggta[cgt]a|t[acg]taccct"
, "agggtaa[cgt]|[acg]ttaccct"
) // end of [variants]

fun count_loop {i:nat} {n:nat} {l:addr}
  (pf: !bytes_v (n, l) | n: int n, p: ptr l, i: int i): void =
  if i < variants_length then let
    val pat = variants[i]
    val cnt = count_pattern_match (pf | n, p, pat)
    val () = (print pat ; print ' '; print cnt ; print_newline ())
  in
    count_loop (pf | n, p, i + 1)
  end // end of [if]

(* ****** ****** *)

datatype seglst (int) =
  | seglst_nil (0) of ()
  | {n:nat}
    seglst_cons (n+1) of (int(*beg*), int(*len*), seglst n)
typedef seglst0 = seglst 0
typedef seglst = [n:nat] seglst (n)

(* ****** ****** *)

extern
typedef "int_ptr_t" = @(void | int, ptr)

extern
vtypedef
"seglst_cons_pstruct" = seglst_cons_pstruct (int, int, seglst)

(* ****** ****** *)
//
extern
fun
seglst_cons_make
(
  beg: int, len: int
) : seglst_cons_pstruct (int, int, seglst0?) = "ext#"
//
implement
seglst_cons_make (beg, len) = seglst_cons{0}(beg, len, _)
//
(* ****** ****** *)

%{$

atsvoid_t0ype subst_copy
(
  char *dst, char *src
, int nsrc, seglst_cons_pstruct sgs, char *sub, int nsub
) {
  int ofs, beg, len ; seglst_cons_pstruct sgs_nxt ;
  for (ofs = 0 ; ; ) {
    if (!sgs) break ;
    beg = sgs->atslab__0 ; len = beg - ofs ;
    memcpy (dst, src, len) ; dst += len ; src += len ; ofs = beg ;
    len = sgs->atslab__1 ;
    memcpy (dst, sub, nsub) ; dst += nsub ; src += len ; ofs += len ;
    sgs_nxt = sgs->atslab__2 ; ATS_MFREE (sgs); sgs = sgs_nxt ;
  }
  len = nsrc - ofs ;  memcpy (dst, src, len) ; return ;
} /* end of [subst_copy] */

int_ptr_t
subst_pattern_string
(
  atstype_int nsrc
, atstype_ptr src, atstype_ptr pat, atstype_ptr sub
) {
  char *dst ; int ndst, nsub ; int beg, len, nxt ;
  pcre *re; pcre_extra *re_ex ; const char *re_e ;
  int err, re_eo, m[3], pos ;
  seglst_cons_pstruct sgs0, sgs, *sgs_ptr ;
  int_ptr_t ans ;

  ndst = nsrc ; nsub = strlen ((char*)sub) ;
  re = pcre_compile
    ((char*)pat, PCRE_CASELESS, &re_e, &re_eo, NULL) ;
  if (!re) exit (1) ;
  re_ex = pcre_study (re, 0, &re_e);  
  for (pos = 0, sgs_ptr = &sgs0 ; ; ) {
    err = pcre_exec (re, re_ex, (char*)src, nsrc, pos, 0, m, 3) ;
    if (err >= 0) {
      beg = m[0] ; pos = m[1] ;
      len = pos - beg ; ndst -= len ; ndst += nsub ;
      sgs = (seglst_cons_pstruct)seglst_cons_make (beg, len) ;
      *sgs_ptr = sgs ; sgs_ptr = (seglst_cons_pstruct*)&(sgs->atslab__2) ;
    } else {
     *sgs_ptr = (seglst_cons_pstruct)0 ; break ;
    }
  } // end of [for]
  dst = malloc_atm (ndst) ;
  ans.atslab__1 = ndst ; ans.atslab__2 = dst ;
  subst_copy (dst, src, nsrc, sgs0, sub, nsub) ;
  return ans ;
} /* end of [subst_pattern_string] */

%} // end of [%{$]

extern
fun subst_pattern_string
  {n:nat} {l:addr} (
  pf: !bytes_v (n, l) | n: int n, p: ptr l, pat: string, sub: string
) : [n:nat] [l:addr] @(bytes_v (n, l) | int n, ptr l) = "subst_pattern_string"
// end of [subst_pattern_string]

(* ****** ****** *)

#define subst_length 22
val subst =
  (arrayref)$arrpsz{string}(
  "B", "(c|g|t)"
, "D", "(a|g|t)"
, "H", "(a|c|t)"
, "K", "(g|t)"
, "M", "(a|c)"
, "N", "(a|c|g|t)"
, "R", "(a|g)"
, "S", "(c|g)"
, "V", "(a|c|g)"
, "W", "(a|t)"
, "Y", "(c|t)"
) // end of [subst]

(* ****** ****** *)

fun subst_loop
  {i:nat}{n:nat}{l:addr}
(
  pf: bytes_v (n, l) | n: int n, p: ptr l, i: int i
) : int =
(
  if i < subst_length - 1 then let
    val pat = subst[i]; val sub = subst[i+1]
    val (pf1 | n1, p1) = subst_pattern_string (pf | n, p, pat, sub)
    val () = free_atm (pf | p)
  in
    subst_loop (pf1 | n1, p1, i + 2)
  end else begin
    let val () = free_atm (pf | p) in n end
  end // end of [if]
) (* end of [subst_loop] *)

(* ****** ****** *)

#define BLOCKSIZE 0x10000 // 0x4000000

implement
main0 () = let
  var n0: int = 0
  val blks = fread_stdin_blocklst (BLOCKSIZE, n0)
  val n0 = g1ofg0 (n0); val () = assert (n0 >= 0)
  val (pf_bytes | p0) = blocklst_concat_and_free (n0, blks)
  val (pf1_bytes | n1, p1) =
    subst_pattern_string (pf_bytes | n0, p0, ">.*|\n", "")
  val () = free_atm (pf_bytes | p0)
  val () = count_loop (pf1_bytes | n1, p1, 0)
  val n_last = subst_loop (pf1_bytes | n1, p1, 0)
  val _ = $extfcall (int, "printf", "\n%i\n%i\n%i\n", n0, n1, n_last)
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [regex-dna.dats] *)
