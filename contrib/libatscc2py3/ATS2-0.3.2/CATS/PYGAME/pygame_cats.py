######
#
# HX-2016-05: pygame
#
######

######
#beg of [PYgame_pygame_cats.py]
######

import pygame

############################################
#
def ats2py_pygame_pygame_init(): return pygame.init()
def ats2py_pygame_pygame_init_ret(): return pygame.init()
#
def ats2py_pygame_pygame_quit(): return pygame.quit()
#
############################################
#
def ats2py_pygame_rect_top(obj): return obj.top
def ats2py_pygame_rect_left(obj): return obj.left
def ats2py_pygame_rect_bottom(obj): return obj.bottom
def ats2py_pygame_rect_right(obj): return obj.right
#
def ats2py_pygame_rect_make_int4(t,l,w,h): return pygame.Rect(t,l,w,h)
def ats2py_pygame_rect_make_int2_int2(tl, wh): return pygame.Rect(tl, wh)
#
############################################
#
def ats2py_pygame_rect_copy(obj): return obj.copy()
#
def ats2py_pygame_rect_fit(obj, obj2): return obj.fit(obj2)
def ats2py_pygame_rect_clip(obj, obj2): return obj.clip(obj2)
#
def ats2py_pygame_rect_move(obj, x, y): return obj.move(x, y)
def ats2py_pygame_rect_move_ip(obj, x, y): return obj.move_ip(x, y)
#
def ats2py_pygame_rect_inflate(obj, x, y): return obj.inflate(x, y)
def ats2py_pygame_rect_inflate_ip(obj, x, y): return obj.inflate_ip(x, y)
#
def ats2py_pygame_rect_clamp(obj, obj2): return obj.clamp(obj2)
def ats2py_pygame_rect_clamp_ip(obj, obj2): return obj.clamp_ip(obj2)
#
def ats2py_pygame_rect_contains(obj, obj2): return obj.contains(obj2)
#
############################################
#
def ats2py_pygame_color_r(obj): return obj.r
def ats2py_pygame_color_g(obj): return obj.g
def ats2py_pygame_color_b(obj): return obj.b
def ats2py_pygame_color_a(obj): return obj.a
#
def ats2py_pygame_color_make_rgb(r, g, b): return pygame.Color(r, g, b, 255)
def ats2py_pygame_color_make_rgba(r, g, b, a): return pygame.Color(r, g, b, a)
#
############################################
#
def ats2py_pygame_draw_rect_(s, c, r): return pygame.draw.rect(s, c, r)
def ats2py_pygame_draw_rect_width(s, c, r, w): return pygame.draw.rect(s, c, r, w)
#
def ats2py_pygame_draw_polygon_(s, c, xs): return pygame.draw.polygon(s, c, xs)
def ats2py_pygame_draw_polygon_width(s, c, xs, w): return pygame.draw.polygon(s, c, xs, w)
#
def ats2py_pygame_draw_circle_(s, c, o, r): return pygame.draw.circle(s, c, o, r)
def ats2py_pygame_draw_circle_width(s, c, o, r, w): return pygame.draw.circle(s, c, o, r, w)
#
def ats2py_pygame_draw_line_(s, c, p0, p1): return pygame.draw.line(s, c, p0, p1)
def ats2py_pygame_draw_line_width(s, c, p0, p1, width): return pygame.draw.line(s, c, p0, p1, width)
#
############################################
#
def ats2py_pygame_event_pump(): return pygame.event.pump()
#
############################################

def ats2py_pygame_event_get(): return pygame.event.get()
def ats2py_pygame_event_get_type(x): return pygame.event.get_type(x)
def ats2py_pygame_event_get_types(xs): return pygame.event.get_types(xs)

############################################
#
def ats2py_pygame_event_poll(): return pygame.event.poll()
#
def ats2py_pygame_event_wait(): return pygame.event.wait()
#
############################################

def ats2py_pygame_event_clear(): return pygame.event.clear()
def ats2py_pygame_event_clear_type(x): return pygame.event.clear(x)
def ats2py_pygame_event_clear_types(xs): return pygame.event.clear(xs)

############################################

def ats2py_pygame_event_post(event): return pygame.event.post(event)

############################################

def ats2py_pygame_event_event_name(type): return pygame.event.event_name(type)

############################################
#
def ats2py_pygame_event_set_blocked(): return pygame.event.set_blocked()
def ats2py_pygame_event_set_blocked_type(x): return pygame.event.set_blocked(x)
def ats2py_pygame_event_set_blocked_types(xs): return pygame.event.set_blocked(xs)
#
def ats2py_pygame_event_set_allowed(): return pygame.event.set_allowed()
def ats2py_pygame_event_set_allowed_type(x): return pygame.event.set_allowed(x)
def ats2py_pygame_event_set_allowed_types(xs): return pygame.event.set_allowed(xs)
#
def ats2py_pygame_event_get_blocked(type): return pygame.event.get_blocked(type)
#
############################################
#
def ats2py_pygame_event_type(obj): return obj.type
def ats2py_pygame_event_type_equal(x, y): return (x == y)
def ats2py_pygame_event_type_nequal(x, y): return (x != y)
#
def ats2py_pygame_event_keyup_key(obj): return obj.key
def ats2py_pygame_event_keyup_mod(obj): return obj.mod
def ats2py_pygame_event_keydown_key(obj): return obj.key
def ats2py_pygame_event_keydown_mod(obj): return obj.mod
#
############################################
#
def ats2py_pygame_surface_make_(clr): return pyname.Surface(clr)
def ats2py_pygame_surface_make_flags_depth(clr, flags, depth): return pygame.Surface(clr,flags,depth)
def ats2py_pygame_surface_make_flags_surface(clr, flags, surface): return pygame.Surface(clr,flags,surface)
#
def ats2py_pygame_surface_get_size(obj): return obj.get_size()
def ats2py_pygame_surface_get_width(obj): return obj.get_width()
def ats2py_pygame_surface_get_height(obj): return obj.get_height()
#
def ats2py_pygame_surface_fill_(obj, clr): return obj.fill(clr)
def ats2py_pygame_surface_fill_rect_flags(obj, clr, rect, flags): return obj.fill(clr,rect,flags)
#
def ats2py_pygame_surface_blit_xy(obj, src, dst): return obj.blit(src, dst)
def ats2py_pygame_surface_blit_xy_area_flags(obj, src, dst, area, flags): return obj.blit(src,dst,area,flags)
def ats2py_pygame_surface_blit_rect(obj, src, dst): return obj.blit(src, dst)
def ats2py_pygame_surface_blit_rect_area_flags(obj, src, dst, area, flags): return obj.blit(src,dst,area,flags)
#
############################################
#
def ats2py_pygame_display_init(): return pygame.display.init()
def ats2py_pygame_display_quit(): return pygame.display.quit()
#
def ats2py_pygame_display_get_init(): return pygame.display.get_init()
def ats2py_pygame_display_get_active(): return pygame.display.get_active()
#
def ats2py_pygame_display_set_mode_resolution(res): return pygame.display.set_mode(res)
def ats2py_pygame_display_set_mode_resolution_flags_depth(res,fs,dep): return pygame.display.set_mode(res,fs,dep)
#
def ats2py_pygame_display_flip(): return pygame.display.flip()
def ats2py_pygame_display_update(xs): return pygame.display.update(xs)
#
def ats2py_pygame_display_iconify(xs): return pygame.display.iconify()
#
############################################
#
def ats2py_pygame_time_wait(ms): return pygame.time.wait(ms)
def ats2py_pygame_time_delay(ms): return pygame.time.delay(ms)
#
def ats2py_pygame_time_get_ticks(): return pygame.time.get_ticks()
#
############################################

###### end of [PYgame_pygame_cats.py] ######
