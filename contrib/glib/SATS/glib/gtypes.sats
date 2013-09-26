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
vtypedef gstrptr0 = [l:agez] gstrptr (l)
vtypedef gstrptr1 = [l:addr | l > null] gstrptr (l)

(* ****** ****** *)

abstype gpointer = ptr

(* ****** ****** *)

abst@ype gint8 = $extype"gint8"
abst@ype gint16 = $extype"gint16"
abst@ype gint32 = $extype"gint32"
abst@ype gint64 = $extype"gint64"

(* ****** ****** *)

abst@ype guint8 = $extype"guint8"
abst@ype guint16 = $extype"guint16"
abst@ype guint32 = $extype"guint32"
abst@ype guint64 = $extype"guint64"

(* ****** ****** *)

(* end of [gtypes.sats] *)
