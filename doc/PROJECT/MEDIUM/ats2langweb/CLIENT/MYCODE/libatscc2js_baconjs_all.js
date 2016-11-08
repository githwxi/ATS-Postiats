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
function
ats2js_bacon_Bacon_repeat(fopr)
{
  return Bacon.repeat(function(i){return ats2jspre_cloref1_app(fopr, i);});
}
//
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
  (xs1, xs2) { return Bacon.mergeAll(xs1, xs2); }
//
function
ats2js_bacon_EStream_merge3
  (xs1, xs2, xs3) { return Bacon.mergeAll(xs1, xs2, xs3); }
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
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-11-7: 22h:51m
**
*/

function
_ats2js_bacon_patsfun_1__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_1(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_3__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_3(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_5__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_5(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_7__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_7(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
_ats2js_bacon_patsfun_9__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_9(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_11__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_11(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_13__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_13(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_15__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_15(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_17__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_17(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_patsfun_19__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_patsfun_19(cenv[1], arg0); }, env0];
}


function
ats2js_bacon_EStream_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret0
  var tmplab, tmplab_js
//
  // __patsflab_EStream_map_method
  tmpret0 = _ats2js_bacon_patsfun_1__closurerize(arg0);
  return tmpret0;
} // end-of-function


function
_ats2js_bacon_patsfun_1(env0, arg0)
{
//
// knd = 0
  var tmpret1
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_1
  tmpret1 = ats2js_bacon_EStream_map(env0, arg0);
  return tmpret1;
} // end-of-function


function
ats2js_bacon_Property_map_method(arg0, arg1)
{
//
// knd = 0
  var tmpret2
  var tmplab, tmplab_js
//
  // __patsflab_Property_map_method
  tmpret2 = _ats2js_bacon_patsfun_3__closurerize(arg0);
  return tmpret2;
} // end-of-function


function
_ats2js_bacon_patsfun_3(env0, arg0)
{
//
// knd = 0
  var tmpret3
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_3
  tmpret3 = ats2js_bacon_Property_map(env0, arg0);
  return tmpret3;
} // end-of-function


function
ats2js_bacon_EStream_filter_method(arg0)
{
//
// knd = 0
  var tmpret4
  var tmplab, tmplab_js
//
  // __patsflab_EStream_filter_method
  tmpret4 = _ats2js_bacon_patsfun_5__closurerize(arg0);
  return tmpret4;
} // end-of-function


function
_ats2js_bacon_patsfun_5(env0, arg0)
{
//
// knd = 0
  var tmpret5
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_5
  tmpret5 = ats2js_bacon_EStream_filter(env0, arg0);
  return tmpret5;
} // end-of-function


function
ats2js_bacon_EStream_scan_method(arg0, arg1)
{
//
// knd = 0
  var tmpret6
  var tmplab, tmplab_js
//
  // __patsflab_EStream_scan_method
  tmpret6 = _ats2js_bacon_patsfun_7__closurerize(arg0, arg1);
  return tmpret6;
} // end-of-function


function
_ats2js_bacon_patsfun_7(env0, env1, arg0)
{
//
// knd = 0
  var tmpret7
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_7
  tmpret7 = ats2js_bacon_EStream_scan(env0, env1, arg0);
  return tmpret7;
} // end-of-function


function
ats2js_bacon_EStream_onValue_method(arg0)
{
//
// knd = 0
  var tmpret8
  var tmplab, tmplab_js
//
  // __patsflab_EStream_onValue_method
  tmpret8 = _ats2js_bacon_patsfun_9__closurerize(arg0);
  return tmpret8;
} // end-of-function


function
_ats2js_bacon_patsfun_9(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_9
  ats2js_bacon_EStream_onValue(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2js_bacon_Property_onValue_method(arg0)
{
//
// knd = 0
  var tmpret10
  var tmplab, tmplab_js
//
  // __patsflab_Property_onValue_method
  tmpret10 = _ats2js_bacon_patsfun_11__closurerize(arg0);
  return tmpret10;
} // end-of-function


function
_ats2js_bacon_patsfun_11(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_11
  ats2js_bacon_Property_onValue(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2js_bacon_EStream_subscribe_method(arg0)
{
//
// knd = 0
  var tmpret12
  var tmplab, tmplab_js
//
  // __patsflab_EStream_subscribe_method
  tmpret12 = _ats2js_bacon_patsfun_13__closurerize(arg0);
  return tmpret12;
} // end-of-function


function
_ats2js_bacon_patsfun_13(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_13
  ats2js_bacon_EStream_subscribe(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2js_bacon_Property_subscribe_method(arg0)
{
//
// knd = 0
  var tmpret14
  var tmplab, tmplab_js
//
  // __patsflab_Property_subscribe_method
  tmpret14 = _ats2js_bacon_patsfun_15__closurerize(arg0);
  return tmpret14;
} // end-of-function


function
_ats2js_bacon_patsfun_15(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_15
  ats2js_bacon_Property_subscribe(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2js_bacon_EStream_doAction_method(arg0)
{
//
// knd = 0
  var tmpret16
  var tmplab, tmplab_js
//
  // __patsflab_EStream_doAction_method
  tmpret16 = _ats2js_bacon_patsfun_17__closurerize(arg0);
  return tmpret16;
} // end-of-function


function
_ats2js_bacon_patsfun_17(env0, arg0)
{
//
// knd = 0
  var tmpret17
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_17
  tmpret17 = ats2js_bacon_EStream_doAction(env0, arg0);
  return tmpret17;
} // end-of-function


function
ats2js_bacon_Property_doAction_method(arg0)
{
//
// knd = 0
  var tmpret18
  var tmplab, tmplab_js
//
  // __patsflab_Property_doAction_method
  tmpret18 = _ats2js_bacon_patsfun_19__closurerize(arg0);
  return tmpret18;
} // end-of-function


function
_ats2js_bacon_patsfun_19(env0, arg0)
{
//
// knd = 0
  var tmpret19
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_patsfun_19
  tmpret19 = ats2js_bacon_Property_doAction(env0, arg0);
  return tmpret19;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
/*
**
** The JavaScript code is generated by atscc2js
** The starting compilation time is: 2016-11-7: 22h:51m
**
*/

function
_ats2js_bacon_ext_patsfun_1__closurerize(env0, env1)
{
  return [function(cenv, arg0, arg1) { return _ats2js_bacon_ext_patsfun_1(cenv[1], cenv[2], arg0, arg1); }, env0, env1];
}


function
_ats2js_bacon_ext_patsfun_4__closurerize(env0)
{
  return [function(cenv, arg0) { return _ats2js_bacon_ext_patsfun_4(cenv[1], arg0); }, env0];
}


function
_ats2js_bacon_ext_patsfun_6__closurerize(env0, env1)
{
  return [function(cenv, arg0) { return _ats2js_bacon_ext_patsfun_6(cenv[1], cenv[2], arg0); }, env0, env1];
}


function
ats2js_bacon_ext_EStream_scan_stream_opt(arg0, arg1, arg2, arg3)
{
//
// knd = 0
  var tmpret0
  var tmp1
  var tmp10
  var tmplab, tmplab_js
//
  // __patsflab_EStream_scan_stream_opt
  tmp1 = ats2jspre_ref(arg2);
  tmp10 = _ats2js_bacon_ext_patsfun_1__closurerize(arg3, tmp1);
  tmpret0 = ats2js_bacon_EStream_scan(arg0, arg1, tmp10);
  return tmpret0;
} // end-of-function


function
_ats2js_bacon_ext_patsfun_1(env0, env1, arg0, arg1)
{
//
// knd = 0
  var tmpret2
  var tmp3
  var tmp4
  var tmp5
  var tmp6
  var tmp7
  var tmp8
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_ext_patsfun_1
  tmp3 = ats2jspre_ref_get_elt(env1);
  tmp4 = ATSPMVlazyval_eval(tmp3); 
  // ATScaseofseq_beg
  tmplab_js = 1;
  while(true) {
    tmplab = tmplab_js; tmplab_js = 0;
    switch(tmplab) {
      // ATSbranchseq_beg
      case 1: // __atstmplab0
      if(ATSCKptriscons(tmp4)) { tmplab_js = 4; break; }
      case 2: // __atstmplab1
      tmpret2 = arg0;
      break;
      // ATSbranchseq_end
      // ATSbranchseq_beg
      case 3: // __atstmplab2
      case 4: // __atstmplab3
      tmp5 = tmp4[0];
      tmp6 = tmp4[1];
      tmp7 = env0[0](env0, arg0, arg1, tmp5);
      // ATScaseofseq_beg
      tmplab_js = 1;
      while(true) {
        tmplab = tmplab_js; tmplab_js = 0;
        switch(tmplab) {
          // ATSbranchseq_beg
          case 1: // __atstmplab4
          if(ATSCKptriscons(tmp7)) { tmplab_js = 4; break; }
          case 2: // __atstmplab5
          tmpret2 = arg0;
          break;
          // ATSbranchseq_end
          // ATSbranchseq_beg
          case 3: // __atstmplab6
          case 4: // __atstmplab7
          tmp8 = tmp7[0];
          // ATSINSfreecon(tmp7);
          ats2jspre_ref_set_elt(env1, tmp6);
          tmpret2 = tmp8;
          break;
          // ATSbranchseq_end
        } // end-of-switch
        if (tmplab_js === 0) break;
      } // endwhile
      // ATScaseofseq_end
      break;
      // ATSbranchseq_end
    } // end-of-switch
    if (tmplab_js === 0) break;
  } // endwhile
  // ATScaseofseq_end
  return tmpret2;
} // end-of-function


function
ats2js_bacon_ext_EValue_get_elt(arg0)
{
//
// knd = 0
  var tmpret11
  var tmplab, tmplab_js
//
  // __patsflab_EValue_get_elt
  tmpret11 = ats2jspre_ref_get_elt(arg0);
  return tmpret11;
} // end-of-function


function
ats2js_bacon_ext_EValue_make_property(arg0)
{
//
// knd = 0
  var tmpret12
  var tmp13
  var tmplab, tmplab_js
//
  // __patsflab_EValue_make_property
  tmp13 = ats2jspre_ref(0);
  ats2js_bacon_Property_onValue(arg0, _ats2js_bacon_ext_patsfun_4__closurerize(tmp13));
  tmpret12 = tmp13;
  return tmpret12;
} // end-of-function


function
_ats2js_bacon_ext_patsfun_4(env0, arg0)
{
//
// knd = 0
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_ext_patsfun_4
  ats2jspre_ref_set_elt(env0, arg0);
  return/*_void*/;
} // end-of-function


function
ats2js_bacon_ext_EValue_make_estream_scan(arg0, arg1, arg2)
{
//
// knd = 0
  var tmpret16
  var tmp17
  var tmplab, tmplab_js
//
  // __patsflab_EValue_make_estream_scan
  tmp17 = ats2jspre_ref(arg0);
  ats2js_bacon_EStream_onValue(arg1, _ats2js_bacon_ext_patsfun_6__closurerize(arg2, tmp17));
  tmpret16 = tmp17;
  return tmpret16;
} // end-of-function


function
_ats2js_bacon_ext_patsfun_6(env0, env1, arg0)
{
//
// knd = 0
  var tmp20
  var tmp21
  var tmplab, tmplab_js
//
  // __patsflab__ats2js_bacon_ext_patsfun_6
  tmp21 = ats2jspre_ref_get_elt(env1);
  tmp20 = env0[0](env0, tmp21, arg0);
  ats2jspre_ref_set_elt(env1, tmp20);
  return/*_void*/;
} // end-of-function


/* ****** ****** */

/* end-of-compilation-unit */
