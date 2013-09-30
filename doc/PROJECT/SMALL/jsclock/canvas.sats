#define ATS_STALOADFLAG 0

%{#
     typedef void* context;
%}

absvtype context

fun make_context (_: string): context = "ext#"

fun free_context (_: context): void = "ext#"

fun save (_: !context): void = "ext#"

fun restore (_: !context): void = "ext#"

fun clear_rect (
  _: !context, x: double, y: double, width: double, height: double
): void = "ext#"

fun begin_path (_: !context): void = "ext#"

fun close_path (_: !context): void = "ext#"

fun move_to (_: !context, x: double, y: double): void = "ext#"

fun line_to (_: !context, x: double, y: double): void = "ext#"

fun rotate (_: !context, radians: double): void = "ext#"

fun scale (_: !context, xs: double, ys: double): void = "ext#"

fun translate (_: !context, x: double, y: double): void = "ext#"

fun arc (
  _: !context, x: double, y: double, radius: double, angle_start: double,
  angle_end: double, anticlockwise : bool
): void = "ext#"

fun stroke (_: !context): void = "ext#"

fun fill (_: !context): void = "ext#"

fun fill_style (_: !context, color: string): void = "ext#"

(* ****** ***** *)

symintr request_animation_frame

fun request_animation_frame_none (callback: (double) -> void): void = "ext#"

overload request_animation_frame with request_animation_frame_none

fun request_animation_frame_env {a:vtype} (
  callback: (double, a) -> void, env: a
): void = "ext#"

overload request_animation_frame with request_animation_frame_env