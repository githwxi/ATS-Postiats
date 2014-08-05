(* ****** ****** *)
//
// HX-2014-08-04
//
// Pattern-matching
// does not handle dependent char type
//
(* ****** ****** *)
//
staload
UNSAFE =
"prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

fun
escape
{c:int8} (
  c : char c
) : [rc:int8 | rc != 0] @(bool, char rc) =
if c = '\n'
then @(true, 'n')
else if c = '\0'
then @(true, '0')
else @(false, c)

(* ****** ****** *)

fun
escape{c:int8}
(
  c : char c
) : [rc:int8 | rc != 0] @(bool, char rc) =
  case c of
  | '\n' => @(true, 'n')
  (* more cases snipped *)
  | '\0' => @(true, '0')
  | _    => let val () = assertloc (c != '\0') in @(false, c) end

(* ****** ****** *)

fun
escape{c:int8}
(
  c : char c
) : [rc:int8 | rc != 0] @(bool, char rc) =
  case c of
  | '\n' => @(true, 'n')
  (* more cases snipped *)
  | '\0' => @(true, '0')
  | _    => let val c = $UNSAFE.cast{charNZ}(c) in @(false, c) end

(* ****** ****** *)

implement main () = 0

(* ****** ****** *)

(* end of [qa-list-312.dats] *)
