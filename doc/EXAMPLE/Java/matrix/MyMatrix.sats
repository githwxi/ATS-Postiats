(*
** ATS data for use in Java
*)

(* ****** ****** *)

abstype MyMatrix_type = ptr
typedef MyMatrix = MyMatrix_type

(* ****** ****** *)

fun matrix_make_elt
(
  size_t(*nrow*), size_t(*ncol*), int(*elt*)
) : MyMatrix // end of [matrix_make_elt]

(* ****** ****** *)

fun matrix_get_at
  (M: MyMatrix, i: int, j: int): int(*elt*)
fun matrix_set_at
  (M: MyMatrix, i: int, j: int, int(*elt*)): void
//
overload [] with matrix_get_at
overload [] with matrix_set_at
//
(* ****** ****** *)

(* end of [MyMatrix.sats] *)
