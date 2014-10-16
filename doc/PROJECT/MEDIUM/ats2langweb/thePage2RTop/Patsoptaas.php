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

<?php /* end of [Patsoptaas.php] */ ?>
