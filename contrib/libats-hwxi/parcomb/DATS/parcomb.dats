(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(*                              Hongwei Xi                             *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS - Unleashing the Potential of Types!
**
** Copyright (C) 2002-2008 Hongwei Xi, Boston University
**
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
** Free Software Foundation; either version 2.1, or (at your option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)
//
// Author: Hongwei Xi
// Authoremail: hwxiATcsDOTbuDOTedu
// Time: December, 2008
//
(* ****** ****** *)

staload "./../SATS/parcomb.sats"

(* ****** ****** *)

#define Okay Some_vt
#define Fail None_vt

(* ****** ****** *)

implement{t}
stream_get_item
  (tks) = let
in
  case+ !tks of
  | stream_cons
      (tk1, tks1) =>
    (
      tks := tks1; Some_vt (tk1)
    )
  | stream_nil () => None_vt(*void*)
end // end of [stream_get_item]
////
(* ****** ****** *)

assume parser_t = // no [ref] effect!
  lam (a:t@ype, t:t@ype) => (&stream t, &int, &int) -<cloref,!laz> Option_vt (a)
// end of [parser_t]

(* ****** ****** *)

implement{a}{t}
apply_parser (p, tks, ncur, nmax) = p (tks, ncur, nmax)

(* ****** ****** *)

implement
lzeta (p) = lam (tks, ncur, nmax) => !p (tks, ncur, nmax)

(* ****** ****** *)

implement{a}{t}
return_parser (x) = lam (tks, ncur, nmax) => Okay (x)

(* ****** ****** *)

implement{a}{t}
alt_parser_parser
  (p1, p2) = lam (tks, ncur, nmax) => let
  val tks0 = tks
  val ncur0 = ncur
  val r1 = p1 (tks, ncur, nmax)
in
  case+ r1 of
  | Okay _ => (fold@ r1; r1) | ~Fail _ => let
      val () = tks := tks0 and () = ncur := ncur0
    in
      p2 (tks, ncur, nmax)
    end (* end of [Fail] *)
end // end of [alt_parser_parser]

(* ****** ****** *)

implement{a1,a2}{t}
seq_parser_parser
  (p1, p2) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
      | ~Okay v2 => Okay @(v1, v2) | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq_parser_parser]

(* ****** ****** *)

implement{a,b}{t}
seq1wth_parser_fun
  (p, f) = lam (tks, ncur, nmax) => let
  val r = p (tks, ncur, nmax) in case+ r of
  | ~Okay v => Okay (f v) | Fail _ => (fold@ r; r)
end // end of [seq1wth_parser_fun]

implement{a,b}{t}
seq1wth_parser_cloref
  (p, f) = lam (tks, ncur, nmax) => let
  val r = p (tks, ncur, nmax) in case+ r of
  | ~Okay v => Okay (f v) | Fail _ => (fold@ r; r)
end // end of [seq1wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,b}{t}
seq2wth_parser_fun
  (p1, p2, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => Okay (f (v1, v2)) | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq2wth_parser_fun]

implement{a1,a2,b}{t}
seq2wth_parser_cloref
  (p1, p2, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => Okay (f (v1, v2)) | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq2wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,b}{t}
seq3wth_parser_fun
  (p1, p2, p3, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
      | ~Okay v2 => let
          val r3 = p3 (tks, ncur, nmax) in case+ r3 of
          | ~Okay v3 => Okay (f (v1, v2, v3)) | Fail _ => (fold@ r3; r3)
        end // end of [Okay]
      | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq3wth_parser_fun]

implement{a1,a2,a3,b}{t}
seq3wth_parser_cloref
  (p1, p2, p3, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
      | ~Okay v2 => let
          val r3 = p3 (tks, ncur, nmax) in case+ r3 of
          | ~Okay v3 => Okay (f (v1, v2, v3)) | Fail _ => (fold@ r3; r3)
        end // end of [Okay]
      | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq3wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,a4,b}{t}
seq4wth_parser_fun
  (p1, p2, p3, p4, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => Okay (f (v1, v2, v3, v4)) | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq4wth_parser_fun]

implement{a1,a2,a3,a4,b}{t}
seq4wth_parser_cloref
  (p1, p2, p3, p4, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => Okay (f (v1, v2, v3, v4)) | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq4wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,a4,a5,b}{t}
seq5wth_parser_fun
  (p1, p2, p3, p4, p5, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => Okay (f (v1, v2, v3, v4, v5)) | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq5wth_parser_fun]

implement{a1,a2,a3,a4,a5,b}{t}
seq5wth_parser_cloref
  (p1, p2, p3, p4, p5, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => Okay (f (v1, v2, v3, v4, v5)) | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq5wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,a4,a5,a6,b}{t}
seq6wth_parser_fun
  (p1, p2, p3, p4, p5, p6, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => Okay (f (v1, v2, v3, v4, v5, v6)) | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq6wth_parser_fun]

implement{a1,a2,a3,a4,a5,a6,b}{t}
seq6wth_parser_cloref
  (p1, p2, p3, p4, p5, p6, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => Okay (f (v1, v2, v3, v4, v5, v6)) | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq6wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,a4,a5,a6,a7,b}{t}
seq7wth_parser_fun
  (p1, p2, p3, p4, p5, p6, p7, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => let val r7 = p7 (tks, ncur, nmax) in case+ r7 of
               | ~Okay v7 => Okay (f (v1, v2, v3, v4, v5, v6, v7)) | Fail _ => (fold@ r7; r7)
               end // end of [Okay]
            | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq7wth_parser_fun]

implement{a1,a2,a3,a4,a5,a6,a7,b}{t}
seq7wth_parser_cloref
  (p1, p2, p3, p4, p5, p6, p7, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => let val r7 = p7 (tks, ncur, nmax) in case+ r7 of
               | ~Okay v7 => Okay (f (v1, v2, v3, v4, v5, v6, v7)) | Fail _ => (fold@ r7; r7)
               end // end of [Okay]
            | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq7wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2,a3,a4,a5,a6,a7,a8,b}{t}
seq8wth_parser_fun
  (p1, p2, p3, p4, p5, p6, p7, p8, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => let val r7 = p7 (tks, ncur, nmax) in case+ r7 of
               | ~Okay v7 => let val r8 = p8 (tks, ncur, nmax) in case+ r8 of
                 | ~Okay v8 => Okay (f (v1, v2, v3, v4, v5, v6, v7, v8)) | Fail _ => (fold@ r8; r8)
                 end // end of [Okay]
               | Fail _ => (fold@ r7; r7)
               end // end of [Okay]
            | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq8wth_parser_fun]

implement{a1,a2,a3,a4,a5,a6,a7,a8,b}{t}
seq8wth_parser_cloref
  (p1, p2, p3, p4, p5, p6, p7, p8, f) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay v1 => let val r2 = p2 (tks, ncur, nmax) in case+ r2 of
    | ~Okay v2 => let val r3 = p3 (tks, ncur, nmax) in case+ r3 of
      | ~Okay v3 => let val r4 = p4 (tks, ncur, nmax) in case+ r4 of
        | ~Okay v4 => let val r5 = p5 (tks, ncur, nmax) in case+ r5 of
          | ~Okay v5 => let val r6 = p6 (tks, ncur, nmax) in case+ r6 of
            | ~Okay v6 => let val r7 = p7 (tks, ncur, nmax) in case+ r7 of
               | ~Okay v7 => let val r8 = p8 (tks, ncur, nmax) in case+ r8 of
                 | ~Okay v8 => Okay (f (v1, v2, v3, v4, v5, v6, v7, v8)) | Fail _ => (fold@ r8; r8)
                 end // end of [Okay]
               | Fail _ => (fold@ r7; r7)
               end // end of [Okay]
            | Fail _ => (fold@ r6; r6)
            end // end of [Okay]
          | Fail _ => (fold@ r5; r5)
          end // end of [Okay]
        | Fail _ => (fold@ r4; r4)
        end // end of [Okay]
      | Fail _ => (fold@ r3; r3)
      end // end of [Okay]
    | Fail _ => (fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [seq8wth_parser_cloref]

(* ****** ****** *)

implement{a1,a2}{t}
proj1_parser_parser
  (p1, p2) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax)
in
  case+ r1 of
  | Okay _(*v1*) => let 
      val r2 = p2 (tks, ncur, nmax) in case+ r2 of
      | ~Okay _(*v2*) => (fold@ r1; r1)
      | Fail _ => (free@ {a1} r1; fold@ r2; r2)
    end // end of [Okay]
  | Fail _ => (fold@ r1; r1)
end // end of [proj1_parser_parser]

implement{a1,a2}{t}
proj2_parser_parser
  (p1, p2) = lam (tks, ncur, nmax) => let
  val r1 = p1 (tks, ncur, nmax) in case+ r1 of
  | ~Okay _(*v1*) => p2 (tks, ncur, nmax) | Fail _ => (fold@ r1; r1)
end // end of [proj2_parser_parser]

(* ****** ****** *)

implement{a}{t}
sat_parser_fun
  (p, f) = lam (tks, ncur, nmax) => let
  val tks0 = tks and ncur0 = ncur
  val r = p (tks, ncur, nmax) in case+ r of
  | Okay v => begin
      if f v then (fold@ r; r) else begin
        tks := tks0; ncur := ncur0; free@ {a} (r); Fail ()
      end // end of [if]
    end (* end of [Okay] *)
  | Fail _ => (fold@ r; r)
end // end of [sat_parser_fun]

implement{a}{t}
sat_parser_cloref
  (p, f) = lam (tks, ncur, nmax) => let
  val tks0 = tks and ncur0 = ncur
  val r = p (tks, ncur, nmax) in case+ r of
  | Okay v => begin
      if f v then (fold@ r; r) else begin
        tks := tks0; ncur := ncur0; free@ {a} (r); Fail ()
      end // end of [if]
    end (* end of [Okay] *)
  | Fail _ => (fold@ r; r)
end // end of [sat_parser_cloref]

(* ****** ****** *)

implement{a}
any_parser () = lam (tks, ncur, nmax) => let
  val ans = stream_get_item<a> tks in case+ ans of
  | ~Some_vt v => Okay v where {
      val () = ncur := ncur + 1
      val () = if ncur > nmax then nmax := ncur
    } // end of [Some_vt]
  | ~None_vt () => Fail ()
end // end of [any_parser]

implement{a}
anyopt_parser () = lam (tks, ncur, nmax) => let
  val ans = stream_get_item<a> tks in case+ ans of
  | ~Some_vt v => Okay (Some v) where {
      val () = ncur := ncur + 1
      val () = if ncur > nmax then nmax := ncur
    } // end of [Some]
  | ~None_vt () => Okay (None ())
end // end of [anyopt_parser]

(* ****** ****** *)

implement{}
fail_parser () = lam (tks, ncur, nmax) => Fail ()

(* ****** ****** *)
//
// HX: it is difficult to know where the failure occurs!
//
implement{a}{t}
neg_parser (p) = lam (tks, ncur, nmax) => let
  val tks0 = tks and ncur0 = ncur
  val r = p (tks, ncur, nmax)
  val () = tks := tks0 and () = ncur := ncur0 in
  case+ r of ~Okay _ => Fail () | ~Fail _ => Okay (unit)
end // end of [neg_parser]

(* ****** ****** *)

implement{a}{t}
optional_parser (p) = lam (tks, ncur, nmax) => let
  val tks0 = tks and ncur0 = ncur; val r = p (tks, ncur, nmax)
in
  case+ r of
  | ~Okay v => Okay (Some v)
  | ~Fail _ => begin
      tks := tks0; ncur := ncur0; Okay (None ()) // no token is consumed
    end // end of [Fail]
end // end of [optional_parser]

(* ****** ****** *)

implement{a}{t}
repeat0_parser
  (p) = lam (tks, ncur, nmax) => let
  typedef T = List a
  fun loop (
    tks: &stream t, ncur: &int, nmax: &int, p: parser_t (a, t), res: &T? >> T
  ) :<!laz> void = let
    val tks0 = tks and ncur0 = ncur; val r = p (tks, ncur, nmax)
  in
    case+ r of
    | ~Okay v => let
        val () = res := list_cons {a} {0} (v, ?)
        val list_cons (_, !p_res_nxt) = res
        val () = loop (tks, ncur, nmax, p, !p_res_nxt)
      in
        fold@ res
      end // end of [Okay]
    | ~Fail _ => begin
        tks := tks0; ncur := ncur0; res:= list_nil ()
      end // end of [Fail]
  end // end of [loop]
  var res: T // uninitialized
  val () = loop (tks, ncur, nmax, p, res)
in
  Okay (res) // this parser never fails
end // end of [repeat0_parser]

(* ****** ****** *)

implement{a}{t}
repeat1_parser
  (p) = lam (tks, ncur, nmax) => let
  val r = p (tks, ncur, nmax) in case+ r of
  | ~Okay v => let
      val- ~Okay (vs) = repeat0_parser (p) (tks, ncur, nmax)
    in
      Okay (list_cons (v, vs))
    end // end of [Okay]
  | Fail _ => (fold@ r; r)
end // end of [repeat1_parser]

(* ****** ****** *)

implement{a,b}{t}
repeat0_sep_parser
  (p, sep) = lam (tks, ncur, nmax) => let
  val tks0 = tks and ncur0 = ncur
  val r = repeat1_sep_parser<a,b> (p, sep) (tks, ncur, nmax) in
  case+ r of
  | Okay _ => (fold@ r; r) | ~Fail _ => let
      val () = tks := tks0 and () = ncur := ncur0 in Okay (list_nil)
    end // end of [Fail]
end // end of [repeat0_sep_parser]

implement{a,b}{t}
repeat1_sep_parser
  (p, sep) = lam (tks, ncur, nmax) => let
  val r = p (tks, ncur, nmax) in case+ r of
  | ~Okay v0 => let
      var res: List a // uninitialized
      val () = loop (tks, ncur, nmax, res) where {
        fun loop (
            tks: &stream t, ncur: &int, nmax: &int
          , res: &(List a?) >> List a
          ) :<cloref,!laz> void = let
          val tks0 = tks and ncur0 = ncur in
          case+ sep (tks, ncur, nmax) of
          | ~Okay v_sep => let
              val r = p (tks, ncur, nmax) in case+ r of
              | ~Okay v => let
                  val () = res := list_cons {a} {0} (v, ?)
                  val list_cons (_, !p_res_next) = res
                  val () = loop (tks, ncur, nmax, !p_res_next)
                in
                  fold@ res
                end // end of [Okay]
              | ~Fail _ => begin
                  tks := tks0; ncur := ncur0; res := list_nil ()
                end // end of [Fail]
            end // end of [Okay]
          | ~Fail _ => begin
              tks := tks0; ncur := ncur0; res := list_nil ()
            end // end of [Fail]
        end // end of [loop]
      } // end of [val]
    in
      Okay (list_cons (v0, res))
    end // end of [Okay]
  | Fail _ => (fold@ r; r)
end // end of [repeat1_sep_parser]

(* ****** ****** *)

implement{a}{t}
discard_one_parser
  (p) = lam (tks, ncur, nmax) => let
  val r = p (tks, ncur, nmax) in case+ r of
  | ~Okay v => Okay unit | Fail _ => (fold@ r; r)
end // end of [discard_parser]

implement{a}{t}
discard_many_parser
  (p) = lam (tks, ncur, nmax) => let
  fun loop (
    tks: &stream t, ncur: &int, nmax: &int, p: parser_t (a, t)
  ) :<!laz> void = let
    val tks0 = tks and ncur0 = ncur val r = p (tks, ncur, nmax) in
    case+ r of
    | ~Okay v => loop (tks, ncur, nmax, p)
    | ~Fail _ => (tks := tks0; ncur := ncur0)
  end // end of [loop]
  val () = loop (tks, ncur, nmax, p)
in
  Okay (unit)
end // end of [discard_many_parser]

(* ****** ****** *)

(* end of [parcomb.dats] *)
