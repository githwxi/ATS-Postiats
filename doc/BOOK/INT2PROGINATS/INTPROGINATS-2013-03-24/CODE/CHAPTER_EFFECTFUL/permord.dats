(*
** Copyright (C) 2011 Hongwei Xi, Boston University
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
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
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

(*
** Example: Ordering Permutations
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: January, 2011
*)

(* ****** ****** *)

staload _(*anon*) = "prelude/DATS/array.dats"
staload _(*anon*) = "prelude/DATS/array0.dats"

(* ****** ****** *)

fun print_intarray
  (A: array0 (int)): void = let
  val asz = array0_size (A)
  val asz = int_of_size (asz)
  fun loop (i: int, sep: string):<cloref1> void =
    if i < asz then
      (if i > 0 then print sep; print A[i]; loop (i+1, sep))
    // end of [if]
in
  loop (0, ", ")
end // end of [print_intarray]

(* ****** ****** *)

fun lrotate (
  A: array0 int, i: int, j: int
) : void = let
  fun lshift (
    A: array0 int, i: int, j: int
  ) : void =
  if i < j then (A[i] := A[i+1]; lshift (A, i+1, j))
in
  if i < j then let
    val tmp = A[i] in lshift (A, i, j); A[j] := tmp
  end // end of [if]
end // end of [lrotate]

fun rrotate (
  A: array0 int, i: int, j: int
) : void = let
  fun rshift (
    A: array0 int, i: int, j: int
  ) : void =
  if i < j then (A[j] := A[j-1]; rshift (A, i, j-1))
in
  if i < j then let
    val tmp = A[j] in rshift (A, i, j); A[i] := tmp
  end // end of [if]
end // end of [rrotate]

(* ****** ****** *)

fun permute
  (n: int): void = let
//
  val asz = size_of_int (n)
//
  val A = array0_make_elt<int> (asz, 0)
//
  val () = init (0) where {
    fun init (i: int):<cloref1> void =
      if i < n then (A[i] := i+1; init (i+1))
  } // end of [val]
//
  fun aux (
      i: int
    ) :<cloref1> void =
    if i <= n then aux2 (i, i) else (
      print_intarray (A); print_newline ()
    ) // end of [if]
  and aux2 (
      i: int, j: int
    ) :<cloref1> void =
    if j <= n then let
      val () = (
        rrotate (A, i-1, j-1); aux (i+1); lrotate (A, i-1, j-1)
      ) // end of [val]
    in
      aux2 (i, j+1)
    end // end of [if]
in
  aux (1)
end // end of [permute]

(* ****** ****** *)

implement
main () = let
  val () = permute (6)
in
  // nothing
end // end of [main]

(* ****** ****** *)

(* end of [permord.dats] *)
