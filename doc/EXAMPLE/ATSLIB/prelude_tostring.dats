(*
** for testing [prelude/tostring]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

val () = assertloc("1024" = tostring_val<int>(32*32))

(* ****** ****** *)

val () = assertloc("1024" = tostring_val<uint>(32u*32u))

(* ****** ****** *)

val () = assertloc("true" = tostring_val<bool>(true))
val () = assertloc("false" = tostring_val<bool>(false))

(* ****** ****** *)

local

implement
tostrptr_list$beg<> () = "["
implement
tostrptr_list$end<> () = "]"
implement
tostrptr_list$sep<> () = ","

in (* in-of-local *)

val xs = $list{int}(0,1,2,3,4,5,6,7,8,9)
val () = println! ("xs = ", tostring_val<List(int)>(xs))

end // end of [local]

(* ****** ****** *)

local

implement
tostrptr_array$beg<> () = "["
implement
tostrptr_array$end<> () = "]"
implement
tostrptr_array$sep<> () = ";"

in (* in-of-local *)
//
var A0 = @[int](0,1,2,3,4,5,6,7,8,9)
val rep = tostrptr_array(A0, i2sz(10))
val ((*void*)) = println! ("A0 = ", rep)
val ((*freed*)) = strptr_free (rep)
//
end // end of [local]

(* ****** ****** *)

val rep = tostrptr_double(3.1416)
val ((*void*)) = println! ("Pi = ", rep)
val ((*freed*)) = strptr_free (rep)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [prelude_tostring.dats] *)
