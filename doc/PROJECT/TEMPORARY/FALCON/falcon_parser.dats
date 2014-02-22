(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"{$LIBATSHWXI}/cstream/SATS/cstream.sats"
staload
"{$LIBATSHWXI}/cstream/SATS/cstream_tokener.sats"
//
staload _ = "libats/DATS/stringbuf.dats"
staload _ = "{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
(* ****** ****** *)
  
staload "./falcon.sats"
  
(* ****** ****** *)

staload "./falcon_tokener.dats"

(* ****** ****** *)
//
implement
fprint_val<grexp> = fprint_grexp
//
implement
fprint_grexp
  (out, gx) = let
in
  case+ gx of
  | GRgene (gn) => fprint! (out, "GRgene(", gn, ")")
  | GRconj (gxs) => fprint! (out, "GRconj(", gxs, ")")
  | GRdisj (gxs) => fprint! (out, "GRdisj(", gxs, ")")
  | GRempty () => fprint! (out, "")
  | GRerror () => fprint! (out, "GRerror(", ")")
end // end of [fprint_grexp]
//
implement
fprint_grexplst (out, gxs) = fprint_list (out, gxs)
//
(* ****** ****** *)
//
datatype parerr =
  | PARERRrpar of (position) // missing rparen
  | PARERRtoken of (token, position) // unhandled token
//
(* ****** ****** *)
//
extern
fun print_parerr (pe: parerr): void
extern
fun prerr_parerr (pe: parerr): void
extern
fun fprint_parerr (out: FILEref, pe: parerr): void
//
overload print with print_parerr
overload prerr with prerr_parerr
overload fprint with fprint_parerr
//
(* ****** ****** *)
//
implement
print_parerr (pe) = fprint_parerr (stdout_ref, pe)
implement
prerr_parerr (pe) = fprint_parerr (stderr_ref, pe)
//
implement
fprint_parerr
  (out, pe) = let
in
//
case+ pe of
| PARERRrpar (pos) =>
    fprint! (out, "error(parse): ", pos, ": unbalanced parenthesis")
| PARERRtoken (tok, pos) =>
    fprint! (out, "error(parse): ", pos, ": unrecognized char: ", tok)
//
end // end of [fprint_parerr]
//
(* ****** ****** *)

typedef
parerrlst = List0 (parerr)

(* ****** ****** *)

extern
fun the_parerrlst_add (parerr): void
extern
fun the_parerrlst_get ((*void*)): parerrlst

(* ****** ****** *)

local

val thePElst = ref<parerrlst> (list_nil)

in (* in-of-local *)
//
implement
the_parerrlst_add (pe) =
  !thePElst := list_cons{parerr}(pe, !thePElst)
//
implement
the_parerrlst_get () = let
  val xs = !thePElst
  val () = !thePElst := list_nil ()
in
  list_vt2t (list_reverse (xs))
end // end of [the_parerrlst_get]
//
end // end of [local]

(* ****** ****** *)
//
extern
fun
fprint_the_parerrlst (FILEref): void
//
implement
fprint_the_parerrlst (out) = let
//
implement
fprint_val<parerr> = fprint_parerr
implement
fprint_list$sep<> (out) = fprint (out, '\n')
//
in
  fprint_list (out, the_parerrlst_get ())
end // end of [fprint_the_parerrlst]
//
(* ****** ****** *)

extern
fun parse_RPAREN (!tokener2): void
extern
fun parseopt_OR (!tokener2): bool
extern
fun parseopt_AND (!tokener2): bool

(* ****** ****** *)

extern
fun parse_gratm (!tokener2): grexp
extern
fun parse_grconj (!tokener2): grexp
extern
fun parse_grdisj (!tokener2): grexp

(* ****** ****** *)

extern
fun parse_AND_gratm (!tokener2): grexplst
extern
fun parse_OR_grconj (!tokener2): grexplst

(* ****** ****** *)

extern
fun parse_grexp (!tokener2): grexp
extern
fun parse_grexplst (!tokener2): grexplst

(* ****** ****** *)

local

(* ****** ****** *)

staload
STRINGS = "libc/SATS/strings.sats"

(* ****** ****** *)
//
macdef get = my_tokener2_get
macdef unget = my_tokener2_unget
macdef getaft = my_tokener2_getaft
macdef getout = my_tokener2_getout
//
macdef strcasecmp = $STRINGS.strcasecmp
//
(* ****** ****** *)

fun auxerr
  (tok: token): void =
{
  val pos = position_get_now ()
  val perr = PARERRtoken (tok, pos)
  val ((*void*)) = the_parerrlst_add (perr)
  val ((*void*)) = prerrln! ("error(parsing): ", perr)
} (* end of [auxerr] *)

in (* in-of-local *)

implement
parse_RPAREN
  (t2knr) = let
//
val (pf | tok) = get (t2knr)
//
in
//
case+ tok of
| TOKrpar () => let
    val () = getaft (pf | t2knr) in ()
  end // end of [TOKrpar]
| _(*rest*) => let
    val () = unget (pf | t2knr)
    val pos = position_get_now ()
  in
    the_parerrlst_add (PARERRrpar(pos))
  end // end of [_]
//
end // end of [parse_RPAREN]

implement
parseopt_AND
  (t2knr) = let
//
val (pf | tok) = get (t2knr)
//
in
//
case+ tok of
| TOKide (sym) => ans where
  {
    val ans =
    strcasecmp (sym.name, "AND") = 0
    val () = (
    if ans
      then getaft (pf | t2knr) else unget (pf | t2knr)
    // end of [if]
    ) : void // end of [val]
  } (* end of [TOKide] *)
| _(*rest*) => (unget (pf | t2knr); false)
//
end // end of [parseopt_AND]

implement
parseopt_OR
  (t2knr) = let
//
val (pf | tok) = get (t2knr)
//
in
//
case+ tok of
| TOKide (sym) => ans where
  {
    val ans =
    strcasecmp (sym.name, "OR") = 0
    val () = (
    if ans
      then getaft (pf | t2knr) else unget (pf | t2knr)
    // end of [if]
    ) : void // end of [val]
  } (* end of [TOKide] *)
| _(*rest*) => (unget (pf | t2knr); false)
//
end // end of [parseopt_OR]

(* ****** ****** *)

implement
parse_gratm
  (t2knr) = let
//
val tok = getout (t2knr)
//
in
//
case+ tok of
| TOKide (sym) => 
    GRgene(gene_make_symbol(sym))
  // end of [TOKide]
| TOKlpar () => gx where
  {
    val gx = parse_grexp (t2knr)
    val () = parse_RPAREN (t2knr)
  } (* end of [TOKlpar] *)
| _(*rest*) => let
    val () = auxerr (tok) in GRerror ()
  end // end of [val]
//
end // end of [parse_gratm]

end // end of [local]

(* ****** ****** *)

implement
parse_AND_gratm
  (t2knr) = let
  val ans = parseopt_AND (t2knr)
in
  if ans then let
    val gx0 = parse_gratm (t2knr)
    val gxs = parse_AND_gratm (t2knr)
  in
    list_cons{grexp}(gx0, gxs)
  end else list_nil ()
end // end of [parse_AND_gratm]

(* ****** ****** *)

implement
parse_grconj (t2knr) = let 
  val gx0 = parse_gratm (t2knr)
  val gxs = parse_AND_gratm (t2knr)
in
  case+ gxs of
  | list_nil () => gx0
  | list_cons _ => GRconj(list_cons{grexp}(gx0, gxs))
end // end of [parse_grconj]

(* ****** ****** *)

implement
parse_OR_grconj
  (t2knr) = let
  val ans = parseopt_OR (t2knr)
in
  if ans then let
    val gx0 = parse_grconj (t2knr)
    val gxs = parse_OR_grconj (t2knr)
  in
    list_cons{grexp}(gx0, gxs)
  end else list_nil ()
end // end of [parse_OR_grconj]

(* ****** ****** *)

implement
parse_grdisj (t2knr) = let 
  val gx0 = parse_grconj (t2knr)
  val gxs = parse_OR_grconj (t2knr)
in
  case+ gxs of
  | list_nil () => gx0
  | list_cons _ => GRdisj (list_cons{grexp}(gx0, gxs))
end // end of [parse_grdisj]

(* ****** ****** *)

implement
parse_grexp (t2knr) = parse_grdisj (t2knr)

(* ****** ****** *)

implement
parse_grexplst
  (t2knr) = let
//
fun loop
(
  t2knr: !tokener2, res: grexplst_vt
) : grexplst_vt = let
//
val (pf | tok) = my_tokener2_get (t2knr) 
val ((*void*)) = my_tokener2_unget (pf | t2knr)
//
in
//
case+ tok of
| TOKeof () => res
| TOKrsep () => let
    val _ = my_tokener2_getout (t2knr)
    val res = list_vt_cons{grexp}(GRempty (), res)
  in
    loop (t2knr, res)
  end // end of [_]
//
| _(*rest*) => let
    val gx = parse_grexp (t2knr)
    val (pf | tok) = my_tokener2_get (t2knr) 
    val () = case+ tok of
      | TOKeof () => my_tokener2_unget (pf | t2knr)
      | TOKrsep () => let
        val () = my_tokener2_unget (pf | t2knr)
        val _ = my_tokener2_getout (t2knr)
      in
        ()
      end
      | _(*assume one rule per separator (e.g. newline)*) =>
      (
        assertloc(false);
        my_tokener2_unget (pf | t2knr)
      )  
    val res = list_vt_cons{grexp}(gx, res)
  in
    loop (t2knr, res)
  end // end of [_]
//
end // end of [loop]
//
val res = loop (t2knr, list_vt_nil)
//
in
  list_vt2t (list_vt_reverse (res))
end // end of [parse_grexplst]

(* ****** ****** *)
//
extern
fun parse_fileref (inp: FILEref): grexplst
//
implement
parse_fileref
  (inp) = gxs where
{
//
val cs0 = cstream_make_fileref (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val gxs = parse_grexplst (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [parse_fileref]

(* ****** ****** *)
//
extern
fun parse_string (inp: string): grexplst
//
implement
parse_string
  (inp) = gxs where
{
//
val cs0 = cstream_make_string (inp)
val tknr = tokener_make_cstream (cs0)
val t2knr = tokener2_make_tokener (tknr)
//
val gxs = parse_grexplst (t2knr)
//
val ((*freed*)) = tokener2_free (t2knr)
//
} // end of [parse_string]

(* ****** ****** *)

(* end of [falcon_parser.dats] *)
