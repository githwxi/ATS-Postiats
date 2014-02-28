/*
** API in ATS for GNU-readline
*/

/* ****** ****** */

/*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2014 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
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

#ifndef READLINE_HISTORY_CATS
#define READLINE_HISTORY_CATS

/* ****** ****** */

#include <readline/history.h>

/* ****** ****** */

#define atscntrb_readline_add_history add_history
#define atscntrb_readline_add_history_time add_history_time

/* ****** ****** */

#define atscntrb_readline_remove_history remove_history

/* ****** ****** */

#define atscntrb_readline_free_history_entry free_history_entry

/* ****** ****** */

#define atscntrb_readline_where_history where_history

/* ****** ****** */

#define atscntrb_readline_history_total_bytes history_total_bytes

/* ****** ****** */

#define atscntrb_readline_history_get history_get
#define atscntrb_readline_history_get_time history_get_time

/* ****** ****** */

#define atscntrb_readline_history_set_pos history_set_pos

/* ****** ****** */

#define atscntrb_readline_current_history current_history

/* ****** ****** */

#define atscntrb_readline_next_history next_history
#define atscntrb_readline_previous_history previous_history

/* ****** ****** */

#define atscntrb_readline_history_search history_search
#define atscntrb_readline_history_search_prefix history_search_prefix
#define atscntrb_readline_history_search_pos history_search_pos

/* ****** ****** */

#endif // ifndef READLINE_HISTORY_CATS

/* ****** ****** */

/* end of [history.cats] */
