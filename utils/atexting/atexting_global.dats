(* ****** ****** *)

staload
FIL = {
//
#include
"share/atspre_define.hats"
//
staload "./atexting.sats"
//
typedef T = fil_t
//
#include"\
{$LIBATSHWXI}\
/globals/HATS/gstacklst.hats"
//
implement
the_filename_get
  ((*void*)) = get_top_exn()
//
implement
the_filename_pop() = pop_exn()
implement
the_filename_push(fil) = push(fil)
//
} (* end of [staload] *)

(* ****** ****** *)

(* end of [atexting_global.dats] *)
