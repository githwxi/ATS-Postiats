(*
** source: glib/gtypes.h
*)

(* ****** ****** *)

abst@ype gint = $extype"gint"
abst@ype guint = $extype"guint"
abst@ype gboolean = $extype"gboolean"
abst@ype gchar = $extype"gchar"
abst@ype guchar = $extype"guchar"

(* ****** ****** *)

abstype gstring = ptr
abstype gstropt = ptr
absvtype gstrptr (l:addr) = ptr (l)

(* ****** ****** *)

abstype gpointer = ptr

(* ****** ****** *)

(* end of [gtypes.sats] *)
