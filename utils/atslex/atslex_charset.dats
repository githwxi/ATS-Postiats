(*
** atslex: lexer for ATS
*)

(* ****** ****** *)

staload "./atslex.sats"

(* ****** ****** *)

#define UCHAR_MAX 0xFF

(* ****** ****** *)

datatype charset =
  | CSnil of ((*void*))
  | CScons of (uchar, uchar, charset) // inclusive
// end of [charset]

(* ****** ****** *)

assume charset_type = charset

(* ****** ****** *)

local

fun
fprint_range
(
  out: FILEref
, c1: uchar, c2: uchar
) : void = let
//
fun fpc
(
  out: FILEref, c: uchar
) : void = let
//
val i = uchar2int0 (c)
//
in
  if isprint (i)
    then $extfcall (void, "fprintf", out, "'c'", c)
    else $extfcall (void, "fprintf", out, "'0x%x'", i)
  // end of [if]
end // end of [fpc]
//
in
//
if c1 < c2
  then let
    val () = fpc (out, c1)
    val () = fprint (out, '-')
    val () = fpc (out, c2)
  in
    // nothing
  end // end of [then]
  else let
    val () = fpc (out, c1)
  in
    // nothing
  end // end of [else]
// end of [if]
//
end // end of [fprint_range]

in (* in of [local] *)

implement
fprint_charset
  (out, cs0) = let
in
//
case+ cs0 of
| CSnil () => fprint (out, "[]")
| CScons (c1, c2, cs) =>
  {
    val () = fprint (out, "[ ")
    val () = fprint_range (out, c1, c2)
    val () = fprint (out, " ]")
  }
//
end // end of [fprint_charset]

end // end of [local]

(* ****** ****** *)

implement
print_charset (cs) = fprint_charset (stdout_ref, cs)
implement
prerr_charset (cs) = fprint_charset (stderr_ref, cs)

(* ****** ****** *)

#define i2uc(i) int2uchar0(i)
#define uc2i(c) uchar2int0(c)

(* ****** ****** *)

implement
charset_nil = CSnil ()
implement
charset_all =
CScons (i2uc(0), i2uc(UCHAR_MAX), CSnil)

(* ****** ****** *)

implement
charset_sing (c) = CScons (c, c, CSnil())

implement
charset_interval
  (c1, c2) =
(
  if c1 <= c2
    then CScons (c1, c2, CSnil) else CScons (c2, c1, CSnil)
  // end of [if]
) (* end of [charset_interval] *)

(* ****** ****** *)

implement
charset_is_member
  (cs, c0) = let
//
fun loop
(
  cs: charset, c0: uchar
) : bool = let
in
//
case+ cs of
| CSnil ((*void*)) => false
| CScons (c1, c2, cs) => (
    if c1 <= c0 then
      (if c0 <= c2 then true else loop (cs, c0))
    else loop (cs, c0)
  ) (* end of [chars_cons] *)
//
end // end of [loop]
//
in
  loop (cs, c0)
end // end of [charset_is_member]

(* ****** ****** *)

implement
charset_comp (cs) = charset_diff (charset_all, cs)

(* ****** ****** *)

implement
charset_union
  (cs10, cs20) = let
//
fun loop
(
  cs10: charset, cs20: charset
) : charset = let
in
//
case+ (cs10, cs20) of
| (CSnil (), _) => cs20
| (_, CSnil ()) => cs10
| (CScons (c11, c12, cs11),
   CScons (c21, c22, cs21)) =>
  (
    if c21 < c11
    then loop (cs20, cs10)
    else (
      if uc2i(c12)+1 < uc2i(c21)
      then CScons (c11, c12, loop (cs11, cs20))
      else (
        if c12 <= c22
        then loop (CScons (c11, c22, cs20), cs11)
        else loop (cs10, cs21)
      ) // end of [if]
    ) // end of [if]
  ) (* end of [CScons _, CScons _] *)
//
end // end of [loop]
//
in
  loop (cs10, cs20)
end // end of [charset_union]

(* ****** ****** *)

(* end of [atslex_charset.dats] *)
