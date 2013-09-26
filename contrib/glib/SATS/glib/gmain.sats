(*
** source: glib/gmain.h
*)

(* ****** ****** *)

/*
typedef gboolean (*GSourceFunc) (gpointer user_data);
*/
abstype GSourceFunc = ptr
castfn GSourceFunc {a:type} (x: a): GSourceFunc // HX: unfortunately ...

(* ****** ****** *)

/*
guint
g_timeout_add
(
  guint interval, GSourceFunc function, gpointer data
) ; // end of [g_timeout_add]
*/
fun g_timeout_add
  (int: guint, gsf: GSourceFunc, data: gpointer): guint = "mac#%"
// end of [g_timeout_add]

(* ****** ****** *)

(* end of [gmain.sats] *)
