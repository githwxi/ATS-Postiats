(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = $UNSAFE

(* ****** ****** *)
//
staload "./../SATS/catsparse.sats"
//
staload "./../SATS/catsparse_syntax.sats"
staload "./../SATS/catsparse_parsing.sats"
//
(* ****** ****** *)

#define NULL the_null_ptr

(* ****** ****** *)

infix ++
overload ++ with location_combine

(* ****** ****** *)

fun
token_null
(
// argumentless
) : token = $UN.cast{token}(NULL)

(* ****** ****** *)

implement
tokbuf_set_ntok_null
  (buf, n0) = let
//
val () =
  tokbuf_set_ntok(buf, n0) in synent_null()
//
end // end of [tokbuf_set_ntok_null]

(* ****** ****** *)

implement
ptoken_fun
(
  buf, bt, err, f, enode
) = let
//
val tok = tokbuf_get_token (buf)
//
(*
val () = println! ("ptoken_fun: tok = ", tok)
*)
//
in
  if f (tok.token_node) then let
    val () = tokbuf_incby1 (buf) in tok
  end else let
    val loc = tok.token_loc
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, enode)
  in
    token_null ()
  end // end of [_]
//
end // end of [ptoken_fun]

(* ****** ****** *)

implement
ptoken_test_fun
  (buf, f) = let
  val tok = tokbuf_get_token (buf)
in
//
if f(tok.token_node)
  then let
    val () = tokbuf_incby1 (buf) in true
  end // end of [then]
  else false // end of [else]
//
end // end of [ptoken_test_fun]

(* ****** ****** *)

implement
ptest_SRPif0
  (buf) = let
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
(*
val () =
println! ("ptest_SRPif0: tok = ", tok)
*)
//
in
//
case+
tok.token_node of
| T_KWORD(SRPif()) =>
    test where
  {
    val () = incby1 ()
    val test = p_LPAREN_test (buf)
    val test =
    (
      if test then p_ZERO_test (buf) else false
    ) : bool // end of [val]
    val test =
    (
      if test then p_RPAREN_test (buf) else false
    ) : bool // end of [val]
    val () = if not(test) then tokbuf_set_ntok (buf, n0)
  } (* end of [SRPif] *)
| _ (*non-SRPif*) => false
//
end // end of [ptest_SRPif0]

(* ****** ****** *)

implement
pskip_SRPif0
  (buf, level) = let
in
//
case+ 0 of
| _ when
    ptest_SRPif0 (buf) =>
  (
    pskip_SRPif0 (buf, level + 1)
  ) (* end of [SRPif0] *)
| _ (*non-SRPif0*) => let
    val tok = tokbuf_get_token (buf)
    val ((*void*)) = tokbuf_incby1 (buf)
(*
    val ((*void*)) =
      println! ("pskip_SRPif0: tok = ", tok)
*)
  in
    case+ tok.token_node of
    | T_EOF () => ()
    | T_KWORD(SRPendif()) =>
        if level >= 2 then pskip_SRPif0 (buf, level-1) else ()
    | _ (* non-SRPendif *) => pskip_SRPif0 (buf, level)
  end // end of [non-SRPif0]
//
end // end of [pskip_SRPif0]

(* ****** ****** *)
//
implement
is_EOF (x) = case+ x of
  | T_EOF () => true | _ => false
//
implement
p_EOF (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_EOF, PARERR_EOF)
//
(* ****** ****** *)
//
implement
is_COMMA (x) = case+ x of
  | T_COMMA () => true | _ => false
//
implement
p_COMMA (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_COMMA, PARERR_COMMA)
//
implement
p_COMMA_test (buf) = ptoken_test_fun (buf, is_COMMA)
//
(* ****** ****** *)
//
implement
is_COLON (x) = case+ x of
  | T_COLON () => true | _ => false
//
implement
p_COLON (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_COLON, PARERR_COLON)
//
implement
p_COLON_test (buf) = ptoken_test_fun (buf, is_COLON)
//
(* ****** ****** *)
//
implement
is_SEMICOLON (x) = case+ x of
  | T_SEMICOLON () => true | _ => false
//
implement
p_SEMICOLON (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_SEMICOLON, PARERR_SEMICOLON)
//
implement
p_SEMICOLON_test (buf) = ptoken_test_fun (buf, is_SEMICOLON)
//
(* ****** ****** *)
//
implement
is_LPAREN (x) = case+ x of
  | T_LPAREN () => true | _ => false
implement
p_LPAREN (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_LPAREN, PARERR_LPAREN)
implement
p_LPAREN_test (buf) = ptoken_test_fun (buf, is_LPAREN)
//
implement
is_RPAREN (x) = case+ x of
  | T_RPAREN () => true | _ => false
implement
p_RPAREN (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_RPAREN, PARERR_RPAREN)
implement
p_RPAREN_test (buf) = ptoken_test_fun (buf, is_RPAREN)
//
(* ****** ****** *)
//
implement
is_LBRACE (x) = case+ x of
  | T_LBRACE () => true | _ => false
implement
p_LBRACE (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_LBRACE, PARERR_LBRACE)
//
(* ****** ****** *)
//
implement
is_RBRACE (x) = case+ x of
  | T_RBRACE () => true | _ => false
implement
p_RBRACE (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_RBRACE, PARERR_RBRACE)
//
(* ****** ****** *)
//
implement
is_INT (x) = case+ x of
  | T_INT _ => true | _ => false
//
implement
p_INT (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_INT, PARERR_INT)
//
(* ****** ****** *)
//
implement
is_INT10 (x) = case+ x of
  | T_INT (10, _) => true | _ => false
//
implement
p_INT10 (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_INT10, PARERR_INT10)
//
(* ****** ****** *)
//
implement
is_ZERO (x) = case+ x of
  | T_INT (_, "0") => true | _ => false
//
implement
p_ZERO (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ZERO, PARERR_ZERO)
//
implement
p_ZERO_test (buf) = ptoken_test_fun (buf, is_ZERO)
//
(* ****** ****** *)
//
implement
is_FLOAT (x) = case+ x of
  | T_FLOAT _ => true | _ => false
//
implement
p_FLOAT (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_FLOAT, PARERR_FLOAT)
//
(* ****** ****** *)
//
implement
is_STRING (x) = case+ x of
  | T_STRING _ => true | _ => false
//
implement
p_STRING (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_STRING, PARERR_STRING)
//
(* ****** ****** *)
//
implement
is_SRPendif (x) = case+ x of
  | T_KWORD(SRPendif()) => true | _ => false
//
implement
p_SRPendif (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_SRPendif, PARERR_SRPendif)
//
(* ****** ****** *)
//
implement
is_ATSextcode_end (x) = case+ x of
  | T_KWORD(ATSextcode_end()) => true | _ => false
implement
p_ATSextcode_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSextcode_end, PARERR_ATSextcode_end)
//
(* ****** ****** *)
//
implement
is_ATSfunbody_end (x) = case+ x of
  | T_KWORD(ATSfunbody_end()) => true | _ => false
implement
p_ATSfunbody_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSfunbody_end, PARERR_ATSfunbody_end)
//
(* ****** ****** *)
//
implement
is_ATScaseof_end (x) = case+ x of
  | T_KWORD(ATScaseof_end()) => true | _ => false
implement
p_ATScaseof_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATScaseof_end, PARERR_ATScaseof_end)
//
(* ****** ****** *)
//
implement
is_ATSbranch_end (x) = case+ x of
  | T_KWORD(ATSbranch_end()) => true | _ => false
implement
p_ATSbranch_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSbranch_end, PARERR_ATSbranch_end)
//
(* ****** ****** *)
//
implement
is_ATStailcal_end (x) = case+ x of
  | T_KWORD(ATStailcal_end()) => true | _ => false
implement
p_ATStailcal_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATStailcal_end, PARERR_ATStailcal_end)
//
(* ****** ****** *)
//
implement
is_ATSINSmove_con1_end (x) = case+ x of
  | T_KWORD(ATSINSmove_con1_end()) => true | _ => false
implement
p_ATSINSmove_con1_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSINSmove_con1_end, PARERR_ATSINSmove_con1_end)
//
implement
is_ATSINSmove_boxrec_end (x) = case+ x of
  | T_KWORD(ATSINSmove_boxrec_end()) => true | _ => false
implement
p_ATSINSmove_boxrec_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSINSmove_boxrec_end, PARERR_ATSINSmove_boxrec_end)
//
implement
is_ATSINSmove_fltrec_end (x) = case+ x of
  | T_KWORD(ATSINSmove_fltrec_end()) => true | _ => false
implement
p_ATSINSmove_fltrec_end (buf, bt, err) =
  ptoken_fun (buf, bt, err, is_ATSINSmove_fltrec_end, PARERR_ATSINSmove_fltrec_end)
//
(* ****** ****** *)

implement
ptest_fun{a}
  (buf, f, ent) = let
  var err: int = 0
  val () = ent := synent_encode (f (buf, 1(*bt*), err))
in
  err = 0
end // end of [ptest_fun]

(* ****** ****** *)
//
// HX: looping if [f] is nullable!
//
implement
pstar_fun{a}
  (buf, bt, f) = let
//
vtypedef res_vt = List0_vt (a)
//
fun
loop
(
  buf: &tokbuf >> _
, res: &res_vt? >> _, err: &int
) : void = let
  val x = f (buf, 1(*bt*), err)
in
//
if
err > 0
then (res := list_vt_nil)
else let
  val () =
  (
    res :=
    list_vt_cons{a}{0}(x, _)
  ) // end of [val]
  val+list_vt_cons(_, res1) = res
  val ((*void*)) = loop (buf, res1, err)
  prval ((*folded*)) = fold@ (res)
in
  // nothing
end // end of [else]
//
end // end of [loop]
//
var res: ptr
var err: int = 0
val () = loop (buf, res, err)
//
in
  res (* properly ordered *)
end // end of [pstar_fun]

(* ****** ****** *)
//
implement
pstar_sep_fun{a}
  (buf, bt, sep, f) = let
//
vtypedef res_vt = List0_vt (a)
//
fun loop (
  buf: &tokbuf
, res: &res_vt? >> _
, err: &int
) : void = let
  val n0 = tokbuf_get_ntok (buf)
in
//
if sep(buf)
  then let
    val x = f (buf, 0(*bt*), err)
  in
    case+ 0 of
    | _ when err > 0 => let
        val () = tokbuf_set_ntok (buf, n0)
        val () = res := list_vt_nil ()
      in
        // nothing
      end
    | _ (*no-error*) => let
        val () =
        res := list_vt_cons{a}{0}(x, _)
        val+list_vt_cons (_, res1) = res
        val ((*void*)) = loop (buf, res1, err)
        prval ((*void*)) = fold@ (res)
      in    
        // nothing
      end
    // end of [case+]
 end // end of [then]
 else (res := list_vt_nil ())
//
end // end of [loop]
//
var res: ptr
var err: int = 0
val () = loop (buf, res, err)
//
in
  res (* properly ordered *)
end // end of [pstar_sep_fun]

(* ****** ****** *)
//
implement
pstar_COMMA_fun{a}
  (buf, bt, f) =
  pstar_sep_fun (buf, bt, p_COMMA_test, f)
//
(* ****** ****** *)

implement
pstar_fun0_sep
  (buf, bt, f, sep) = let
  var err: int = 0
  val x0 = f (buf, 1(*bt*), err)
in
//
case+ 0 of
| _ when err > 0 =>
    list_vt_nil ()
//
| _ (*no-error*) => let
    val xs =
      pstar_sep_fun (buf, 1(*bt*), sep, f)
    // end of [val]
  in
    list_vt_cons (x0, xs)
  end // end of [_]
//
end // end of [pstar_fun0_sep]

(* ****** ****** *)

implement
pstar_fun0_COMMA
  (buf, bt, f) =
  pstar_fun0_sep (buf, bt, f, p_COMMA_test)
// end of [pstar_fun0_COMMA]

(* ****** ****** *)

implement
pif_fun (
  buf, bt, err, f, err0
) = (
//
if err <= err0
  then f (buf, bt, err) else synent_null ((*void*))
//
) (* end of [pif_fun] *)

(* ****** ****** *)

implement
parse_signed
  (buf, bt, err) = let
//
val err0 = err
//
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| T_INT (base, rep) =>
  (
    if base = 10
      then let
        val () = incby1 ()
        val loc = tok.token_loc
      in
        SIGNED (loc, g0string2int(rep))
      end // end of [then]
      else let
        val () = err := err + 1 in synent_null ()
      end // end of [else]
    // end of [if]
  ) (* end of [T_INT] *)
//
| T_MINUS ((*void*)) => let
    val bt = 0
    val () = incby1 ()
    val tok2 = p_INT10 (buf, bt, err)
  in
    if err = err0
      then let
        val loc =
          tok.token_loc ++ tok2.token_loc
        // end of [val]
        val-T_INT(_, rep) = tok2.token_node
      in
        SIGNED (loc, ~g0string2int(rep))
      end // end of [then]
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [T_MINUS]
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end // end of [_]
//
end // end of [parse_signed]

(* ****** ****** *)

implement
parse_i0dex
  (buf, bt, err) = let
//
val tok =
  tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| T_IDENT_alp (x) => let
    val () = incby1 () in i0dex_make_string (loc, x)
  end // end of [T_IDENT_alp]
//
| _ (*non-IDENT_alp*) => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PARERR_i0dex)
  in
    synent_null ()
  end // end of [_]
//
end // end of [parse_i0dex]

(* ****** ****** *)
//
implement
parse_label
  (buf, bt, err) =
  parse_i0dex (buf, bt, err)
//
(* ****** ****** *)

implement
parse_s0exp
  (buf, bt, err) = let
//
var err0 = err
var ent: synent?
//
val loc = let
  val tok = tokbuf_get_token (buf)
in
  tok.token_loc
end // end of [val]
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+ 0 of
//
| _ when
    ptest_fun
    (
      buf, parse_i0dex, ent
    ) => let
    val bt = 0
    val id = synent_decode2{i0de}(ent)
    val opt = parse_s0expargopt (buf, bt, err)
  in
    case+ opt of
    | None () => s0exp_ide (loc, id)
    | Some (s0e) => s0exp_appid (id, s0e)
  end
//
| _ => let
    val () = err := err + 1
    val () = the_parerrlst_add_ifnbt (bt, loc, PARERR_s0exp)
  in
    synent_null ()
  end (* end of [_] *)
//
end // end of [parse_s0exp]

(* ****** ****** *)

implement
parse_s0expseq
  (buf, bt, err) =
  list_vt2t(pstar_fun0_COMMA (buf, bt, parse_s0exp))
// end of [parse_s0expseq]

(* ****** ****** *)

(*
//
s0exparg = '(' s0expseq ')'
//
*)
  
implement
parse_s0exparg
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val s0es = parse_s0expseq (buf, bt, err)
    val ent2 = pif_fun(buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then let
        val loc2 = token_get_loc (ent2)
      in
        s0exp_list (loc ++ loc2, s0es)
      end // end of [then]
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end // end of [_]
//
end // end of [parse_s0exparg]
  
(* ****** ****** *)
  
implement
parse_s0expargopt
  (buf, bt, err) = let
//
val err0 = err
val s0arg = parse_s0exparg (buf, bt, err)
//
in
//
if err0 = err
  then Some(s0arg) else (err := err0; None())
//
end // end of [parse_s0expargopt]
  
(* ****** ****** *)

implement
parse_tyfld
  (buf, bt, err) = let
//
(*
val () = println! ("parse_tyfld")
*)
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| _ when
    ptest_SRPif0 (buf) => let
    val () = incby1 ()
    val () = pskip_SRPif0 (buf, 1(*level*))
  in
    parse_tyfld (buf, bt, err)
  end // end of [#if(0)]
//
| _ (*rest*) => let
    val ent1 = parse_s0exp (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
    val ent3 = pif_fun (buf, bt, err, p_SEMICOLON, err0)
  in
    if err = err0
      then tyfld_make (ent1, ent2) else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end // end of [_]
//
end // end of [parse_tyfld]

(* ****** ****** *)
//
extern
fun parse_tyfldseq : parser (tyfldlst)
//
implement
parse_tyfldseq
  (buf, bt, err) =
  list_vt2t (pstar_fun (buf, bt, parse_tyfld))
//
(* ****** ****** *)

implement
parse_tyrec
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_KWORD
  (
    ATSstruct()
  ) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LBRACE (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, parse_tyfldseq, err0)
    val ent3 = pif_fun (buf, bt, err, p_RBRACE, err0)
  in
    if err = err0
      then tyrec_make (tok, ent2, ent3)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end // end of [_]
//  
end // end of [parse_tyrec]

(* ****** ****** *)

implement
parse_fkind
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
(*
val () = println! ("parse_fkind: tok = ", tok)
*)
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
| T_KWORD
  (
    ATSextern()
  ) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then fkind_extern (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| T_KWORD
  (
    ATSstatic()
  ) => let
    val bt = 0
    val () = incby1 ()
    val ent1 = p_LPAREN (buf, bt, err)
    val ent2 = pif_fun (buf, bt, err, p_RPAREN, err0)
  in
    if err = err0
      then fkind_static (tok, ent2)
      else tokbuf_set_ntok_null (buf, n0)
    // end of [if]
  end
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [parse_fkind]

(* ****** ****** *)

implement
parse_f0arg
  (buf, bt, err) = let
//
(*
val () = println! ("parse_f0arg")
*)
//
val err0 = err
var ent: synent?
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = parse_s0exp (buf, bt, err)
//
in
//
if (
err = err0
) then (
case+ 0 of
//
| _ when ptest_fun
  (
    buf, parse_i0dex, ent
  ) => let
    val ent2 = synent_decode2{i0de}(ent)
  in
    f0arg_some (ent1, ent2)
  end // end of [parse_i0dex]
//
| _ (*none*) => f0arg_none (ent1)
//
) else tokbuf_set_ntok_null (buf, ntok0)
//
end // end of [parse_f0arg]

(* ****** ****** *)

(*
f0marg = '(' f0argseq ')'
*)

implement
parse_f0marg
  (buf, bt, err) = let
//
val err0 = err
val n0 = tokbuf_get_ntok (buf)
val tok = tokbuf_get_token (buf)
val loc = tok.token_loc
//
macdef incby1 () = tokbuf_incby1 (buf)
//
in
//
case+
tok.token_node of
//
| T_LPAREN () => let
    val bt = 0
    val () = incby1 ()
    val ent2 =
      pstar_fun0_COMMA (buf, bt, parse_f0arg)
    val ent3 = p_RPAREN (buf, bt, err) // err = err0
  in
    if err = err0
      then f0marg_make (tok, list_vt2t(ent2), ent3)
      else let
        val () = list_vt_free (ent2) in synent_null ()
      end // end of [else]
    // end of [if]
  end // end of [T_LPAREN]
//
| _ (*error*) => let
    val () = err := err + 1 in synent_null ()
  end (* end of [_] *)
//
end // end of [parse_f0marg]

(* ****** ****** *)

implement
parse_f0head
  (buf, bt, err) = let
//
val err0 = err
val ntok0 = tokbuf_get_ntok (buf)
//
val ent1 = parse_s0exp (buf, bt, err)
val ent2 = pif_fun (buf, bt, err, parse_i0dex, err0)
val ent3 = pif_fun (buf, bt, err, parse_f0marg, err0)
//
in
//
if err = err0
  then f0head_make (ent1, ent2, ent3)
  else tokbuf_set_ntok_null (buf, ntok0)
//
end // end of [parse_f0head]

(* ****** ****** *)

implement
parse_extval
  (buf, bt, err) = let
//
vtypedef res = List0_vt(token)
//
fun loop
(
  buf: &tokbuf, level: intGt(0), res: res
) : res = let
//
val tok = tokbuf_get_token_any (buf)
//
in
case+
tok.token_node of
//
| T_EOF () => res
//
| T_LPAREN () => let
    val () = tokbuf_incby1 (buf)
    val res =
      list_vt_cons (tok, res) in loop (buf, level+1, res)
    // end of [val]
  end // end of [T_LPAREN]
//
| T_RPAREN () => let
    val level1 = level - 1
  in
    if level1 > 0
      then let
        val () = tokbuf_incby1 (buf)
        val res =
          list_vt_cons (tok, res) in loop (buf, level1, res)
        // end of [val]
      end // end of [then]
      else res // end of [else]
    // end of [if]
  end // end of [T_RPAREN]
//
| _ (*rest*) => let
    val () = tokbuf_incby1 (buf)
    val res = list_vt_cons (tok, res) in loop (buf, level, res)
  end // end of [_]
//
end // end of [loop]
//
val res =
  loop (buf, 1, list_vt_nil())
//
in
  list_vt2t(list_vt_reverse(res))
end // end of [parse_extval]

(* ****** ****** *)

implement
parse_extcode
  (buf, bt, err) = let
//
vtypedef res = List0_vt(token)
//
fun loop
(
  buf: &tokbuf >> _, res: res
) : res = let
//
val tok = tokbuf_get_token_any (buf)
//
(*
val () =
println!
  ("parse_extcode: loop: tok = ", tok)
*)
//
in
//
case+
tok.token_node of
//
| T_EOF () => res
//
| T_KWORD (ATSextcode_end()) => res
//
| _ (*rest*) => let
    val () = tokbuf_incby1 (buf)
  in
    loop (buf, list_vt_cons (tok, res))
  end // end of [_]
//
end // end of [loop]
//
val res = loop (buf, list_vt_nil())
//
in
  list_vt2t (list_vt_reverse (res))
end // end of [parse_extcode]

(* ****** ****** *)

implement
parse_closurerize
  (buf, bt, err) = let
//
//
fun loop
(
  buf: &tokbuf >> _
, bt: int, err: &int >> _
) : token = let
//
val tok = tokbuf_get_token (buf)
//
in
//
case+
tok.token_node of
//
| T_KWORD
  (
    ATSclosurerize_end()
  ) =>
    let val () = tokbuf_incby1 (buf) in tok end
  // end of [ATSclosurerize_end]
//
| T_EOF () => let
     val () = err := err + 1
     val () =
     the_parerrlst_add
       (tok.token_loc, PARERR_ATSclosurerize_end)
     // end of [val]
   in
     tok
   end // end of [T_EOF]
//
| _ (*rest*) =>
    let val () = tokbuf_incby1 (buf) in loop (buf, bt, err) end
//
end // end of [loop]
//
in
  loop (buf, bt, err)
end // end of [parse_closurerize]

(* ****** ****** *)

implement
parse_toplevel
  (buf) = let
//
fun loop
(
  buf: &tokbuf >> _, d0cs: List0_vt(d0ecl)
) : List0_vt (d0ecl) = let
//
var ent: synent?
//
in
//
case+ 0 of
//
| _ when
    ptest_fun
    (
      buf, parse_d0ecl, ent
    ) => let
       val () = tokbuf_reset (buf)
       val d0c = synent_decode2{d0ecl}(ent)
     in
       loop (buf, list_vt_cons (d0c, d0cs))
     end // end of [parse_d0ecl]
| _ (*error*) => d0cs
//
end // end of [loop]
//
val d0cs = loop (buf, list_vt_nil)
//
in
  list_vt2t(list_vt_reverse (d0cs))
end // end of [parse_toplevel]

(* ****** ****** *)

implement
parse_from_string
  (inp, f) = let
//
var buf: tokbuf
val () = tokbuf_initize_string (buf, inp)
//
var nerr: int = 0
val res = f (buf, 0(*bt*), nerr)
val _(*EOF*) = p_EOF (buf, 0, nerr) // HX: all tokens need to consumed
//
val () = tokbuf_uninitize (buf)
//
in
  if nerr = 0 then Some_vt (res) else None_vt ()
end // end of [parser_from_string]

(* ****** ****** *)

implement
parse_from_tokbuf
  (buf) = let
//
val () = the_lexerrlst_clear ()
val () = the_parerrlst_clear ()
//
val d0cs = parse_toplevel (buf)
//
// HX: see if there are tokens 
//
var err: int = 0
val _(*EOF*) = p_EOF (buf, 0(*bt*), err)
//
val nerr1 = the_lexerrlst_print_free ()
val nerr2 = the_parerrlst_print_free ()
//
val ((*void*)) = if nerr1 + nerr2 > 0 then abort ()
//
in
  d0cs
end // end of [parse_from_tokbuf]

(* ****** ****** *)

implement
parse_from_fileref
  (inp) = let
//
var buf: tokbuf
val () =
  tokbuf_initize_fileref (buf, inp)
//
val d0cs = parse_from_tokbuf (buf)
//
val () = tokbuf_uninitize (buf)
//
in
  d0cs
end // end of [parse_from_fileref]

(* ****** ****** *)

(* end of [catsparse_parsing.dats] *)
