#include "share/atspre_staload.hats"

%{^
  /* 
     This function isn't implemented yet, but maybe best left to plain
     javascript.
  */
  extern double atspre_g0float_mod_double (double, double);
%}

staload cnvs = "canvas.sats"
vtypedef context = $cnvs.context

val PI  = 3.141592653589793
val PI2 = PI / 2

extern 
fun render_frame (timestamp: double, ctx: !context): bool = "ext#"

(* ****** ***** *)

abst@ype wallclock

typedef wallclock_struct = @{
  hours= double,
  minutes= double,
  seconds= double
}

assume wallclock = wallclock_struct

extern
fun wallclock_now (_: &wallclock? >> wallclock): void = "ext#"

(* ****** ***** *)

fun start_animation (): void = let
  val ctx = $cnvs.make_context ("clock")
  fun step (timestamp: double, ctx: context): void =
    if render_frame (timestamp, ctx) then
      $cnvs.request_animation_frame (step, ctx)
    else
      $cnvs.free_context (ctx)
in $cnvs.request_animation_frame (step, ctx) end

(* ****** ***** *)

val w = 920.0
val h = 600.0

(* ****** ***** *)

implement render_frame (_, ctx) = let
  val mn = min (w, h)
  val xc = w / 2 and yc = h / 2

  val () = $cnvs.save (ctx)
  
  val () = $cnvs.translate (ctx, xc, yc)
  
  val alpha = mn / 100
  val () = $cnvs.scale (ctx, alpha, alpha)

  var localtime: wallclock
  
  val () = wallclock_now (localtime)
  //
  fun draw_hand (
    ctx: !context, bot: double, top: double, len: double
  ): void = begin
    $cnvs.move_to (ctx, 0.0, bot/2);
    $cnvs.line_to (ctx, len, top/2);
    $cnvs.line_to (ctx, len, ~top/2);
    $cnvs.line_to (ctx, 0.0, ~bot/2);
    $cnvs.close_path (ctx);
    $cnvs.fill(ctx);
  end
  //
  fun draw_clock (
    ctx: !context, time: wallclock
  ): void = {
    val rad = 280.0
    //
    val s_angle = time.seconds * (PI / 30) - PI2
    val m_angle = time.minutes * (PI / 30) - PI2
    val h_angle = time.hours * (PI / 6) - PI2
    //
    val h_l = 0.60 * rad
    val m_l = 0.85 * rad
    val s_l = m_l
    //    
    val () = begin
      $cnvs.clear_rect (ctx, ~xc, ~yc, w, h);
      // main clock
      $cnvs.begin_path (ctx);
      $cnvs.arc (ctx, 0.0, 0.0, rad, 0.0, 2.0*PI, true);
      $cnvs.fill_style (ctx, "rgb(0, 0, 0)");
      $cnvs.fill (ctx);
      // base
      $cnvs.begin_path (ctx);
      $cnvs.arc (ctx, 0.0, 0.0, 10.0, 0.0, 2.0*PI, true);
      $cnvs.fill_style (ctx, "rgb(198, 198, 198)");
      $cnvs.fill (ctx);
      //hour hand
      $cnvs.save (ctx);
      $cnvs.fill_style (ctx, "rgb(175, 185, 185)");
      $cnvs.rotate (ctx, h_angle);
      draw_hand (ctx, 4.0, 2.5, h_l);
      $cnvs.restore (ctx);
      $cnvs.save (ctx);
      $cnvs.rotate (ctx, h_angle + PI);
      draw_hand (ctx, 4.0, 2.5, h_l / 4);
      $cnvs.restore (ctx);
      // minute hand
      $cnvs.save (ctx);
      $cnvs.fill_style (ctx, "rgb(175, 185, 185)");
      $cnvs.rotate (ctx, m_angle);
      draw_hand (ctx, 3.0, 2.0, m_l);
      $cnvs.restore (ctx);
      $cnvs.save (ctx);
      $cnvs.rotate (ctx, m_angle + PI);
      $cnvs.restore (ctx);
      // second hand
      $cnvs.save (ctx);
      $cnvs.fill_style (ctx, "rgb(198, 198, 198)");
      $cnvs.rotate (ctx, s_angle);
      draw_hand (ctx, 2.0, 1.5, s_l);
      $cnvs.restore (ctx);
      $cnvs.save (ctx);
      $cnvs.rotate (ctx, s_angle + PI);
      draw_hand (ctx, 2.0, 1.5, s_l / 4);
      $cnvs.restore (ctx);
    end
  }
in
  draw_clock (ctx, localtime);
  $cnvs.restore (ctx);
  true
end

(* ****** ***** *)

implement main0 () =  let
  val () = start_animation ()
in println! "Starting Clock" end
