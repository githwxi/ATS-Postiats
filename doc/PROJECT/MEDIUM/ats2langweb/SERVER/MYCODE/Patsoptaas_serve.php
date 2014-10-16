<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<base
 href="http://atslangweb-postiats.rhcloud.com">
</base>
<style>
html {
  height: 100%;
}
body {
  margin: 0px;
  height: 100%;
}
#thePage2Left {
/*
parent: thePage2
children: 
*/
height: 100%;
} /* thePage2Left */

#thePage2RTop {
/*
parent: thePage2Right
children: 
*/
height: 100%;
background-color: rgb(143,2,34);
} /* thePage2RTop */

#thePage2RBody {
/*
parent: thePage2Right
children: 
*/
height: 100%;
} /* thePage2RBody */

#thePage2Right {
/*
parent: thePage2
children: thePage2RTop, thePage2RBody
*/
height: 100%;
} /* thePage2Right */

#thePage2 {
/*
parent: theBodyProp
children: thePage2Left, thePage2Right
*/
height: 100%;
} /* thePage2 */

#theBodyProp {
/*
parent: 
children: thePage2
*/
height: 100%;
} /* theBodyProp */

body {
  font-family: Helvetica, Arial, sans-serif;
  background-color: #213449; /* dark blue */
}

#thePage2Left
{
  background-color: #1e5799;
  background-image: linear-gradient(to right, #1e5799, #7db9e8);
}
</style>
<link
 rel="icon" type="image/gif"
 href="./MYDATA/favicon_animated.gif">
</link>
<script
 src="./SCRIPT/jquery-2.1.1.min.js">
</script>
<script
 src="//cdn.jsdelivr.net/ace/1.1.7/min/ace.js">
</script>
<script
 src="./CLIENT/MYCODE/ace-mode-ats2-by-hwwu.js">
</script>
<script
  src="//cdn.jsdelivr.net/filesaver.js/0.2/FileSaver.min.js">
</script>
<script
 src="./CLIENT/MYCODE/libatscc2js_all.js">
</script>
<script
 src="./CLIENT/MYCODE/libatscc2js_canvas2d_all.js">
</script>
<script
 src="./CLIENT/MYCODE/libatscc2js_print_store.js">
</script>
<script
 src="./CLIENT/MYCODE/atslangweb_utils_dats.js">
</script>
<script
 src="./CLIENT/MYCODE/patsoptaas_utils_dats.js">
</script>
<script
 src="./CLIENT/MYCODE/patsoptaas_examples_dats.js">
</script>
<script
 src="./CLIENT/MYCODE/patsoptaas_templates_dats.js">
</script>
</head>
<body>
<div id="theBodyProp">
<div id="thePage2">

<?php $mycode = $_REQUEST["mycode"]; ?>
<?php $mycode_url = $_REQUEST["mycode_url"]; ?>
<!--php-->

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePage2_initize()
{
//
var
editor=
ace.edit('thePage2RBody1_prop');
//
editor.setFontSize('16px');
editor.setTheme('ace/theme/monokai');
editor.getSession().setMode('ace/mode/ats2');
editor.getSession().setValue(Patsoptaas_getWelcomeMessage());
//
Patsoptaas_thePatsopt_stderr_set("");
//
Editor_KB_select_onchange(document.getElementById('Editor_KB_select'));
//
document.getElementById('Editor-read-only').checked = false;
document.getElementById('Editor-show-gutter').checked = true;
//
document.getElementById('Patsopt-tcats-flag').checked = true;
document.getElementById('Patsopt2js-eval-flag').checked = true;
document.getElementById('Compile-stderr-flag').checked = true;
document.getElementById('Evaluate-canvas-flag').checked = false;
//
document.getElementById('File_special_select').selectedIndex = 0;
//
} // end of [Patsoptaas_thePage2_initize]
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePage2_initize2
  (fname, fname_url)
{
//
if(fname==='hello')
{
//
File_examples_load
  (Patsoptaas_File_examples_hello);
//
return;
}
//
if(fname==='fibats')
{
//
File_examples_load
  (Patsoptaas_File_examples_fibats_verify);
//
return;
}
//
File_loadurl_input_doWork(fname_url);
//
} // end of [Patsoptaas_thePage2_initize2]
//
</script>

<!--php-->
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<tr height="100%">
<td style="vertical-align:top;width:15%;">
<div id="thePage2Left">
<style>
#thePage2Left
{
  color: #FFFFF0;
}
#Editor_table_body
{
  display: none;
}
</style>

<!-- ****** ****** -->

<script>
//
function
Compile_stderr_flag_onclick()
{
//
if(Patsoptaas_Compile_stderr_flag())
{
  $('#thePage2RBody1_tr').css({height:'80%'});
  $('#thePage2RBody2_prop').css({display:'block'});
  ace.edit('thePage2RBody1_prop').resize(true);
} else {
  $('#thePage2RBody1_tr').css({height:'100%'});
  $('#thePage2RBody2_prop').css( {display:'none'} );
  ace.edit('thePage2RBody1_prop').resize(true);
} // end of [if]
//
} // end of [Compile_stderr_flag_onclick()]
//
</script>

<!-- ****** ****** -->

<script>
//
function
Evaluate_canvas_flag_onclick()
{
//
var
w, h, div, table, canvas;
//
div = $('#thePage2RBody3_canvas');
//
if(Patsoptaas_Evaluate_canvas_flag())
{
//
  table =
  $('#thePage2RBody_table')
  w = table.outerWidth(true);
  h = table.outerHeight(true);
//
  div.css({display:'block'});
//
  canvas =
  document.getElementById('Patsoptaas-Evaluate-canvas');
  if (canvas.width != w) canvas.width = w;
  if (canvas.height != h) canvas.height = h;
//
} else {
  div.css({display: 'none' });
} // end of [if]
//
} // end of [Evaluate_canvas_flag_onclick()]
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_examples_load
  (mycode)
{
  File_special_select_reset();
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_stderr_set("");
  Patsoptaas_thePatsopt_editor_set(mycode);
}
//
function
File_examples_onchange(x0)
{
//
  var i0;
//
  i0 = x0.selectedIndex; x0.selectedIndex = 0;
//
  switch(i0)
  {
    case 1: break;
    case 2:
    File_examples_load(Patsoptaas_File_examples_hello); break;
    case 3:
    File_examples_load(Patsoptaas_File_examples_factrec); break;
    case 4:
    File_examples_load(Patsoptaas_File_examples_factiter); break;
    case 5:
    File_examples_load(Patsoptaas_File_examples_fact_verify); break;
    case 6:
    File_examples_load(Patsoptaas_File_examples_fibats_verify); break;
    case 7:
    File_examples_load(Patsoptaas_File_examples_list_append); break;
    case 8:
    File_examples_load(Patsoptaas_File_examples_list_reverse); break;
    case 9:
    File_examples_load(Patsoptaas_File_examples_list_sort_insert); break;
    case 10:
    File_examples_load(Patsoptaas_File_examples_list_sort_quick); break;
    default: break;
  }
//
} // end of [File_examples_onchange]
//
</script>

<!-- ****** ****** -->

<script>
//
var
theFile_special_select_index = 0;
//
function
File_special_select_get()
{
  return theFile_special_select_index;
}
function
File_special_select_reset()
{
  theFile_special_select_index = 0;
  document.getElementById('File_special_select').selectedIndex = 0;
}
//
function
File_special_select_onchange(x0)
{
//
  var i0 = theFile_special_select_index;
  theFile_special_select_index = x0.selectedIndex;
//
  switch(i0)
  {
    case 0:
    Patsoptaas_thePatsopt_source_set(Patsoptaas_thePatsopt_editor_get()); break;
    case 1:
    Patsoptaas_thePatsopt_output_set(Patsoptaas_thePatsopt_editor_get()); break;
    case 2:
    Patsoptaas_thePatsopt2js_output_set(Patsoptaas_thePatsopt_editor_get()); break;
    default: break;
  } // end of [if]
//
  switch(theFile_special_select_index)
  {
    case 0:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_source_get()); break;
    case 1:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt_output_get()); break;
    case 2:
    Patsoptaas_thePatsopt_editor_set(Patsoptaas_thePatsopt2js_output_get()); break;
    default: break;
  } // end of [switch]
//
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Patsoptaas_thePatsopt_source_get2()
{
  if(theFile_special_select_index===0)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt_source_get();
  }
}
function
Patsoptaas_thePatsopt_source_set2(str)
{
  if(theFile_special_select_index===0)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt_source_set(str); return;
  }
}
//
function
Patsoptaas_thePatsopt_output_get2()
{
  if(theFile_special_select_index===1)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt_output_get();
  }
}
function
Patsoptaas_thePatsopt_output_set2(str)
{
  if(theFile_special_select_index===1)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt_output_set(str); return;
  }
}
//
function
Patsoptaas_thePatsopt2js_output_get2()
{
  if(theFile_special_select_index===2)
  {
    return Patsoptaas_thePatsopt_editor_get();
  } else {
    return Patsoptaas_thePatsopt2js_output_get();
  }
}
function
Patsoptaas_thePatsopt2js_output_set2(str)
{
  if(theFile_special_select_index===2)
  {
    Patsoptaas_thePatsopt_editor_set(str); return;
  } else {
    Patsoptaas_thePatsopt2js_output_set(str); return;
  }
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Editor_table_head_onclick()
{
  var jqt;
  jqt =
  $('#Editor_table_body');
  if(jqt.css('display')!=='none')
  {
    jqt.css('display', 'none');
  } else {
    jqt.css('display', 'table');
  }
}
//
function
Editor_KB_select_onchange
  (x0)
{
//
  var
  editor =
  ace.edit('thePage2RBody1_prop');
//
  switch(x0.selectedIndex)
  {
    case 0:
    editor.setKeyboardHandler(null); break
    case 1:
    editor.setKeyboardHandler('ace/keyboard/vim'); break;
    case 2:
    editor.setKeyboardHandler('ace/keyboard/emacs'); break;
    default: break;
  }
//
} // end of [Editor_KB_select_onchange]
//
function
Editor_read_only_onclick
  (x0)
{
  var
  editor =
  ace.edit('thePage2RBody1_prop');
  editor.setReadOnly( x0.checked );
} // end of [Editor_read_only_onclick]
//
function
Editor_show_gutter_onclick
  (x0)
{
  var
  editor =
  ace.edit('thePage2RBody1_prop');
  editor.renderer.setShowGutter(x0.checked);
} // end of [Editor_show_gutter_onclick]
//
</script>

<!-- ****** ****** -->

<table
 width="100%"
><!--table-->
<tr>
<td
 height="156px"
 align="center"
><!--td-->
<a
 href="./Home.html">
<img src="./MYDATA/theLogo.png" alt="ATSlogo" style="height:72%"></img>
</a>
</td>
</tr>
<tr>
<td
 align="center">

<table>
<tr>
<td
 colspan="2">
<table
 width="100%"
 border="0px"
 cellspacing="0"
 cellpadding="0"
><!--table-->
<tr>
<th
 align="left">
<button
 type="button"
 style="padding-left:3px"
 onclick="Editor_table_head_onclick()"
>Editor</button>
</th>
</tr>

<tr
 width="100%"
>
<td
 style="border-radius:6px;background-color:rgba(64,64,144,0.5)"
>
<table
 width="100%"
 cellpadding="0px"
 id="Editor_table_body"
><!--table-->

<tr>
<td
 colspan="2">
<select
 id="Editor_KB_select"
 onchange="Editor_KB_select_onchange(this)"
><!--select-->
<option>KB-ace</option>
<option>KB-vim</option>
<option>KB-emacs</option>
</select> 
</td>
</tr>

<!--
<tr>
<td>
Code-folding
</td>
</tr>
-->

<tr>
<td>
<label style="padding-left:2px">Read-only</label>
</td>
<td
 align="right">
<input
 type="checkbox"
 id="Editor-read-only"
 onclick="Editor_read_only_onclick(this)"
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Show-gutter</label>
</td>
<td
 align="right">
<input
 type="checkbox"
 id="Editor-show-gutter"
 onclick="Editor_show_gutter_onclick(this)"
 checked
></input>
</td>
</tr>

</table>
</td>
</tr>

</table>
</td>
</tr>

<tr>
<td
 colspan="2">
<select
 id="File_examples_select"
 onchange="File_examples_onchange(this)"
><!--select-->
<option>Examples</option>
<option>Randomly</option>
<option>Hello, world</option>
<option>Factorial(rec)</option>
<option>Factorial(iter)</option>
<option>Factorial(verify)</option>
<option>Fibonacci(verify)</option>
<option>List-append</option>
<option>List-reverse</option>
<option>List-sort-insert</option>
<option>List-sort-quick</option>
</select> 
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Patsopt-tcats</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt-tcats-flag"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Patsopt2js-eval</label>
</td>
<td>
<input
 type="checkbox"
 id="Patsopt2js-eval-flag"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Compile-stderr</label>
</td>
<td>
<input
 type="checkbox"
 id="Compile-stderr-flag"
 onclick="Compile_stderr_flag_onclick()"
 checked
></input>
</td>
</tr>

<tr>
<td>
<label style="padding-left:2px">Evaluate-canvas</label>
</td>
<td>
<input
 type="checkbox"
 id="Evaluate-canvas-flag"
 onclick="Evaluate_canvas_flag_onclick()"
></input>
</td>
</tr>

<tr>
<td
 colspan="2">
<select
 id="File_special_select"
 onchange="File_special_select_onchange(this)"
><!--select-->
<option value="Patsopt-source">Patsopt-source</option>
<option value="Patsopt-output">Patsopt-output</option>
<option value="Patsopt2js-output">Patsopt2js-output</option>
</select> 
</td>
</tr>

</table>
</td>
</tr>
</table>

<!--php-->
</div><!--thePage2Left-->
</td>

<td style="vertical-align:top;width:85%;">
<div id="thePage2Right">
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
<tr height="6%">
<td>
<div id="thePage2RTop">
<style>
#thePage2RTop
{
  color: #FFFFF0;
}

#thePage2RTopL
{
  text-align: left;
  padding-left: 2px;
}

#thePage2RTopL ul
{
  margin: 0px;
  padding: 0px;
  list-style-type: none;
}
#thePage2RTopL ul > li
{
  float: left;
/*
  display: inline;
*/
  border-width: 1px;
  border-color: #ffffff;
  border-right-style: double;
  margin-top: 6px;
  margin-bottom: 6px;
  padding-left: 10px;
  padding-right: 10px;
}

#thePage2RTopL td
{
  border-width: 1px;
  border-color: rgba(160,160,160,0.75);
  border-bottom-style: double;
  padding-top: 1px;
  padding-bottom: 2px;
}

.thePage2RTopL_submenu
{
  z-index: 9;
  display: none;
  position: absolute;
  border-radius: 6px;
  background-color: rgba(160,20,50,0.875);
  padding-top: 6px;
  padding-bottom: 6px;
  padding-left: 8px;
  padding-right: 8px;
}

#thePage2RTopR
{
  background-color: #FFFFF0;
}
</style>

<script>
//
// HX-2014-10:
// 8 levels should be more than enough!
//
var
theTopmenuTables =
  [0,0,0,0,0,0,0,0];
//
var theTopmenuTimeout = 0;
//
function
theTopmenuTables_hide()
{
  theTopmenuTables_hide2(0); return;
}
function
theTopmenuTables_hide2(i0)
{
  var i = i0;
  var n = theTopmenuTables.length;
  while (i < n)
  {
    var x = theTopmenuTables[i];
    if(x===0)
    {
      break;
    } else {
      x.css({display:'none'});
      theTopmenuTables[i] = 0; i = i + 1;
    } // end of [if]
  } // end of [while]
}
//
function
theTopmenuTimeout_clear()
{
  if(theTopmenuTimeout)
  {
    clearTimeout(theTopmenuTimeout); theTopmenuTimeout = 0;
  }
}
//
function
Patsoptaas_topmenu_mouseout()
{
  Patsoptaas_topmenu_mouseout2(500); return;
}
function
Patsoptaas_topmenu_mouseout2(msec)
{
//
  if(theTopmenuTimeout) clearTimeout(theTopmenuTimeout); 
  theTopmenuTimeout = // HX: [theTopmenuTimeout] must be clear!!!
  setTimeout (function(){theTopmenuTimeout=0;theTopmenuTables_hide();}, msec);
//
}
//
function
Patsoptaas_topmenu_mouseover
  (x0)
{
  var jqi, jqi2;
  jqi = jQuery(x0)
  theTopmenuTables_hide2(0);
  theTopmenuTimeout_clear( ); 
  jqi2 = jqi.next('table');
  theTopmenuTables[0] = jqi2;
  jqi2.css({display:'table'});
  jqi2.css
  (
    {top:jqi.position().top+jqi.outerHeight(true)}
  ) ; // end of [jqi2.css]
  jqi2.css({left:jqi.position().left});
  return;
}
//
function
Patsoptaas_submenu_mouseout()
{
  return;
}
function
Patsoptaas_submenu_mouseover
  (x0, i0)
{
  var jqi, jqi2;
//
  jqi = jQuery(x0);
  theTopmenuTables_hide2(i0);
  theTopmenuTimeout_clear( ); 
  jqi2 = jqi.next('table');
  theTopmenuTables[i0] = jqi2;
//
  jqi2.css({display:'table'});
  jqi2.css({top:jqi.position().top-9});
  jqi2.css
  (
    {left:jqi.position().left+jqi.outerWidth(true)+10}
  ) ; // end of [jqi2.css]
//
  return;
//
}
//
function
Patsoptaas_submenu_table_mouseout()
{
  Patsoptaas_topmenu_mouseout(); return;
}
function
Patsoptaas_submenu_table_mouseover(i0)
{
/*
  if(i0 >= 1)
  {
    alert("Patsoptaas_submenu_table_mouseover("+i0+")");
  }
*/
  theTopmenuTimeout_clear(/*void*/); return;
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_newfile_load
  (code)
{
  File_special_select_reset();
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_stderr_set("");
  Patsoptaas_thePatsopt_editor_set(code);
}
//
function
File_newfile_blank_onclick
  ()
{ 
  theTopmenuTables_hide2(0);
  File_newfile_load(Patsoptaas_File_newfile_blank);
}
//
function
File_newfile_template1_onclick
  ()
{
  theTopmenuTables_hide2(0);
  File_newfile_load(Patsoptaas_File_newfile_template1);
}
/*
function
File_newfile_template2_onclick
  ()
{
  theTopmenuTables_hide2(0);
  File_newfile_load(Patsoptaas_File_newfile_template2);
}
*/
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_loadfile_onclick(x0)
{
  jQuery(x0).next('input').trigger('click');
}
//
function
File_loadfile_mouseout(x0)
{
  Patsoptaas_submenu_mouseout(x0);
} // end of [File_loadfile_mouseout]
//
function
File_loadfile_mouseover(x0)
{
  Patsoptaas_submenu_mouseover(x0,1);
} // end of [File_loadfile_mouseover]
//
function
File_loadfile_input_onchange(x0)
{
//
var files, freader
//
theTopmenuTables_hide2(0);
//
files = x0.files;
freader = new FileReader();
freader.onloadend = function(evt)
{
//
if(evt.target.readyState==FileReader.DONE)
{
  File_special_select_reset();
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_stderr_set("");
  Patsoptaas_thePatsopt_editor_set(evt.target.result);
} ;
//
}
//
if (files.length > 0)
{
  freader.readAsText(files[0]);
} else {
alert("File_loadfile_input_onchange:2");
  Patsoptaas_thePatsopt_source_set2
  (
    "ERROR(File_loadfile): no file is choosen!!!"
  ) ; // end of [Patsoptaas_thePatsopt_source_set2]
} // end of [if]
//
} // end of [File_loadfile_input_onchange]
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_loadurl_input_doWork(url)
{
//
  File_special_select_reset();
  Patsoptaas_thePatsopt_source_set("");
  Patsoptaas_thePatsopt_output_set("");
  Patsoptaas_thePatsopt2js_output_set("");
  Patsoptaas_thePatsopt_stderr_set("");
  Patsoptaas_File_loadurl_input_doWork(url);
//
} // end of [File_loadurl_input_doWork]
//
function
File_loadurl_input_onkeyup(x0,evt)
{
  var url, length;
  length = x0.value.length;
  if(evt.keyCode == 13)
  {
    url = x0.value;
    x0.value = ""; x0.size = 24;
    theTopmenuTables_hide2(0);
    File_loadurl_input_doWork(url);
  } else {
    if(length >= 1.20 * x0.size) x0.size = length + 1;
  } // end of [if]
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
File_saveAs_onclick(x0)
{
//
var i, code, blob, fname;
//
theTopmenuTables_hide2(0);
//
i = File_special_select_get();
switch(i)
{
  case 0:
  fname = "Patsoptaas_source.dats"; break;
  case 1:
  fname = "Patsoptaas_output_dats.c"; break;
  case 2:
  fname = "Patsoptaas_output_dats.js"; break;
  default:
  fname = "Patsoptaas_compile_stderr.log"; break; 
}
//
code =
Patsoptaas_thePatsopt_editor_get();
blob =
new Blob([code], {type: 'text/plain'});
//
saveAs(blob, fname);
//
} // end of [File_saveAs_onclick]
</script>

<!-- ****** ****** -->

<script>
//
function
Compile_patsopt_onclick()
{
  theTopmenuTables_hide2(0);
  Patsoptaas_thePatsopt_stderr_set("Waiting...");
  if(Patsoptaas_Patsopt_tcats_flag())
  {
    Patsoptaas_Compile_patsopttc_onclick();
  } else {
    Patsoptaas_Compile_patsoptcc_onclick();
  } // end of [if]
}
//
function
Compile_patsopt2js_onclick()
{
  theTopmenuTables_hide2(0);
  Patsoptaas_thePatsopt_stderr_set("Waiting...");
  Patsoptaas_Compile_patsopt2js_onclick();
}
//
</script>

<!-- ****** ****** -->

<script>
//
function
Evaluate_JS_onclick()
{
  theTopmenuTables_hide2(0); Patsoptaas_Evaluate_JS_onclick();
}
//
</script>

<table
 width="100%" height="100%"
 cellspacing="0" cellpadding="0">

<tr>
<td width="75%">
<div
 id="thePage2RTopL">
<ul>
<li
 name="File"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>File</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>New File</li>
<table
 width="120px"
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(1)"
>
<tr><td>
<button
 type="button"
 onclick="File_newfile_blank_onclick()"
>Blank</button>
</td></tr>
<tr><td>
<button
 type="button"
 onclick="File_newfile_template1_onclick()"
>Template-1</button>
</td></tr>
<tr><td>
<button
 type="button"
 onclick="File_newfile_template2_onclick()"
>Template-2</button>
</td></tr>
</table>
</td></tr>

<tr><td>
<button
 onclick="File_loadfile_onclick(this)"
 onmouseout="File_loadfile_mouseout(this)"
 onmouseover="File_loadfile_mouseover(this)"
>Load File</button>
<input
 type="file"
 style="display:none"
 onchange="File_loadfile_input_onchange(this)"
></input>
</td></tr>

<tr><td>
<li
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Load URL</li>
<table
 width="120px"
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(1)"
>
<tr><td>
<input
 type="text" size="24" maxlength="1024"
 onkeyup="File_loadurl_input_onkeyup(this,event)"
></input>
<input
 id="File_loadurl_input_content" type="hidden"></input>
</td></tr>
</table>
</td></tr>

<tr><td>
<button
 type="button"
 onclick="File_saveAs_onclick(this)"
 onmouseout="Patsoptaas_submenu_mouseout()"
 onmouseover="Patsoptaas_submenu_mouseover(this,1)"
>Save As...</button>
</td></tr>

</table><!--File-->

<li
 name="Compile"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Compile</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button"
 onclick="Compile_patsopt_onclick()"
>Patsopt</button>
</td></tr>
<tr><td>
<button
 type="button"
 onclick="Compile_patsopt2js_onclick()"
>Patsopt2js</button>
</td></tr>
</table><!--Compile-->

<li
 name="Evaluate"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Evaluate</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button"
 onclick="Evaluate_JS_onclick()"
>EvalJS</button>
</td></tr>
</table><!--Evaluate-->

<li
 name="Help"
 onmouseout="Patsoptaas_topmenu_mouseout()"
 onmouseover="Patsoptaas_topmenu_mouseover(this)"
>Help</li>
<table
 class="thePage2RTopL_submenu"
 onmouseout="Patsoptaas_submenu_table_mouseout()"
 onmouseover="Patsoptaas_submenu_table_mouseover(0)"
>
<tr><td>
<button
 type="button" onclick="Help_about_onclick()"
>About</button>
</td></tr>
</table><!--Help-->

</ul>
</div>

<td
 width="25%"
 style="background-color:#FFFFF0">
</td>

</tr>
</table>

<!--php-->
</div><!--thePage2RTop-->
</td>
</tr>

<tr height="94%">
<td>
<div id="thePage2RBody">
<style>
#thePage2RBody1_prop
{
  width: 100%;
  height: 100%;
}
#thePage2RBody2_prop
{
  width: 98%;
  height: 100%;
  font-size: 12px;
  background: #FFFFF0;
}
#thePage2RBody3_canvas
{
  z-index: 8;
  position: absolute;
  font-size: 12px;
  background: #FFFFF0;
}
</style>

<table
 id="thePage2RBody_table"
 width="100%" height="100%">

<tr
 id="thePage2RBody1_tr"
 height="80%">
<td align="left">
<div
 id="thePage2RBody1_prop"></div>
</td>
</tr>

<tr
 id="thePage2RBody2_tr"
 height="20%">
<td align="center">
<textarea
 id="thePage2RBody2_prop"></textarea>
</td>
</tr>

<div
 id="thePage2RBody3_canvas"
 style="display:none">
<canvas
 id="Patsoptaas-Evaluate-canvas"
 oncontextmenu="event.preventDefault()">
It seems that &lt;canvas&gt; is not supported by the browser!
</canvas>

</div>

</table>

<!--php-->
</div><!--thePage2RBody-->
</td>
</tr>
</table>
</div><!--thePage2Right-->
</td>
</tr>
</table>
</div><!--thePage2-->
</div><!--theBodyProp-->
</body>
<script>
$(document).ready(Patsoptaas_thePage2_initize);
</script>

<?php
  echo "<script>\n";
  echo "\$(document).ready(function(){Patsoptaas_thePage2_initize2('".$mycode."','".$mycode_url."');});\n";
  echo "</script>\n";
?><!--php-->

</html>
