(* ****** ****** *)
//
// HX-2015-02-12: Let's do geometry!
//
(* ****** ****** *)

datasort pnt = // abstract
datasort line = line of (pnt, pnt)
datasort angle = angle of (pnt, pnt, pnt)
datasort triangle = triangle of (pnt, pnt, pnt)

(* ****** ****** *)

absprop CONGline(line, line)
absprop CONGangle(angle, angle)
absprop CONGtriangle(triangle, triangle)

(* ****** ****** *)

stadef CONG = CONGline
stadef CONG = CONGangle
stadef CONG = CONGtriangle

(* ****** ****** *)

extern
praxi
CONGline_refl{x:line}(): CONG(x, x)
extern
praxi
CONGline_symm{x1,x2:line}(CONG(x1, x2)): CONG(x2, x1)
extern
praxi
CONGline_trans{x1,x2,x3:line}(CONG(x1, x2), CONG(x2, x3)): CONG(x1, x3)

(* ****** ****** *)

extern
praxi
CONGangle_refl{x:angle}(): CONG(x, x)
extern
praxi
CONGangle_symm{x1,x2:angle}(CONG(x1, x2)): CONG(x2, x1)
extern
praxi
CONGangle_trans{x1,x2,x3:angle}(CONG(x1, x2), CONG(x2, x3)): CONG(x1, x3)

(* ****** ****** *)

extern
praxi
CONGtriangle_refl{x:triangle}(): CONG(x, x)
extern
praxi
CONGtriangle_symm{x1,x2:triangle}(CONG(x1, x2)): CONG(x2, x1)
extern
praxi
CONGtriangle_trans{x1,x2,x3:triangle}(CONG(x1, x2), CONG(x2, x3)): CONG(x1, x3)

(* ****** ****** *)
//
extern
praxi
CONGline_AB_BA{A,B:pnt}(): CONG(line(A,B), line(B,A))
//
(* ****** ****** *)

absprop ONLINE (p: pnt, l: line)

(* ****** ****** *)
//
extern
praxi
online_AB_BA
  {A,B:pnt}{P:pnt}(ONLINE(P,line(A,B))): ONLINE(P,line(B,A))
//
(* ****** ****** *)
//
extern
praxi
CONGangle_online
  {A,B,C:pnt}{D:pnt}(ONLINE(C,line(B,D))): CONG(angle(A,B,C),angle(A,B,D))
//
(* ****** ****** *)

extern
praxi
lemma_CONGtriangle_line_line_line
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(line(A1,B1), line(A2,B2))
, CONG(line(B1,C1), line(B2,C2))
, CONG(line(C1,A1), line(C2,A2))
) : CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))

(* ****** ****** *)

extern
praxi
lemma_CONGtriangle_line_line_angle
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(line(A1,B1), line(A2,B2))
, CONG(line(A1,C1), line(A2,C2))
, CONG(angle(B1,A1,C1), angle(B2,A2,C2))
) : CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))

(* ****** ****** *)

extern
praxi
lemma_CONGtriangle_line_angle_angle
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(line(B1,C1), line(B2,C2))
, CONG(angle(A1,B1,C1), angle(A2,B2,C2))
, CONG(angle(A1,C1,B1), angle(A2,C2,B2))
) : CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))

(* ****** ****** *)

extern
praxi
lemma_CONGtriangle_AB
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(line(A1,B1), line(A2,B2))
extern
praxi
lemma_CONGtriangle_BC
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(line(B1,C1), line(B2,C2))
extern
praxi
lemma_CONGtriangle_CA
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(line(C1,A1), line(C2,A2))

(* ****** ****** *)

extern
praxi
lemma_CONGtriangle_ABC
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(angle(A1,B1,C1), angle(A2,B2,C2))
extern
praxi
lemma_CONGtriangle_BCA
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(angle(B1,C1,A1), angle(B2,C2,A2))
extern
praxi
lemma_CONGtriangle_CAB
{A1,B1,C1:pnt}
{A2,B2,C2:pnt}
(
  CONG(triangle(A1,B1,C1), triangle(A2,B2,C2))
) : CONG(angle(C1,A1,B1), angle(C2,A2,B2))

(* ****** ****** *)

extern
prfun
IsoscelesAngleq
  {A,B,C:pnt}
(
  CONG(line(A,B), line(A,C))
) : CONG(angle(A,B,C), angle(A,C,B))

(* ****** ****** *)

primplmnt
IsoscelesAngleq
  {A,B,C}
(
  eq_AB_AC
) = let
//
prval
[D:pnt]
(on_D_BC,
 eq_BD_CD) =
__assert () where
{
  extern
  praxi
  __assert
  (
  ): [D:pnt]
     (ONLINE(D, line(B, C)), CONG(line(B,D), line(C,D)))
} (* end of [prval] *)
//
prval on_D_CB = online_AB_BA(on_D_BC)
//
prval
eq_DA_DA = CONGline_refl{line(D,A)}()
//
prval
trieq_ABD_ACD =
  lemma_CONGtriangle_line_line_line(eq_AB_AC, eq_BD_CD, eq_DA_DA)
//
prval eq_ABD_ACD =
  lemma_CONGtriangle_ABC(trieq_ABD_ACD)
//
prval eq_ABD_ABC = CONGangle_online(on_D_BC)
prval eq_ACD_ACB = CONGangle_online(on_D_CB)
//
in
  CONGangle_trans (CONGangle_symm (eq_ABD_ABC), CONGangle_trans(eq_ABD_ACD, eq_ACD_ACB))
end // end of [Isosceles_CONGangle]

(* ****** ****** *)
  
(* end of [IsoscelesAngleq.dats] *)
