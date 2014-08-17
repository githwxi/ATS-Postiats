(*
** Copyright (C) 2013 Hongwei Xi, ATS Trustful Software, Inc.
**
** Permission is hereby granted, free of charge, to any person
** obtaining a copy of this software and associated documentation
** files (the "Software"), to deal in the Software without
** restriction, including without limitation the rights to use,
** copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the
** Software is furnished to do so, subject to the following
** conditions:
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
** OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
** NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
** HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
** FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
** OTHER DEALINGS IN THE SOFTWARE.
*)

(* ****** ****** *)

staload "./calculator.sats"

(* ****** ****** *)

(*

A grammar for aexp:

expr   ::=   term kexpr
kexpr  ::=   ('+' | '-') term kexpr | (*empty*)

term   ::=   factor kterm
kterm  ::=   ('*' | '/') factor kterm | (*empty*)

factor ::=   INT | '(' expr ')'

*)

(* ****** ****** *)

exception IllegalTokenExn of token

(* ****** ****** *)

typedef
faexp = (aexp) -<cloref1> aexp

extern fun p_expr (ts: tstream): aexp
extern fun p_kexpr (ts: tstream): faexp

extern fun p_term (ts: tstream): aexp
extern fun p_kterm (ts: tstream): faexp

extern fun p_factor (ts: tstream): aexp

extern fun p_TOKlpar (ts: tstream): void
extern fun p_TOKrpar (ts: tstream): void

extern fun p_TOKeof (ts: tstream): void

(* ****** ****** *)

(*
expr ::= term exprk
*)
implement
p_expr (ts) = let
  val ae1 = p_term (ts)
  val fae2 = p_kexpr (ts)
in
  fae2 (ae1)
end // end of [p_expr]

(* ****** ****** *)

(*
kexpr ::= ('+' | '-') term kexpr | (*empty*)
*)
implement
p_kexpr (ts) = let
//
val t0 = tstream_get (ts)
//
in
//
case+ 0 of
| _ when
    token_is_add (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_term (ts)
    val fae3 = p_kexpr (ts)
  in
    lam (ae) => fae3 (AEadd (ae, ae2))
  end
| _ when
    token_is_sub (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_term (ts)
    val fae3 = p_kexpr (ts)
  in
    lam (ae) => fae3 (AEsub (ae, ae2))
  end
| _ => lam (ae) => ae
//
end // end of [p_kexpr]

(* ****** ****** *)

implement
p_term (ts) = let
  val ae1 = p_factor (ts)
  val fae2 = p_kterm (ts)
in
  fae2 (ae1)
end // end of [p_term]
      
(* ****** ****** *)
      
implement
p_kterm (ts) = let
  val t0 = tstream_get (ts)
in
//
case+ 0 of
| _ when
    token_is_mul (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_factor (ts)
    val fae3 = p_kterm (ts)
  in
    lam (ae) => fae3 (AEmul (ae, ae2))
  end
| _ when
    token_is_div (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_factor (ts)
    val fae3 = p_kterm (ts)
  in
    lam (ae) => fae3 (AEdiv (ae, ae2))
  end
| _ => lam (ae) => ae
//
end // end of [p_kterm]

(* ****** ****** *)

implement
p_factor (ts) = let
  val t0 = tstream_get (ts)
in
//
case+ t0 of
| TOKint (i) => let
    val () = tstream_inc (ts)
  in
    AEint (i)
  end // end of [TOKint]
| TOKlpar () => let
    val () = tstream_inc (ts)
    val fae2 = p_expr (ts)
    val () = p_TOKrpar (ts)
  in
    fae2
  end // end of [TOKlpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_factor]
                                  
(* ****** ****** *)

implement
p_TOKeof (ts) = let
  val t0 = tstream_get (ts)
in
//
case+ t0 of
| TOKeof () => let
    val () = tstream_inc (ts)
  in
    // nothing
  end // end of [TOKrpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_TOKeof]
              
(* ****** ****** *)
              
implement
p_TOKlpar (ts) = let
  val t0 = tstream_get (ts)
in
//
case+ t0 of
| TOKlpar () => let
    val () = tstream_inc (ts)
  in
    // nothing
  end // end of [TOKlpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_TOKlpar]

implement
p_TOKrpar (ts) = let
  val t0 = tstream_get (ts)
in
//
case+ t0 of
| TOKrpar () => let
    val () = tstream_inc (ts)
  in
    // nothing
  end // end of [TOKrpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_TOKrpar]

(* ****** ****** *)

implement
aexp_parse_string
  (inp) = let
in
//
try let
  val ts =
    tstream_make_string (inp)
  val ae = p_expr (ts)
  val () = p_TOKeof (ts)
in
  Some_vt{aexp}(ae)
end with
  | ~IllegalTokenExn _ => None_vt{aexp}()
//
end // end of [aexp_parse_string]
                
(* ****** ****** *)

(* end of [calculator_parsing.dats] *)
