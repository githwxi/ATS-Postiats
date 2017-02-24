/*
******
//
// HX-2015-04:
// for JavaScript code
// translated from ATS source
//
******
*/

/*
//
//beg of [baconjs_cats.js]
//
*/

/* ****** ****** */
//
function
ats2js_baconjs_Bacon_more() { return Bacon.more; }
function
ats2js_baconjs_Bacon_noMore() { return Bacon.noMore; }
//
/* ****** ****** */
//
function
ats2js_baconjs_Bacon_once(x) { return Bacon.once(x); }
function
ats2js_baconjs_Bacon_never() { return Bacon.never(); }
//
function
ats2js_baconjs_Bacon_later(delay, x) { return Bacon.later(delay, x); }
//
function
ats2js_baconjs_Bacon_interval
  (int, x) { return Bacon.interval(int, x); }
//
function
ats2js_baconjs_Bacon_repeatedly
  (int, xs) { return Bacon.repeatedly(int, xs); }
//
function
ats2js_baconjs_Bacon_sequentially
  (int, xs) { return Bacon.sequentially(int, xs); }
//
function
ats2js_baconjs_Bacon_repeat(fopr)
{
  return Bacon.repeat(
    function(i){return ats2jspre_cloref1_app(fopr, i);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_map
  (xs, fopr)
{
  return ats2js_baconjs_Observable_map(xs, fopr);
}
function
ats2js_baconjs_Property_map
  (xs, fopr)
{
  return ats2js_baconjs_Observable_map(xs, fopr);
}
function
ats2js_baconjs_Observable_map
  (xs, fopr)
{
  return xs.map(
    function(x){return ats2jspre_cloref1_app(fopr, x);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_filter
  (xs, fopr)
{
  return ats2js_baconjs_Observable_filter(xs, fopr);
}
function
ats2js_baconjs_Property_filter
  (xs, fopr)
{
  return ats2js_baconjs_Observable_filter(xs, fopr);
}
function
ats2js_baconjs_Observable_filter
  (xs, fopr)
{
  return xs.filter(
    function(x){return ats2jspre_cloref1_app(fopr, x);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_map_property
  (xs, ys) { return xs.map(ys); }
function
ats2js_baconjs_EStream_filter_property
  (xs, bs) { return xs.filter(bs); }
//
/* ****** ****** */

function
ats2js_baconjs_EStream_scan
  (xs, ini, fopr)
{
  return xs.scan(
    ini, function(y, x){return ats2jspre_cloref2_app(fopr, y, x);}
  ); // end of [return]
}

/* ****** ****** */
//
function
ats2js_baconjs_EStream_merge2
(
  xs1, xs2
) { return Bacon.mergeAll(xs1, xs2); }
function
ats2js_baconjs_EStream_merge3
(
  xs1, xs2, xs3
) { return Bacon.mergeAll(xs1, xs2, xs3); }
function
ats2js_baconjs_EStream_merge4
(
  xs1, xs2, xs3, xs4
) { return Bacon.mergeAll(xs1, xs2, xs3, xs4); }
function
ats2js_baconjs_EStream_merge5
(
  xs1, xs2, xs3, xs4, xs5
)
{
  return Bacon.mergeAll(xs1, xs2, xs3, xs4, xs5);
}
function
ats2js_baconjs_EStream_merge6
(
  xs1, xs2, xs3, xs4, xs5, xs6
)
{
  return Bacon.mergeAll(xs1, xs2, xs3, xs4, xs5, xs6);
}
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_flatMap
  (xs, fopr)
{
  return ats2js_baconjs_Observable_flatMap(xs, fopr);
}
function
ats2js_baconjs_Property_flatMap
  (xs, fopr)
{
  return ats2js_baconjs_Observable_flatMap(xs, fopr);
}
function
ats2js_baconjs_Observable_flatMap
  (xs, fopr)
{
  return xs.flatMap(
    function(x){return ats2jspre_cloref1_app(fopr, x);}
  ); // end of [return]
}
//
/* ****** ****** */

function
ats2js_baconjs_Bacon_combineWith2
  (xs1, xs2, fopr)
{
  var
  theCombined =
  Bacon.combineWith(
    function(x1,x2){ return ats2jspre_cloref2_app(fopr, x1, x2); },
    xs1, xs2
  ) // end of [var]
  return theCombined;
}

function
ats2js_baconjs_Bacon_combineWith3
  (xs1, xs2, xs3, fopr)
{
  var
  theCombined =
  Bacon.combineWith(
    function(x1,x2,x3){ return ats2jspre_cloref3_app(fopr, x1, x2, x3); },
    xs1, xs2, xs3
  ) // end of [var]
  return theCombined;
}

/* ****** ****** */
//
function
ats2js_baconjs_EStream_toProperty
  (xs) { return xs.toProperty(); }
function
ats2js_baconjs_EStream_toProperty_init
  (xs, x0) { return xs.toProperty(x0); }
//
/* ****** ****** */
//
function
ats2js_baconjs_Property_changes
  (xs) { return xs.changes(/*void*/); }
function
ats2js_baconjs_Property_toEventStream
  (xs) { return xs.toEventStream(/*void*/); }
//
/* ****** ****** */

function
ats2js_baconjs_EStream_onValue
  (xs, fopr)
{
  return ats2js_baconjs_Observable_onValue(xs, fopr);
}
function
ats2js_baconjs_Property_onValue
  (xs, fopr)
{
  return ats2js_baconjs_Observable_onValue(xs, fopr);
}
function
ats2js_baconjs_Observable_onValue
  (xs, fopr)
{
  return xs.onValue(
    function(x){return ats2jspre_cloref1_app(fopr, x);}
  ); // end of [return]
}

/* ****** ****** */

function
ats2js_baconjs_EStream_subscribe
  (xs, fopr)
{
  return ats2js_baconjs_Observable_subscribe(xs, fopr);
}
function
ats2js_baconjs_Property_subscribe
  (xs, fopr)
{
  return ats2js_baconjs_Observable_subscribe(xs, fopr);
}
function
ats2js_baconjs_Observable_subscribe
  (xs, fopr)
{
  return xs.subscribe(
    function(x){return ats2jspre_cloref1_app(fopr, x);}
  ); // end of [return]
}

/* ****** ****** */
//
function
ats2js_baconjs_Property_startWith
  (xs, x0) { return xs.startWith(x0); }
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_doAction
  (xs, fopr)
{
  return ats2js_baconjs_Observable_doAction(xs, fopr);
}
function
ats2js_baconjs_Property_doAction
  (xs, fopr)
{
  return ats2js_baconjs_Observable_doAction(xs, fopr);
}
function
ats2js_baconjs_Observable_doAction
  (xs, fopr)
{
  return xs.doAction(
    function(x){ats2jspre_cloref1_app(fopr, x); return;}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_Property_sampledBy_estream
  (xs, ys) { return xs.sampledBy(ys); }
function
ats2js_baconjs_Property_sampledBy_estream_cfun
  (xs, ys, fopr)
{
  return xs.sampledBy(
    ys,function(x,y){return ats2jspre_cloref2_app(fopr, x, y);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_Property_sampledBy_property
  (xs, ys) { return xs.sampledBy(ys); }
function
ats2js_baconjs_Property_sampledBy_property_cfun
  (xs, ys, fopr)
{
  return xs.sampledBy(
    ys,function(x,y){return ats2jspre_cloref2_app(fopr, x, y);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_baconjs_EStream_zip_estream_cfun
  (xs, ys, fopr) 
{
  return xs.zip(
    ys,function(x,y){return ats2jspre_cloref2_app(fopr, x, y);}
  ); /* end of [return] */
}
//
/* ****** ****** */

function
ats2js_baconjs_Bacon_new_bus() { return new Bacon.Bus(); }

/* ****** ****** */
//
function
ats2js_baconjs_EStream_bus_push(bus, x0) { return bus.push(x0); }
function
ats2js_baconjs_EStream_bus_plug(bus, xs) { return bus.plug(xs); }
//
/* ****** ****** */

/* end of [baconjs_cats.js] */
