(*
** Some testing code for [zlog]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload_tmpdef.hats"
//
(* ****** ****** *)

#define strnone stropt_none()
#define strsome(str) stropt_some(str)

(* ****** ****** *)

staload "zlog/SATS/zlog.sats"

(* ****** ****** *)

implement
main0 () = let
//
val ctx = zlog_init (strnone)
//
val () = assertloc (zlgctx2int(ctx) = 0)
//
val n = zlog_reload (ctx, strsome"test.conf")
//
val () = assertloc (n = 0)
//
val
(
  fpf | cat
) = zlog_get_category (ctx, "mycat")
val p_cat = zlgcat2ptr(cat)
//
val () = assertloc (p_cat > 0)
//
val () = $extfcall (void, "zlog_info", p_cat, "%s, %d", "Hello World", 1024)
//
val () = zlog_clean_mdc (ctx)
val ec = zlog_put_mdc (ctx, "mykey", "myval")
val () = assertloc (ec = 0)
val () = $extfcall (void, "zlog_info", p_cat, "%s, %d", "Hello World", 1024)
//
prval () = minus_addback (fpf, cat | ctx)
//
val () = zlog_fini (ctx)
//
in
  // nothing
end // end of [main0]

(* ****** ****** *)

(* end of [zlog.sats] *)
