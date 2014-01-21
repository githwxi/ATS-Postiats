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
  
staload "./falcon.sats"
  
(* ****** ****** *)

staload "./falcon_tokener.dats"

(* ****** ****** *)

absvtype tokener2_vtype = ptr
vtypedef tokener2 = tokener2_vtype

(* ****** ****** *)

extern
fun tokener2_peek (!tokener2): token
extern
fun tokener2_next (!tokener2): void

(* ****** ****** *)

local

datavtype
tokener2 =
TOKENER2 of (tokener, token)

assume tokener2_vtype = tokener2

in (* in-of-local *)

implement
tokener2_peek (tknr2) =
let val+TOKENER2(_, tok) = tknr2 in tok end

implement
tokener2_next
  (tknr2) = () where
{
//
val+@TOKENER2(tknr, tok) = tknr2
val () = tok := my_tokener_get_token (tknr)
prval ((*void*)) = fold@ (tknr2)
//
} (* end of [tokener2_next] *)

end // end of [local]

(* ****** ****** *)

datatype grexp =
  | GRgene of gene
  | GRconj of grexplst
  | GRdisj of grexplst
  | GRerror of ((*void*))
// end of [grexp]

where grexplst = List0 (grexp)
          
(* ****** ****** *)
//
extern
fun fprint_grexp (FILEref, grexp): void
extern
fun fprint_grexplst (FILEref, grexplst): void
//
overload fprint with fprint_grexp
overload fprint with fprint_grexplst
//
(* ****** ****** *)
//
datatype parerr =
  | PARERRrpar of (position) // missing rparen
  | PARERRtoken of (token, position) // unhandled token
  | PARERRuneof of (position) // unused tokens
//
(* ****** ****** *)
//
extern
fun fprint_parerr
  (out: FILEref, pe: parerr): void
overload fprint with fprint_parerr
//
(* ****** ****** *)

implement
fprint_parerr
  (out, pe) = let
in
//
case+ pe of
| PARERRrpar (pos) =>
    fprint! (out, "error(parse): ", pos, ": unbalanced right parenthesis")
| PARERRtoken (tok, pos) =>
    fprint! (out, "error(parse): ", pos, ": unrecognized char: ", tok)
| PARERRuneof (pos) =>
    fprint! (out, "error(parse): ", pos, ": tokens are not fully consumed")
//
end // end of [fprint_parerr]

(* ****** ****** *)

typedef
parerrlst = List0 (parerr)

(* ****** ****** *)

extern
fun
the_parerrlst_add (parerr): void
extern
fun
the_parerrlst_get ((*void*)): parerrlst

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
fun parse_gratm (!tokener2): grexp
extern
fun parse_grconj (!tokener2): grexp
extern
fun parse_grdisj (!tokener2): grexp
extern
fun parse_grexp (!tokener2): grexp

(* ****** ****** *)

extern
fun parse_AND_gratm (!tokener2): grexplst
extern
fun parse_OR_grconj (!tokener2): grexplst

(* ****** ****** *)

extern
fun parse_RPAREN (!tokener2): void
extern
fun parseopt_OR (!tokener2): bool
extern
fun parseopt_AND (!tokener2): bool

(* ****** ****** *)

local

(* ****** ****** *)

staload
STRINGS = "libc/SATS/strings.sats"

(* ****** ****** *)

macdef peek = tokener2_peek
macdef next = tokener2_next

(* ****** ****** *)

fun auxerr
  (tok: token): void = let
  val pos = position_get_now ()
in
  the_parerrlst_add (PARERRtoken (tok, pos))
end // end of [auxerr]

in (* in-of-local *)

implement
parse_RPAREN
  (tknr2) = let
//
val tok = peek (tknr2)
//
in
//
case+ tok of
| TOKrpar () => ()
| _(*rest*) => let
    val pos = position_get_now ()
  in
    the_parerrlst_add (PARERRrpar(pos))
  end // end of [_]
//
end // end of [parse_RPAREN]

implement
parseopt_AND
  (tknr2) = let
//
val tok = peek (tknr2)
//
in
//
case+ tok of
| TOKide (sym) =>
    $STRINGS.strcasecmp (sym.name, "AND") = 0
| _(*rest*) => false
//
end // end of [parseopt_AND]

implement
parseopt_OR
  (tknr2) = let
//
val tok = peek (tknr2)
//
in
//
case+ tok of
| TOKide (sym) =>
    $STRINGS.strcasecmp (sym.name, "OR") = 0
| _(*rest*) => false
//
end // end of [parseopt_OR]

(* ****** ****** *)

implement
parse_gratm
  (tknr2) = let
//
val tok = peek (tknr2)
//
in
//
case+ tok of
| TOKide (sym) => let
    val () = next (tknr2)
    val gn = gene_make_symbol (sym) in GRgene (gn)
  end // end of [TOKide]
| TOKlpar () => gx where
  {
    val () = next (tknr2)
    val gx = parse_grexp (tknr2)
    val () = parse_RPAREN (tknr2)
  } (* end of [TOKlpar] *)
| _(*rest*) => let
    val () = next (tknr2)
    val () = auxerr (tok) in GRerror ()
  end // end of [val]
//
end // end of [parse_gratm]

end // end of [local]

(* ****** ****** *)

implement
parse_AND_gratm
  (tknr2) = let
  val ans = parseopt_AND (tknr2)
in
  if ans then let
    val gx0 = parse_gratm (tknr2)
    val gxs = parse_AND_gratm (tknr2)
  in
    list_cons{grexp}(gx0, gxs)
  end else list_nil ()
end // end of [parse_AND_gratm]

(* ****** ****** *)

implement
parse_grconj (tknr2) = let 
  val gx0 = parse_gratm (tknr2)
  val gxs = parse_AND_gratm (tknr2)
in
  GRconj(list_cons{grexp}(gx0, gxs))
end // end of [parse_grconj]

(* ****** ****** *)

implement
parse_OR_grconj
  (tknr2) = let
  val ans = parseopt_OR (tknr2)
in
  if ans then let
    val gx0 = parse_grconj (tknr2)
    val gxs = parse_OR_grconj (tknr2)
  in
    list_cons{grexp}(gx0, gxs)
  end else list_nil ()
end // end of [parse_OR_grconj]

(* ****** ****** *)

implement
parse_grdisj (tknr2) = let 
  val gx0 = parse_grconj (tknr2)
  val gxs = parse_OR_grconj (tknr2)
in
  GRdisj (list_cons{grexp}(gx0, gxs))
end // end of [parse_grdisj]

(* ****** ****** *)

implement
parse_grexp (tknr2) = parse_grdisj (tknr2)

(* ****** ****** *)

(* end of [falcon_parser.dats] *)
