/*
** API for zlog in ATS
*/

/* ****** ****** */

/*
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
** Author: Zhiqiang Ren
** Authoremail: aren AT bu DOT edu
** Start Time: October, 2012
*/

/* ****** ****** */

/*
** Author: Hanwen Wu
** Authoremail: hwwu AT bu DOT edu
** Start Time: August, 2013
*/

/* ****** ****** */

/*
** Author Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT com
** Start Time: August, 2013
*/

/* ****** ****** */

#ifndef ZLOG_ZLOG_CATS
#define ZLOG_ZLOG_CATS

/* ****** ****** */

#define atscntrb_zlog_init(cfg) zlog_init(cfg)
#define atscntrb_zlog_reload(ctx, cfg) zlog_reload(cfg)
#define atscntrb_zlog_fini(ctx) zlog_fint()

/* ****** ****** */

#endif // ifndef ZLOG_ZLOG_CATS

/* ****** ****** */

/* end of [json.cats] */

