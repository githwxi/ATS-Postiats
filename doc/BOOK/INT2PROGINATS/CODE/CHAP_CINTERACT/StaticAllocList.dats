(*
** Some code used in the book INT2PROGINATS
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
vtypedef
list_node = list_cons_pstruct(int,ptr)
extern vtypedef "list_node" = list_node
typedef list_node_ = $extype"list_node_"
//
(* ****** ****** *)

local

#define N 10

(*
** static allocation
*)
var nodes = @[list_node_][N]()

fun loop
(
  p: ptr, i: int
) : void = let
in
//
if i < N then let
  val res =
  $UN.castvwtp0{list_node}(p)
  val+list_cons (x, xs) = res
  val (
  ) = x := i*i
  val p = ptr_succ<list_node_> (p)
  val i = i + 1
  val () = (
    if i < N then xs := p else xs := the_null_ptr
  ) : void // end of [val]
  val _(*ptr*) = $UN.castvwtp0{ptr}((view@x, view@xs | res))
in
  loop (p, i)
end else ((*void*)) // end of [if]
//
end // end of [loop]

in (* in of [local] *)

val () = loop (addr@nodes, 0)
val xs_static = $UN.castvwtp0{list(int,N)}((view@nodes|addr@nodes))
val () = println! ("xs_static = ", xs_static) // 0, 1, 4, 9, 16, ...

end // end of [local]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [StaticAllocList.dats] *)
