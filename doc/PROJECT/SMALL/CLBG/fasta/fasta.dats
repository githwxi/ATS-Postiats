(*
** The Computer Language Shootout
** http://shootout.alioth.debian.org/
** 
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Author: Zhiqiang Ren (aren AT cs DOT bu DOT edu)
**
** Time: January, 2010
**
** compilation command:
**   atscc -O3 fasta4.dats -msse2 -mfpmath=sse -o fasta4
*)

(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-11-12
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDIO = "libc/SATS/stdio.sats"

(* ****** ****** *)

macdef fputc(out, c) = $STDIO.fputc0_char (,(out), ,(c))

(* ****** ****** *)

%{^
#define likely(x) __builtin_expect((x), 1)
#define unlikely(x) __builtin_expect((x), 0)
%} // end of [{%^]
extern fun unlikely0 (x: bool): bool = "mac#unlikely"

(* ****** ****** *)

macdef IA = 3877U
macdef IC = 29573U
macdef IM = 139968U

#define BUFLEN 60
#define BUFLEN1 61
#define LOOKUP 4096

(* ****** ****** *)

macdef
float(x) = $UN.cast{float}(,(x))
macdef
LOOKUP_SCALE = (float)(LOOKUP - 1)

(* ****** ****** *)

typedef random_t = uint
extern typedef "random_t" = random_t

extern fun random_init
  (seed: &random_t? >> random_t): void = "random_init"

implement random_init (seed) = seed := 42U

fn random_next_lookup
  (seed: &random_t): float = let
  val () =
    seed := (seed * IA + IC) mod IM
in
  (float)seed * (LOOKUP_SCALE / (float)IM)
end // end of [random_next_lookup]

(* ****** ****** *)

typedef amino_acid =
  $extype_struct "amino_acid" of {
  sym= char, prob= float, cprob_lookup= float
} // end of [amino_acid]

typedef aminoarr (n:int) = @[amino_acid][n]

(* ****** ****** *)

extern
fun fwrite_substring
  {m,p,n:nat | p + n <= m}
(
  str: string m, beg: size_t p, n: size_t n, out: FILEref
) : void = "fwrite_substring"

(* ****** ****** *)
//
extern
fun repeat_fasta
  {len:nat}{n:nat}
  (out: FILEref, str: string len, n: size_t n): void = "repeat_fasta"
//
implement
repeat_fasta
  {len}{n}
  (out, str, n) = let
//
macdef BUFLEN_sz = i2sz(BUFLEN)
//
val len = string1_length (str)
val ((*void*)) = assertloc (len >= BUFLEN_sz)
fun loop
  {n,pos:nat | pos <= len}
(
  out: FILEref, n: size_t n, pos: size_t pos
) :<cloref1> void = let
in
//
if n > BUFLEN_sz then let
  val left = len - pos in
  if left >= BUFLEN_sz then let
    val () = fwrite_substring (str, pos, BUFLEN_sz, out)
    val _err = fputc ('\n', out)
  in
    loop (out, n - BUFLEN_sz, pos + BUFLEN_sz)
  end else let
    val () = fwrite_substring (str, pos, left, out)
    val () = fwrite_substring (str, i2sz(0), BUFLEN_sz - left, out)
    val _err = fputc ('\n', out)
  in
    loop (out, n - BUFLEN_sz, BUFLEN_sz - left)
  end // end of [if]
end else let
  val left = len - pos in
  if left >= n then let
    val () = fwrite_substring (str, pos, n, out)
    val _err = fputc ('\n', out)
  in
    // nothing
  end else let
    val () = fwrite_substring (str, pos, left, out)
    val () = fwrite_substring (str, i2sz(0), n-left, out)
    val _err = fputc ('\n', out)
  in
    // nothing
  end // end of [if]
end (* end of [if] *)
//
end // end of [loop]
//
in
  loop (out, n, i2sz(0))
end // end of [repeat_fasta]

(* ****** ****** *)

overload + with add_ptr_bsz of 20

(* ****** ****** *)

fun
fill_lookuparr{n0:pos}
(
  lookuparr: &(@[ptr?][LOOKUP]) >> @[ptr][LOOKUP]
, aminoarr: &aminoarr(n0), n0: size_t n0
) : void = let
//
typedef T = amino_acid
//
fun loop1
  {l:addr}{n:nat} .<n>.
(
  pf: !array_v (T, l, n) | p: ptr l, n: size_t n, acc: float
) :<!wrt> void =
  if n > 0 then let
    prval (pf1, pf2) = array_v_uncons {T} (pf)
    val acc = acc + p->prob
    val () = p->cprob_lookup := acc * LOOKUP_SCALE
    val () = loop1 (pf2 | p + sizeof<T>, pred(n), acc)
    prval () = pf := array_v_cons {T} (pf1, pf2)
  in
    // nothing
  end // end of [if]
// end of [loop1]
//
val () =
loop1 (view@aminoarr | addr@aminoarr, n0, (float)0.0)
val () = aminoarr.[pred(n0)].cprob_lookup := LOOKUP_SCALE
//
fun loop2
  {l:addr}{n:nat} .<n>.
(
  pf: !array_v (ptr?, l, n) >> array_v (ptr, l, n)
| aminoarr: &(@[T][n0]), p: ptr l, n: size_t n, fi: float, j0: natLt n0
) : void =
  if n > 0 then let
    var j: natLt n0 = j0
    val () = while*
      {j:nat | j < n0} (j: int j): (j: natLt n0) =>
      (aminoarr.[j].cprob_lookup < fi) let
      prval () = _meta_info () where {
        extern praxi _meta_info (): [j+1 < n0] void
      } // end of [prval]
    in
      j := j + 1
    end // end of [val]
    prval (pf1, pf2) = array_v_uncons {ptr?} (pf)
    val () = !p := addr@(aminoarr.[j])
    val () = loop2 (pf2 | aminoarr, p + sizeof<ptr>, pred(n), fi+(float)1, j)
  in
    pf := array_v_cons {ptr} (pf1, pf2)
  end else let
    prval () = array_v_unnil {ptr?} pf
    prval () = pf := array_v_nil {ptr} ()
  in
    // nothing
  end // end of [if]
// end of [loop2]
//
val () = loop2
(
  view@lookuparr
| aminoarr, addr@lookuparr, i2sz(LOOKUP), (float)0, 0
) (* end of [val] *)
//
in
  // nothing
end // end of [fill_lookuparr]

(* ****** ****** *)

typedef lookuparr = @[ptr][LOOKUP]

(* ****** ****** *)

extern
fun randomize
  {n0:pos}{n:nat}
(
  aminoarr: &aminoarr(n0), n0: size_t n0, n: int n, seed: &random_t
) : void = "randomize"
 
implement
randomize
  (aminoarr, n0, n, seed) =
{
//
  extern fun fwrite_byte
    (buf: ptr, n: int, out: FILEref):<> void = "fwrite_byte"
  // end of [fwrite_byte]
//
  var buf = @[char?][BUFLEN1]()
  var lookuparr = @[ptr][LOOKUP]()
  val () = buf[BUFLEN] := '\n'
  val () = fill_lookuparr (lookuparr, aminoarr, n0)
  var i: Nat = 0 and j: natLte (BUFLEN) = 0
  val () = while (i < n) let
    val () = if :(j: natLt (BUFLEN)) =>
      (j = BUFLEN) then
      (fwrite_byte (addr@buf, BUFLEN1, stdout_ref); j := 0)
    // end of [if]
//
    val r = random_next_lookup (seed)
    val ri = g0float2int_float_int (r)
    val [ri:int] ri = g1ofg0_int (ri)
    prval () = _meta_info () where {
      extern praxi _meta_info (): [0 <= ri && ri < LOOKUP] void
    } // end of [prval]
//
    typedef T = amino_acid
    var u: ptr = lookuparr[ri]
//
    val () = while (true) let
      val (
        pf, fpf | u1
      ) = $UN.ptr0_vtake{T}(u)
      val r1 = u1->cprob_lookup
      prval () = fpf (pf)
    in
      if unlikely0(r1 < r) then u := u + sizeof<T> else $break
    end // end of [val]
//
    val (
      pf, fpf | u1
    ) = $UN.ptr0_vtake{T}(u)
    val () = buf[j] := u1->sym
    prval () = fpf (pf)
//
  in
    i := i + 1; j := j + 1
  end // end of [while]
  val () = buf[j] := '\n'
  val () = fwrite_byte (addr@buf, j+1, stdout_ref)
} (* end of [randomize] *)

(* ****** ****** *)

implement
main0 (argc, argv) =
  $extfcall(void, "mainats", argc, $UN.castvwtp1{ptr}(argv))
(* end of [main0] *)

(* ****** ****** *)

%{$

#define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))

void
mainats (
  atstype_int argc, atstype_ptr argv0
) {
  char **argv = (char**)argv0 ;
  int n = argc > 1 ? atoi( argv[1] ) : 512;
  random_t rand;
  random_init(&rand);
//
  fprintf(stdout, ">ONE Homo sapiens alu\n");
  repeat_fasta((atstype_ref)stdout, (atstype_ptr)alu, n*2);
//
  fprintf(stdout, ">TWO IUB ambiguity codes\n");
  randomize(aminoacids, ARRAY_SIZE(aminoacids), n*3, &rand);
//
  fprintf(stdout, ">THREE Homo sapiens frequency\n");
  randomize(homosapiens, ARRAY_SIZE(homosapiens), n*5, &rand);
//
  return;
} // end of [mainats]
                                                    
%}

(* ****** ****** *)

%{^

typedef
struct _amino_acid {
  char sym;
  float prob;
  float cprob_lookup;
} amino_acid ;

//
// let us do initialization in C to avoid many hassels
//
         
amino_acid aminoacids[] = {
   { 'a', 0.27 },
   { 'c', 0.12 },
   { 'g', 0.12 },
   { 't', 0.27 },
//            
   { 'B', 0.02 },
   { 'D', 0.02 },
   { 'H', 0.02 },
   { 'K', 0.02 },
   { 'M', 0.02 },
   { 'N', 0.02 },
   { 'R', 0.02 },
   { 'S', 0.02 },
   { 'V', 0.02 },
   { 'W', 0.02 },
   { 'Y', 0.02 },
} ;
                                             
amino_acid homosapiens[] = {
  { 'a', 0.3029549426680 },
  { 'c', 0.1979883004921 },
  { 'g', 0.1975473066391 },
  { 't', 0.3015094502008 },
} ;
                                                         
static const char alu[] =
"GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTG"
"GGAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGA"
"GACCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAA"
"AATACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAAT"
"CCCAGCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAAC"
"CCGGGAGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTG"
"CACTCCAGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";

//

void
fwrite_substring
(
  atstype_ptr str
, atstype_size beg
, atstype_size len
, atstype_ptr out
) {
  fwrite_unlocked(((char*)str)+beg, 1, len, (FILE*)out) ; return ;
} // end of [fwrite_substring]

void
fwrite_byte
(
  atstype_ptr buf, atstype_int n, atstype_ptr fil
) {
  fwrite_unlocked ((void*)buf, (size_t)1, (size_t)n, (FILE*)fil) ;
  return ;
} // end of [fasta_fwrite_byte]
                                                                              
//

static
void
mainats (atstype_int argc, atstype_ptr argv) ;

%} // end of [%{^]

(* ****** ****** *)

(* end of [fasta.dats] *)
