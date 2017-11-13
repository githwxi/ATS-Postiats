/*
******
*
* HX-2015-04:
* for JavaScript code
* translated from ATS
*
******
*/

/*
******
* beg of [baconjs_cats.js]
******
*/

/* ****** ****** */
//
function
ats2js_bacon_Bacon_more() { return Bacon.more; }
function
ats2js_bacon_Bacon_noMore() { return Bacon.noMore; }
//
/* ****** ****** */
//
function
ats2js_bacon_Bacon_once(x) { return Bacon.once(x); }
function
ats2js_bacon_Bacon_never() { return Bacon.never(); }
//
function
ats2js_bacon_Bacon_later(delay, x) { return Bacon.later(delay, x); }
//
/* ****** ****** */
//
function
ats2js_bacon_Bacon_interval
  (int, x) { return Bacon.interval(int, x); }
//
function
ats2js_bacon_Bacon_repeatedly
  (int, xs) { return Bacon.repeatedly(int, xs); }
//
function
ats2js_bacon_Bacon_sequentially
  (int, xs) { return Bacon.sequentially(int, xs); }
//
/* ****** ****** */
//
function
ats2js_bacon_Bacon_repeat(fopr)
{
  return Bacon.repeat(function(i){return ats2jspre_cloref1_app(fopr, i);});
} // ats2js_bacon_Bacon_repeat
//
/* ****** ****** */

function
ats2js_bacon_Bacon_fromPoll(ms, fopr)
{
  return Bacon.fromPoll(ms, function(){return ats2jspre_cloref0_app(fopr);});
} // ats2js_bacon_Bacon_fromPoll

/* ****** ****** */
//
function
ats2js_bacon_EStream_map(xs, f)
{
  return ats2js_bacon_Observable_map(xs, f);
}
function
ats2js_bacon_Property_map(xs, f)
{
  return ats2js_bacon_Observable_map(xs, f);
}
function
ats2js_bacon_Observable_map(xs, f)
{
  return xs.map(
    function(x){return ats2jspre_cloref1_app(f, x);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_bacon_EStream_filter(xs, f)
{
  return ats2js_bacon_Observable_filter(xs, f);
}
function
ats2js_bacon_Property_filter(xs, f)
{
  return ats2js_bacon_Observable_filter(xs, f);
}
function
ats2js_bacon_Observable_filter(xs, f)
{
  return xs.filter(
    function(x){return ats2jspre_cloref1_app(f, x);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_bacon_EStream_map_property(xs, ys) { return xs.map(ys); }
function
ats2js_bacon_EStream_filter_property(xs, bs) { return xs.filter(bs); }
//
/* ****** ****** */

function
ats2js_bacon_EStream_scan(xs, ini, f)
{
  return xs.scan(
    ini, function(y, x){return ats2jspre_cloref2_app(f, y, x);}
  ); // end of [return]
}

/* ****** ****** */
//
function
ats2js_bacon_EStream_merge2
(
  xs1, xs2
) { return Bacon.mergeAll(xs1, xs2); }
function
ats2js_bacon_EStream_merge3
(
  xs1, xs2, xs3
) { return Bacon.mergeAll(xs1, xs2, xs3); }
function
ats2js_bacon_EStream_merge4
(
  xs1, xs2, xs3, xs4
) { return Bacon.mergeAll(xs1, xs2, xs3, xs4); }
function
ats2js_bacon_EStream_merge5
(
  xs1, xs2, xs3, xs4, xs5
) { return Bacon.mergeAll(xs1, xs2, xs3, xs4, xs5); }
function
ats2js_bacon_EStream_merge6
(
  xs1, xs2, xs3, xs4, xs5, xs6
) { return Bacon.mergeAll(xs1, xs2, xs3, xs4, xs5, xs6); }
//
/* ****** ****** */
//
function
ats2js_bacon_EStream_flatMap(xs, f)
{
  return ats2js_bacon_Observable_flatMap(xs, f);
}
function
ats2js_bacon_Property_flatMap(xs, f)
{
  return ats2js_bacon_Observable_flatMap(xs, f);
}
function
ats2js_bacon_Observable_flatMap(xs, f)
{
  return xs.flatMap(
    function(x){return ats2jspre_cloref1_app(f, x);}
  ); // end of [return]
}
//
/* ****** ****** */

function
ats2js_bacon_Bacon_combineWith2(xs1, xs2, f)
{
  var
  theCombined =
  Bacon.combineWith(
    function(x1,x2){ return ats2jspre_cloref2_app(f, x1, x2); },
    xs1, xs2
  ) // end of [var]
  return theCombined;
}

function
ats2js_bacon_Bacon_combineWith3(xs1, xs2, xs3, f)
{
  var
  theCombined =
  Bacon.combineWith(
    function(x1,x2,x3){ return ats2jspre_cloref3_app(f, x1, x2, x3); },
    xs1, xs2, xs3
  ) // end of [var]
  return theCombined;
}

/* ****** ****** */
//
function
ats2js_bacon_EStream_toProperty(xs) { return xs.toProperty(); }
function
ats2js_bacon_EStream_toProperty_init(xs, x0) { return xs.toProperty(x0); }
//
/* ****** ****** */
//
function
ats2js_bacon_Property_changes(xs) { return xs.changes(); }
function
ats2js_bacon_Property_toEventStream(xs) { return xs.toEventStream(); }
//
/* ****** ****** */

function
ats2js_bacon_EStream_onValue(xs, f)
{
  return ats2js_bacon_Observable_onValue(xs, f);
}
function
ats2js_bacon_Property_onValue(xs, f)
{
  return ats2js_bacon_Observable_onValue(xs, f);
}
function
ats2js_bacon_Observable_onValue(xs, f)
{
  return xs.onValue(function(x){return ats2jspre_cloref1_app(f, x);});
}

/* ****** ****** */

function
ats2js_bacon_EStream_subscribe(xs, f)
{
  return ats2js_bacon_Observable_subscribe(xs, f);
}
function
ats2js_bacon_Property_subscribe(xs, f)
{
  return ats2js_bacon_Observable_subscribe(xs, f);
}
function
ats2js_bacon_Observable_subscribe(xs, f)
{
  return xs.subscribe(function(x){return ats2jspre_cloref1_app(f, x);});
}

/* ****** ****** */
//
function
ats2js_bacon_Property_startWith
  (xs, x0) { return xs.startWith(x0); }
//
/* ****** ****** */
//
function
ats2js_bacon_EStream_doAction(xs, f0)
{
  return ats2js_bacon_Observable_doAction(xs, f0);
}
function
ats2js_bacon_Property_doAction(xs, f0)
{
  return ats2js_bacon_Observable_doAction(xs, f0);
}
function
ats2js_bacon_Observable_doAction(xs, f0)
{
  return xs.doAction(
    function(x){ats2jspre_cloref1_app(f0, x); return;}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_bacon_Property_sampledBy_estream
  (xs, ys) { return xs.sampledBy(ys); }
function
ats2js_bacon_Property_sampledBy_estream_cfun(xs, ys, f)
{
  return xs.sampledBy(
    ys,function(x,y){return ats2jspre_cloref2_app(f,x,y);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_bacon_Property_sampledBy_property
  (xs, ys) { return xs.sampledBy(ys); }
function
ats2js_bacon_Property_sampledBy_property_cfun(xs, ys, f0)
{
  return xs.sampledBy(
    ys,function(x,y){return ats2jspre_cloref2_app(f0,x,y);}
  ); // end of [return]
}
//
/* ****** ****** */
//
function
ats2js_bacon_EStream_zip_estream_cfun(xs, ys, f0) 
{
  return xs.zip(
    ys,function(x,y){return ats2jspre_cloref2_app(f0,x,y);}
  ); /* end of [return] */
}
//
/* ****** ****** */

function
ats2js_bacon_Bacon_new_bus() { return new Bacon.Bus(); }

/* ****** ****** */
//
function
ats2js_bacon_EStream_bus_push(bus, x0) { return bus.push(x0); }
function
ats2js_bacon_EStream_bus_plug(bus, xs) { return bus.plug(xs); }
//
/* ****** ****** */

/* end of [baconjs_cats.js] */
