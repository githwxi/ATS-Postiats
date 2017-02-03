/*
** Copyright (C) 2011 Chris Double.
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
// HX-2014-05: Ported to ATS2
//
/* ****** ****** */

#ifndef LIBEVENT_EVENT_CATS
#define LIBEVENT_EVENT_CATS

/* ****** ****** */
//
#include <event2/event.h>
//
#include <event2/buffer.h>
//
#include <event2/http.h>
#include <event2/http_struct.h>
//
/* ****** ****** */
/*
**
** event.h
**
*/
/* ****** ****** */

#define \
atscntrb_libevent_event_get_version() ((char*)(event_get_version()))
#define \
atscntrb_libevent_event_get_version_number() event_get_version_number()

/* ****** ****** */

#define \
atscntrb_libevent_event_enable_debug_mode event_enable_debug_mode
#define atscntrb_libevent_event_debug_unassign event_debug_unassign

/* ****** ****** */

#define atscntrb_libevent_eventp_config_new eventp_config_new
#define atscntrb_libevent_eventp_config_free eventp_config_free
#define \
atscntrb_libevent_eventp_config_avoid_method eventp_config_avoid_method

/* ****** ****** */

#define atscntrb_libevent_event_base_new event_base_new
#define atscntrb_libevent_event_reinit event_reinit
#define atscntrb_libevent_event_base_dispatch event_base_dispatch
#define atscntrb_libevent_event_base_get_method event_base_get_method

/* ****** ****** */
//
#define \
atscntrb_libevent_event_base_get_features event_base_get_features
#define \
atscntrb_libevent_event_config_require_features event_config_require_features
//
#define \
atscntrb_libevent_event_config_set_flag event_config_set_flag
#define \
atscntrb_libevent_event_config_set_num_cpus_hint event_config_set_num_cpus_hint
//
#define atscntrb_libevent_event_base_free event_base_free
#define atscntrb_libevent_event_base_new_with_config event_base_new_with_config
//
/* ****** ****** */
//
#define atscntrb_libevent_event_base_set event_base_set
#define atscntrb_libevent_event_set_log_callback event_set_log_callback
#define atscntrb_libevent_event_set_fatal_callback event_set_fatal_callback
//
/* ****** ****** */
//
#define atscntrb_libevent_event_base_loop event_base_loop
//
#define atscntrb_libevent_event_base_loopexit event_base_loopexit
#define atscntrb_libevent_event_base_loopbreak event_base_loopbreak
//
#define atscntrb_libevent_event_base_got_exit event_base_got_exit
//
/* ****** ****** */

#define atscntrb_libevent_event_new event_new
#define atscntrb_libevent_event_free event_free

/* ****** ****** */

#define atscntrb_libevent_event_add event_add
#define atscntrb_libevent_event_add_null(ev) event_add(ev, (void*)0)

/* ****** ****** */

#define atscntrb_libevent_event_initialized event_initialized

/* ****** ****** */

#define \
atscntrb_libevent_event_priority_set event_priority_set
#define \
atscntrb_libevent_event_base_priority_init event_base_priority_init

/* ****** ****** */

/*
**
** buffer.h
**
*/

/* ****** ****** */

#define \
atscntrb_libevent_evbuffer_pullup evbuffer_pullup

/* ****** ****** */

/*
**
** http.h
**
*/

/* ****** ****** */

#define atscntrb_libevent_evhttp_new evhttp_new
#define atscntrb_libevent_evhttp_free evhttp_free

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_bind_socket evhttp_bind_socket

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_request_new1(cb, arg) evhttp_request_new((void*)cb, arg)
#define \
atscntrb_libevent_evhttp_request_new1_ref(cb, arg) evhttp_request_new((void*)cb, arg)

/* ****** ****** */

#define atscntrb_libevent_evhttp_request_free evhttp_request_free

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_request_get_input_buffer evhttp_request_get_input_buffer

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_request_get_response_code evhttp_request_get_response_code

/* ****** ****** */

#define atscntrb_libevent_evhttp_request_get_host evhttp_request_get_host

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_request_get_input_headers evhttp_request_get_input_headers
#define \
atscntrb_libevent_evhttp_request_get_output_headers evhttp_request_get_output_headers

/* ****** ****** */
//
#define atscntrb_libevent_evhttp_add_header evhttp_add_header
//
#define \
atscntrb_libevent_evhttp_find_header(headers, key) ((char*)(evhttp_find_header(headers, key)))
//
#define atscntrb_libevent_evhttp_remove_header evhttp_remove_header
//
#define atscntrb_libevent_evhttp_clear_headers evhttp_clear_headers
//
/* ****** ****** */

#define \
atscntrb_libevent_evhttp_connection_free evhttp_connection_free
#define \
atscntrb_libevent_evhttp_connection_base_new evhttp_connection_base_new

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_make_request evhttp_make_request
#define \
atscntrb_libevent_evhttp_cancel_request evhttp_cancel_request

/* ****** ****** */

#define \
atscntrb_libevent_evhttp_uri_get_port evhttp_uri_get_port
#define \
atscntrb_libevent_evhttp_uri_get_host(uri) ((char*)(evhttp_uri_get_host(uri)))
#define \
atscntrb_libevent_evhttp_uri_get_path(uri) ((char*)(evhttp_uri_get_path(uri)))
#define \
atscntrb_libevent_evhttp_uri_get_query(uri) ((char*)(evhttp_uri_get_query(uri)))

/* ****** ****** */

#define atscntrb_libevent_evhttp_uri_free evhttp_uri_free
#define atscntrb_libevent_evhttp_uri_parse evhttp_uri_parse

/* ****** ****** */

#endif // ifndef LIBEVENT_EVENT_CATS

/* ****** ****** */

/* end of [event.cats] */
