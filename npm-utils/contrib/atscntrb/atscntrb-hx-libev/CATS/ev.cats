/*
** Copyright (C) 2014 Hongwei Xi.
**
** Permission to use, copy, modify, and distribute this software for any
** purpose with or without fee is hereby granted, provided that the above
** copyright notice and this permission notice appear in all copies.
** 
** THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
** WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
** MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
** ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
** WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
** ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
** OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

/* ****** ****** */
//
// Author: Hongwei Xi
// Authoremail: gmhwxiATgmailDOTcom
// Start Time: May, 2014
//
/* ****** ****** */

#ifndef ATSCNTRB_LIBEV_EV_CATS
#define ATSCNTRB_LIBEV_EV_CATS

/* ****** ****** */
//
#include <ev.h>
//
/* ****** ****** */

typedef
struct ev_loop *ev_loop_ref ;

/* ****** ****** */

#define atscntrb_libev_ev_time ev_time

/* ****** ****** */

#define atscntrb_libev_ev_sleep ev_sleep

/* ****** ****** */

#define atscntrb_libev_ev_version_major ev_version_major
#define atscntrb_libev_ev_version_minor ev_version_minor

/* ****** ****** */

#define \
atscntrb_libev_ev_supported_backends ev_supported_backends
#define \
atscntrb_libev_ev_recommended_backends ev_recommended_backends
#define \
atscntrb_libev_ev_embeddable_backends ev_embeddable_backends

/* ****** ****** */

#define atscntrb_libev_ev_feed_signal ev_feed_signal

/* ****** ****** */
//
#define atscntrb_libev_ev_default_loop ev_default_loop
//
#define atscntrb_libev_ev_loop_new ev_loop_new
//
#define atscntrb_libev_ev_loop_destroy ev_loop_destroy
//
#define atscntrb_libev_ev_loop_fork ev_loop_fork
//
/* ****** ****** */

#define atscntrb_libev_ev_is_default_loop ev_is_default_loop

/* ****** ****** */

#define \
atscntrb_libev_ev_init_io(w, cb) ev_init(w, (void*)cb)
#define \
atscntrb_libev_ev_init_timer(w, cb) ev_init(w, (void*)cb)

/* ****** ****** */

#define atscntrb_libev_ev_io_start ev_io_start
#define atscntrb_libev_ev_io_stop ev_io_stop

/* ****** ****** */

#define atscntrb_libev_ev_timer_start ev_timer_start
#define atscntrb_libev_ev_timer_stop ev_timer_stop

/* ****** ****** */

#define atscntrb_libev_ev_run ev_run
#define atscntrb_libev_ev_break ev_break

/* ****** ****** */

#endif // ifndef ATSCNTRB_LIBEV_EV_CATS

/* ****** ****** */

/* end of [ev.cats] */
